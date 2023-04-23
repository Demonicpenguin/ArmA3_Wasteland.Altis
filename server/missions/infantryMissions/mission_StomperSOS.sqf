// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_StomperSOS.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev
//	@file Created: 08/12/2012 15:19

if (!isServer) exitwith {};
#include "infantryMissionDefines.sqf";

private ["_nbUnits", "_box1", "_box2", "_vehicle"];

_setupVars =
{
	_missionType = "Stomper SOS";
	_locationsArray = [ForestMissionMarkers, MissionSpawnMarkers] select (ForestMissionMarkers isEqualTo []);
	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;

	_vehicleClass =
	[
		"B_UGV_01_F",
		"B_UGV_01_rcws_F",
		"I_UGV_01_F",
		"I_UGV_01_rcws_F",
		"O_UGV_01_F",
		"O_UGV_01_rcws_F"
	] call BIS_fnc_selectRandom;
	
	// Class, Position, Fuel, Ammo, Damage, Special
	_vehicle = [_vehicleClass, _missionPos] call createMissionVehicle;
	
	_box1 = createVehicle ["Box_NATO_Wps_F", _missionPos, [], 5, "None"];
	_box1 setDir random 360;
	[_box1, "mission_USSpecial"] call fn_refillbox;

	_box2 = createVehicle ["Box_East_Wps_F", _missionPos, [], 5, "None"];
	_box2 setDir random 360;
	[_box2, "mission_USLaunchers"] call fn_refillbox;

	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach [_box1, _box2];
	_vehicle setVariable ["R3F_LOG_disabled", true, true];	

	_aiGroup = createGroup CIVILIAN;
	[_aiGroup, _missionPos, _nbUnits] call createCustomGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> typeOf _vehicle >> "picture");
	_missionHintText = "<br/>An UGV Stomper is being guarded by a group of highly trained Special Forces.<br/>Kill the Squad and claim it for your team!";
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach [_box1, _box2];
};

_successExec =
{
	// Mission completed
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2];
	
	_vehicle setVariable ["R3F_LOG_disabled", false, true];
	_vehicle setVariable ["A3W_RewardVehicle", true, true];	
	_vehicle lock 1;
	
	_successHintMessage = "Great job! The special forces has been killed! Connect to the Stomper and get the hell outa there!";
};

_this call infantryMissionProcessor;
