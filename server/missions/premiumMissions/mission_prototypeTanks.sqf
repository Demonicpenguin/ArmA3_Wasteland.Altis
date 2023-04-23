// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 2.1
//	@file Name: mission_prototypeTanks.sqf
//	@file Author: JoSchaap / routes by Del1te - (original idea by Sanjo), AgentRev
//	@file Created: 31/08/2013 18:19
//	@file Edit: 27/06/2019 by [509th] Coyote Rogue
// 	@file Description: Creates an ELITE tank convoy with higher than normal armor and skills.
// ****************************************************************************************** 

if (!isServer) exitwith {};
#include "premiumMissionDefines.sqf";

private ["_vehClass", "_moneyAmount", "_vehSelect", "_moneyText", "_vehClasses", "_createVehicle", "_vehicles", "_veh1", "_veh2", "_veh3", "_veh4", "_veh5", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints", "_cash", "_boxes1", "_boxes2", "_box1", "_box2", "_box3", "_smokemarker"];

_setupVars =
{
	_locationsArray = ConvoyStarts;

	_vehClass = selectRandom
	[
		["I_APC_Wheeled_03_cannon_F", "B_MBT_01_TUSK_F", "B_MBT_01_TUSK_F"], // BluFor Patrol
		["I_APC_Wheeled_03_cannon_F", "O_MBT_04_command_F", "O_MBT_04_command_F"] // OpFor  Patrol
	];
	
	_veh1 = _vehClass select 0;
	_veh2 = _vehClass select 1;
	_veh3 = _vehClass select 2;

	_missionType = "Prototype Tanks";
	_moneyAmount = 500000; //Reward amount for completing mission
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

	//Enhanced Gorgon
		if (_vehicle isKindOf "I_APC_Wheeled_03_cannon_F") then 
		{
			_vehicle setObjectTextureGlobal [0, "client\images\vehicleTextures\hex.paa"]; 
			_vehicle setObjectTextureGlobal [1, "A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext2_co.paa"]; 
			_vehicle setObjectTextureGlobal [2, "client\images\vehicleTextures\hex.paa"]; 
			_vehicle setObjectTextureGlobal [3, "A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext_alpha_co.paa"];			
			_vehicle removeMagazine ("1000Rnd_65x39_Belt_Yellow");
			_vehicle removeWeapon ("LMG_M200");
			_vehicle addWeaponTurret ["HMG_127_MBT",[0]];
			for "_i" from 1 to 4 do 
			{
				_vehicle addMagazineTurret ["500Rnd_127x99_mag_Tracer_Red",[0]];
			};	
			_vehicle addMagazineTurret ["60Rnd_30mm_APFSDS_shells_Tracer_Yellow",[0],40];
			_vehicle addMagazineTurret ["140Rnd_30mm_MP_shells_Tracer_Yellow",[0],60];
		};

	//Enhanced Slammer
		if (_vehicle isKindOf "B_MBT_01_TUSK_F") then 
		{	
			_vehicle setObjectTextureGlobal [0, "client\images\vehicleTextures\hex.paa"];
			_vehicle setObjectTextureGlobal [1, "client\images\vehicleTextures\hex.paa"];
			_vehicle removeMagazine ("40Rnd_105mm_APFSDS_T_Red");
			_vehicle removeMagazine ("20Rnd_105mm_HEAT_MP_T_Red");
			_vehicle removeMagazine ("2000Rnd_65x39_belt");
			_vehicle removeMagazine ("2000Rnd_65x39_belt");
			_vehicle removeWeapon ("cannon_105mm");
			_vehicle removeWeapon ("LMG_M200_body");
			_vehicle addWeaponTurret ["cannon_120mm",[0]];
			_vehicle addMagazineTurret ["32Rnd_120mm_APFSDS_shells_Tracer_Red",[0]];
			_vehicle addMagazineTurret ["16Rnd_120mm_HE_shells_Tracer_Red",[0]];
			_vehicle addMagazineTurret ["16Rnd_120mm_HE_shells_Tracer_Red",[0]];
			_vehicle addWeaponTurret ["HMG_127_MBT",[0]];
			for "_i" from 1 to 4 do 
			{
				_vehicle addMagazineTurret ["500Rnd_127x99_mag_Tracer_Red",[0]];
			};	
		};

	//Enhanced Varsuk
		if (_vehicle isKindOf "O_MBT_04_command_F") then 
		{
			_vehicle setObjectTextureGlobal [0, "client\images\vehicleTextures\hex.paa"];
			_vehicle setObjectTextureGlobal [1, "client\images\vehicleTextures\hex.paa"];
 			_vehicle setObjectTextureGlobal [2, "client\images\vehicleTextures\hex.paa"];
			_vehicle removeMagazine ("2000Rnd_762x51_Belt_Green");
			_vehicle removeMagazine ("2000Rnd_762x51_Belt_Green");
			_vehicle removeWeapon ("LMG_coax");
			_vehicle addWeaponTurret ["HMG_127_MBT",[0]];
			for "_i" from 1 to 4 do 
				{
				_vehicle addMagazineTurret ["500Rnd_127x99_mag_Tracer_Red",[0]];
				};	
			_vehicle addMagazineTurret ["12Rnd_125mm_HEAT_T_Green",[0]];
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
					_damage = _olddamage + ((_this select 2) - _olddamage) * 0.20; // The lower the number, the higher the armor
					_gethit set [_i, _damage];
					_damage;
				}
			];

		_vehicle setDir _direction;
		_aiGroup addVehicle _vehicle;

		// Add driver & crew
		_soldier = [_aiGroup, _position] call createEliteSoldier;
		_soldier moveInDriver _vehicle;
		_soldier = [_aiGroup, _position] call createEliteSoldier;
		_soldier moveInGunner _vehicle;
		_soldier = [_aiGroup, _position] call createEliteSoldier;		
			if (_vehicle emptyPositions "commander" > 0) then
			{
				_soldier moveInCommander _vehicle;
			}
			else
			{
				_soldier moveInCargo [_vehicle, 1];
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
		[_veh3, _starts select 2, _startDirs select 0] call _createVehicle
	];

	sleep 2;

	// Assign AI behavior
	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;
	_leader setRank "MAJOR";
	_aiGroup setCombatMode "RED"; // GREEN = Hold fire, Defend only; YELLOW = Fire at will;  RED = Fire at will, engage at will
	_aiGroup setBehaviour "COMBAT"; // SAFE = Defend only; AWARE = (default) Take action when enemy is noted; COMBAT = Always alert
	_aiGroup setFormation "FILE"; //COLUMN - Line up single file behind unit 1; STAG COLUMN - Two columns offset, left column leads; FILE - Same as COLUMN, except tighter.
	_speedMode = "NORMAL"; //"LIMITED" (half speed); "NORMAL" (full speed, maintain formation); "FULL" (do not wait for any other units in formation)
	_aiGroup setSpeedMode _speedMode;

	sleep 2;

	// Establish waypoints and set behavior
	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 50;
		_waypoint setWaypointCombatMode "RED"; // GREEN = Hold fire, Defend only; YELLOW = Fire at will;  RED = Fire at will, engage at will
		_waypoint setWaypointBehaviour "COMBAT"; // SAFE = Defend only; AWARE = (default) Take action when enemy is noted; COMBAT = Always alert
		_waypoint setWaypointFormation "FILE"; //COLUMN - Line up single file behind unit 1; STAG COLUMN - Two columns offset, left column leads; FILE - Same as COLUMN, except tighter.
		_waypoint setWaypointSpeed _speedMode;
	} forEach ((call WPList) call BIS_fnc_arrayShuffle);

	// Mission announcement 
	_missionPos = getPosATL leader _aiGroup;
	_missionPicture = getText (configFile >> "CfgVehicles" >> (_veh2 param [0,""]) >> "picture");
 	_vehicleName = getText (configFile >> "CfgVehicles" >> (_veh2 param [0,""]) >> "displayName");
	_missionHintText = format ["The enemy is testing a prototype armor. <br/>A convoy including two <br/><t color='%2'>%1s</t><br/> equipped with this armor is patrolling the island. Stop that patrol!", _vehicleName, premiumMissionColor];
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
		/*{ _x removeAllEventHandlers "HandleDamage"} forEach _vehicles;*/

		//Money
		for "_x" from 1 to 5 do
		{
			_cash = "Land_Money_F" createVehicle markerPos _marker;
			_cash setPos ((markerPos _marker) vectorAdd ([[2 + random 2,0,0], random 360] call BIS_fnc_rotateVector2D));
			_cash setDir random 360;
			_cash setVariable["cmoney",80000,true];
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
	
		_box3 = "B_supplyCrate_F" createVehicle getMarkerPos _marker;
		[_box3,"GEVP"] call fn_refillbox2;
		_box3 allowDamage false;
		_box3 setVariable ["moveable", true, true];

	//Crate Behavior
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2, _box3];	//Allows crates to be picked up and carried	

	//Smoke to mark the reward
	_smokemarker = createMarker ["SMMarker1", _lastPos];
	[_smokemarker] spawn CrateSmoke; //Calls repeating green smoke grenade
	uiSleep 2;		
	deleteMarker "SMMarker1";

	//Message
	_successHintMessage = "Great job! You've busted those tanks! Rewards are nearby.";
};

_this call premiumMissionProcessor;
