/*
Author: BIB_Monkey
FileName: DisableUAV.sqf
Purpose: Removs AI from owned UAV to "turn off" the UAVControl
*/


//setup vairables
_uav = cursorTarget;
_class = typeOf _uav;
_isUAV = (round getNumber (configFile >> "CfgVehicles" >> _class >> "isUav") > 0);
_playerID = getPlayerUID player;
_uavOwner = _uav getVariable "ownerUID";
_uavcrew = crew _uav;

//lets do the thing
if (_isUAV) then {
	if (_uavOwner == _playerID) then {
		hint "UAV has been disabled!";
		playSound3D [call currMissionDir + "media\powerdown.ogg", _uav, true, getPosASL _uav, 3,1,60];
		{deleteVehicle _x}foreach _uavcrew
	} else {
		hint "No owned UAV in range";
	};
} else {
	hint "No UAV in range";
};
