// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 2.1
//	@file Name: mission_BaseConvoy.sqf
//	@file Author: JoSchaap / routes by Del1te - (original idea by Sanjo), AgentRev
//	@file Created: 31/08/2013 18:19
//	@file Edit: GriffinZS

if (!isServer) exitwith {};
#include "armouredMissionDefines.sqf";

private ["_convoyVeh", "_veh1", "_veh2", "_veh3", "_createVehicle", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints", "_box1", "_box2", "_box3", "_box4", "_box5", "_box6", "_smokemarker"];

_setupVars =
{
	_missionType = "Large Weapons Crate Delivery";
	_locationsArray = LandConvoyPaths;
};

_setupObjects =
{
	private ["_starts", "_startDirs", "_waypoints"];
	call compile preprocessFileLineNumbers format ["mapConfig\convoys\%1.sqf", _missionLocation];

	// pick the vehicles for the convoy
	_convoyVeh =
	[
		["B_MBT_01_cannon_F", "B_Truck_01_medical_F", "O_APC_Tracked_02_AA_F"],
		["I_MBT_03_cannon_F", "B_Truck_01_medical_F", "O_APC_Tracked_02_AA_F"],
		["O_MBT_04_command_F", "B_Truck_01_ammo_F", "O_APC_Tracked_02_AA_F"]
	] call BIS_fnc_selectRandom;

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

		_vehicle setDir _direction;
		_aiGroup addVehicle _vehicle;

		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInDriver _vehicle;

		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInCargo [_vehicle, 0];

		if !(_type isKindOf "Truck_F") then
		{
			_soldier = [_aiGroup, _position] call createRandomSoldier;
			_soldier moveInGunner _vehicle;

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

	_missionHintText = format ["A <t color='%2'>%1</t> is going to deliver a large cache of Weapon Crates to a secret Base. It is escorted by <t color='%2'>2 Militerised Vehicles</t>!<br/>Stop the delivery and get the Crates!", _vehicleName, armouredMissionColor];

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

	_box1 = "B_supplyCrate_F" createVehicle getMarkerPos _marker;
    [_box1,"Launchers_Tier_2"] call fn_refillbox2;
	_box1 allowDamage false;
	_box1 setVariable ["moveable", true, true];

	_box2 = "Box_NATO_Wps_F" createVehicle getMarkerPos _marker;
    [_box2,"mission_USSpecial2"] call fn_refillbox2;
	_box2 allowDamage false;
	_box2 setVariable ["moveable", true, true];

	_box3 = "Box_NATO_Support_F" createVehicle getMarkerPos _marker;
    [_box3,"mission_snipers"] call fn_refillbox2;
	_box3 allowDamage false;
	_box3 setVariable ["moveable", true, true];

	_box4 = "Box_NATO_Support_F" createVehicle getMarkerPos _marker;
    [_box4,"mission_snipers"] call fn_refillbox2;
	_box4 allowDamage false;
	_box4 setVariable ["moveable", true, true];

	_box5 = "B_supplyCrate_F" createVehicle getMarkerPos _marker;
    [_box5,"GEVP"] call fn_refillbox2;
	_box5 allowDamage false;
	_box5 setVariable ["moveable", true, true];

	_box6 = "B_supplyCrate_F" createVehicle getMarkerPos _marker;
    [_box6,"Launchers_Tier_2"] call fn_refillbox2;
	_box6 allowDamage false;
	_box6 setVariable ["moveable", true, true];

	//Crate Behavior	
					
		{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2, _box3,_box4, _box5, _box6];	//Allows crates to be picked up and carried

		//Smoke to mark the crates
		_smokemarker = createMarker ["SMMarker1", _lastPos];
		[_smokemarker] spawn CrateSmoke; //Calls repeating green smoke grenade
		uiSleep 2;		
		deleteMarker "SMMarker1";	

	_successHintMessage = "Well done! The Weapons Convoy has been stopped!";
};

_this call armouredMissionProcessor;
