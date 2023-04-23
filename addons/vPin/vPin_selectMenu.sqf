// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: vPin_selectMenu.sqf
//	@file Author: LouD (Original author: Cael817)
//	@file Description: vPin script

#define PLAYER_CONDITION "(vehicle player == player && {!isNull cursorObject})"
#define ITEM_CONDITION "{({cursorObject iskindof _x} count ['Land', 'Air', 'Water', 'Ship'] > 0)} && {(player distance cursorObject) < 25}"
#define OBJECT_CONDITION "{!(isNil {cursorObject getVariable 'ownerUID'})}"
#define OBJECT_OWNER "{cursorObject getVariable ['ownerUID',''] == getPlayerUID player}"
#define OBJECT_NONOWNER "{cursorObject getVariable ['ownerUID',''] != getPlayerUID player}"
#define PIN_CONDITION "{cursorObject getVariable ['vPin', true]} && {!isNil {cursorObject getVariable 'vPin'}}"

vPin_open = 
{
	execVM "addons\vPin\password_enter.sqf";
};

vPin_owner =
{
	execVM "addons\vPin\vPin_ownerMenu.sqf";
};

vPin_Actions = 
{
	{ [player, _x] call fn_addManagedAction } forEach
	[
		["<t color='#FFFFFF'><img image='client\icons\keypad.paa'/> Vehicle Pinlock</t>", vPin_owner, [cursorObject], -6, false, false, "", PLAYER_CONDITION + " && " + ITEM_CONDITION + " && " + OBJECT_CONDITION + " && " + OBJECT_OWNER + " && " + PIN_CONDITION],
		["<t color='#FFFFFF'><img image='client\icons\keypad.paa'/> Vehicle Pinlock</t>", vPin_open, [cursorObject], -6, false, false, "", PLAYER_CONDITION + " && " + ITEM_CONDITION + " && " + OBJECT_CONDITION + " && " + OBJECT_NONOWNER + " && " + PIN_CONDITION]
	];
};

vPinScriptInitialized = true;