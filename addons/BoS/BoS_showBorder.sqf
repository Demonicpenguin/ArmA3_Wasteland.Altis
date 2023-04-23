//	@file Version: 1.0
//	@file Name: showBorder.sqf
//	@file Author: Cael817, all credit to Larrow
//	@file Created: 20150217 21:19
//	@file Info:

#define AMOUNT 100

private _nearestManagers = nearestObjects [player, ["Land_SatellitePhone_F"], 100];
private _manager = _nearestManagers select 0;
private _uid = getPlayerUID player;
private _managerUID = _manager getvariable "ownerUID";

_target = cursorObject;

if (!(_target isKindOf "Land_SatellitePhone_F") && _managerUID == _uid) then {_target = _manager};

_target_pos = getPos _target;

//Get manager level
private _ManagerLevel = _target getVariable ["ManagerLevel", 1];
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

//hint format["%1", _target_pos];

if (isNil "borderObjects") then {
    borderObjects = [];
    _rad = _BaseRadius;
    _bcount = AMOUNT;
    _inc = 360/_bcount; 
    for "_ang" from 1 to 360 step _inc do {
        _a = (_target_pos select 0)+(sin(_ang)*_rad);
        _b = (_target_pos select 1)+(cos(_ang)*_rad);
        _pos = [_a,_b,_target_pos select 2];
        _light = "Sign_Arrow_Large_F" createVehicle _pos;
        _light setPos _pos;
		borderObjects pushBack _light;
    };
	//["Added Markers around the base radius (30m) they will be removed in 30 seconds", 5] call mf_notify_client;
	[format ["Added Markers around the base radius (%1m) they will be removed in 30 seconds",_BaseRadius], 5] call mf_notify_client;	
};

sleep 30;
if ( !(isNil "borderObjects") ) then {
    {
        deleteVehicle _x;    
    }forEach borderObjects;
    borderObjects = nil;
};  
