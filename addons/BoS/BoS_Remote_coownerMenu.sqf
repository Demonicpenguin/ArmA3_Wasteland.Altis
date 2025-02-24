//	@file Version:
//	@file Name:
//	@file Author: Cael817, all credit to A3W
//	@file Created:

#define BoS_Menu_option 17001
disableSerialization;

private ["_start","_panelOptions","_BoS_select","_displayBoS"];
_uid = getPlayerUID player;
if (!isNil "_uid") then {
	_start = createDialog "BoS_Menu";

	_displayBoS = uiNamespace getVariable "BoS_Menu";
	_BoS_select = _displayBoS displayCtrl BoS_Menu_option;

	_panelOptions = [
					"Lights OFF",
					"Lights ON",
					"Lock Doors",
					"Unlock Doors",
					"Open Roof",
					"Close Roof",
					"Open Canal Door",
					"Close Canal Door",
					"Open Wall Portal",
					"Close Wall Portal",					
					"Lock Down Base",
					"Release Lock Down"				
	];

	{
		_BoS_select lbAdd _x;
	} forEach _panelOptions;
};
