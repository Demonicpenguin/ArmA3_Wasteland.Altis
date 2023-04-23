// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_cargoContainer.sqf
//	@file Author: The Scotsman

#include "airborneMissionDefines.sqf";

if (!isServer) exitwith {};

private ["_class", "_vehicles", "_vehicle", "_count", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints", "_container", "_smokemarker"];

_setupVars = {

	_missionType = "Cargo Container";
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
	_missionHintText = format ["A <t color='%2'>%1</t> and at least two armed escorts are transporting a payroll and some cargo. Shoot it down and kill the pilot to recover container and the money!", _vehicleName, airborneMissionColor];

	_numWaypoints = count waypoints _aiGroup;

};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome
_successExec = {

	//Thirty percent chance of actual cargo container
	private _reward = [ST_CARGO_SMALL, ST_CARGO_LARGE] select (30 > random 100);

	
	// Mission completed
	//_container = [_lastPos, nil, true, false, _reward] call STCreateContainer;
	
	_container = createVehicle [_reward, _lastPos, [], 2, "NONE"];
	_container setDir random 360;
	_container allowDamage false;
	_container setVariable ["R3F_LOG_disabled", _disabled, true];
	_container setVariable ["moveable", true, true];	

	//At least put some crap in the crate
	if( _reward == ST_CARGO_SMALL ) then {

		private _veh = [(selectRandom [ST_STATIC_AA, ST_STATIC_AT, ST_MORTER]), _lastPos] call createMissionVehicle;

		[_veh, 1] call A3W_fnc_setLockState; // Unlock

		//Load Reward inside crate
		nul = [_container, [_veh]] execVM "addons\R3F_LOG\auto_load_in_vehicle.sqf";

	};
	
	if( _reward == ST_CARGO_LARGE ) then {

		//Load Reward inside crate
		[_container, [[ST_STATIC_AA, 1],[ST_STATIC_AT, 1],[ST_MORTER, 1]]] execVM "addons\R3F_LOG\auto_load_in_vehicle.sqf";
	};	

	if( _unitPos select 2 > 20 ) then {

		_unitPos set[2, (_unitPos select 2) + 20];

		_container setPos _unitPos;
		_container call STParaDropObject;

		_container spawn {

			private _pos = nil;
			private _veh = _this;

			waitUntil {
				sleep 0.1;
				_pos = getPos _veh;
				(isTouchingGround _veh || _pos select 2 < 5) && {vectorMagnitude velocity _veh < [1,5] select surfaceIsWater _pos}
			};

			//The Crate Has Landed, Spawn Money
			[_pos, 500000] call STFixedCashReward;

		};

		_successHintMessage = "The transport was stopped! The cargo and payroll has been dropped by parachute nearby.";

	} else {

			[_lastPos, 500000] call STFixedCashReward;

			_successHintMessage = "The transport was stopped! The cargo and payroll has been dropped.";

	};
	
	//Smoke to mark the crates
	_smokemarker = createMarker ["SMMarker1", _lastPos];
	[_smokemarker] spawn CrateSmoke; //Calls repeating green smoke grenade
	uiSleep 2;		
	deleteMarker "SMMarker1"; 	

};

_this call airborneMissionProcessor;
