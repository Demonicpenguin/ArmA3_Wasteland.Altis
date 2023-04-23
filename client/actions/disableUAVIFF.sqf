/*
Author: BIB_Monkey
FileName: DisableUAVIFF.sqf
Purpose: Removs AI from owned UAV to "turn off" the UAVControl
*/


//setup vairables
_uav = cursorTarget;
_class = typeOf _uav;
_isUAV = (round getNumber (configFile >> "CfgVehicles" >> _class >> "isUav") > 0);
_playerID = getPlayerUID player;
_uavOwner = _uav getVariable "ownerUID";
_uavcrew = crew _uav;
_uavrating = rating _uav;

//lets do the thing
if (_isUAV) then {
	if (_uavOwner == _playerID) then {
		_uav addrating  -10000;
		_uav setCombatMode "RED";
		_uav setBehaviour "AWARE";
	} else {
		hint "No owned UAV in range";
	};
} else {
	hint "No UAV in range";
};
