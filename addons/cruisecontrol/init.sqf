// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: init.sqf
//	@file Author: The Scotsman
//	@file Description:

waitUntil {time > 0};
execVM "addons\cruisecontrol\STCruiseControl.sqf";
waitUntil {!isNil "CruiseControlInitialized"};
[player] call Cruise_Control_Setup;
