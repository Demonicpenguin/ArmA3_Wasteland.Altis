/*******************************************************************************************
* This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com
********************************************************************************************
* @file Name: STPopCrateSmoke.sqf
* @author: The Scotsman
*
* Attaches smoke and flares to the given crate for five minutes
* Arguments: [ crate ]: Object
*
*/
if (!isServer) exitWith {};

params ["_crate", ["_minutes",5]];
private ["_crate", "_minutes", "_smoke", "_flare"];

for "_i" from 1 to _minutes do {

  _smoke = "SmokeShellBlue" createVehicle getPos _crate;
  _smoke attachto [_crate,[0,0,-0.5]];
  _flare = "F_40mm_Green" createVehicle getPos _crate;
  _flare attachto [_crate,[0,0,-0.5]];

  if( _i < 10 ) then {

    sleep 60;

  };

};
