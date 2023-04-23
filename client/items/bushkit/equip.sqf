// ******************************************************************************************
// * Copyright © 2019 Nurdism                                                               *
// ******************************************************************************************
// @file Author: Nurdism
// @file Name: equip.sqf

_bush = createSimpleObject ["A3\plants_f\Bush\b_FicusC1s_F.p3d", [0,0,0]];
_bush attachTo [_this, [0.7, 0.5, 0.5]];
_bush setVariable ["bushkit", true, true];
_bush setVariable ["player", _this, true];

_this setVariable ["bushkitOn", 1, true];
_this allowSprint false;
_this setAnimSpeedCoef 0.5;

waitUntil {
  _break = false;
  
  switch (true) do {
		case (!alive _this): { _break = true };
    case (vehicle _this != _this):{ _break = true };
    case (_this call A3W_fnc_isUnconscious):{ _break = true };
    case (_this getVariable ["bushkitOn", 0] != 1):{ _break = true };
	};
  _break;
};

deleteVehicle _bush;
_this allowSprint true;
_this setAnimSpeedCoef 1;
_this setVariable ["bushkitOn", 0, true];