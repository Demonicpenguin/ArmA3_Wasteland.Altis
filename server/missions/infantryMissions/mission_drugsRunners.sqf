// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 2.1
//	@file Name: mission_drugsRunners.sqf
//	@file Author: JoSchaap / routes by Del1te - (original idea by Sanjo), AgentRev, LouD
//	@file Created: 31/08/2013 18:19

if (!isServer) exitwith {};
#include "infantryMissionDefines.sqf";

private ["_convoyVeh", "_veh1", "_veh2", "_createVehicle", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints", "_drop_item", "_drugpilerandomizer", "_drugpile"];

_setupVars =
{
	_missionType = "Drugs n' Surf";
	_locationsArray = nil;
};

_setupObjects =
{
	_town = (call cityList) call BIS_fnc_selectRandom;
	_missionPos = markerPos (_town select 0);
	
	// pick the vehicles for the convoy
	_convoyVeh = if (missionDifficultyHard) then
	{
		["C_Offroad_02_unarmed_F"]
	}
	else
	{
		["C_Offroad_02_unarmed_F"]
	};

	_veh1 = _convoyVeh select 0;

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

		_soldier = [_aiGroup, _position] call createRandomSurfer;
		_soldier moveInDriver _vehicle;

		_soldier = [_aiGroup, _position] call createRandomSurfer;
		_soldier moveInCargo [_vehicle, 0];
		
		_vehicle addEventhandler ["HandleDamage", {0.75*(_this select 2)}];
		_vehicle addEventhandler ["HandleDamage", {if (_this select 1 in ["wheel_1_1_steering","wheel_1_2_steering","wheel_2_1_steering","wheel_2_2_steering"]) then {0*(_this select 2)}}];

		switch (true) do
		{
			case (_type isKindOf "C_SUV_01_F"):
			{
				[_vehicle, "#(rgb,1,1,1)color(0.01,0.01,0.01,1)", [0]] call applyVehicleTexture; // Apply black color
			};
		};

		[_vehicle, _aiGroup] spawn checkMissionVehicleLock;

		_vehicle
	};

	_aiGroup = createGroup CIVILIAN;

	_pos = getMarkerPos (_town select 0);
	_rad = _town select 1;
	_vehiclePos = [_pos,5,_rad,5,0,0,0] call findSafePos;
	
	_vehicles =
	[
		[_veh1, _vehiclePos, 0] call _createVehicle
	];

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;

	_aiGroup setCombatMode "GREEN"; // units will never fire
	_aiGroup setBehaviour "CARELESS"; // nits will try to stay on roads, not caring about finding any cover
	_aiGroup setFormation "STAG COLUMN";

	_speedMode = if (missionDifficultyHard) then { "FULL" } else { "FULL" };
	
	_aiGroup setSpeedMode _speedMode;
	
	// behaviour on waypoints
	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 50;
		_waypoint setWaypointCombatMode "GREEN";
		_waypoint setWaypointBehaviour "CARELESS";
		_waypoint setWaypointFormation "STAG COLUMN";
		_waypoint setWaypointSpeed _speedMode;
	} forEach ((call cityList) call BIS_fnc_arrayShuffle);

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _veh1 >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _veh1 >> "displayName");

	_missionHintText = format ["Two sunnyboys with a <t color='%2'>%1</t> are on their way to hit the perfect wave. Kick their asses back to Hawaii!", _vehicleName, infantryMissionColor];

	_numWaypoints = count waypoints _aiGroup;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome

_drop_item = 
{
	private["_item", "_pos"];
	_item = _this select 0;
	_pos = _this select 1;

	if (isNil "_item" || {typeName _item != typeName [] || {count(_item) != 2}}) exitWith {};
	if (isNil "_pos" || {typeName _pos != typeName [] || {count(_pos) != 3}}) exitWith {};

	private["_id", "_class"];
	_id = _item select 0;
	_class = _item select 1;

	private["_obj"];
	_obj = createVehicle [_class, _pos, [], 5, "None"];
	_obj setPos ([_pos, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
	_obj setVariable ["mf_item_id", _id, true];
};

_successExec =
{
	// Mission completed
	_drugpilerandomizer = [4,8,12];
	_drugpile = _drugpilerandomizer call BIS_fnc_SelectRandom;
	
	for "_i" from 1 to _drugpile do 
	{
	  private["_item"];
	  _item = [
	          ["lsd", "Land_WaterPurificationTablets_F"],
	          ["marijuana", "Land_VitaminBottle_F"],
	          ["cocaine","Land_PowderedMilk_F"],
	          ["heroin", "Land_PainKillers_F"]
	        ] call BIS_fnc_selectRandom;
	  [_item, _lastPos] call _drop_item;
	};
	
	_successHintMessage = "Good job! The sunnyboys won't surf anymore. Save the drugs ..";
};

_this call infantryMissionProcessor;