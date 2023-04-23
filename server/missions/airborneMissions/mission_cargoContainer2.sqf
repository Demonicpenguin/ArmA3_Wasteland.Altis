// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_cargoContainer.sqf
//	@file Author: The Scotsman

#include "airborneMissionDefines.sqf";

if (!isServer) exitwith {};

private ["_class", "_vehicles", "_vehicle", "_count", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints", "_container", "_smokemarker", "_vehicleClass"];

_setupVars = {

	_missionType = "Heavy Armoured Cargo Drop";
	_locationsArray = nil; // locations are generated on the fly from towns

};

_setupObjects = {

	_missionPos = markerPos (((call cityList) call BIS_fnc_selectRandom) select 0);

	_class = [ST_APACHE,ST_APACHE_NORADAR,ST_APACHE_GREY,"B_Heli_Attack_01_F","B_Heli_Attack_01_dynamicLoadout_F",ST_COBRA,"RHS_UH60M_ESSS2_d"] call BIS_fnc_selectRandom;
	_count = [2,3] call BIS_fnc_randomInt;

	_aiGroup = createGroup CIVILIAN;

	_vehicles = [];

	//C130J
	_vehicle = [ST_C130, _missionPos, 0, _aiGroup] call STCreateVehicle;
	_vehicles set [0, _vehicle];

	for "_x" from 1 to _count do {

		_vehicle = [_class, _missionPos vectorAdd ([[random 500, 0, 0], random 360] call BIS_fnc_rotateVector2D), 0, _aiGroup] call STCreateVehicle;
		_vehicles set [_x, _vehicle];

	};

	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "COMBAT";
	_aiGroup setFormation "STAG COLUMN";

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;
	_leader setRank "LIEUTENANT";

	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };

	// behaviour on waypoints
	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 55;
		_waypoint setWaypointCombatMode "RED";
		_waypoint setWaypointBehaviour "COMBAT";
		_waypoint setWaypointFormation "STAG COLUMN";
		_waypoint setWaypointSpeed _speedMode;
	} forEach ((call cityList) call BIS_fnc_arrayShuffle);

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> ST_C130 >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> ST_C130 >> "displayName");
	_missionHintText = format ["A <t color='%2'>%1</t> and at least two armed escorts are transporting a Heavy Armoured Tank. Shoot it down and kill the pilot to recover the Hardware and cash!", _vehicleName, airborneMissionColor];

	_numWaypoints = count waypoints _aiGroup;

};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome
_successExec = {

	_vehicleClass =
	[
		"B_MBT_01_cannon_F",
		"O_MBT_02_cannon_F",
		"I_MBT_03_cannon_F",
		"RHS_M2A3_BUSKIII",
		"O_MBT_04_command_F",
		"O_APC_Tracked_02_AA_F",
		"rhsusf_m1a2sep1tuskiiwd_usarmy"
	] call BIS_fnc_selectRandom;
	
	_tank = _vehicleClass createVehicle [0,0,0];
	_tank setDir random 360;

	if( _unitPos select 2 > 20 ) then {

		_unitPos set[2, (_unitPos select 2) + 20];

		_tank setPos _unitPos;
		_tank call STParaDropObject;

		_tank spawn {

			private _pos = nil;
			private _veh = _this;

			waitUntil {
				sleep 0.1;
				_pos = getPos _veh;
				(isTouchingGround _veh || _pos select 2 < 5) && {vectorMagnitude velocity _veh < [1,5] select surfaceIsWater _pos}
			};

			//The Crate Has Landed, Spawn Money
			[_pos, 300000] call STFixedCashReward;

		};

		_successHintMessage = "The transport was stopped! The Tank and cash has been dropped by parachute nearby.";

	} else {

			[_lastPos, 300000] call STFixedCashReward;

			_successHintMessage = "The transport was stopped! The Tank and cash has been dropped.";

	};
	
	//Smoke to mark the crates
	_smokemarker = createMarker ["SMMarker1", _lastPos];
	[_smokemarker] spawn CrateSmoke; //Calls repeating green smoke grenade
	uiSleep 2;		
	deleteMarker "SMMarker1"; 	

};

_this call airborneMissionProcessor;
