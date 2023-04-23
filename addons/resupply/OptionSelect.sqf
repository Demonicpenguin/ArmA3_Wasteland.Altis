// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name:
//	@file Author:
//	@file Description:

#define Rearm_Menu_option 17001
disableSerialization;

private ["_panelType","_displayRearm","_rearm_select","_money"];
_uid = getPlayerUID player;
if (!isNil "_uid") then
{
	_panelType = _this select 0;

	_displayRearm = uiNamespace getVariable ["Rearm_Menu", displayNull];

	switch (true) do
	{
		case (!isNull _displayRearm): //Rearm Panel
		{
			_rearm_select = _displayRearm displayCtrl Rearm_Menu_option;

			switch (lbCurSel _rearm_select) do
			{
				case 0: //Lock
				{
					closeDialog 0;
					nul = [true] execVM "addons\resupply\RearmController.sqf";
				};
				case 1: //Unlock
				{
					closeDialog 0;
					nul = [false] execVM "addons\resupply\RearmController.sqf";
				};
				case 2: //Change Password
				{
					closeDialog 0;
					execVM "addons\safe\password_change.sqf";
				};
			};
		};
	};
};
