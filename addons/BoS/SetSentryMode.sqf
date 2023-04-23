
private _nearestManagers = nearestObjects [player, ["Land_SatellitePhone_F"], 100];
private _manager = _nearestManagers select 0;

private _ManagerPosition = getpos _manager;
private _playerMoney = player getVariable "cmoney";
//Get manager level
private _ManagerLevel = _manager getVariable ["ManagerLevel", 1];
//set default base radius and maximum objects for level 1 manager
private _BaseRadius = 25;
//set base radius and max objects based on manager level
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
private _Turrets= nearestObjects [_ManagerPosition, ["StaticWeapon"], _BaseRadius, true];
{
	if (_x getVariable "ownerUID" == getPlayerUID player)
	{
		[_x, civilian, true, true] call fn_createCrewUAV
	};
}foreach _Turrets;