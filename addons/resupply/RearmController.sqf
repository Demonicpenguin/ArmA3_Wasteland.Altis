// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright � 2014 	BadVolt 	*
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: RearmController.sqf
//	@file Author:
//	@file Description: Handles Lock/Unlock action on reammo crate

params ["_lock", ["_crate", cursorTarget], ["_verbose", true]];

_crate setVariable ["R3F_LOG_disabled", _lock, true];
_crate setVariable ["A3W_inventoryLockR3F", _lock, true];
_crate setVariable ["lockedSafe", _lock, true];

pvar_manualObjectSave = netId _crate;
publicVariableServer "pvar_manualObjectSave";

playSound3D [call currMissionDir + "media\carbeep.ogg", _crate, true, getPosASL _crate, 2];
//playSound3d [MISSION_ROOT + "media\carbeep.ogg", _crate, true, getPosASL _crate, 2];

if( _verbose ) then { hint (["Your Resupply Crate is unlocked", "Your Resupply Crate is locked"] select _lock); };
