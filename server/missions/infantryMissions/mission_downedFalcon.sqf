// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_downedFalcon.sqf
//	@file Author: The Scotsman
//	@file Description: Retrieve a disabled falcon UAV

if (!isServer) exitwith {};

#include "infantryMissionDefines.sqf";

private ["_positions", "_uav", "_guns", "_vehicleName"];

_setupVars = {

	_missionType = "Downed Falcon";
	_locationsArray = MissionSpawnMarkers;

};

_setupObjects = {

  _missionPos = markerPos _missionLocation;

	_uav = createVehicle ["B_T_UAV_03_F", _missionPos, [], 3, "NONE"];
	_uav allowDamage true;
	_uav setDir random 360;
	_uav setVariable ["R3F_LOG_disabled", true, true];

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

  _missionPicture = getText (configFile >> "CfgVehicles" >> typeOf _uav >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> typeOf _uav >> "displayName");

	_missionHintText = format ["<br/>Deep in the woods, a <t color='%1'>%2</t> went down, heavily guarded by special forces. Head there, dispatch the guards and recover the hardware", infantryMissionColor, _vehicleName];

};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

//Mission failed
_failedExec = {

	{ deleteVehicle _x } forEach [_uav];
  { deleteVehicle _x } forEach _guns;

};

//Mission completed
_successExec = {

	{ deleteVehicle _x } forEach _guns;

	_uav setVariable ["R3F_LOG_disabled", false, true];
	_uav setVariable ["A3W_RewardVehicle", true, true];
	_uav lock 1;	
	//createVehicleCrew _uav;	

  //Random Number of Crates
	[_lastPos, [1, 3]] call STRandomCratesReward;

	_successHintMessage = format ["Well done! The guards of the MQ-12 Falcon UAV were killed! The UAV is yours to take along with any left over supplies"];

};

_this call infantryMissionProcessor;
