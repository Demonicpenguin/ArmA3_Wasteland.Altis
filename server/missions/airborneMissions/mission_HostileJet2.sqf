// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_HostileJet.sqf
//	@file Author: JoSchaap, AgentRev, LouD

if (!isServer) exitwith {};
#include "airborneMissionDefines.sqf";

private ["_smokemarker", "_planeChoices", "_convoyVeh", "_veh1", "_veh2", "_veh3", "_createVehicle", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints", "_cash", "_boxes1", "_currBox1", "_boxes2", "_currBox2", "_box1", "_box2"];

_setupVars =
{
	_missionType = "Operation Triple Trouble";
	_locationsArray = nil; // locations are generated on the fly from towns
};

_setupObjects =
{
	_missionPos = markerPos (((call cityList) call BIS_fnc_selectRandom) select 0);

	_planeChoices =
	[
		[["B_Plane_CAS_01_dynamicLoadout_F", "Universal"], ["B_Plane_CAS_01_dynamicLoadout_F", "Universal"], ["B_Plane_CAS_01_dynamicLoadout_F", "24xHE28xAP"]],
		[["O_Plane_CAS_02_dynamicLoadout_F", "neophronCAS"], ["O_Plane_CAS_02_dynamicLoadout_F", "neophronAA"], ["O_Plane_CAS_02_dynamicLoadout_F", "neophronAP"]],
		[["I_Plane_Fighter_03_dynamicLoadout_F", "buzzardAA"], ["I_Plane_Fighter_03_dynamicLoadout_F", "buzzardCAS"], ["I_Plane_Fighter_03_dynamicLoadout_F", "buzzardAA"]]
	];

    _convoyVeh = _planeChoices call BIS_fnc_selectRandom;

    _veh1 = [(_convoyVeh select 0) select 0, (_convoyVeh select 0) select 1];
    _veh2 = [(_convoyVeh select 1) select 0, (_convoyVeh select 1) select 1];
    _veh3 = [(_convoyVeh select 2) select 0, (_convoyVeh select 2) select 1];

	_createVehicle =
	{
		private ["_type","_position","_direction","_vehicle","_soldier", "_variant"];

		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;
        _variant = _this select 3;

		_vehicle = createVehicle [_type, _position, [], 0, "FLY"]; // Added to make it fly

        if (_variant != "") then
        {
            _vehicle setVariable ["A3W_vehicleVariant", _variant, true];
        };

        [_vehicle] call vehicleSetup;

		_vehicle setVariable ["R3F_LOG_disabled", true, true];
		_vel = [velocity _vehicle, -(_direction)] call BIS_fnc_rotateVector2D; // Added to make it fly
		_vehicle setDir _direction;
		_vehicle setVelocity _vel; // Added to make it fly
		_vehicle setVariable [call vChecksum, true, false];
		_aiGroup addVehicle _vehicle;

		// add pilot
		_soldier = [_aiGroup, _position] call createRandomSoldierC;
		_soldier moveInDriver _vehicle;
        _soldier setSkill ["aimingSpeed", 1];
        _soldier setSkill ["aimingAccuracy", 1];
        _soldier setSkill ["spotTime", 1];
        _soldier setSkill ["reloadSpeed", 1];
        _soldier setSkill ["commanding", 1];
		// lock the vehicle untill the mission is finished and initialize cleanup on it

		[_vehicle, _aiGroup] spawn checkMissionVehicleLock;
		_vehicle
	};

	_aiGroup = createGroup CIVILIAN;

	_vehicles =
	[
		[_veh1 select 0, _missionPos vectorAdd ([[random 50, 0, 0], random 360] call BIS_fnc_rotateVector2D), 0, _veh1 select 1] call _createVehicle,
		[_veh2 select 0, _missionPos vectorAdd ([[random 50, 0, 0], random 360] call BIS_fnc_rotateVector2D), 0, _veh2 select 1] call _createVehicle,
		[_veh3 select 0, _missionPos vectorAdd ([[random 50, 0, 0], random 360] call BIS_fnc_rotateVector2D), 0, _veh3 select 1] call _createVehicle
	];
	
	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;
	_leader setRank "CAPTAIN";
	
	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "COMBAT";
	_aiGroup setFormation "VEE";
	
	_speedMode = if (missionDifficultyHard) then { "FULL" } else { "FULL" };
	
	// behaviour on waypoints
	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "SAD";
		_waypoint setWaypointCompletionRadius 55;
		_waypoint setWaypointCombatMode "RED";
		_waypoint setWaypointBehaviour "COMBAT";
		_waypoint setWaypointFormation "VEE";
		_waypoint setWaypointSpeed _speedMode;
	} forEach ((call cityList) call BIS_fnc_arrayShuffle);

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _veh1 select 0 >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _veh1 select 0 >> "displayName");
	_missionHintText = format ["Three ACE Pilots are looking for a little fun. Three <t color='%2'>%1</t> are patrolling the island. Shoot then down and kill the pilots to recover the money and weapons!", _vehicleName, airborneMissionColor];

	_numWaypoints = count waypoints _aiGroup;
};
	
_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome

_successExec =
{
	// Mission completed

	//Money
	for "_i" from 1 to 8 do
	{
		_cash = createVehicle ["Land_Money_F", _lastPos, [], 5, "None"];
		_cash setPos ([_lastPos, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
		_cash setDir random 360;
		_cash setVariable ["cmoney", 50000, true];
		_cash setVariable ["owner", "world", true];
	};

	_Boxes1 = ["Box_NATO_WpsSpecial_F","Box_NATO_WpsSpecial_F","Box_IND_WpsLauch_F"];
	_currBox1 = _Boxes1 call BIS_fnc_selectRandom;
	_box1 = createVehicle [_currBox1, _lastPos, [], 2, "None"];
	_box1 setDir random 360;
	_box1 allowDamage false;

	_Boxes2 = ["Box_IED_Exp_F","Box_EAF_WpsLauch_F","Box_FIA_Wps_F"];
	_currBox2 = _Boxes2 call BIS_fnc_selectRandom;
	_box2 = createVehicle [_currBox2, _lastPos, [], 2, "None"];
	_box2 setDir random 360;
	_box2 allowDamage false;
	
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2];
	
	//Smoke to mark the crates
	_smokemarker = createMarker ["SMMarker1", _lastPos];
	[_smokemarker] spawn CrateSmoke; //Calls repeating green smoke grenade
	uiSleep 2;		
	deleteMarker "SMMarker1";	

	_successHintMessage = "They weren't that skilled after all. The sky is clear again, the enemy patrol was taken out! Ammo crates and some money have fallen near the pilot.";
};

_this call airborneMissionProcessor;
