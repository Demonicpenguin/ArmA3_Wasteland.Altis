// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 2.1
//	@file Name: mission_islandPatrol.sqf
//	@file Author: JoSchaap / routes by Del1te - (original idea by Sanjo), AgentRev
//	@file Created: 31/08/2013 18:19
//	@file Edit: 27/06/2019 by [509th] Coyote Rogue
// 	@file Description: Creates a convoy that travels between cities.
// ****************************************************************************************** 

if (!isServer) exitwith {};
#include "armouredMissionDefines.sqf";

private ["_vehClass", "_moneyAmount", "_vehSelect", "_moneyText", "_vehClasses", "_createVehicle", "_vehicles", "_veh2", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints", "_cash", "_smokemarker", "_box1", "_box2", "_box3", "_box4"];

_setupVars =
{
	_locationsArray = ConvoyStarts;

	_vehClass = selectRandom
	[
		[
			"Patrol",
			500000,
			[
				[ // NATO convoy
				
					["B_MRAP_01_gmg_F", "B_MRAP_01_hmg_F", "B_G_Offroad_01_armed_F", "B_T_LSV_01_armed_F"], // Veh 4
					["B_MBT_01_cannon_F", "B_MBT_01_TUSK_F"], // Veh 2	
					["B_APC_Wheeled_01_cannon_F", "B_APC_Tracked_01_rcws_F", "B_APC_Tracked_01_AA_F"], // Veh 1				
					["B_APC_Wheeled_01_cannon_F", "B_APC_Tracked_01_rcws_F", "B_AFV_Wheeled_01_up_cannon_F"], // Veh 3
					["B_APC_Tracked_01_AA_F"] // Veh 5
				],
				[ // CSAT convoy
					["O_MRAP_02_gmg_F", "O_MRAP_02_hmg_F", "O_G_Offroad_01_armed_F", "O_T_LSV_02_armed_F"], // Veh 4
					["O_MBT_02_cannon_F", "O_MBT_04_cannon_F", "O_MBT_04_command_F"], // Veh 2
					["O_APC_Wheeled_02_rcws_F", "O_APC_Tracked_02_cannon_F", "O_APC_Tracked_02_AA_F"], // Veh 1
					["O_APC_Wheeled_02_rcws_v2_F", "O_APC_Tracked_02_cannon_F", "O_APC_Tracked_02_AA_F"], // Veh 3
					["O_APC_Tracked_02_AA_F"] // Veh 5
				],
				[ // AAF convoy
					["I_MRAP_03_gmg_F", "I_MRAP_03_hmg_F", "I_G_Offroad_01_armed_F"], // Veh 4
					["I_MBT_03_cannon_F"], // Veh 2
					["I_APC_Wheeled_03_cannon_F", "I_APC_tracked_03_cannon_F"], // Veh 1
					["I_APC_Wheeled_03_cannon_F", "I_APC_tracked_03_cannon_F"], // Veh 3
					["I_LT_01_AA_F"] // Veh 5
				]
			]
		]
	];

	_missionType = "Altis Patrol Variant";
	_moneyAmount = _vehClass select 1;

	_vehSelect = selectRandom (_vehClass select 2);
	_vehClasses = [];
	{ _vehClasses pushBack selectRandom _x } forEach _vehSelect;
};

_setupObjects =
{
	private ["_starts", "_startDirs", "_waypoints"]; //These parameters are convoy path
	call compile preprocessFileLineNumbers format ["mapConfig\convoys\%1.sqf", _missionLocation];

	// Setup parameters for vehicles
	_createVehicle =
	{
		private ["_type", "_position", "_direction", "_vehicle", "_variant", "_soldier"];

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
		/*if (worldName == "Tanoa" && _type select [1,3] != "_T_") then
		{
			switch (toUpper (_type select [0,2])) do
			{
				case "B_": { [_vehicle, ["Olive"]] call applyVehicleTexture };
				case "O_": { [_vehicle, ["GreenHex"]] call applyVehicleTexture };
			};
		};*/

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
	_vehicles = [];
	{
		_vehicles pushBack ([_x, _starts select (_forEachIndex max 0 min (count _starts - 1)), _startdirs select 0, _aiGroup] call _createVehicle);
	} forEach _vehClasses;
	_veh2 = _vehClasses select (1 min (count _vehClasses - 1));

	sleep 2;

	// Assign AI behavior
	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;
	_leader setRank "LIEUTENANT";
	_aiGroup setCombatMode "YELLOW"; // GREEN = Hold fire, Defend only; YELLOW = Fire at will;  RED = Fire at will, engage at will
	_aiGroup setBehaviour "AWARE"; // SAFE = Defend only; AWARE = (default) Take action when enemy is noted; COMBAT = Always alert
	_aiGroup setFormation "COLUMN"; //COLUMN - Line up single file behind unit 1; STAG COLUMN - Two columns offset, left column leads; FILE - Same as COLUMN, except tighter.
	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" }; //"LIMITED" (half speed); "NORMAL" (full speed, maintain formation); "FULL" (do not wait for any other units in formation)
	_aiGroup setSpeedMode _speedMode;

	sleep 2;

	// Establish waypoints and set behavior
	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 50;
		_waypoint setWaypointCombatMode "YELLOW"; // GREEN = Hold fire, Defend only; YELLOW = Fire at will;  RED = Fire at will, engage at will
		_waypoint setWaypointBehaviour "AWARE"; // SAFE = Defend only; AWARE = (default) Take action when enemy is noted; COMBAT = Always alert
		_waypoint setWaypointFormation "COLUMN"; //COLUMN - Line up single file behind unit 1; STAG COLUMN - Two columns offset, left column leads; FILE - Same as COLUMN, except tighter.
		_waypoint setWaypointSpeed _speedMode;
	} forEach ((call WPList) call BIS_fnc_arrayShuffle);

	// Mission announcement 
	_missionPos = getPosATL leader _aiGroup;
	_missionPicture = getText (configFile >> "CfgVehicles" >> (_veh2 param [0,""]) >> "picture");
 	_vehicleName = getText (configFile >> "CfgVehicles" >> (_veh2 param [0,""]) >> "displayName");
	_missionHintText = format ["A reinforced armored patrol fortified by a <t color='%1'>%2</t> is patrolling %3! Stop the patrol and collect the money!", armouredMissionColor, _vehicleName, worldName];
	_numWaypoints = count waypoints _aiGroup;
};

// Mission failed
	_waitUntilMarkerPos = {getPosATL _leader};
	_waitUntilExec = nil;
	_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};
	_failedExec = nil;

// Mission completed

	_successExec =
	{
		// Remove "super" armor from vehicles
		{ _x removeAllEventHandlers "HandleDamage"} forEach _vehicles;

		//Money
		for "_x" from 1 to 5 do
		{
			_cash = "Land_Money_F" createVehicle markerPos _marker;
			_cash setPos ((markerPos _marker) vectorAdd ([[2 + random 2,0,0], random 360] call BIS_fnc_rotateVector2D));
			_cash setDir random 360;
			_cash setVariable["cmoney",50000,true];
			_cash setVariable["owner","world",true];
		};

		//Crates
		_box1 = "Box_NATO_Wps_F" createVehicle getMarkerPos _marker;
		[_box1,"mission_USSpecial2"] call fn_refillbox2;
		_box1 allowDamage false;
		_box1 setVariable ["moveable", true, true];

		_box2 = "B_supplyCrate_F" createVehicle getMarkerPos _marker;
		[_box2,"Launchers_Tier_2"] call fn_refillbox2;
		_box2 allowDamage false;
		_box2 setVariable ["moveable", true, true];
		
		_box3 = "Box_NATO_Support_F" createVehicle getMarkerPos _marker;
		[_box3,"mission_snipers"] call fn_refillbox2;
		_box3 allowDamage false;
		_box3 setVariable ["moveable", true, true];

		_box4 = "B_supplyCrate_F" createVehicle getMarkerPos _marker;
		[_box4,"GEVP"] call fn_refillbox2;
		_box4 allowDamage false;
		_box4 setVariable ["moveable", true, true];

		//Crate Behavior
		{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2, _box3, _box4];	//Allows crates to be picked up and carried	

		//Smoke to mark the crates
		_smokemarker = createMarker ["SMMarker1", _lastPos];
		[_smokemarker] spawn CrateSmoke; //Calls repeating green smoke grenade
		uiSleep 2;		
		deleteMarker "SMMarker1";

		//Message
		_successHintMessage = "The patrol has been stopped! The money, crates and vehicles are yours to take.";
	};

_this call armouredMissionProcessor;
