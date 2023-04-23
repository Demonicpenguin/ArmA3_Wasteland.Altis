// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_cargoContainer.sqf
//	@file Author: The Scotsman

if (!isServer) exitwith {};
#include "premiumMissionDefines.sqf";

private ["_transport", "_transports", "_attacks", "_escorts", "_scouts", "_attack","_escort", "_scout", "_pos", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints", "_smokemarker"];

_setupVars = {
	_missionType = "Chopper Strike";
	_locationsArray = nil; // locations are generated on the fly from towns
};

_transports = ["I_Heli_Transport_02_F", "B_Heli_Transport_03_F"];

_attacks = [
	"B_Heli_Attack_01_dynamicLoadout_F",
	"O_Heli_Attack_02_dynamicLoadout_F",
	"rhs_ka60_c",
	"rhs_ka60_grey",
	"O_Heli_Light_02_dynamicLoadout_F",
	"B_Heli_Attack_01_F"
];

_scouts = [
	"B_Heli_Light_01_dynamicLoadout_F",
	"O_Heli_Light_02_dynamicLoadout_F",
	"I_Heli_light_03_dynamicLoadout_F",
	"RHS_MELB_AH6M",
	"RHS_MELB_AH6M",
	"RHS_MELB_AH6M",
	"RHS_MELB_AH6M"
];

_escorts = [
	"I_Heli_light_03_dynamicLoadout_F",
	"RHS_AH64D",
	"RHS_Mi24Vt_vvs",
	"B_Heli_Attack_01_dynamicLoadout_F"
];

_attack = _attacks call BIS_fnc_selectRandom;
_scout = _scouts call BIS_fnc_selectRandom;
_escort = _escorts call BIS_fnc_selectRandom;
_transport = _transports call BIS_fnc_selectRandom;

_setupObjects = {

	_missionPos = markerPos (((call cityList) call BIS_fnc_selectRandom) select 0);

	_aiGroup = createGroup CIVILIAN;
	_vehicles =
	[
	[_attack, _missionPos vectorAdd ([[random 250, 0, 0], random 200] call BIS_fnc_rotateVector2D), 0, _aiGroup] call STCreateVehicle,
    [_attack, _missionPos vectorAdd ([[random 350, 0, 0], random 250] call BIS_fnc_rotateVector2D), 0, _aiGroup] call STCreateVehicle,
	[_escort, _missionPos vectorAdd ([[random 750, 0, 0], random 550] call BIS_fnc_rotateVector2D), 0, _aiGroup] call STCreateVehicle,
    [_escort, _missionPos vectorAdd ([[random 850, 0, 0], random 600] call BIS_fnc_rotateVector2D), 0, _aiGroup] call STCreateVehicle,
    [_escort, _missionPos vectorAdd ([[random 950, 0, 0], random 650] call BIS_fnc_rotateVector2D), 0, _aiGroup] call STCreateVehicle
  ];

	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "COMBAT";
	_aiGroup setFormation "VEE";

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;
	_leader setRank "LIEUTENANT";

	_speedMode = "NORMAL";

	// behaviour on waypoints
	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 55;
		_waypoint setWaypointCombatMode "RED";
		_waypoint setWaypointBehaviour "COMBAT";
		_waypoint setWaypointFormation "VEE";
		_waypoint setWaypointSpeed "NORMAL";
	} forEach ((call cityList) call BIS_fnc_arrayShuffle);

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = "media\chopperstrike.jpg";	
	_vehicleName = getText (configFile >> "CfgVehicles" >> _attack >> "displayName");
	_missionHintText = format ["A 5 strong formation of armed helicopters are conducting an air strike on an undisclosed location.  Stop them!", premiumMissionColor];

	_numWaypoints = count waypoints _aiGroup;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome
_successExec = {

	_pos = getMarkerPos _marker;

	//Cash
	[_lastPos, [200000, 400000, 400000,400000,400000, 800000]] call STRandomCashReward;

	//Crates
	[(getMarkerPos _marker), [2, 6]] call STRandomCratesReward;
	
	//Smoke to mark the crates
	_smokemarker = createMarker ["SMMarker1", _lastPos];
	[_smokemarker] spawn CrateSmoke; //Calls repeating green smoke grenade
	uiSleep 2;		
	deleteMarker "SMMarker1"; 	

	_successHintMessage = "The Chopper Strike has been averted.  Cargo has been dropped by the last vehicle";

};

_this call premiumMissionProcessor;
