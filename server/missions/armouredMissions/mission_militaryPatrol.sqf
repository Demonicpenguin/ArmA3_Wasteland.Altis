// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 2.1
//	@file Name: mission_Patrol.sqf
//	@file Author: JoSchaap / routes by Del1te - (original idea by Sanjo), AgentRev
//	@file Created: 31/08/2013 18:19
//	@file Edit: 27/06/2019 by [509th] Coyote Rogue
// 	@file Description: Creates a convoy that travels between cities.
// ****************************************************************************************** 

if (!isServer) exitwith {};
#include "armouredMissionDefines.sqf";

private ["_vehClass", "_moneyAmount", "_vehSelect", "_moneyText", "_vehClasses", "_createVehicle", "_vehicles", "_veh1", "_veh2", "_veh3", "_veh4", "_veh5", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints", "_cash", "_boxes1", "_boxes2", "_box1", "_box2", "_smokemarker"];

_setupVars =
{
	_locationsArray = PatrolConvoyPaths;

	_vehClass = selectRandom
		[
			["B_MBT_01_TUSK_F", "B_APC_Tracked_01_AA_F", "B_MBT_01_cannon_F", "B_AFV_Wheeled_01_cannon_F", "B_APC_Wheeled_01_cannon_F","I_MRAP_03_F"], // BluFor Patrol
			["O_MBT_04_command_F", "O_APC_Tracked_02_AA_F", "O_MBT_04_cannon_F", "O_APC_Tracked_02_cannon_F", "O_MBT_04_command_F","I_MRAP_03_F"], // OpFor  Patrol
			["I_MBT_03_cannon_F", "B_APC_Tracked_01_AA_F", "I_APC_tracked_03_cannon_F", "I_APC_Wheeled_03_cannon_F", "I_MBT_03_cannon_F","I_MRAP_03_F"] // Ind  Patrol
		];

		_veh1 = _vehClass select 0;
		_veh2 = _vehClass select 1;
		_veh3 = _vehClass select 2;
		_veh4 = _vehClass select 3;
		_veh5 = _vehClass select 4;
		_veh6 = _vehClass select 5;		

	_missionType = "Military Patrol";
	_moneyAmount = Tier_3_Reward; //Reward amount for completing mission
};

_setupObjects =
{
	private ["_starts", "_startDirs", "_waypoints"]; //These parameters are convoy path
	call compile preprocessFileLineNumbers format ["mapConfig\convoys\%1.sqf", _missionLocation];

	// Setup parameters for vehicles
	_createVehicle =
	{
		private ["_type", "_position", "_direction", "_variant", "_soldier"];

		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;
		_variant = _type param [1,"",[""]];

		if (_type isEqualType []) then
		{
			_type = _type select 0;
		};

		_vehicle = createVehicle [_type, _position, [], 0, "NONE"];
		_vehicle setVehicleReportRemoteTargets true;
		_vehicle setVehicleReceiveRemoteTargets true;
		_vehicle setVehicleRadar 1;
		_vehicle confirmSensorTarget [west, true];
		_vehicle confirmSensorTarget [east, true];
		_vehicle confirmSensorTarget [resistance, true];
		_vehicle setVariable ["R3F_LOG_disabled", true, true];
		[_vehicle] call vehicleSetupAI;

		if (_variant != "") then
		{
			_vehicle setVariable ["A3W_vehicleVariant", _variant, true];
		};

		// Apply tropical textures to vehicles on Tanoa
		if (worldName == "Tanoa" && _type select [1,3] != "_T_") then
		{
			switch (toUpper (_type select [0,2])) do
			{
				case "B_": { [_vehicle, ["Olive"]] call applyVehicleTexture };
				case "O_": { [_vehicle, ["GreenHex"]] call applyVehicleTexture };
			};
		};

	// Add some armor
		_vehicle setVariable ["selections", []];
		_vehicle setVariable ["gethit", []];
		_vehicle addEventHandler
			[
				"HandleDamage",
				{
					_unit = _this select 0;
					_selections = _unit getVariable ["selections", []];
					_gethit = _unit getVariable ["gethit", []];
					_selection = _this select 1;
					if !(_selection in _selections) then
					{
						_selections set [count _selections, _selection];
						_gethit set [count _gethit, 0];
					};
					_i = _selections find _selection;
					_olddamage = _gethit select _i;
					_damage = _olddamage + ((_this select 2) - _olddamage) * 0.50; // The lower the number, the higher the armor
					_gethit set [_i, _damage];
					_damage;
				}
			];

		_vehicle setDir _direction;
		_aiGroup addVehicle _vehicle;

		// Add driver & crew
		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInDriver _vehicle;

		if !(_type isKindOf "Truck_F") then
		{
			_soldier = [_aiGroup, _position] call createRandomSoldier;
			_soldier moveInGunner _vehicle;
			if (_type isKindOf "LT_01_base_F") exitWith {};

			_soldier = [_aiGroup, _position] call createRandomSoldier;

			if (_vehicle emptyPositions "commander" > 0) then
			{
				_soldier moveInCommander _vehicle;
			}
			else
			{
				_soldier moveInCargo [_vehicle, 1];
			};
		};	
		switch (true) do
		{
			case (_type isKindOf "LSV_01_armed_base_F"):
			{
				_soldier = [_aiGroup, _position] call createRandomSoldier;
				_soldier moveInTurret [_vehicle, [1]];

			};
		};

		_vehicle spawn refillPrimaryAmmo;
		[_vehicle, _aiGroup] spawn checkMissionVehicleLock;

		_vehicle
	};

	// Spawn vehicles & crew
	_aiGroup = createGroup CIVILIAN;
	_vehicles =
	[
		[_veh1, _starts select 0, _startDirs select 0] call _createVehicle,
		[_veh2, _starts select 1, _startDirs select 0] call _createVehicle,
		[_veh3, _starts select 2, _startDirs select 0] call _createVehicle,
		[_veh4, _starts select 3, _startDirs select 0] call _createVehicle,
		[_veh5, _starts select 4, _startDirs select 0] call _createVehicle,
		[_veh6, _starts select 5, _startDirs select 5] call _createVehicle1		
	];

	sleep 2;

	// Assign AI behavior
	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;
	_leader setRank "LIEUTENANT";
	_aiGroup setCombatMode "YELLOW"; // GREEN = Hold fire, Defend only; YELLOW = Fire at will;  RED = Fire at will, engage at will
	_aiGroup setBehaviour "SAFE"; // SAFE = Defend only; AWARE = (default) Take action when enemy is noted; COMBAT = Always alert
	_aiGroup setFormation "COLUMN"; //COLUMN - Line up single file behind unit 1; STAG COLUMN - Two columns offset, left column leads; FILE - Same as COLUMN, except tighter.
	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" }; //"LIMITED" (half speed); "NORMAL" (full speed, maintain formation); "FULL" (do not wait for any other units in formation)
	_aiGroup setSpeedMode _speedMode;

	sleep 2;

	// Establish waypoints and set behavior
	{
		_waypoint = _aiGroup addWaypoint [_x, 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 50;
		_waypoint setWaypointCombatMode "YELLOW"; // GREEN = Hold fire, Defend only; YELLOW = Fire at will;  RED = Fire at will, engage at will
		_waypoint setWaypointBehaviour "AWARE"; // SAFE = Defend only; AWARE = (default) Take action when enemy is noted; COMBAT = Always alert
		_waypoint setWaypointFormation "COLUMN"; //COLUMN - Line up single file behind unit 1; STAG COLUMN - Two columns offset, left column leads; FILE - Same as COLUMN, except tighter.
		_waypoint setWaypointSpeed _speedMode;
	} forEach _waypoints;

	// Mission announcement 
	_missionPos = getPosATL leader _aiGroup;
	_missionPicture = getText (configFile >> "CfgVehicles" >> (_veh2 param [0,""]) >> "picture");
 	_vehicleName = getText (configFile >> "CfgVehicles" >> (_veh2 param [0,""]) >> "displayName");
 	_vehicleName2 = getText (configFile >> "CfgVehicles" >> (_veh3 param [0,""]) >> "displayName");
 	_vehicleName3 = getText (configFile >> "CfgVehicles" >> (_veh4 param [0,""]) >> "displayName");
	_missionHintText = format ["A convoy containing at least a <t color='%4'>%1</t>, a <t color='%4'>%2</t> and a <t color='%4'>%3</t> is patrolling a high value location! Stop the patrol and capture the goods and money!", _vehicleName, _vehicleName2, _vehicleName3, armouredMissionColor];
	_numWaypoints = count waypoints _aiGroup;
};

// Mission failed
	_waitUntilMarkerPos = {getPosATL _leader};
	_waitUntilExec = nil;
	_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};
	_failedExec = nil;

_successExec =
{

	// Remove "super" armor from vehicles
	/*{ _x removeAllEventHandlers "HandleDamage"} forEach _vehicles;*/

	// Mission completed

	for "_x" from 1 to 10 do
	{
		_cash = "Land_Money_F" createVehicle markerPos _marker;
		_cash setPos ((markerPos _marker) vectorAdd ([[2 + random 2,0,0], random 360] call BIS_fnc_rotateVector2D));
		_cash setDir random 360;
		_cash setVariable["cmoney",50000,true];
		_cash setVariable["owner","world",true];
	};
	
	_box1 = "Box_East_Wps_F" createVehicle getMarkerPos _marker;
    [_box1,"mission_USLaunchers"] call fn_refillbox;
	_box1 allowDamage false;
	
	_box2 = "Box_NATO_Wps_F" createVehicle getMarkerPos _marker;
    [_box2,"mission_USSpecial2"] call fn_refillbox;
	_box2 allowDamage false;
	
	_box3 = "Box_NATO_Support_F" createVehicle getMarkerPos _marker;
    [_box3,"mission_Main_A3snipers"] call fn_refillbox;
	_box3 allowDamage false;
	
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2, _box3];
	
	//Smoke to mark the crates
	_smokemarker = createMarker ["SMMarker1", _lastPos];
	[_smokemarker] spawn CrateSmoke; //Calls repeating green smoke grenade
	uiSleep 2;		
	deleteMarker "SMMarker1"; 	
	
	_successHintMessage = "The patrol has been stopped, the money, crates and vehicles are yours to take.";
};

_this call armouredMissionProcessor;
