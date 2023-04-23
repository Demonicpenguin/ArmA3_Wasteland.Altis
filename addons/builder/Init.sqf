// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: Init.sqf
//	@file Author: The Scotsman
//	@file Description:

waitUntil {time > 0};

execVM "addons\builder\Main.sqf";
waitUntil {!isNil "BuilderInitialized"};
[player] call builder_Actions;
