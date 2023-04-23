//	@file Name: mission_SpecOps.sqf
//	@file Author: AryX, [FRAC] Mokey , soulkobk
//	@file Version: 0.1
//	@file Description: SpecOps Extra-Mission

if (!isServer) exitWith {};

#include "infantryMissionDefines.sqf";

private ["_pos","_radius","_leader","_speedMode","_waypoint","_numWaypoints","_groupAmount","_box1","_box2"];

_setupVars =
{
	_missionType = "SpecOps Paratroops";
	_locationsArray = nil;
};

_setupObjects =
{
    _skippedTowns = // get the list from -> ttp\configs\mapConfig\towns.sqf
    [
        "Town_14" // Pythos Island Marker Name
    ];

    _town = ""; 
    _missionPos = [0,0,0]; 
    _radius = 0;
    _townOK = false;
    while {!_townOK} do {
        _town = (call cityList) call BIS_fnc_selectRandom;
        _missionPos = markerPos (_town select 0); // the town position.
        _radius = (_town select 1); // the town radius.
        _anyPlayersAround = (nearestObjects [_missionPos,["MAN"],_radius]) select {isPlayer _x}; // search the area for players only.
        if (((count _anyPlayersAround) isEqualTo 0) && !((_town select 0) in _skippedTowns)) exitWith // if there are no players around and the town marker is not in the skip list, set _townOK to true (exit loop).
        {
            _townOK = true;
        };
        sleep 0.1;
    };

	_aiGroup = createGroup CIVILIAN;
	_groupAmount = (round(random 6) + 12); // min 12, max 18
	_soldiers = [_aiGroup,_missionPos,_groupAmount,_radius] call createCustomGroupAirSpecOps;
	{
		// skill level is "HIGH" for all (see setMissionSkill.sqf).
		_x setSkill ["aimingSpeed", 0.3];
		_x setSkill ["spotDistance", 0.3];
		_x setSkill ["aimingAccuracy", 0.3];
		_x setSkill ["aimingShake", 0.3];
		_x setSkill ["spotTime", 0.5];
		_x setSkill ["spotDistance", 0.8];
		_x setSkill ["commanding", 0.8];
		_x setSkill ["general", 0.9];
	} forEach _soldiers;

	_leader = leader _aiGroup;
	_aiGroup selectLeader _leader;	
	_leader setRank "LIEUTENANT";
	_aiGroup setCombatMode "GREEN"; // units will defend themselves
	_aiGroup setBehaviour "SAFE"; // units feel safe until they spot an enemy or get into contact
	_aiGroup setFormation "STAG COLUMN";

	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };
	_aiGroup setSpeedMode _speedMode;

	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 50;
		_waypoint setWaypointCombatMode "RED";
		_waypoint setWaypointBehaviour "COMBAT";
		_waypoint setWaypointFormation "STAG COLUMN";
		_waypoint setWaypointSpeed _speedMode;
	} forEach ((call cityList) call BIS_fnc_arrayShuffle);

	_missionPos = getPosATL leader _aiGroup;
	
	_missionPicture = "media\specops.jpg";
	_missionHintText = format ["<br/>A Special Operations Force have parachuted over <br/><t size='1.25' color='%1'>%2</t><br/><br/>and making their way to the neighbouring towns. Locate and kill them and take their supplies before they disappear!", infantryMissionColor, (_town select 2)];
	_numWaypoints = count wayPoints _aiGroup;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};
_failedExec = nil;

_successExec =
{
	_box1 = createVehicle ["Box_Syndicate_Wps_F", _lastPos, [], 5, "None"];
	_box1 setDir random 360;
	[_box1, "mission_Gear_BlackBox"] call fn_refillbox;
	_box1 setVariable ["cmoney", 150000, true];	
	
	_box2 = createVehicle ["Box_Syndicate_Ammo_F", _lastPos, [], 5, "None"];
	_box2 setDir random 360;
	[_box2, "mission_Launchers4"] call fn_refillbox;
	_box2 setVariable ["cmoney", 150000, true];	
	
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2];	

	_successHintMessage = "Good job, you successfully defeated the SpecOps,<br/>Now go and retrieve their supplies!";
};

_this call infantryMissionProcessor;