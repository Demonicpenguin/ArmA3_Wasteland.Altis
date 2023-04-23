/*******************************************************************************************
* This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com
********************************************************************************************
* @file Name: STCreateVehicle.sqf
* @author: The Scotsman
*
* Creates a mission vehicle
* Arguments: [ _type, _position, _direction, _group ]
*   _type: The vehicle classname
*   _position: Spawn Position
*   _direction: Vehicle Direction
*   _group: Group to add the vehicle to
*   _kind: Type of units to populate in vehicle (@see STConstants.h)
*/

#include "..\..\..\STConstants.h"

params ["_type", "_position", "_direction", "_group", ["_kind", ST_INFANTRY]];
private ["_mode", "_vehicle", "_createUnit", "_velocity"];

//Fly?
_mode = if( _type isKindOf "Air" ) then { "FLY" } else { "NONE" };

_vehicle = createVehicle [_type, _position, [], 0, _mode];

if( _vehicle isKindOf "Air" ) then {

  //Make sure it has altitude
  if( (_position select 2) < 20 ) then { _position set [2, ([75, 200] call BIS_fnc_randomInt)] };

  //Make it fly
  _kind = ST_PILOT;
  _velocity = [velocity _vehicle, -(_direction)] call BIS_fnc_rotateVector2D;
  _vehicle setDir _direction;
  _vehicle setVelocity _velocity;

} else {

  _vehicle setDir _direction;

};

/* if( _vehicle isKindOf "Boat" ) then { _kind = ST_SQUID; }; */

_vehicle setVariable [call vChecksum, true, false];
_vehicle setVariable ["R3F_LOG_disabled", true, true];
_vehicle setVariable ["A3W_Mission_Object", true, true];


_vehicle setVehicleReportRemoteTargets true;
_vehicle setVehicleReceiveRemoteTargets true;
_vehicle setVehicleRadar 1;
_vehicle confirmSensorTarget [west, true];
_vehicle confirmSensorTarget [east, true];
_vehicle confirmSensorTarget [resistance, true];

_vehicle addEventHandler ["GetIn", {
    _veh = _this select 0;
    _unit = _this select 2;

    if( isPlayer _unit ) then { _veh setVariable ["A3W_Mission_Object", nil, true]; }

  }];


[_vehicle] call vehicleSetup;

_group addVehicle _vehicle;

//Driver
([_position, _group, _kind] call STCreateUnit) moveInDriver _vehicle;

//Gunners
while { _vehicle emptyPositions "gunner" > 0 } do { ([_position, _group, _kind] call STCreateUnit) moveInGunner _vehicle; };

//Land Vehicle
if( _vehicle isKindOf "LandVehicle" && _vehicle emptyPositions "commander" > 0 ) then { ([_position, _group, _kind] call STCreateUnit) moveInCommander _vehicle; };

[_vehicle, _group] spawn checkMissionVehicleLock;

//diag_log format ["STCreateVehicle %1:%2 (%3)", (["Land", "Air"] select (_kind == ST_PILOT)), _type, _mode];

_vehicle
