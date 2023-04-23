
params ["_unit"];

private ["_unit", "_uid,", "_owner"];

_uid = getPlayerUID _unit;
_owner = cursorTarget getvariable "ownerUID";

if (!isNull (uiNamespace getVariable ["Rearm_Menu", displayNull]) && !(player call A3W_fnc_isUnconscious)) exitWith {};

switch (true) do {

	case (_uid == _owner || _uid != _owner): {
		execVM "addons\resupply\PasswordEnter.sqf";
		hint "Welcome";
	};
	case (isNil _uid || isNull _uid): {
		hint "You need to lock the object first!";
	};
	default {
		hint "An unknown error occurred. This could be because the object is not locked."
	};

};
