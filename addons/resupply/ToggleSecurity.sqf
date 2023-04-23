// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright � 2014 	BadVolt 	*
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: ToggleSecurity.sqf
//	@file Author:
//	@file Description: Turns off/on security on Rearm Crates

#include "..\..\STConstants.h"

private ["_crates", "_locker", "_lock"];

//Find the baselocker relative to the player (Keypad)
_lockers = nearestObjects [player, [BASE_LOCKER], 20];

if( !isNil "_lockers" ) then {

	_locker = _lockers select 0;
	_lock = !(_locker getVariable ["ammolocked", true]);

  _crates = (nearestObjects [_locker, [ST_RESUPPLY_KIT, ST_REPAIR_DEPOT], 200]);

  if( !isNil "_crates" ) then {

    //Toggle Crates
    { nul = [_lock, _x, false] execVM "addons\resupply\RearmController.sqf"; } forEach _crates;

    _locker setVariable ["ammolocked", _lock, true];

		hint format ["All Rearm Crates have been %1", (["unlocked", "locked"] select _lock)];

	} else {

		hint "No Rearm Crates are within a 200 metre proximety of the base locker";

	};

};
