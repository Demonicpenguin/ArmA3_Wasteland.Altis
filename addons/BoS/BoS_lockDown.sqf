//	@file Version:
//	@file Name:
//	@file Author: Cael817 Edited By: GMG_Monkey
//	@file Created:

private _nearestManagers = nearestObjects [player, ["Land_SatellitePhone_F"], 100];
private _manager = _nearestManagers select 0;

private _lockdown = false;

//Get manager level
private _ManagerLevel = _manager getVariable ["ManagerLevel", 1];
//set default base radius for level 1 manager
private _BaseRadius = 25;
//set base radius based on manager level
//set default base radius and maximum objects for level 1 manager
private _BaseRadius = 25;
private _MaxObjects = 50;
//set base radius and max objects based on manager level
switch (_ManagerLevel) do
{
	case (2):
	{
		_BaseRadius = 30;
		_MaxObjects = 100;
	};
	case (3):
	{
		_BaseRadius = 45;
		_MaxObjects = 150;
	};
	case (4):
	{
		_BaseRadius = 70;
		_MaxObjects = 200;
	};
	case (5):
	{
		_BaseRadius = 100;
		_MaxObjects = 250;
	};
};

private _managers = nearestObjects [ _manager, ["Land_SatellitePhone_F"], (_BaseRadius * 2), true];
private _otherManagerCheck = nearestObjects [ _manager, ["Land_SatellitePhone_F"], 100000, true];
private _objects = nearestObjects [_manager, ["All"], _BaseRadius, true];
private _baseobjects = [];
{
	_object = _x;
	_locked = _object getVariable ["objectLocked", false];
	if (_locked) then
	{
		_baseobjects pushback _object;
		//player globalchat format ["Adding %1 to Base Objects List", _object];
	};
}foreach _objects;
private _objectsCount = count _baseobjects;
_uid = getPlayerUID player;

if ( count _managers > 1) then 
{
	{
		_islockeddown = _x getVariable ["Baselockenabled", false];
		if (_islockeddown) then
		{
			_lockdown = true
		}; 
	} foreach _managers;
};

if (_lockdown) then 
{
	hint "Base Underlockdown. Action Aborted";
} else 
{
	if (_objectsCount > _MaxObjects) exitwith { titletext [format ["Error %1 objects detected. Maximum %2 objects can be Locked down. Upgrade your Base to increase this limit", _objectsCount, _MaxObjects], "PLAIN DOWN"]};
	{
		private _objectLocked = _x getVariable ["objectLocked",false];
		if (_objectLocked) then
		{
			_x setVariable ["Moveable", false, true];
			_x setVariable ["Lockeddown", true, true];
		};	
	} foreach _baseobjects;
	_manager setvariable ["Baselockenabled", true, true];
	cursorobject enableSimulationGlobal false;
	playSound3D [call currMissionDir + "media\online.ogg", player, true, getPosASL player, 1,1,60];		
	hint "Base is now under Lock Down";
};
