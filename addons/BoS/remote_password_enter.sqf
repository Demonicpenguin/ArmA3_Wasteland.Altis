// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright � 2014 	BadVolt 	*
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: remote_password_enter.sqf
//	@file Author: GMG_Monkey
//	@file Description: Entering password and open the doors for duration. Then closes them.

//#define DURATION 10

private _nearestManagers = nearestObjects [player, ["Land_SatellitePhone_F"], 100];
private _object = _nearestManagers select 0;

OutputText = nil;

createDialog "AF_Keypad";

waitUntil {!(isNil "OutputText")};

if (isNil "OutputText") exitWith {hint "No Code Entered. Require a Valid Entry!!";};

if (OutputText == _object getVariable [format ["password_%1", _Door], ""] && _object getVariable [format ["password_%1", _Door], ""] != "") then {
	execVM "addons\BoS\BoS_Remote_coownerMenu.sqf";	
	//[format ["Doors opened for %1 seconds ",DURATION], 5] call mf_notify_client;
}else{
	["Wrong PIN!", 5] call mf_notify_client;
};

OutputText = nil;
