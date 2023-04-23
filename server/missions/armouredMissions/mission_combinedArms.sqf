// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_artyPatrol.sqf
//	@file Author: WitchDoctor [GGO]

if (!isServer) exitwith {};

#include "armouredMissionDefines.sqf";

private ["_location", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_vehicleName2", "_numWaypoints","_noTanks", "_noHelis"];

_setupVars = {

	_missionType = "Combined Arms";
	_locationsArray = nil;

};

_setupObjects = {

	_town = (call cityList) call BIS_fnc_selectRandom;
	_missionPos = markerPos (_town select 0);

	_aiGroup = createGroup CIVILIAN;
	_location = [_missionPos] call STFindRoadPosDir;
	_vehicles = [];

	private _pos = _location select 0;
	private _dir = _location select 1;
	
	for "_i" from 1 to 4 do {

		_vehicles pushBack ([selectRandom ST_TANKS, _pos, _dir, _aiGroup] call STCreateVehicle);
		_pos = [(_pos getPos [20, _dir]), 0, 50, 10, 0, 60 * (pi / 180), 0] call findSafePos;

	};
	
	for "_i" from 1 to 2 do {

		_vehicles pushBack ([selectRandom ST_ATTACK_HELOS, _missionPos vectorAdd ([[random 250, 0, 0], random 360] call BIS_fnc_rotateVector2D), 0, _aiGroup] call STCreateVehicle)

	};

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;
	_leader setRank "LIEUTENANT";

	_aiGroup setCombatMode "YELLOW"; // units will defend themselves
	_aiGroup setBehaviour "SAFE"; // units feel safe until they spot an enemy or get into contact
	_aiGroup setFormation "STAG COLUMN";

	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };

	_aiGroup setSpeedMode _speedMode;

	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 50;
		_waypoint setWaypointCombatMode "YELLOW";
		_waypoint setWaypointBehaviour "SAFE"; // safe is the best behaviour to make AI follow roads, as soon as they spot an enemy or go into combat they WILL leave the road for cover though!
		_waypoint setWaypointFormation "FILE";
		_waypoint setWaypointSpeed _speedMode;
	} forEach ((call cityList) call BIS_fnc_arrayShuffle);

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> typeOf (_vehicles select 0) >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >>  typeOf (_vehicles select 0) >> "displayName");
	_vehicleName2 = getText (configFile >> "CfgVehicles" >>  typeOf (_vehicles select 6) >> "displayName");

	_missionHintText = format ["A combined arms convoy containing at least a <t color='%3'>%1</t>, and a <t color='%3'>%2</t> has been spotted. Defeat them and capture their supplied and money!", _vehicleName, _vehicleName2, armouredMissionColor];

	_numWaypoints = count waypoints _aiGroup;

};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome
_successExec = {

	//A random (possible large)cash reward
	[_lastPos, [10000,15000,20000,25000,30000,30000,30000,30000,35000,40000,45000,80000]] call STRandomCashReward;

	//Random Number of Crates
	[_lastPos, [1, 4]] call STRandomCratesReward;

	_successHintMessage = "Well done, the patrol has been stopped.  The money, crates and vehicles are yours to take.";

};

_this call armouredMissionProcessor;
