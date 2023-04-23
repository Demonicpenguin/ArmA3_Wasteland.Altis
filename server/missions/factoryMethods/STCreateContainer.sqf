#include "..\..\..\STConstants.h"

if (!isServer) exitWith {};

params ["_position", "_boxes", ["_smoke", false], ["_disabled", false], ["_type", ST_CARGO_SMALL]];
private ["_container"];

//Load reward crates into container
_container = createVehicle [_type, _position, [], 2, "NONE"];
_container setDir random 360;
_container allowDamage false;
_container setVariable ["R3F_LOG_disabled", _disabled, true];
_container setVariable ["moveable", true, true];

if( !isNil "_boxes" ) then { nul = [_container, _boxes] execVM "addons\R3F_LOG\auto_load_in_vehicle.sqf"; };

//Smoke the container
if( _smoke ) then { [_container] spawn STPopCrateSmoke; };

_container
