// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 2.1
//	@file Name: mission_HeavyMetal.sqf
//	@file Author: JoSchaap / routes by Del1te - (original idea by Sanjo), AgentRev
//	@file Tanoa Edit: GriffinZS
//	@file Created: 31/08/2013 18:19

if (!isServer) exitwith {};
#include "armouredMissionDefines.sqf";

private ["_convoyVeh", "_veh1", "_veh2", "_veh3", "_createVehicle", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints", "_box1", "_box2", "_smokemarker"];

_setupVars =
{
	_missionType = "Heavy Metal Convoy";
	_locationsArray = LandConvoyPaths;
};

_setupObjects =
{
	private ["_starts", "_startDirs", "_waypoints"];
	call compile preprocessFileLineNumbers format ["mapConfig\convoys\%1.sqf", _missionLocation];

	// pick the vehicles for the convoy
	_convoyVeh = if (missionDifficultyHard) then
	{
		["B_T_APC_Tracked_01_rcws_F", "B_T_APC_Tracked_01_AA_F", "	B_T_MBT_01_TUSK_F"]
	}
	else
	{
		[
			["I_APC_Wheeled_03_cannon_F", "O_Truck_03_covered_F", "B_APC_Tracked_01_CRV_F"],
			["O_T_MBT_04_command_F", "B_GEN_Van_02_transport_F", "O_APC_Tracked_02_AA_F"]
		] call BIS_fnc_selectRandom;
	};

	_veh1 = _convoyVeh select 0;
	_veh2 = _convoyVeh select 1;
	_veh3 = _convoyVeh select 2;

	_createVehicle =
	{
		private ["_type", "_position", "_direction", "_vehicle", "_soldier"];

		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;

		_vehicle = createVehicle [_type, _position, [], 0, "None"];
		_vehicle setVariable ["R3F_LOG_disabled", true, true];
		[_vehicle] call vehicleSetup;
		
		if (_vehicle isKindOf "B_APC_Tracked_01_CRV_F") then
		{
			_vehicle setAmmoCargo 0;
			_vehicle setFuelCargo 0;
			_vehicle setRepairCargo 0;
			_vehicle spawn GOM_fnc_addAircraftLoadoutToObject;
			_vehicle setVariable ["GOM_fnc_ammoCargo", 500, true];
			_vehicle setVariable ["GOM_fnc_fuelCargo", 500, true];
			_vehicle setVariable ["GOM_fnc_repairCargo", 500, true];			
		};		

		_vehicle setDir _direction;
		_aiGroup addVehicle _vehicle;

		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInDriver _vehicle;

		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInCargo [_vehicle, 0];

		switch (true) do
		{
			case (_type isKindOf "Offroad_01_armed_base_F"):
			{
				_soldier = [_aiGroup, _position] call createRandomSoldier;
				_soldier moveInGunner _vehicle;
			};
			case (_type isKindOf "C_Van_01_box_F"):
			{
				[_vehicle, "\A3\Soft_F_Bootcamp\Van_01\Data\Van_01_ext_IG_01_CO.paa", [0]] call applyVehicleTexture; // Apply camo instead of civilian color
			};
		};

		[_vehicle, _aiGroup] spawn checkMissionVehicleLock;

		_vehicle
	};

	_aiGroup = createGroup CIVILIAN;

	_vehicles =
	[
		[_veh1, _starts select 0, _startDirs select 0] call _createVehicle,
		[_veh2, _starts select 1, _startDirs select 1] call _createVehicle,
		[_veh3, _starts select 2, _startDirs select 2] call _createVehicle
	];

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;

	_aiGroup setCombatMode "GREEN"; // units will defend themselves
	_aiGroup setBehaviour "SAFE"; // units feel safe until they spot an enemy or get into contact
	_aiGroup setFormation "STAG COLUMN";

	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };

	_aiGroup setSpeedMode _speedMode;

	{
		_waypoint = _aiGroup addWaypoint [_x, 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 25;
		_waypoint setWaypointCombatMode "GREEN";
		_waypoint setWaypointBehaviour "SAFE"; // safe is the best behaviour to make AI follow roads, as soon as they spot an enemy or go into combat they WILL leave the road for cover though!
		_waypoint setWaypointFormation "STAG COLUMN";
		_waypoint setWaypointSpeed _speedMode;
	} forEach _waypoints;

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _veh2 >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _veh2 >> "displayName");

	_missionHintText = format ["<br/>Right! A <t color='%2'>%1</t> has been spottet. Escorted by a <t color='%2'>M2A4 Slammer</t> and an <t color='%2'>IFV-6c Panther</t> <br/>Don't TRY your best! DO your best!", _vehicleName, armouredMissionColor];

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
	_box1 = createVehicle ["O_CargoNet_01_ammo_F", _lastPos, [], 2, "None"];
	_box1 setDir random 360;
	[_box1, "mission_USSpecial2"] call fn_refillbox;

	_box2 = createVehicle ["Box_East_WpsSpecial_F", _lastPos, [], 2, "None"];
	_box2 setDir random 360;
	[_box2, "mission_USLaunchers"] call fn_refillbox;

	for "_i" from 1 to 10 do
	{
		_cash = createVehicle ["Land_Money_F", _lastPos, [], 5, "None"];
		_cash setPos ([_lastPos, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
		_cash setDir random 360;
		_cash setVariable ["cmoney", 60000, true];
		_cash setVariable ["owner", "world", true];
	};

	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2];
	
	
	//Smoke to mark the crates
	_smokemarker = createMarker ["SMMarker1", _lastPos];
	[_smokemarker] spawn CrateSmoke; //Calls repeating green smoke grenade
	uiSleep 2;		
	deleteMarker "SMMarker1"; 	
	
	
	
	_successHintMessage = "Not bad! No more Heavy Metal. What about Gangster Rap?";
};

_this call armouredMissionProcessor;
