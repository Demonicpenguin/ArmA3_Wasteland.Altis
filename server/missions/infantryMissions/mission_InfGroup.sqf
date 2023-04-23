// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2019 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_InfGroup.sqf
//	@file Author: AryX
//	@file Version: 0.2
//	@file Description: InfGroup Extra-Mission

if (!isServer) exitWith {};
#include "infantryMissionDefines.sqf";


private ["_totalEarnings", "_townName", "_location", "_leader", "_InfantryGroup", "_speedMode", "_waypoint", "_numWaypoints", "_moneyAmount", "_groupsAmount", "_cash", "_nbUnits", "_moneyText"];

_setupVars =
{
	_locationsArray = nil;
	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };	
};

_setupObjects =
{
	_town = (call cityList) call BIS_fnc_selectRandom;
	_missionPos = markerPos (_town select 0);
	_townName = _town select 2;	

	_aiGroup = createGroup CIVILIAN;
	_location = [_missionPos] call STFindRoadPosDir;
	
	private _pos = _location select 0;
	private _dir = _location select 1;

	
	
	_InfantryGroup =
	[
		// Small
		[
			"Small Infantry Group", // Marker text
			24000, // Money
			_nbUnits
		],
		// Medium
		[
			"Medium Infantry Group", // Marker text
			48000, // Money
			(_nbUnits) * 2
		],
		// Large
		[
			"Large Infantry Group", // Marker text
			72000, // Money
			(_nbUnits) * 3
		],
		// Heavy
		[
			"Heavy Infantry Group", // Marker text
			96000, // Money
			(_nbUnits) * 4
		]
	]
	call BIS_fnc_selectRandom;

	_missionType = _InfantryGroup select 0;
	_moneyAmount = _InfantryGroup select 1;
	_groupsAmount = _InfantryGroup select 2;
	_totalEarnings = _moneyAmount * 10;
	
	[_aiGroup, _pos, _groupsAmount] call customGroupPatrol;	

	_moneyText = format ["$%1", [_totalEarnings] call fn_numbersText];
	
	_leader = leader _aiGroup;
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

	_missionPicture = "media\footpatrol.jpg";
	_missionHintText = format ["<br/>A foot patrol of %3 Infantry soldiers are heading out of <br/><t size='1.1' color='%1'>%4</t><br/>Ambush and kill the patrol to earn <t color='%1'>%2</t>!", infantryMissionColor, _moneyText, _groupsAmount, _townName];

	_numWaypoints = count waypoints _aiGroup;
	
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

_successExec =
{
	// Mission completed

	for "_i" from 1 to 10 do
	{
		_cash = createVehicle ["Land_Money_F", _lastPos, [], 5, "None"];
		_cash setPos ([_lastPos, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
		_cash setDir random 360;
		_cash setVariable ["cmoney", _moneyAmount, true];
		_cash setVariable ["owner", "world", true];
	};
	_successHintMessage = "Well done, the money is yours.";
};

_this call infantryMissionProcessor;