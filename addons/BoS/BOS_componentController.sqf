// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: BOS_componentController.sqf
//	@file Author: The Scotsman
//	@file Description: Controls the lock state of all base components (parts)

params[["_lock", true]];

scopeName "check";

//Are you sure?
if( !_lock ) then {

  if !(["Are you REALLY REALLY sure you want to unlock ALL the parts of your base?", "Confirm", true, true] call BIS_fnc_guiMessage) exitWith { breakOut "check" };

};

//Get The base Locker
private _lockers = nearestObjects [player, ["Land_SatellitePhone_F"], 90];

//Find all base parts within the radius of the base (100M);
private _locker = if( count _lockers > 0 ) then { _lockers select 0 } else { objNull };

if( isNull _locker ) exitWith { hint "No base locker" };

private _objects = nearestObjects [_locker, R3F_LOG_CFG_can_be_moved_by_player, 90, true];
private _count = 0;

{

  _locked = _x getVariable ["objectLocked", nil];

  if( _x isKindOf "Land_SatellitePhone_F" ) then {

    cursorTarget setVariable ["lockDown", _lock, true];

  };

  if( !(_x isKindOf "Land_SatellitePhone_F") && !(isNil "_locked") ) then {

    _x setVariable["objectLocked", _lock, true];
    _count = _count + 1;

  };

} forEach _objects;

playSound3D [call currMissionDir + "media\klaxon.ogg", _locker, true, getPos _locker, 2];

hint format ["%1 base parts have been %2", (count _objects), (["Unlocked", "Locked"] select (_lock))];
