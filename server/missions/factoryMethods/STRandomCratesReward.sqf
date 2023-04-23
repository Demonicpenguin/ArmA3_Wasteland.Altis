/*******************************************************************************************
* This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com
********************************************************************************************
* @file Name: STRandomCrates.sqf
* @author: The Scotsman
*
*
* Arguments: [ position, count, smoke ]: Number of crates
*
*/
#include "..\..\..\STConstants.h"

if (!isServer) exitWith {};

params ["_position", "_range", ["_smoke", false], ["_disabled", false]];

private ["_count", "_types", "_type", "_box", "_boxes"];

//TODO: Fill crate according to it's type

//Random Number of Crates
_count = _range call BIS_fnc_randomInt;
_types = [
  "Box_Ammo_F",
  "Box_GEN_Equip_F",
  "B_supplyCrate_F",
  "Box_East_Wps_F",
  "Box_NATO_Wps_F",
  "Box_NATO_Support_F",
  "Box_NATO_Equip_F",
  "Box_NATO_Ammo_F",
  "Box_NATO_Grenades_F",
  "Box_NATO_AmmoOrd_F",
  "Box_NATO_Uniforms_F",
  "Box_NATO_WpsLaunch_F",
  "Box_IND_Ammo_F",
  "Box_IND_Grenades_F",
  "Box_IND_Support_F",
  "Box_IND_AmmoOrd_F",
  "Box_IND_AmmoVeh_F",
  "Box_IND_WpsLaunch_F",
  "Box_EAST_Ammo_F",
  "Box_EAST_Grenades_F",
  "Box_EAST_AmmoOrd_F",
  "Box_AAF_Equip_F",
  "Box_AAF_Uniforms_F",
  "Box_AAF_Equip_F",
  "Box_CSAT_Uniforms_F",
  "Box_CSAT_Equip_F",
  "Box_T_East_Ammo_F",
  "Box_T_East_WpsSpecial_F",
  "Box_East_Support_F",
  "Box_East_WpsLaunch_F"
];

_boxes = [];

//Three percent chance of something special
if( (random 100) <= 3 ) then {

  _type = selectRandom [ST_ATCONVENIENCEKIT, ST_AACONVENIENCEKIT, ST_SNIPERKIT];

  _count = _count - 1;
  _boxes pushBack ([_position, _type] call STCreateSpecialCrate);

};

for "_x" from 1 to _count do {

  _box = (selectRandom _types) createVehicle _position;
  _box allowDamage false;
  _box setVariable ["R3F_LOG_disabled", _disabled, true];

  [_box] call STFillCrate;

  _boxes pushBack _box;

};

//Pop Smoke on first box
if( _smoke ) then { [_boxes select 0] spawn STPopCrateSmoke; };

//Two percent chance of an Artillery Strike
if( (random 100) <= 10 ) then { (_boxes select 0) setVariable ["artillery", 1, true]; };

_boxes
