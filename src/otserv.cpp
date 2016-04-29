/**
 * The Forgotten Server - a free and open-source MMORPG server emulator
 * Copyright (C) 2016  Mark Samman <mark.samman@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

#include "otpch.h"

#include "server.h"

#include "game.h"

#include "iomarket.h"

#ifndef _WIN32
#include <csignal> // for sigemptyset()
#endif

#include "configmanager.h"
#include "scriptmanager.h"
#include "rsa.h"
#include "protocolold.h"
#include "protocollogin.h"
#include "protocolstatus.h"
#include "databasemanager.h"
#include "scheduler.h"
#include "databasetasks.h"

DatabaseTasks g_databaseTasks;
Dispatcher g_dispatcher;
Scheduler g_scheduler;

Game g_game;
ConfigManager g_config;
Monsters g_monsters;
Vocations g_vocations;
RSA g_RSA;

std::mutex g_loaderLock;
std::condition_variable g_loaderSignal;
std::unique_lock<std::mutex> g_loaderUniqueLock(g_loaderLock);

void startupErrorMessage(const std::string& errorStr)
{
	std::cout << "> ERRO: " << errorStr << std::endl;
	g_loaderSignal.notify_all();
}

void mainLoader(int argc, char* argv[], ServiceManager* servicer);

void badAllocationHandler()
{
	// Use functions that only use stack allocation
	puts("Falha na alocacao, servidor sem memoria.\nDiminua o tamanho do seu mapa ou compile em 64 bits.\n");
	getchar();
	exit(-1);
}

int main(int argc, char* argv[])
{
	// Setup bad allocation handler
	std::set_new_handler(badAllocationHandler);

#ifndef _WIN32
	// ignore sigpipe...
	struct sigaction sigh;
	sigh.sa_handler = SIG_IGN;
	sigh.sa_flags = 0;
	sigemptyset(&sigh.sa_mask);
	sigaction(SIGPIPE, &sigh, nullptr);
#endif

	ServiceManager serviceManager;

	g_dispatcher.start();
	g_scheduler.start();

	g_dispatcher.addTask(createTask(std::bind(mainLoader, argc, argv, &serviceManager)));

	g_loaderSignal.wait(g_loaderUniqueLock);

	if (serviceManager.is_running()) {
		std::cout << ">> " << g_config.getString(ConfigManager::SERVER_NAME) << " Server Online!" << std::endl << std::endl;
#ifdef _WIN32
		SetConsoleCtrlHandler([](DWORD) -> BOOL {
			g_dispatcher.addTask(createTask([]() {
				g_dispatcher.addTask(createTask(
					std::bind(&Game::shutdown, &g_game)
				));
				g_scheduler.stop();
				g_databaseTasks.stop();
				g_dispatcher.stop();
			}));
			ExitThread(0);
		}, 1);
#endif
		serviceManager.run();
	} else {
		std::cout << ">> Nao ha servicos em execucao. O server NAO esta online." << std::endl;
		g_scheduler.shutdown();
		g_databaseTasks.shutdown();
		g_dispatcher.shutdown();
	}

	g_scheduler.join();
	g_databaseTasks.join();
	g_dispatcher.join();
	return 0;
}

void mainLoader(int, char*[], ServiceManager* services)
{
	//dispatcher thread
	g_game.setGameState(GAME_STATE_STARTUP);

	srand(static_cast<unsigned int>(OTSYS_TIME()));
#ifdef _WIN32
	SetConsoleTitle(STATUS_SERVER_NAME);
#endif
	std::cout << STATUS_SERVER_NAME << " - Versao " << STATUS_SERVER_VERSION << std::endl;
	std::cout << "Compilado com " << BOOST_COMPILER << std::endl;
	std::cout << "Compilado em " << __DATE__ << ' ' << __TIME__ << " para plataforma ";

#if defined(__amd64__) || defined(_M_X64)
	std::cout << "x64" << std::endl;
#elif defined(__i386__) || defined(_M_IX86) || defined(_X86_)
	std::cout << "x86" << std::endl;
#elif defined(__arm__)
	std::cout << "ARM" << std::endl;
#else
	std::cout << "desconhecida" << std::endl;
#endif
	std::cout << std::endl;

	std::cout << "Este servidor foi desenvolvido por " << STATUS_SERVER_DEVELOPERS << std::endl;
	std::cout << "Visite nosso forum para updates, suporte e pedidos: http://xtibia.com/." << std::endl;
	std::cout << "Um oferecimento OTPanel, OTserv Cloud em 60s." << std::endl;
	std::cout << std::endl;

	// read global config
	std::cout << ">> Carregando configuracoes" << std::endl;
	if (!g_config.load()) {
		startupErrorMessage("Falha ao carregar o config.lua!");
		return;
	}

#ifdef _WIN32
	const std::string& defaultPriority = g_config.getString(ConfigManager::DEFAULT_PRIORITY);
	if (strcasecmp(defaultPriority.c_str(), "high") == 0) {
		SetPriorityClass(GetCurrentProcess(), HIGH_PRIORITY_CLASS);
	} else if (strcasecmp(defaultPriority.c_str(), "above-normal") == 0) {
		SetPriorityClass(GetCurrentProcess(), ABOVE_NORMAL_PRIORITY_CLASS);
	}
#endif

	//set RSA key
	const char* p("14299623962416399520070177382898895550795403345466153217470516082934737582776038882967213386204600674145392845853859217990626450972452084065728686565928113");
	const char* q("7630979195970404721891201847792002125535401292779123937207447574596692788513647179235335529307251350570728407373705564708871762033017096809910315212884101");
	g_RSA.setKey(p, q);

	std::cout << ">> Estabilizando conexao com o banco de dados..." << std::flush;

	Database* db = Database::getInstance();
	if (!db->connect()) {
		startupErrorMessage("Falha ao conectar-se com o banco de dados.");
		return;
	}

	std::cout << " MySQL " << Database::getClientVersion() << std::endl;

	// run database manager
	std::cout << ">> Carregando banco de dados" << std::endl;

	if (!DatabaseManager::isDatabaseSetup()) {
		startupErrorMessage("O banco de dados que especificou no config.lua esta vazio, por favor importar o schema.sql para seu banco de dados.");
		return;
	}
	g_databaseTasks.start();

	DatabaseManager::updateDatabase();

	if (g_config.getBoolean(ConfigManager::OPTIMIZE_DATABASE) && !DatabaseManager::optimizeTables()) {
		std::cout << "> Nenhuma tabela foi otimizada." << std::endl;
	}

	//load vocations
	std::cout << ">> Carregando vocacoes" << std::endl;
	if (!g_vocations.loadFromXml()) {
		startupErrorMessage("Impossivel carregar vocacoes!");
		return;
	}

	// load item data
	std::cout << ">> Carregando items" << std::endl;
	if (Item::items.loadFromOtb("data/items/items.otb") != ERROR_NONE) {
		startupErrorMessage("Impossivel carregar items (OTB)!");
		return;
	}

	if (!Item::items.loadFromXml()) {
		startupErrorMessage("Impossivel carregar (XML)!");
		return;
	}

	std::cout << ">> Carregando sistemas de scripts" << std::endl;
	if (!ScriptingManager::getInstance()->loadScriptSystems()) {
		startupErrorMessage("Impossivel carregar sistemas de scripts");
		return;
	}

	std::cout << ">> Carregando criaturas" << std::endl;
	if (!g_monsters.loadFromXml()) {
		startupErrorMessage("Impossivel carregar criaturas!");
		return;
	}

	std::cout << ">> Carregando outfits" << std::endl;
	Outfits* outfits = Outfits::getInstance();
	if (!outfits->loadFromXml()) {
		startupErrorMessage("Impossivel carregar outfits!");
		return;
	}

	std::cout << ">> Checando tipo do servidor... " << std::flush;
	std::string worldType = asLowerCaseString(g_config.getString(ConfigManager::WORLD_TYPE));
	if (worldType == "pvp") {
		g_game.setWorldType(WORLD_TYPE_PVP);
	} else if (worldType == "no-pvp") {
		g_game.setWorldType(WORLD_TYPE_NO_PVP);
	} else if (worldType == "pvp-enforced") {
		g_game.setWorldType(WORLD_TYPE_PVP_ENFORCED);
	} else {
		std::cout << std::endl;

		std::ostringstream ss;
		ss << "> ERRO: Tipo do servidor desconhecido: " << g_config.getString(ConfigManager::WORLD_TYPE) << ", os tipos validos sao: pvp, no-pvp and pvp-enforced.";
		startupErrorMessage(ss.str());
		return;
	}
	std::cout << asUpperCaseString(worldType) << std::endl;

	std::cout << ">> Carregando mapa" << std::endl;
	if (!g_game.loadMainMap(g_config.getString(ConfigManager::MAP_NAME))) {
		startupErrorMessage("Impossivel carregar o mapa");
		return;
	}

	std::cout << ">> Inicializando o servidor" << std::endl;
	g_game.setGameState(GAME_STATE_INIT);

	// Game client protocols
	services->add<ProtocolGame>(g_config.getNumber(ConfigManager::GAME_PORT));
	services->add<ProtocolLogin>(g_config.getNumber(ConfigManager::LOGIN_PORT));

	// OT protocols
	services->add<ProtocolStatus>(g_config.getNumber(ConfigManager::STATUS_PORT));

	// Legacy login protocol
	services->add<ProtocolOld>(g_config.getNumber(ConfigManager::LOGIN_PORT));

	RentPeriod_t rentPeriod;
	std::string strRentPeriod = asLowerCaseString(g_config.getString(ConfigManager::HOUSE_RENT_PERIOD));

	if (strRentPeriod == "yearly") {
		rentPeriod = RENTPERIOD_YEARLY;
	} else if (strRentPeriod == "weekly") {
		rentPeriod = RENTPERIOD_WEEKLY;
	} else if (strRentPeriod == "monthly") {
		rentPeriod = RENTPERIOD_MONTHLY;
	} else if (strRentPeriod == "daily") {
		rentPeriod = RENTPERIOD_DAILY;
	} else {
		rentPeriod = RENTPERIOD_NEVER;
	}

	g_game.map.houses.payHouses(rentPeriod);

	IOMarket::checkExpiredOffers();
	IOMarket::getInstance()->updateStatistics();

	std::cout << ">> Todos os modulos carregados, servidor iniciando..." << std::endl;

#ifndef _WIN32
	if (getuid() == 0 || geteuid() == 0) {
		std::cout << "> Aviso: O servidor foi executado com usuario root, por favor considere executa-lo como um usuario normal." << std::endl;
	}
#endif

	g_game.start(services);
	g_game.setGameState(GAME_STATE_NORMAL);
	g_loaderSignal.notify_all();
}
