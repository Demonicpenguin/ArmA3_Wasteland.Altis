// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.1
//	@file Name: serverCompile.sqf
//	@file Author: [404] Deadbeat, [GoT] JoSchaap, AgentRev
//	@file Created: 20/11/2012 05:19
//	@file Args:

if (!isServer) exitWith {};

diag_log "WASTELAND SERVER - Initializing Server Compile";

//Factory Compiles
_path = "server\missions\factoryMethods";
attemptCompileMissions = [_path, "attemptCompileMissions.sqf"] call mf_compile;
checkMissionVehicleLock = [_path, "checkMissionVehicleLock.sqf"] call mf_compile;
cleanLocationObjects = [_path, "cleanLocationObjects.sqf"] call mf_compile;
createMayanDivers = [_path, "createUnits\mayanDivers.sqf"] call mf_compile;
createSubDivers = [_path, "createUnits\SubDivers.sqf"] call mf_compile;
createalcatrazGroup = [_path, "createUnits\alcatrazGroup.sqf"] call mf_compile;
createoverWaterGroup = [_path, "createUnits\overWaterGroup.sqf"] call mf_compile;
createCustomGroup = [_path, "createUnits\customGroup.sqf"] call mf_compile;
createCustomGroup2 = [_path, "createUnits\customGroup2.sqf"] call mf_compile;
createCustomGroup3 = [_path, "createUnits\customGroup3.sqf"] call mf_compile;
createCustomGroup4 = [_path, "createUnits\customGroup4.sqf"] call mf_compile;
createCustomGroup5 = [_path, "createUnits\customGroup5.sqf"] call mf_compile;
createCustomGroup6 = [_path, "createUnits\customGroup6.sqf"] call mf_compile;
createCustomGroup7 = [_path, "createUnits\customGroup7.sqf"] call mf_compile;
createCustomGroup8 = [_path, "createUnits\customGroup8.sqf"] call mf_compile;			// wearing Gas Masks
customGroupPatrol = [_path, "createUnits\customGroupPatrol.sqf"] call mf_compile;
createsniperGroup = [_path, "createUnits\sniperGroup.sqf"] call mf_compile;
createMilitaryGroup = [_path, "createUnits\createMilitaryGroup.sqf"] call mf_compile;
createRoadBlock = [_path, "createUnits\createRoadBlock.sqf"] call mf_compile;
createSubBase = [_path, "createUnits\createSubBase.sqf"] call mf_compile;
createsquadAssault = [_path, "createUnits\createSquadAssault.sqf"] call mf_compile;
createLargeDivers = [_path, "createUnits\largeDivers.sqf"] call mf_compile;
createDivingGroup = [_path, "createUnits\createDivingGroup.sqf"] call mf_compile;
createMissionLocation = [_path, "createMissionLocation.sqf"] call mf_compile;
createMissionMarker = [_path, "createMissionMarker.sqf"] call mf_compile;
createMissionVehicle = [_path, "createMissionVehicle.sqf"] call mf_compile;
createMissionVehicle2 = [_path, "createMissionVehicle2.sqf"] call mf_compile;
STCreateRandomGroup = [_path, "STCreateRandomGroup.sqf"] call mf_compile;
createOutpost = [_path, "createOutpost.sqf"] call mf_compile;
createAirpost = [_path, "createAirpost.sqf"] call mf_compile;
addDefensiveMines = [_path, "createUnits\addDefensiveMines.sqf"] call mf_compile;
createCustomGroupAirSpecOps = [_path, "createUnits\customGroupAirSpecOps.sqf"] call mf_compile;
createCustomGroupAirSpetsnaz = [_path, "createUnits\customGroupAirSpetsnaz.sqf"] call mf_compile;
 

STCreateVehicle = [_path, "STCreateVehicle.sqf"] call mf_compile;
STParaDropObject = [_path, "STParaDropObject.sqf"] call mf_compile;
STCreateUnit = [_path, "STCreateUnit.sqf"] call mf_compile;
STPopCrateSmoke = [_path, "STPopCrateSmoke.sqf"] call mf_compile;
STRandomCashReward = [_path, "STRandomCashReward.sqf"] call mf_compile;
STRandomCratesReward = [_path, "STRandomCratesReward.sqf"] call mf_compile;
STCreateSpecialCrate = [_path, "STCreateSpecialCrate.sqf"] call mf_compile;
STFillSniperCrate = [_path, "STFillSniperCrate.sqf"] call mf_compile;
STFixedCashReward = [_path, "STFixedCashReward.sqf"] call mf_compile;
STFindRoadPosDir = [_path, "STFindRoadPosDir.sqf"] call mf_compile;
STCreateContainer = ["_path", "STCreateContainer.sqf"] call mf_compile;
STCreateConvenienceKit = ["_path", "STCreateConvenienceKit.sqf"] call mf_compile;

createReinforceAttackHelicopter = [_path, "createReinforceAttackHelicopter.sqf"] call mf_compile;

createBanditpost = [_path, "createBanditpost.sqf"] call mf_compile;
createEliteSoldier = [_path, "createUnits\createEliteSoldier.sqf"] call mf_compile;
createRandomSoldier = [_path, "createUnits\createRandomSoldier.sqf"] call mf_compile;
createRandomSoldierA = [_path, "createUnits\createRandomSoldierA.sqf"] call mf_compile;
createRandomPilot = [_path, "createUnits\createRandomPilot.sqf"] call mf_compile;
createRandomSurfer = [_path, "createUnits\createRandomSurfer.sqf"] call mf_compile;
createRandomSoldierC = [_path, "createUnits\createRandomSoldierC.sqf"] call mf_compile;
createSmallDivers = [_path, "createUnits\smallDivers.sqf"] call mf_compile;

//New AI templates
createsoldier = [_path, "createsoldier.sqf"] call mf_compile;

generateMissionWeights = [_path, "generateMissionWeights.sqf"] call mf_compile;
mission_VehicleCapture = "server\missions\infantryMissions\mission_VehicleCapture.sqf" call mf_compile;
missionHint = [_path, "missionHint.sqf"] call mf_compile;
moveIntoBuildings = [_path, "moveIntoBuildings.sqf"] call mf_compile;
ZmoveIntoBuildings = [_path, "ZmoveIntoBuildings.sqf"] call mf_compile;
removeDisabledMissions = [_path, "removeDisabledMissions.sqf"] call mf_compile;
setLocationObjects = [_path, "setLocationObjects.sqf"] call mf_compile;
setLocationState = [_path, "setLocationState.sqf"] call mf_compile;
setMissionState = [_path, "setMissionState.sqf"] call mf_compile;

//non-vanilla missions
createsniperGroup = [_path, "createUnits\sniperGroup.sqf"] call mf_compile; 
createsmugglerGroup = [_path, "createUnits\smugglerGroup.sqf"] call mf_compile;
createCustomGroup3 = [_path, "createUnits\customGroup3.sqf"] call mf_compile;
createRandomPilot = [_path, "createUnits\createRandomPilot.sqf"] call mf_compile;
createWaitCondition = [_path, "createWaitCondition.sqf"] call mf_compile;
createGroup1= [_path, "createUnits\Group1.sqf"] call mf_compile;
createGroup2= [_path, "createUnits\Group2.sqf"] call mf_compile;
createGroup3= [_path, "createUnits\Group3.sqf"] call mf_compile;
createGroup4= [_path, "createUnits\Group4.sqf"] call mf_compile;
createGroup5= [_path, "createUnits\Group5.sqf"] call mf_compile;
randomSoldierLoadOut = [_path, "createUnits\randomSoldierLoadOut.sqf"] call mf_compile;
createAirTroops = [_path, "createUnits\createAirTroops.sqf"] call mf_compile;

//Function Compiles
_path = "server\functions";
A3W_fnc_checkHackedVehicles = [_path, "checkHackedVehicles.sqf"] call mf_compile;
A3W_fnc_deleteEmptyGroup = [_path, "fn_deleteEmptyGroup.sqf"] call mf_compile;
A3W_fnc_playerRespawnServer = [_path, "playerRespawnServer.sqf"] call mf_compile;
A3W_fnc_registerKillScore = [_path, "fn_registerKillScore.sqf"] call mf_compile;
A3W_fnc_requestTickTime = [_path, "fn_requestTickTime.sqf"] call mf_compile;
A3W_fnc_setItemCleanup = [_path, "fn_setItemCleanup.sqf"] call mf_compile;
A3W_fnc_updateSpawnTimestamp = [_path, "fn_updateSpawnTimestamp.sqf"] call mf_compile;
addMilCap = [_path, "addMilCap.sqf"] call mf_compile;
basePartSetup = [_path, "basePartSetup.sqf"] call mf_compile;
cleanVehicleWreck = [_path, "cleanVehicleWreck.sqf"] call mf_compile;
convertTerritoryOwner = "territory\server\convertTerritoryOwner.sqf" call mf_compile;
defendArea = [_path, "defendArea.sqf"] call mf_compile;
defendAlcatraz = [_path, "defendAlcatraz.sqf"] call mf_compile;
dropPlayerItems = [_path, "dropPlayerItems.sqf"] call mf_compile;
findClientPlayer = [_path, "findClientPlayer.sqf"] call mf_compile;
fn_entityKilled = [_path, "fn_entityKilled.sqf"] call mf_compile;
fn_onPlayerConnected = [_path, "fn_onPlayerConnected.sqf"] call mf_compile;
fn_onPlayerDisconnected = [_path, "fn_onPlayerDisconnected.sqf"] call mf_compile;
fn_publicVariableAll = [_path, "fn_publicVariableAll.sqf"] call mf_compile;
fn_refillBox = [_path, "fn_refillbox.sqf"] call mf_compile;
fn_refillBox2 = [_path, "fn_refillbox2.sqf"] call mf_compile;
fn_refillTruck = [_path, "fn_refilltruck.sqf"] call mf_compile;
fn_replaceMagazines = [_path, "fn_replaceMagazines.sqf"] call mf_compile;
fn_invis = [_path, "invis.sqf"] call mf_compile;
fn_replaceWeapons = [_path, "fn_replaceWeapons.sqf"] call mf_compile;
fn_updatePlayerScore = [_path, "fn_updatePlayerScore.sqf"] call mf_compile;
fn_vehicleGetInOutServer = [_path, "fn_vehicleGetInOutServer.sqf"] call mf_compile;
fn_vehicleKilledServer = [_path, "fn_vehicleKilledServer.sqf"] call mf_compile;
hintBroadcast = [_path, "hintBroadcast.sqf"] call mf_compile;
parachuteLiftedVehicle = [_path, "parachuteLiftedVehicle.sqf"] call mf_compile;
processGroupInvite = [_path, "processGroupInvite.sqf"] call mf_compile;
processItems = [_path, "processItems.sqf"] call mf_compile;
punishTeamKiller = [_path, "punishTeamKiller.sqf"] call mf_compile;
refillPrimaryAmmo = [_path, "refillPrimaryAmmo.sqf"] call mf_compile;
respawnEventServer = [_path, "respawnEventServer.sqf"] call mf_compile;
setMissionSkill = [_path, "setMissionSkill.sqf"] call mf_compile;
setMissionSkill2 = [_path, "setMissionSkill2.sqf"] call mf_compile;
spawnStoreObject = [_path, "spawnStoreObject.sqf"] call mf_compile;
teamKillUnlock = [_path, "teamKillUnlock.sqf"] call mf_compile;
teamSwitchLock = [_path, "teamSwitchLock.sqf"] call mf_compile;
teamSwitchUnlock = [_path, "teamSwitchUnlock.sqf"] call mf_compile;
updateConnectingClients = "territory\client\updateConnectingClients.sqf" call mf_compile;
vehicleRepair = [_path, "vehicleRepair.sqf"] call mf_compile;
vehicleSetup = [_path, "vehicleSetup.sqf"] call mf_compile;
vehicleSetupAI = [_path, "vehicleSetupAI.sqf"] call mf_compile;
waitUntilBagTaken = [_path, "waitUntilBagTaken.sqf"] call mf_compile;
weaponDisassembledServer = [_path, "weaponDisassembledServer.sqf"] call mf_compile;
randomCrateLoadOut = [_path, "randomCrateLoadOut.sqf"] call mf_compile;
setEliteSkill = [_path, "setEliteSkill.sqf"] call mf_compile;
TAG_fnc_BUBBLES = [_path, "TAG_fnc_BUBBLES.sqf"] call mf_compile;

//Player Management
server_playerDied = [_path, "serverAiDied.sqf"] call mf_compile;
A3W_fnc_serverPlayerDied = [_path, "serverPlayerDied.sqf"] call mf_compile;


//Bounty System
/*_path = "server\systems\bounties";
onBountySystemPlayerDied = [_path, "onBountySystemPlayerDied.sqf"] call mf_compile;
startPlayerBounty = [_path, "startPlayerBounty.sqf"] call mf_compile;
startSystemBounty = [_path, "startSystemBounty.sqf"] call mf_compile;
startSystemBountyByName = [_path, "startSystemBountyByName.sqf"] call mf_compile;*/


//Spawning Compiles
_path = "server\spawning";
addVehicleRespawn = [_path, "addVehicleRespawn.sqf"] call mf_compile;
boatCreation = [_path, "boatCreation.sqf"] call mf_compile;
objectCreation = [_path, "objectCreation.sqf"] call mf_compile;
planeCreation = [_path, "planeCreation.sqf"] call mf_compile;
randomWeapons = [_path, "randomWeapon.sqf"] call mf_compile;
// staticGunCreation = [_path, "staticGunCreation.sqf"] call mf_compile;
staticHeliCreation = [_path, "staticHeliCreation.sqf"] call mf_compile;
vehicleCreation = [_path, "vehicleCreation.sqf"] call mf_compile;

_path = "addons\scripts";
Soul_AutoLoad = [_path, "Soul_AutoLoad.sqf"] call mf_compile;


