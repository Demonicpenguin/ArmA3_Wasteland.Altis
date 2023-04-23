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

private ["_vehChoices", "_convoyVeh", "_veh1", "_veh2", "_createVehicle", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_vehicleName2", "_numWaypoints", "_Boxes", "_Box", "_box1", "_Box2", "_box3"];

_setupVars =
{
	_missionType = "Hunt for Red October";
	_locationsArray = SubConvoyPaths;
};

_setupObjects =
{
	private ["_starts", "_startDirs", "_waypoints"];
	call compile preprocessFileLineNumbers format ["mapConfig\convoys\%1.sqf", _missionLocation];

	_vehChoices =
	[
		["HAFM_Virginia", "HAFM_Yasen"],
		["HAFM_Yasen", "HAFM_209"],
		["HAFM_209", "HAFM_214"],
		["HAFM_214", "HAFM_Virginia"]
	];

	_convoyVeh = _vehChoices call BIS_fnc_selectRandom;

	_veh1 = _convoyVeh select 0;

	_createVehicle =
	{
		private ["_type", "_position", "_direction", "_special", "_vehicle", "_soldier"];

		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;

		_vehicle = createVehicle [_type, _position, [], 0, "FLY"];
		_vehicle setVehicleReportRemoteTargets true;
		_vehicle setVehicleReceiveRemoteTargets true;
		_vehicle setVehicleRadar 1;
		_vehicle confirmSensorTarget [west, true];
		_vehicle confirmSensorTarget [east, true];
		_vehicle confirmSensorTarget [resistance, true];		
		_vehicle setVariable ["R3F_LOG_disabled", true, true];

		[_vehicle] call vehicleSetup;
		
		[_vehicle, 20] spawn HAFM_fnc_Dive;		


		_vehicle setDir _direction;
			

		_aiGroup addVehicle _vehicle;

		// add a driver/pilot/captain to the vehicle
		// the little bird, orca, and hellcat do not require gunners and should not have any passengers
		_soldier = [_aiGroup, _position] call createRandomSoldierC;
		_soldier moveInDriver _vehicle;
		_soldier triggerDynamicSimulation true;
		switch (true) do 
		{
			case (_type isKindOf "HAFM_Virginia" || _type isKindOf "HAFM_Yasen" || _type isKindOf "HAFM_209" || _type isKindOf "HAFM_214"): // driver assigned, now assign 6 other ship positions
			{
				_soldier = [_aiGroup, _position] call createRandomSoldierC;
				_soldier moveInTurret [_vehicle, [0]];
				if (isNull objectParent _soldier) then {_soldier setDamage 1;};				
				_soldier = [_aiGroup, _position] call createRandomSoldierC;
				_soldier moveInTurret [_vehicle, [1]];
				if (isNull objectParent _soldier) then {_soldier setDamage 1;};				
				_soldier = [_aiGroup, _position] call createRandomSoldierC;
				_soldier moveInTurret [_vehicle, [2]];
				if (isNull objectParent _soldier) then {_soldier setDamage 1;};				
				_soldier = [_aiGroup, _position] call createRandomSoldierC;
				_soldier moveInTurret [_vehicle, [3]];
				if (isNull objectParent _soldier) then {_soldier setDamage 1;};				
				_soldier = [_aiGroup, _position] call createRandomSoldierC;	
				_soldier moveInTurret [_vehicle, [4]];
				if (isNull objectParent _soldier) then {_soldier setDamage 1;};				
				_soldier = [_aiGroup, _position] call createRandomSoldierC;
				_soldier moveInTurret [_vehicle, [5]];
				if (isNull objectParent _soldier) then {_soldier setDamage 1;};				
				_soldier = [_aiGroup, _position] call createRandomSoldierC;
				_soldier moveInTurret [_vehicle, [6]];				
				if (isNull objectParent _soldier) then {_soldier setDamage 1;};				
			};
		};

		[_vehicle, _aiGroup] spawn checkMissionVehicleLock;
		_vehicle
	};

	_aiGroup = createGroup CIVILIAN;

	_vehicles =
	[
		[_veh1, _starts select 0, _startdirs select 0] call _createVehicle	
	];

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;
	_leader setRank "LIEUTENANT";	

	_aiGroup setCombatMode "RED"; // units will defend themselves
	_aiGroup setBehaviour "COMBAT"; // units feel safe until they spot an enemy or get into contact
	_aiGroup setFormation "STAG COLUMN";

	_speedMode = "NORMAL";

	_aiGroup setSpeedMode _speedMode;


	// behaviour on waypoints
	{
		_waypoint = _aiGroup addWaypoint [_x, 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 50;
		_waypoint setWaypointCombatMode "RED";
		_waypoint setWaypointBehaviour "COMBAT";
		_waypoint setWaypointFormation "STAG COLUMN";
		_waypoint setWaypointSpeed _speedMode;
		[_vehicle, 20] call HAFM_fnc_Dive;
	} forEach _waypoints;

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _veh1 >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _veh1 >> "displayName");

	_missionHintText = format ["A <t color='%3'>%1</t> CLASS Submarine is silently patrolling the deep waters off the coast of Altis</t>. Locate and destroy the sub to receive a $1,500,000 reward!", _vehicleName, marineMissionColor];

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

	_successHintMessage = "The Submarine has been destroyed, an airdrop of a small craft has been air dropped. Navigate to the boat and collect your reward!<br/>Please destroy the light craft once looted";	

	_Boxes = selectrandom ["Box_IND_Wps_F","Box_East_Wps_F","Box_NATO_Wps_F","Box_NATO_AmmoOrd_F","Box_NATO_Grenades_F","Box_East_WpsLaunch_F","Box_NATO_WpsLaunch_F","Box_East_WpsSpecial_F","Box_NATO_WpsSpecial_F"];
	_veh6 = selectrandom ["C_Boat_Civil_01_F"];
	_lastPos set [2, 200];
	_Box = createVehicle [_veh6, _lastPos, [], 0, "None"];
	_Box2 = createVehicle [_Boxes, _lastPos, [], 0, "None"];	
	_Box2 setVariable ["cmoney", 1500000, true];	
	
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
