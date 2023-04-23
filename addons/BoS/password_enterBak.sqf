// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright � 2014 	BadVolt 	*
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: password_enter.sqf
//	@file Author: BadVolt
//	@file Description: Entering password and open the doors for duration. Then closes them.

//#define DURATION 10

_Object = nearestObject [player, "Land_SatellitePhone_F"];

OutputText = nil;

createDialog "AF_Keypad";

waitUntil {!(isNil "OutputText")};

if (OutputText == _Object getVariable [format ["password_%1", _Door], ""] && _Object getVariable [format ["password_%1", _Door], ""] != "") then {
	execVM "addons\BoS\BoS_coownerMenu.sqf";	
	//[format ["Doors opened for %1 seconds ",DURATION], 5] call mf_notify_client;	
}else{
	["Wrong PIN!", 5] call mf_notify_client;	
};

OutputText = nil;
