// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: CfgRemoteExec_fnc.hpp
//	@file Author: AgentRev

// remoteExec & BIS_fnc_MP functions whitelist (client only, server calls are not filtered)

// BIS
class BIS_fnc_debugConsoleExec {}; // secure function made by Killzone Kid for BIS, only works for logged-in admins
class BIS_fnc_effectKilledAirDestruction {};
class BIS_fnc_effectKilledSecondaries {};
class BIS_fnc_initVehicle {}; // required for vehicle parts like tank cages
class BIS_fnc_objectVar {};
// do NOT whitelist BIS_fnc_execVM or BIS_fnc_spawn, hackers will exploit them!

// A3W vanilla
class A3W_fnc_adminMenuLog { allowedTargets = 2; };
class A3W_fnc_artilleryStrike { allowedTargets = 2; };
class A3W_fnc_chatBroadcast {};
class A3W_fnc_checkHackedVehicles { allowedTargets = 2; };
class A3W_fnc_checkPlayerFlag { allowedTargets = 2; };
class A3W_fnc_copilotTakeControl {};
class A3W_fnc_deathMessage {};
class A3W_fnc_deleteEmptyGroup { allowedTargets = 2; };
class A3W_fnc_deletePlayerData { allowedTargets = 2; };
class A3W_fnc_flagHandler { allowedTargets = 2; };
class A3W_fnc_getInFast {};
class A3W_fnc_initPlayerServer { allowedTargets = 2; };
class A3W_fnc_killBroadcast { allowedTargets = 2; };
class A3W_fnc_logMemAnomaly { allowedTargets = 2; };
class A3W_fnc_playerRespawnServer { allowedTargets = 2; };
class A3W_fnc_processTransaction { allowedTargets = 2; };
class A3W_fnc_pushVehicle {};
//class A3W_fnc_registerKillScore { allowedTargets = 2; }; // only needed for injury kill points, not currently enabled due to point farming concerns
class A3W_fnc_requestPlayerData { allowedTargets = 2; };
class A3W_fnc_requestTickTime { allowedTargets = 2; };
class A3W_fnc_savePlayerData { allowedTargets = 2; };
class A3W_fnc_serverPlayerDied { allowedTargets = 2; };
class A3W_fnc_setCMoney { allowedTargets = 2; };
class A3W_fnc_setItemCleanup { allowedTargets = 2; };
class A3W_fnc_setLockState {};
class A3W_fnc_setName { jip = 1; };
class A3W_fnc_setVarServer { allowedTargets = 2; };
class A3W_fnc_takeArtilleryStrike { allowedTargets = 2; };
class A3W_fnc_takeOwnership { allowedTargets = 2; };
class A3W_fnc_titleTextMessage {};
class A3W_fnc_towingHelper {};
class A3W_fnc_updateSpawnTimestamp { allowedTargets = 2; };
class FAR_fnc_headshotHitPartEH {};
class FAR_fnc_public_EH {};
class mf_remote_refuel {};
class mf_remote_repair {};
class mf_remote_extinguish {};
class mf_remote_syphon {};

// Third-party
class A3W_fnc_addMagazineTurret {};
class A3W_fnc_addMagazineTurretBaheli {};
class A3W_fnc_addMagazineTurretBcas {};
class A3W_fnc_addMagazineTurretHorca {};
class A3W_fnc_addMagazineTurretIcas {};
class A3W_fnc_addMagazineTurretLheli {};
class A3W_fnc_addMagazineTurretMortar {};
class A3W_fnc_addMagazineTurretOaheli {};
class A3W_fnc_addMagazineTurretOcas {};
class A3W_fnc_addMagazineTurretUav2 {};
class A3W_fnc_hideObjectGlobal {};
class A3W_fnc_movedObjectGlobal {};
class A3W_fnc_lock {};
class A3W_fnc_removeMagazinesTurret {};
class A3W_fnc_setVectorUpAndDir { jip = 1; };
class A3W_fnc_setVehicleAmmoDef {};
class A3W_fnc_unflip {};
class A3W_fnc_cleanupObjects {};

// Other third-party
class APOC_srv_startAirdrop { allowedTargets = 2; };
class Monkey_srv_StartAirSupport { allowedTargets = 2; };
class FZ_fnc_discordEmbed { allowedTargets = 2; };
class JTS_FNC_SENT {};

class GOM_fnc_carpetbombing {allowedTargets = 2;};
class GOM_fnc_airRaidSirens {allowedTargets = 1;};

// Third-party

class AR_Client_Rappel_From_Heli { allowedTargets=0; };
class AR_Hint { allowedTargets=1; };
class AR_Hide_Object_Global { allowedTargets=2; };
class AR_Enable_Rappelling_Animation { allowedTargets=2; };
class AR_Rappel_From_Heli { allowedTargets=2; };
class AUR_Hint { allowedTargets=1; };
class AUR_Hide_Object_Global { allowedTargets=2; };
class AUR_Enable_Rappelling_Animation_Global { allowedTargets=2; };
class AUR_Play_Rappelling_Sounds_Global { allowedTargets=2; };
class A3W_fnc_aj_s_refreshZeus { allowedTargets = 2; };     //Zeus Server
class saky_fnc_irToIncendiary { jip = 1; };

class Soul_AutoLoad { allowedTargets = 0; };

//Sanctuary Tactical
//class STSiren { allowedTargets = 0; };
//class STYelp { allowedTargets = 0; };
//class STWelcome {};
class say3d {};
//class STDoorController { allowedTargets = 2; };

//VCOM AI
class vcm_serverask { allowedTargets = 0;jip = 1; };
class VCM_PublicScript { allowedTargets = 0;jip = 1; };
class SpawnScript { allowedTargets = 0;jip = 1; };
class VCM_fnc_KnowAbout { allowedTargets = 0;jip = 1; };

class HARC_fn_timeSkip { allowedTargets = 2; };
	