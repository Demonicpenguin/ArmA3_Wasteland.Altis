//	@file Version:
//	@file Name:
//	@file Author: Cael817, all credit to A3W
// Edited By: GMG Monkey
//	@file Created:

#define BoS_Menu_option 17001
disableSerialization;
private _uid = getPlayerUID player;
if (!isNil "_uid") then 
{
	_start = createDialog "BoS_Menu";
	_displayBoS = uiNamespace getVariable "BoS_Menu";
	_BoS_select = _displayBoS displayCtrl BoS_Menu_option;
	_panelOptions = 
	[
		"Lights OFF",  //0
		"Lights ON", //1
		"Lock Doors", //2
		"Unlock Doors", //3
		"Open Roof", // 4
		"Close Roof", // 5
		"Open Canal Door", // 6
		"Close Canal Door", // 7
		"Open Wall Portal", //8
		"Close Wall Portal", //9
		"Lock Down Base", //10
		"Release Lock Down" //11


	];
	{
		_BoS_select lbAdd _x;
	} forEach _panelOptions;
};
