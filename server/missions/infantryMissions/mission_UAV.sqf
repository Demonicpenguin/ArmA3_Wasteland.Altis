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
	_missionType = "UAV Terminal";
	_locationsArray = MissionSpawnMarkers;
	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;

	_vehicleClass =
	[
		"B_UAV_02_F",
		"B_UAV_02_CAS_F",
		"O_UAV_02_F",
		"O_UAV_02_CAS_F",
		"I_UAV_02_F",
		"I_UAV_02_CAS_F"
	] call BIS_fnc_selectRandom;

	// Class, Position, Fuel, Ammo, Damage, Special
	_vehicle = [_vehicleClass, _missionPos] call createMissionVehicle;
	_vehicle allowDamage true;
	_vehicle setDir random 360;	
	_vehicle setVariable ["R3F_LOG_disabled", true, true];	

	  _guns = [];

	  //Create some random static guns
	  for "_i" from 0 to ([1,3] call BIS_fnc_randomInt) do {

		//Create a random position near the mission position
		_position = + _missionPos;
		_position set [0, (_position select 0) + ([1,8] call BIS_fnc_randomInt)];
		_position set [1, (_position select 1) + ([2,10] call BIS_fnc_randomInt)];

		_guns pushBack (createVehicle [(selectRandom["I_GMG_01_high_F", "I_HMG_01_high_F"]), _position,[], 10, "NONE"]);

	  };	



	_aiGroup = [_missionPos, ST_DELTA, 20]call STCreateRandomGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _vehicleClass >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _vehicleClass >> "displayName");
	
	_missionHintText = format ["Wake up! A %1 Drone has been spotted near the marker!<br/> Kill the guards and claim the %1 for your Team!<br/>", _vehicleName, infantryMissionColor];

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
	_vehicle setVariable ["A3W_RewardVehicle", true, true];	
	//createVehicleCrew _vehicle;	

	_randomCase = ["Box_FIA_Support_F","Box_FIA_Wps_F","Box_FIA_Ammo_F","Box_NATO_WpsSpecial_F","Box_East_WpsSpecial_F","Box_NATO_Ammo_F","Box_East_Ammo_F"] call BIS_fnc_selectRandom;
	
	_box1 = createVehicle [_randomCase, _missionPos, [], 5, "None"];	
	_box1 setDir random 360;
	_box1 addItemCargoGlobal ["O_UavTerminal",1];
	_box1 addItemCargoGlobal ["I_UavTerminal",1];
	_box1 addItemCargoGlobal ["B_UavTerminal",1];
	_box1 allowdamage false;
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1];

	//playSound3D ["A3\data_f_curator\sound\cfgsounds\air_raid.wss", _box1, false, _box1, 15, 1, 1500];
	
	_successHintMessage = format ["Well done! The guards of the UAV were killed! Aquire or Claim the Drone for your Team, it's yours to take along with any left over supplies"];

};


_this call infantryMissionProcessor;
