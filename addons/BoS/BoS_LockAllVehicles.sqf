
private ["_lockers", "_vehicles"];

_lockers = nearestObjects [player, ["Land_SatellitePhone_F"], 10];

private _manager = nearestObject [player, "Land_SatellitePhone_F"];
private _ManagerPosition = getpos _manager;
//Get manager level
private _ManagerLevel = _manager getVariable ["ManagerLevel", 1];
//set default base radius for level 1 manager
private _BaseRadius = 25;
//set base radius based on manager level
switch (_ManagerLevel) do
{
	case (2):
	{
		_BaseRadius = 30;
	};
	case (3):
	{
		_BaseRadius = 45;
	};
	case (4):
	{
		_BaseRadius = 70;
	};
	case (5):
	{
		_BaseRadius = 100;
	};
};

if( !isNil "_lockers" ) then {

	_vehicles = (nearestObjects [_lockers select 0, ["AllVehicles"], _BaseRadius]);

	if (!isNil "_vehicles") then {

    _count = 0;
		_locked = 0;

    {
      //Vehicle Has Pin?
      if( _x getVariable ["vPin", false] ) then {

				//Already Locked?
				if( _x getVariable "R3F_LOG_disabled" ) then {

					_locked = _locked + 1;

				} else {

	        _count = _count + 1;

	        if (local _x) then
	        {
	          _x lock 2;
	        }
	        else
	        {
	          [[netId _x, 2], "A3W_fnc_setLockState", _x] call A3W_fnc_MP; // Unlock
	        };

	        _x setVariable ["objectLocked", true, true];
	        _x setVariable ["R3F_LOG_disabled",true,true];
	        playSound3D [call currMissionDir + "media\carbeep.ogg", _x, true, getPosASL _x, 2];

				};

      };

    } forEach _vehicles;

		//playMusic "LockVehicle";
		hint format["Remote locked %1 pin-enabled vehicles within range of this base. \n%2 other vehicles were already locked.", _count call fn_numbersText, _locked call fn_numbersText];

	} else {

		hint "No pin-enabled vehicles were found within range";

	};

};
