/*******************************************************************************************
* This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com
********************************************************************************************
* @file Name: STCreateConvenienceKit.sqf
* @author: The Scotsman
*
* Creates a "convenience" crate in the setOxygenRemaining value
* Arguments: [crate, type]
* crate = The crate to load
* type = AA OR AT?
*/
#include "..\..\..\STConstants.h"

if (!isServer) exitWith {};

params ["_crate"];

_crate setAmmoCargo 10;
_crate allowDamage false; //Prevents destruction of crates
_crate setVariable ["allowDamage", false, true];
_crate setVariable ["A3W_inventoryLockR3F", true, true];

clearMagazineCargoGlobal _crate;
clearWeaponCargoGlobal _crate;
clearItemCargoGlobal _crate;

if( _crate isKindOf ST_AACONVENIENCEKIT ) then {

  _crate addMagazineCargoGlobal ["Titan_AA", 25];
  _crate addWeaponCargoGlobal ["launch_B_Titan_F", 2];

};

if( _crate isKindOf ST_ATCONVENIENCEKIT ) then {

  _crate addMagazineCargoGlobal ["Titan_AT", 25];
  _crate addWeaponCargoGlobal ["launch_I_Titan_short_F", 2];

};
