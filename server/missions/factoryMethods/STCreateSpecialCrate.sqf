/*******************************************************************************************
* This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com
********************************************************************************************
* @file Name: STCreateSpecialCrate.sqf
* @author: The Scotsman
*
*
* Arguments: [ _position ]:
*
*/
#include "..\..\..\STConstants.h"

if (!isServer) exitWith {};

params ["_position", "_type", ["_smoke", false]];

private ["_pos"];

_box = _type createVehicle _position;
_box allowDamage false;
_box setVariable ["R3F_LOG_disabled", false, true];

if( _type == ST_SNIPERKIT ) then {

  [_box] call STFillSniperCrate;

} else {

  [_box] call STFillCrate;

};

//Still have random chance for arty strike
if (["A3W_artilleryStrike"] call isConfigOn ) then {
  if (random 1.0 < ["A3W_artilleryCrateOdds", 1/10] call getPublicVar) then {
    _box setVariable ["artillery", 1, true];
  };
};

if( _smoke ) then { [_box] spawn STPopCrateSmoke; };

_box
