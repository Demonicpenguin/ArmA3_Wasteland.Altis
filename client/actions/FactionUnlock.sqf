/*
filename: FactionUnlock.sqf
Author: GMG_Monkey
Purpose: Allow claiming of faction reward vehicles
*/

private _vehicle = _this select 3 select 0;
[_vehicle, player] call A3W_fnc_takeOwnership;
["Acquiring complete!", 5] call mf_notify_client;
_vehicle setVariable ["FactionLocked", nil, true];