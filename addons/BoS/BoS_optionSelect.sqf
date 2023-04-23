//	@file Version:
//	@file Name:
//	@file Author: Cael817 Edited By: GMG_Monkey
//	@file Created:

#define BoS_Menu_option 17001
disableSerialization;

private ["_panelType","_displayBoS","_BoS_select","_money"];
_uid = getPlayerUID player;
if (!isNil "_uid") then
{
	_panelType = _this select 0;

	_displayBoS = uiNamespace getVariable ["BoS_Menu", displayNull];

	switch (true) do
	{
		case (!isNull _displayBoS): //BoS panel
		{
			_BoS_select = _displayBoS displayCtrl BoS_Menu_option;

			switch (lbCurSel _BoS_select) do
			{
				case 0: //Turn off all lights
				{
					closeDialog 0;
					execVM "addons\BoS\BoS_lightsOff.sqf";;
				};
				case 1: //Turn on all lighs
				{
					closeDialog 0;				
					execVM "addons\BoS\BoS_lightsOn.sqf";
				};
				case 2: //Lock Doors
				{
					closeDialog 0;				
					execVM "addons\Bos\LockDoors.sqf";
				};
				Case 3: //Unlock Doors
				{
					closeDialog 0;				
					execVM "addons\Bos\UnlockDoors.sqf";
				};
				Case 4: //Open Roof
				{
					closeDialog 0;				
					execVM "addons\Door\Door_openRoof.sqf";
				};				
				Case 5: //Close Roof
				{
					closeDialog 0;				
					execVM "addons\Door\Door_closeRoof.sqf";
				};
				case 6: //open Canal Door
				{
					closeDialog 0;					
					execVM "addons\Door\Door_openDoor.sqf";
				};
				case 7: //close Canal Door
				{
					closeDialog 0;					
					execVM "addons\Door\Door_closeDoor.sqf";
				};
				Case 8: //Open Wall Portal
				{
					closeDialog 0;				
					execVM "addons\Door\Door_openWall.sqf";
				};				
				Case 9: //Close Wall Portal
				{
					closeDialog 0;				
					execVM "addons\Door\Door_closeWall.sqf";
				};				
				case 10: //Lock Down Base
				{
					closeDialog 0;
					execVM "addons\BoS\BoS_lockDown.sqf";
				};
				case 11: //Release Lock Down
				{
					closeDialog 0;
					execVM "addons\BoS\BoS_releaseLockDown.sqf";
				};
				case 12: //Mark Owned Object
				{
					closeDialog 0;				
					execVM "addons\BoS\BoS_markOwned.sqf";
				};				
				case 13: //Show Base Border
				{
					closeDialog 0;
					execVM "addons\BoS\BoS_showBorder.sqf";
				};				
				case 14: //Relock Base Objects
				{
					closeDialog 0;				
					execVM "addons\BoS\BoS_reLock.sqf";
				};
				case 15: //Resupply Service Objects
				{
					closedialog 0;
					execVM "addons\BoS\SetSentryMode.sqf";
				};
				case 16: //Resupply Service Objects
				{
					closedialog 0;
					execVM "addons\BoS\DisableSentryMode.sqf";
				};
				case 17: //Resupply Service Objects
				{
					closedialog 0;
					execVM "addons\BoS\ResupplyServiceObjects.sqf";
				};
				case 18: //Change Password
				{
					closeDialog 0;
					execVM "addons\BoS\password_change.sqf";
				};
				case 19: //Upgrade Base
				{
					execVM "addons\BoS\UpgradeBase.sqf";
				};
				/*case 20: {
					closeDialog 0;
					[false] execVM "addons\BoS\BOS_componentController.sqf";
				};
				case 21: {
					closeDialog 0;
					[true] execVM "addons\BoS\BOS_componentController.sqf";
				};*/
				case 20: //Toggle Rearm Crate Security
				{
					closeDialog 0;
					execVM "addons\resupply\ToggleSecurity.sqf";
				};
				case 21: //Lock All Vehicles
				{
					closeDialog 0;
					execVM "addons\BoS\BoS_LockAllVehicles.sqf";
				}				
			};
		};
	};
};
