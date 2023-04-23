// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: init.sqf
//	@file Author: The Scotsman
//	@file Description: Reammo Crate

waitUntil {time > 0};
execVM "addons\resupply\RearmMenu.sqf";
waitUntil {!isNil "RearmInitialized"};
[player] call Rearm_Actions;
