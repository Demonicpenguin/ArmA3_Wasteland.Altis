// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_HostileJet.sqf
//	@file Author: JoSchaap, AgentRev, LouD

if (!isServer) exitwith {};
#include "airborneMissionDefines.sqf";

private ["_planeChoices", "_convoyVeh", "_veh1", "_createVehicle", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints", "_cash", "_boxes1", "_boxes2", "_boxes3", "_boxes4","_boxes5","_boxes6", "_boxes7", "_boxes8", "_boxes9", "_box1", "_box2", "_box3", "_box4", "_box5", "_box6", "_box7", "_box8", "_box9", "_currBox1", "_currBox2", "_currBox3", "_currBox4", "_currBox5", "_currBox6", "_currBox7", "_currBox8", "_currBox9"];

_setupVars =
{
	_missionType = "Supply Drop";
	_locationsArray = nil; // locations are generated on the fly from towns
};

_setupObjects =
{
	_missionPos = markerPos (((call cityList) call BIS_fnc_selectRandom) select 0);

	_planeChoices =
	[
		["B_T_VTOL_01_vehicle_F"]
	];

	_convoyVeh = _planeChoices call BIS_fnc_selectRandom;

	_veh1 = _convoyVeh select 0;

	_createVehicle =
	{
		private ["_type","_position","_direction","_vehicle","_soldier"];

		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;


		_vehicle = createVehicle [_type, _position, [], 0, "FLY"]; // Added to make it fly
		_vehicle setVehicleReportRemoteTargets true;
		_vehicle setVehicleReceiveRemoteTargets true;
		_vehicle setVehicleRadar 1;
		_vehicle confirmSensorTarget [west, true];
		_vehicle confirmSensorTarget [east, true];
		_vehicle confirmSensorTarget [resistance, true];
		_vehicle setVariable ["R3F_LOG_disabled", true, true];
		_vel = [velocity _vehicle, -(_direction)] call BIS_fnc_rotateVector2D; // Added to make it fly
		_vehicle setDir _direction;
		_vehicle setVelocity _vel; // Added to make it fly
		_vehicle setVariable [call vChecksum, true, false];
		_aiGroup addVehicle _vehicle;

		// add pilot
		_soldier = [_aiGroup, _position] call createRandomPilot;
		_soldier moveInDriver _vehicle;
		_soldier triggerDynamicSimulation true;
		// lock the vehicle untill the mission is finished and initialize cleanup on it


		[_vehicle, _aiGroup] spawn checkMissionVehicleLock;
		_vehicle
	};

	_aiGroup = createGroup CIVILIAN;

	_vehicles = [];
	_vehicles set [0, [_veh1,[14321.6,15857.7,0], 14, _aiGroup] call _createVehicle]; // static value update when porting to different maps

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;
	_leader setRank "LIEUTENANT";

	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "SAFE";
	_aiGroup setFormation "STAG COLUMN";

	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };

	// behaviour on waypoints
	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 55;
		_waypoint setWaypointCombatMode "RED";
		_waypoint setWaypointBehaviour "SAFE";
		_waypoint setWaypointFormation "STAG COLUMN";
		_waypoint setWaypointSpeed _speedMode;
	} forEach ((call cityList) call BIS_fnc_arrayShuffle);

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _veh1 >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _veh1 >> "displayName");
	_missionHintText = format ["A <t color='%2'>%1</t> is patrolling the island. Shoot it down and kill the pilot to recover the money and weapons!", _vehicleName, airborneMissionColor];

	_numWaypoints = count waypoints _aiGroup;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome

_successExec =
{
	_Boxes1 = ["Box_NATO_Ammo_F","Box_T_NATO_Wps_F","Box_NATO_AmmoOrd_F","Box_NATO_Equip_F","Box_NATO_Grenades_F","Box_T_NATO_WpsSpecial_F","Box_NATO_WpsLaunch_F", "Box_NATO_Grenades_F", "Box_NATO_Support_F", "Box_NATO_AmmoVeh_F"];
	_currBox1 = _Boxes1 call BIS_fnc_selectRandom;
	_box1 = createVehicle [_currBox1, _lastPos, [], 2, "None"];
	_box1 setDir random 360;
	if (_box1 isKindOf "Box_NATO_AmmoVeh_F") then
	{
		_box1 setammocargo 0;
		[_box1] remoteExecCall ["GOM_fnc_addAircraftLoadout", 0, _box1];
	};
	_box1 setVariable ["moveable", true, true];
	_box1 allowDamage false;

	_Boxes2 = ["Box_NATO_Ammo_F","Box_T_NATO_Wps_F","Box_NATO_AmmoOrd_F","Box_NATO_Equip_F","Box_NATO_Grenades_F","Box_T_NATO_WpsSpecial_F","Box_NATO_WpsLaunch_F", "Box_NATO_Grenades_F", "Box_NATO_Support_F", "Box_NATO_AmmoVeh_F"];
	_currBox2 = _Boxes2 call BIS_fnc_selectRandom;
	_box2 = createVehicle [_currBox2, _lastPos, [], 2, "None"];
	_box2 setDir random 360;
	if (_box2 isKindOf "Box_NATO_AmmoVeh_F") then
	{
		_box2 setammocargo 0;
		[_box2] remoteExecCall ["GOM_fnc_addAircraftLoadout", 0, _box2];
	};
	_box2 setVariable ["moveable", true, true];
	_box2 allowDamage false;

	_Boxes3 = ["Box_NATO_Ammo_F","Box_T_NATO_Wps_F","Box_NATO_AmmoOrd_F","Box_NATO_Equip_F","Box_NATO_Grenades_F","Box_T_NATO_WpsSpecial_F","Box_NATO_WpsLaunch_F", "Box_NATO_Grenades_F", "Box_NATO_Support_F", "Box_NATO_AmmoVeh_F"];
	_currBox3 = _Boxes3 call BIS_fnc_selectRandom;
	_box3 = createVehicle [_currBox3, _lastPos, [], 2, "None"];
	_box3 setDir random 360;
	if (_box3 isKindOf "Box_NATO_AmmoVeh_F") then
	{
		_box3 setammocargo 0;
		[_box3] remoteExecCall ["GOM_fnc_addAircraftLoadout", 0, _box3];
	};
	_box3 setVariable ["moveable", true, true];
	_box3 allowDamage false;

	_Boxes4 = ["Box_NATO_Ammo_F","Box_T_NATO_Wps_F","Box_NATO_AmmoOrd_F","Box_NATO_Equip_F","Box_NATO_Grenades_F","Box_T_NATO_WpsSpecial_F","Box_NATO_WpsLaunch_F", "Box_NATO_Grenades_F", "Box_NATO_Support_F", "Box_NATO_AmmoVeh_F"];
	_currBox4 = _Boxes4 call BIS_fnc_selectRandom;
	_box4 = createVehicle [_currBox4, _lastPos, [], 2, "None"];
	_box4 setDir random 360;
	if (_box4 isKindOf "Box_NATO_AmmoVeh_F") then
	{
		_box4 setammocargo 0;
		[_box4] remoteExecCall ["GOM_fnc_addAircraftLoadout", 0, _box4];
	};
	_box4 setVariable ["moveable", true, true];
	_box4 allowDamage false;

	_Boxes5 = ["Box_NATO_Ammo_F","Box_T_NATO_Wps_F","Box_NATO_AmmoOrd_F","Box_NATO_Equip_F","Box_NATO_Grenades_F","Box_T_NATO_WpsSpecial_F","Box_NATO_WpsLaunch_F", "Box_NATO_Grenades_F", "Box_NATO_Support_F", "Box_NATO_AmmoVeh_F"];
	_currBox5 = _Boxes5 call BIS_fnc_selectRandom;
	_box5 = createVehicle [_currBox5, _lastPos, [], 2, "None"];
	_box5 setDir random 360;
	if (_box5 isKindOf "Box_NATO_AmmoVeh_F") then
	{
		_box5 setammocargo 0;
		[_box5] remoteExecCall ["GOM_fnc_addAircraftLoadout", 0, _box5];
	};
	_box5 setVariable ["moveable", true, true];
	_box5 allowDamage false;

	_Boxes6 = ["Box_NATO_Ammo_F","Box_T_NATO_Wps_F","Box_NATO_AmmoOrd_F","Box_NATO_Equip_F","Box_NATO_Grenades_F","Box_T_NATO_WpsSpecial_F","Box_NATO_WpsLaunch_F", "Box_NATO_Grenades_F", "Box_NATO_Support_F", "Box_NATO_AmmoVeh_F"];
	_currBox6 = _Boxes6 call BIS_fnc_selectRandom;
	_box6 = createVehicle [_currBox6, _lastPos, [], 2, "None"];
	_box6 setDir random 360;
	if (_box6 isKindOf "Box_NATO_AmmoVeh_F") then
	{
		_box6 setammocargo 0;
		[_box6] remoteExecCall ["GOM_fnc_addAircraftLoadout", 0, _box6];
	};
	_box6 setVariable ["moveable", true, true];
	_box6 allowDamage false;

	_Boxes7 = ["Box_NATO_Ammo_F","Box_T_NATO_Wps_F","Box_NATO_AmmoOrd_F","Box_NATO_Equip_F","Box_NATO_Grenades_F","Box_T_NATO_WpsSpecial_F","Box_NATO_WpsLaunch_F", "Box_NATO_Grenades_F", "Box_NATO_Support_F", "Box_NATO_AmmoVeh_F"];
	_currBox7 = _Boxes7 call BIS_fnc_selectRandom;
	_box7 = createVehicle [_currBox7, _lastPos, [], 2, "None"];
	_box7 setDir random 360;
	if (_box7 isKindOf "Box_NATO_AmmoVeh_F") then
	{
		_box7 setammocargo 0;
		[_box7] remoteExecCall ["GOM_fnc_addAircraftLoadout", 0, _box7];
	};
	_box7 setVariable ["moveable", true, true];
	_box7 allowDamage false;

	_Boxes8 = ["Box_NATO_Ammo_F","Box_T_NATO_Wps_F","Box_NATO_AmmoOrd_F","Box_NATO_Equip_F","Box_NATO_Grenades_F","Box_T_NATO_WpsSpecial_F","Box_NATO_WpsLaunch_F", "Box_NATO_Grenades_F", "Box_NATO_Support_F", "Box_NATO_AmmoVeh_F"];
	_currBox8 = _Boxes8 call BIS_fnc_selectRandom;
	_box8 = createVehicle [_currBox8, _lastPos, [], 2, "None"];
	_box8 setDir random 360;
	if (_box8 isKindOf "Box_NATO_AmmoVeh_F") then
	{
		_box8 setammocargo 0;
		[_box8] remoteExecCall ["GOM_fnc_addAircraftLoadout", 0, _box8];
	};
	_box8 setVariable ["moveable", true, true];
	_box8 allowDamage false;

	_Boxes9 = ["Box_NATO_Ammo_F","Box_T_NATO_Wps_F","Box_NATO_AmmoOrd_F","Box_NATO_Equip_F","Box_NATO_Grenades_F","Box_T_NATO_WpsSpecial_F","Box_NATO_WpsLaunch_F", "Box_NATO_Grenades_F", "Box_NATO_Support_F", "Box_NATO_AmmoVeh_F"];
	_currBox9 = _Boxes9 call BIS_fnc_selectRandom;
	_box9 = createVehicle [_currBox9, _lastPos, [], 2, "None"];
	_box9 setDir random 360;
	if (_box9 isKindOf "Box_NATO_AmmoVeh_F") then
	{
		_box9 setammocargo 0;
		[_box9] remoteExecCall ["GOM_fnc_addAircraftLoadout", 0, _box9];
	};
	_box9 setVariable ["moveable", true, true];
	_box9 allowDamage false;

_this call airborneMissionProcessor;
