// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_UAV.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev
//	@file Created: 08/12/2012 15:19

if (!isServer) exitwith {};
#include "infantryMissionDefines.sqf";

private ["_nbUnits", "_vehicleClass", "_vehicle", "_randomBox", "_randomCase", "_box1", "_para", "_guns"];

_setupVars =
{
	_missionType = "Artillery Hardware";
	_locationsArray = MissionSpawnMarkers;
	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;

	_vehicleClass =
	[
		"rhsusf_m109_usarmy",
		"RHS_M119_WD"
	] call BIS_fnc_selectRandom;

	// Class, Position, Fuel, Ammo, Damage, Special
	if (_vehicleClass isKindOf "rhsusf_m109_usarmy") then
	{
		_vehicle = [_vehicleClass, _missionPos] call createMissionVehicle;
	} 
	else
		{
			_vehicle = createVehicle ["RHS_M119_WD", _missionPos,[], 10,"None"]; 
			_vehicle setPosATL [_missionPos select 0, _missionPos select 1, _missionPos select 2];
		};
	
	_vehicle lock 0;
	_vehicle setVariable ["R3F_LOG_disabled", true, true];	
	
	  _guns = [];

	  //Create some random static guns
	  for "_i" from 0 to ([4,6] call BIS_fnc_randomInt) do {

		//Create a random position near the mission position
		_position = + _missionPos;
		_position set [0, (_position select 0) + ([1,8] call BIS_fnc_randomInt)];
		_position set [1, (_position select 1) + ([2,10] call BIS_fnc_randomInt)];

		_guns pushBack (createVehicle [(selectRandom["I_GMG_01_high_F", "I_HMG_01_high_F"]), _position,[], 10, "NONE"]);
	  };	

	_aiGroup = [_missionPos, ST_DELTA, 20]call STCreateRandomGroup;

	if (_vehicleClass isKindOf "rhsusf_m109_usarmy") then
	{
			_missionPicture = "media\m109a6.jpg";
	} 
	else
		{
			_missionPicture = "media\artillery.jpg";
		};	
		
	_vehicleName = getText (configFile >> "CfgVehicles" >> _vehicleClass >> "displayName");
	
	_missionHintText = format ["ALERT! An Artillery Escort has broken down and is undergoing emergency repairs en route to a secret location.<br/> Kill the escort guards, and claim it for your team</t>!<br/>", _vehicleName, infantryMissionColor];

};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = {!alive _vehicle};

_failedExec =
{
	// Mission failed
	deleteVehicle _vehicle;
  { deleteVehicle _x } forEach _guns;	
	
};

_successExec =
{
	// Mission completed

	{ deleteVehicle _x } forEach _guns;
	_vehicle lock 1;
	_vehicle setVariable ["R3F_LOG_disabled", false, true];

	_successHintMessage = format ["Well done! The guards of the Artillery Hardware were killed! The hardware is yours"];
};


_this call infantryMissionProcessor;
