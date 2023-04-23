// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright � 2014 	BadVolt 	*
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: PasswordEnter.sqf
//	@file Author:
//	@file Description:

_object = cursorTarget;

OutputText = nil;

createDialog "AF_Keypad";

waitUntil {!(isNil "OutputText")};

//TODO: Make execVM a parameter so this can be reused
if (OutputText == _object getVariable ["password", ""]) then {
	execVM "addons\resupply\OwnerMenu.sqf";
}else{
	["Wrong PIN!", 5] call mf_notify_client;
};

OutputText = nil;
