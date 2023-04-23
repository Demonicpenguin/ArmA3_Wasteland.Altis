/*
filename: DoorLocking.sqf
Author: GMG_Monkey
Purpose: Allow owner, and authorized player to lock and unlock specific doors on owned structurs
*/

private _Object = cursorObject;
private _Door = getCursorObjectParams select 1 select 0;
private _Action = _this select 3 select 0;
private _ObjectOwner = _Object getvariable ["OwnerUID", ""];
private _PlayerUID = getPlayerUID player;


switch (_Action) do
{
	case "lock":
	{
		if (_ObjectOwner == _PlayerUID) then
		{
			while {(_Object getvariable [format ["bis_disabled_%1",_Door], 0]) < 1} do
			{
				_Object setVariable [format ["bis_disabled_%1",_Door], 1, true];
			};
		}
		else
		{
			OutputText = nil;
			createDialog "AF_Keypad";
			waitUntil {!(isNil "OutputText")};
			if (OutputText == _Object getVariable [format ["password_%1", _Door], ""] && _Object getVariable [format ["password_%1", _Door], ""] != "") then 
			{
				while {(_Object getvariable [format ["bis_disabled_%1",_Door], 0]) < 1} do
				{
					_Object setVariable [format ["bis_disabled_%1",_Door], 1, true];
				};	
			}
			else
			{
				["Wrong PIN!", 5] call mf_notify_client;	
			};
			OutputText = nil;
		};
	};
	case "unlock":
	{
		if (_ObjectOwner == _PlayerUID) then
		{
			while {(_Object getvariable [format ["bis_disabled_%1",_Door], 0]) > 0} do
			{
				_Object setVariable [format ["bis_disabled_%1",_Door], 0, true];
			};
		}
		else
		{
			OutputText = nil;
			createDialog "AF_Keypad";
			waitUntil {!(isNil "OutputText")};
			if (OutputText == _Object getVariable [format ["password_%1", _Door], ""] && _Object getVariable [format ["password_%1", _Door], ""] != "") then 
			{
				while {(_Object getvariable [format ["bis_disabled_%1",_Door], 0]) > 0} do
				{
					_Object setVariable [format ["bis_disabled_%1",_Door], 0, true];
				};	
			}
			else
			{
				["Wrong PIN!", 5] call mf_notify_client;	
			};
			OutputText = nil;
		};
	};
	case "ChangePin":
	{
		OutputText = nil;
		createDialog "AF_Keypad";
		waitUntil {!(isNil "OutputText")};
		_Object setVariable [format ["password_%1", _Door], OutputText, true];
		if (OutputText=="")then 
		{
			["PIN lock disabled.", 5] call mf_notify_client;
		}else
		{
			["You successfully changed the PIN", 5] call mf_notify_client;	
		};	
		OutputText = nil;
	}
};
