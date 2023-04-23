// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 2
//	@file Name: mission_Coastal_Convoy.sqf
//	@file Author: JoSchaap / routes by Del1te - (original idea by Sanjo)
//	@file Created: 02/09/2013 11:29
//	@file Args: none

if (!isServer) exitwith {};
#include "marineMissionDefines.sqf";

private ["_vehChoices", "_convoyVeh", "_veh1", "_veh2", "_veh3", "_veh4", "_createVehicle", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_vehicleName2", "_numWaypoints", "_box1", "_box2", "_box3", "_smoke2", "_flare2"];

_setupVars =
{
	_missionType = "CB90 Coastal Patrol";
	_locationsArray = CoastalConvoyPaths;
};

_setupObjects =
{
	private ["_starts", "_startDirs", "_waypoints"];
	call compile preprocessFileLineNumbers format ["mapConfig\convoys\%1.sqf", _missionLocation];

	_vehChoices =
	[
		["HAFM_CB90_BLU", "B_Heli_Transport_01_F"],
		["HAFM_CB90", "I_Heli_light_03_F"]
	];

	if (missionDifficultyHard) then
	{
		(_vehChoices select 0) set [1, "B_Heli_Attack_01_F"];
		(_vehChoices select 1) set [1, "O_Heli_Attack_02_F"];
		(_vehChoices select 2) set [1, "O_Heli_Attack_02_black_F"];
	};

	_convoyVeh = _vehChoices call BIS_fnc_selectRandom;

	_veh1 = _convoyVeh select 0;
	_veh2 = _convoyVeh select 1;
	_veh3 = _convoyVeh select 0;

	_createVehicle =
	{
		private ["_type", "_position", "_direction", "_special", "_vehicle", "_soldier"];

		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;

		_vehicle = createVehicle [_type, _position, [], 0, "FLY"];
		_vehicle setVariable ["R3F_LOG_disabled", true, true];
		[_vehicle] call vehicleSetup;

		_vehicle setDir _direction;
		_aiGroup addVehicle _vehicle;

		// add a driver/pilot/captain to the vehicle
		// the little bird, orca, and hellcat do not require gunners and should not have any passengers
		_soldier = [_aiGroup, _position] call createRandomSoldierC;
		_soldier moveInDriver _vehicle;

		switch (true) do
		{
			case (_type isKindOf "Boat_Armed_01_base_F"):
			{
				// the boats need a gunner (rear) and a commander (frontgunner) aside from a driver
				if (missionDifficultyHard) then
				{
					// frontgunner will be here if mission is running at hard dificulty
					_soldier = [_aiGroup, _position] call createRandomSoldierC;
					_soldier moveInTurret [_vehicle, [0]]; // commanderseat - front gunner
				};

				_soldier = [_aiGroup, _position] call createRandomSoldierC;
				_soldier moveInTurret [_vehicle, [1]]; // rear gunner
			};

			case (_type isKindOf "Heli_Transport_01_base_F"):
			{
				// these choppers have 2 turrets so we need 2 gunners
				_soldier = [_aiGroup, _position] call createRandomSoldierC;
				_soldier moveInTurret [_vehicle, [1]];

				_soldier = [_aiGroup, _position] call createRandomSoldierC;
				_soldier moveInTurret [_vehicle, [2]];
			};

			case (_type isKindOf "Heli_Attack_01_base_F" || _type isKindOf "Heli_Attack_02_base_F"):
			{
				// these choppers need 1 gunner
				_soldier = [_aiGroup, _position] call createRandomSoldierC;
				_soldier moveInGunner _vehicle;
			};

			case (_type isKindOf "HAFM_CB90_BLU" || _type isKindOf "HAFM_CB90"): // driver assigned, now assign 2 other ship positions				
			{
				_soldier = [_aiGroup, _position] call createRandomSoldierC;
				_soldier moveInTurret [_vehicle, [0]];
				if (isNull objectParent _soldier) then {_soldier setDamage 1;};				
				_soldier = [_aiGroup, _position] call createRandomSoldierC;
				_soldier moveInTurret [_vehicle, [1]];
				if (isNull objectParent _soldier) then {_soldier setDamage 1;};		
			};			
		};

		// remove flares because it overpowers AI choppers
		/*if (_type isKindOf "Air") then
		{
			{
				if (["CMFlare", _x] call fn_findString != -1) then
				{
					_vehicle removeMagazinesTurret [_x, [-1]];
				};
			} forEach getArray (configFile >> "CfgVehicles" >> _type >> "magazines");
		};*/

		[_vehicle, _aiGroup] spawn checkMissionVehicleLock;
		_vehicle
	};

	_aiGroup = createGroup CIVILIAN;

	_vehicles =
	[
		[_veh1, _starts select 0, _startdirs select 0] call _createVehicle,
		[_veh2, _starts select 1, _startdirs select 1] call _createVehicle,
		[_veh3, _starts select 2, _startdirs select 2] call _createVehicle
	];

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;

	_aiGroup setCombatMode "GREEN"; // units will defend themselves
	_aiGroup setBehaviour "SAFE"; // units feel safe until they spot an enemy or get into contact
	_aiGroup setFormation "STAG COLUMN";

	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };

	_aiGroup setSpeedMode _speedMode;

	// behaviour on waypoints
	{
		_waypoint = _aiGroup addWaypoint [_x, 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 50;
		_waypoint setWaypointCombatMode "GREEN";
		_waypoint setWaypointBehaviour "SAFE";
		_waypoint setWaypointFormation "STAG COLUMN";
		_waypoint setWaypointSpeed _speedMode;
	} forEach _waypoints;

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _veh1 >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _veh1 >> "displayName");
	_vehicleName2 = getText (configFile >> "CfgVehicles" >> _veh2 >> "displayName");

	_missionHintText = format ["Two <t color='%3'>%1</t> are patrolling the coasts, escorted by a <t color='%3'>%2</t>.<br/>Intercept them and recover the cash cargo!", _vehicleName, _vehicleName2, marineMissionColor];

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

	_successHintMessage = "The CB_90 convoy has been destroyed, an airdrop of a small craft has been dropped. Navigate to the boat and collect the 1 million reward!<br/>Please destroy the light craft once looted";	

	_Boxes = selectrandom ["Box_IND_Wps_F","Box_East_Wps_F","Box_NATO_Wps_F","Box_NATO_AmmoOrd_F","Box_NATO_Grenades_F","Box_East_WpsLaunch_F","Box_NATO_WpsLaunch_F","Box_East_WpsSpecial_F","Box_NATO_WpsSpecial_F"];
	_veh6 = selectrandom ["C_Boat_Civil_01_F"];
	_lastPos set [2, 200];
	_Box = createVehicle [_veh6, _lastPos, [], 0, "None"];
	_Box2 = createVehicle [_Boxes, _lastPos, [], 0, "None"];	
	_Box2 setVariable ["cmoney", 1000000, true];	
	
	_Box2 attachTo [_Box, [0, -1.1, -.9] ]; 	

	//_Box addMagazineCargo [_Box2, 5];	
	_para = createVehicle ["B_Parachute_02_F", _lastPos, [], 0, "None"];
	_Box attachTo [_para,[0,0,-1.5]];
	_Box allowDamage false;


	WaitUntil {((((position _Box) select 2) < 1) || (isNil "_para"))};
	detach _Box;
	
	_Box SetVelocity [0,0,-5];           
	sleep 0.3;
	_Box setPos [(position _Box) select 0, (position _Box) select 1, 1];
	_Box SetVelocity [0,0,0];		
	
	_smoke2= "SmokeShellBlue" createVehicle getPos _Box;
	_flare2= "F_40mm_Blue" createVehicle getPos _Box;
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_Box, _Box2];
};

_this call marineMissionProcessor;
