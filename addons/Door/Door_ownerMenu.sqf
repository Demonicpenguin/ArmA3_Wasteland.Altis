// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: Door_ownerMenu.sqf
//	@file Author: LouD / Cael817 for original script
//	@file Description: Door script

#define Door_Menu_option 17001
disableSerialization;

private ["_start","_panelOptions","_Door_select","_displayDoor"];
_uid = getPlayerUID player;
if (!isNil "_uid") then {
	_start = createDialog "Door_Menu";

	_displayDoor = uiNamespace getVariable "Door_Menu";
	_Door_select = _displayDoor displayCtrl Door_Menu_option;

	_panelOptions = 
	[
		"Open Canal Door",
		"Close Canal Door",
		"Open Roof Portal",
		"Close Roof Portal",
		"Open Wall Portal",
		"Close Wall Portal",		
		"Open Hangar Door",
		"Close Hangar Door",
		"Open both Canal & Hangar Doors",
		"Close both Canal & Hangar Doors",
		"Change PIN",
		"Exit Door Menu"
	];

	{
		_Door_select lbAdd _x;
	} forEach _panelOptions;
};