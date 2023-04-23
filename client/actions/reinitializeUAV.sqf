/*
File Name: reinitilizeUAV.sqf
Author: GMG_Monkey
Purpose: Allow player to reactive UAV/Autonomour turret after server restart or being removed from Parking
*/


//Setup Variable
private _mode = _this select 3 select 0;
private _uav = cursortarget;
private _class = typeOf _uav;
private _isUAV = (round getNumber (configFile >> "CfgVehicles" >> _class >> "isUav") > 0);
private _playerSide = side player;
private _playerID = getPlayerUID player;
private _uavOwner = _uav getVariable ["ownerUID", ""];

if (_isUAV) then 
{
	if (_uavOwner == _playerID) then 
	{
		switch (_mode) do
		{
			case "Re-Initilize":{[_uav, _playerSide, true] call fn_createCrewUAV; playSound3D [call currMissionDir + "media\powerup.ogg", _uav, true, getPosASL _uav, 3,1,60]; hint "UAV has been reintiated. Ready to fly."};
			case "Sentry":{[_uav, civilian, true, true] call fn_createCrewUAV};
			default {player globalChat "Something has gone awry"};
		};
	} else 
	{
		hint "No owned UAVs in range";
	};
} else 
{
	hint "No UAV in range";
};

