// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: Rearm_Menu.sqf
//	@file Author: The Scotsman
//	@file Description: Lockable Reammo Crates

#define PLAYER_CONDITION "vehicle player == player && !(isNull cursorTarget) && !((vehicle player) getVariable ['A3W_resupplyTruck', false])"
#define ITEM_CONDITION "cursortarget getVariable ['A3W_resupplyTruck', false] && (player distance2D (getPosATL cursortarget)) < 5"
#define OBJECT_CONDITION "(cursorTarget getVariable ['objectLocked', false] || cursorTarget isKindOf 'LandVehicle')"

Rearm_Actions = {

	{ [player, _x] call fn_addManagedAction } forEach [
		["<t color='#FFE496'><img image='client\icons\keypad.paa'/> Security Settings</t>", "addons\resupply\SecuritySettings.sqf", [cursorTarget], -97, false, false, "", PLAYER_CONDITION + " && " + ITEM_CONDITION + " && " + OBJECT_CONDITION]
	];
};

RearmInitialized = true;
