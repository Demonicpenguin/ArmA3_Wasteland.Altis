// ******************************************************************************************
// * Copyright © 2019 Nurdism                                                               *
// ******************************************************************************************
// @file Author: Nurdism
// @file Name: cleanup.sqf

if (!isServer) exitWith {};

while { true } do {
  {
    if (_x getVariable ["bushkit", false]) then {
      _player = _x getVariable ["player", objNull];
      if (!isNull _player) then {
        if (_player getVariable ["bushkitOn", 0] != 1) then {
          deleteVehicle _x;
        };
      } else {
        deleteVehicle _x;
      };
    };
  } forEach allSimpleObjects [];
	uiSleep 30;
};

