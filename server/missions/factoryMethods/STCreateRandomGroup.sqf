// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: STCreateRandomGroup.sqf
//	@file Author: The Scotsman
//Types: DEFAULT, SNIPER, PILOT

#include "..\..\..\STConstants.h"

if (!isServer) exitWith {};

params ["_position", ["_type", ST_INFANTRY], ["_max", 18]];
private ["_group", "_unit", "_rank", "_range"];

if( _max <= 8 ) then { _max = 10; };

_range = [8, _max] call BIS_fnc_randomInt;

_group = createGroup CIVILIAN;
_group setCombatMode "RED";
_group setBehaviour "COMBAT";

diag_log format ["STCreateGroup (%1) size:%2", _type, _range];

for "_i" from 1 to _range do {

  _rank = [ST_PRIVATE, ST_CORPORAL, ST_SERGEANT] call BIS_fnc_selectRandom;
  _unit = [_position, _group, _type, _rank, (_i == 1)] call STCreateUnit;

};

[_group, _position] call defendArea;

_group
