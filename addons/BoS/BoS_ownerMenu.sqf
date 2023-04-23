//	@file Version:
//	@file Name:
//	@file Author: Cael817, all credit to A3W
//	Edited by: GMG_Monkey
//	@file Created:

#define BoS_Menu_option 17001
disableSerialization;

private ["_start","_panelOptions","_BoS_select","_displayBoS"];
_uid = getPlayerUID player;
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
		"Release Lock Down", //11
		"Show objects owned by you", //12		
		"Show Base Border", //13		
		"Base payment every 29 days", //14
		"Set Auto Guns to Sentry", //15
		"Disable Auto Guns to Sentry", //16
		"Resupply", //17
		"Change PIN", //18
		"Upgrade Base Manager", //19
		//"UNLOCK All Base Components", //20
		//"LOCK All Base Components", //21
		"Toggle Rearm Security", //22
		"Lock All Vehicles" //23		
	];

	{
		_BoS_select lbAdd _x;
	} forEach _panelOptions;
};
