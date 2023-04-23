// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name:
//	@file Author:
//	@file Description:

#define Rearm_Menu_option 17001
disableSerialization;

private ["_start","_panelOptions","_rearm_select","_displayRearm"];
_uid = getPlayerUID player;
if (!isNil "_uid") then {
	_start = createDialog "Rearm_Menu";

	_displayRearm = uiNamespace getVariable "Rearm_Menu";
	_rearm_select = _displayRearm displayCtrl Rearm_Menu_option;

	_panelOptions =
	[
		"Lock Helipad Resupply",
		"Unlock Helipad Resupply",
		"Change PIN"
	];

	{
		_Rearm_select lbAdd _x;
	} forEach _panelOptions;
};
