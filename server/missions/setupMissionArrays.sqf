// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: setupMissionArrays.sqf
//	@file Author: AgentRev

if (!isServer) exitWith {};


MarineMissions =
[
	//Mission filename, weightmission_Mines
	["mission_Mines", 1],	
	["mission_Warhead", 1],	
	["mission_ArmedMayanTemple", 1],
	["mission_ArmedDiversquad", 1],
	["mission_SunkenTreasure", 1],
    ["mission_SunkenTreasure2", 1],	
    ["mission_Coastal_Convoy2", 1],	
	["mission_Sub_Convoy", 1],
	["mission_Warship_Convoy", 1],	
	["mission_SubRepair", 1],	
    ["mission_SunkenSupplies", 1],
	["mission_Coastal_Convoy", 1],
	["mission_NavalConvoy", 1]	
];

OccupationMissions =
[
	// Mission filename, weight
	["mission_RoadBlockvariant", 1],
	["mission_theMaze", 1],
	["mission_TownInvasion", 1],
    ["mission_TownInvasion3", 1],
	["mission_Outpost", 1],	
	["mission_TownInvasion4", 1],
	["mission_alcatraz", 1],	
	["mission_SquadAssault", 1],	
	["mission_miltaryIncursion", 1],	
	["mission_Riot", 1],
	["mission_SuicideSquad", 1],	
	["mission_Base", 1],
	["mission_SubBase", 1],
	["mission_Airpost", 1],
    ["mission_Harborinvasion", 1]	
];


AirborneMissions =
[
	// Mission filename, weight	
	["mission_GhostSwarm", 1],
	["mission_TanoaPatrol", 1],
	["mission_CarpetBombing", 1],	
	["mission_HostileJetFormation", 1],
	["mission_cargoContainer", 1],
	["mission_DoubleBlackfish", 1],	
	["mission_SkySmuggler", 1],
	["mission_HostileTanoaFormation", 1],
	["mission_SupplyDrop", 1],	
	["mission_HostileHeliFormation", 1],
	["mission_HostileHelicopter", 1],
	["mission_HostileJet", 1],
	["mission_HostileGunShip",1],
	["mission_PawneeSquadron", 1],
	["mission_BlackfootTwins", 1],
	["mission_DeadSky", 1],
	["mission_JetFormation", 1],
	["mission_cargoContainer2", 1],
	["mission_HostileJet2", 1]	
	
];

ArmouredMissions =
[
	// Mission filename, weight
    ["mission_MoneyShipment", 1],
    ["mission_altisPatrol", 1],
	["mission_militaryPatrol", 1],
	["mission_combinedArms", 1],
	["mission_cargoDelivery", 1],	
	["mission_islandPatrol", 1],
	["mission_MadScientist",1],	
	//["mission_Demolition", 1],	
	["mission_mechPatrol", 1],	
	["mission_Payday", 1],
	["mission_ArmedPatrol", 1],
	["mission_HeavyMetal", 1],	
	["mission_Convoy", 1],
	["mission_BaseConvoy", 1],	
	["mission_MiniConvoy", 1],	
	["mission_CarJack", 1],	
    ["mission_altisPatrol2", 1],
	["mission_TroopsRelocation", 1]
];

InfantryMissions =
[
	// Mission filename, weight
	["mission_BombDisposal",1],
	["mission_SpecOps", 1],	
	["mission_AirWreck", 1],
	["mission_drugsRunners", 1],
	["mission_ArmyBounty", 1],
	["mission_redDawn", 1],
	["mission_geoCache", 1],
	["mission_InfGroup", 1],	
	["mission_Samsite", 1],
	["mission_Samsite2", 1],
	["mission_Spetsnaz", 1],	
	["mission_Roulette", 1],
	["mission_hightechengineer", 1],
	["mission_ArtilleryH", 1],
	["mission_downedFalcon",1],
	["mission_StomperSOS",1],	
    ["mission_Explosives", 1],
	["mission_UAV", 1],	
	["mission_Sniper", 1],
	["mission_APC", 1],
	["mission_MBT", 1],
	["mission_JET", 1],
	["mission_VTOL", 1],	
	["mission_LightArmVeh", 1],
	["mission_ArmedHeli", 1],
	["mission_CivHeli", 1],	
	["mission_WepCache", 1],
	["mission_Smugglers", 1],
	["mission_Truck", 1]
];

PremiumMissions =
[
	//["mission_ChopperStrike", 1],
	["mission_Hackers", 1],
	["mission_GhostSniper", 1],	
	["mission_Autonomous", 1],
	["mission_tankRush", 1],	
	["mission_HackATM", 1],	
	["mission_Jackpot", 1],	
	["mission_prototypeTanks", 1],
	["mission_artypatrol", 1]
];


BountyMissions =
[
	//["mission_Bounty", 1]
];


MissionSpawnMarkers = (allMapMarkers select {["Mission_", _x] call fn_startsWith}) apply {[_x, false]};
AlcatrazSpawnMarkers = (allMapMarkers select {["Alcatraz_", _x] call fn_startsWith}) apply {[_x, false]};
ForestMissionMarkers = (allMapMarkers select {["ForestMission_", _x] call fn_startsWith}) apply {[_x, false]};
SunkenMissionMarkers = (allMapMarkers select {["SunkenMission_", _x] call fn_startsWith}) apply {[_x, false]};
SunkenMissionMarkers2 = (allMapMarkers select {["DeepSunkenMission_", _x] call fn_startsWith}) apply {[_x, false]};
SubBaseMissionMarkers = (allMapMarkers select {["SubBase_", _x] call fn_startsWith}) apply {[_x, false]};
RoadblockMissionMarkers2 = (allMapMarkers select {["RoadBlockMission_", _x] call fn_startsWith}) apply {[_x, false]};
SubMissionMarkers = (allMapMarkers select {["subRepair_", _x] call fn_startsWith}) apply {[_x, false]};
AirpostMissionMarkers = (allMapMarkers select {["Airpost_", _x] call fn_startsWith}) apply {[_x, false]};
RiotMissionMarkers = (allMapMarkers select {["Riot_", _x] call fn_startsWith}) apply {[_x, false]};
HarborMissionMarkers = (allMapMarkers select {["Harbor_", _x] call fn_startsWith}) apply {[_x, false]};
TheHeistMissionMarkers = (allMapMarkers select {["TheHeist_", _x] call fn_startsWith}) apply {[_x, false]};
RaceMissionMarkers = (allMapMarkers select {["Race_", _x] call fn_startsWith}) apply {[_x, false]};
DeepMissionMarkers = (allMapMarkers select {["Deep_", _x] call fn_startsWith}) apply {[_x, false]};
SamsiteMissionMarkers = (allMapMarkers select {["sam_", _x] call fn_startsWith}) apply {[_x, false]};
HackMissionMarkers = (allMapMarkers select {["hack_", _x] call fn_startsWith}) apply {[_x, false]};
MilitaryMissionMarkers = (allMapMarkers select {["milSpawn_", _x] call fn_startsWith}) apply {[_x, false]};
MazeMissionMarkers = (allMapMarkers select {["theMaze_", _x] call fn_startsWith}) apply {[_x, false]};
DemolitionMissionMarkers = (allMapMarkers select {["demolition_", _x] call fn_startsWith}) apply {[_x, false]};
SniperMissionMarkers = (allMapMarkers select {["sniper_", _x] call fn_startsWith}) apply {[_x, false]};

if !(ForestMissionMarkers isEqualTo []) then
{
	InfantryMissions append
	[
		["mission_AirWreck", 1.5],
		["mission_Sniper2", 1],
		["mission_WepCache", 1.5],
		["mission_Sniper", 1]
	];
};

LandConvoyPaths = (call compile preprocessFileLineNumbers "mapConfig\convoys\landConvoysList.sqf") apply {[_x, false]};
CoastalConvoyPaths = (call compile preprocessFileLineNumbers "mapConfig\convoys\coastalConvoysList.sqf") apply {[_x, false]};
RushConvoyPaths = (call compile preprocessFileLineNumbers "mapConfig\convoys\rushConvoysList.sqf") apply {[_x, false]};
ArtyConvoyPaths = (call compile preprocessFileLineNumbers "mapConfig\convoys\artyConvoysList.sqf") apply {[_x, false]};
FleetConvoyPaths = (call compile preprocessFileLineNumbers "mapConfig\convoys\fleetConvoysList.sqf") apply {[_x, false]};
SubConvoyPaths = (call compile preprocessFileLineNumbers "mapConfig\convoys\SubConvoysList.sqf") apply {[_x, false]};
PatrolConvoyPaths = (call compile preprocessFileLineNumbers "mapConfig\convoys\patrolConvoysList.sqf") apply {[_x, false]};
navalConvoyPaths = (call compile preprocessFileLineNumbers "mapConfig\convoys\navalConvoyList.sqf") apply {[_x, false]};
//TruckConvoyPaths = (call compile preprocessFileLineNumbers "mapConfig\convoys\truckConvoysList.sqf") apply {[_x, false]};
ConvoyStarts = (call compile preprocessFileLineNumbers "mapConfig\convoys\convoysStartList.sqf") apply {[_x, false]};


InfantryMissions = [InfantryMissions, [["A3W_heliPatrolMissions", ["mission_HostileHelicopter"]], ["A3W_underWaterMissions", ["mission_SunkenSupplies"]]]] call removeDisabledMissions;
ArmouredMissions = [ArmouredMissions, [["A3W_underWaterMissions"]]] call removeDisabledMissions;
AirborneMissions = [AirborneMissions, [["A3W_heliPatrolMissions", ["mission_GhostSwarm","mission_TanoaPatrol", "mission_HostileJetFormation", "mission_HostileHeliFormation", "mission_HostileHelicopter", "mission_HostileJet", "mission_PawneeSquadron"]]]] call removeDisabledMissions;


{ _x set [2, false] } forEach InfantryMissions;
{ _x set [2, false] } forEach ArmouredMissions;
{ _x set [2, false] } forEach AirborneMissions;
{ _x set [2, false] } forEach OccupationMissions;
{ _x set [2, false] } forEach MarineMissions;
{ _x set [2, false] } forEach PremiumMissions;
//{ _x set [2, false] } forEach BountyMissions;

ConvoyStarts = [];
{
	ConvoyStarts pushBack [_x, false];
} forEach (call compile preprocessFileLineNumbers "mapConfig\convoys\convoysStartList.sqf");
