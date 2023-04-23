//Client Function for Airdrop Assistance (not really a function, as it is called via ExecVM from command menu)
//This takes values from command menu, and some passed variables, and interacts with client and sends commands to server
//Author: Apoc, GMG_Monkey
//Credits: Some methods taken from Cre4mpie's airdrop scripts, props for the idea!
//Starts off much the same as the client start.  This is to find information from config arrays


private ["_type","_selection","_player","_aircraftDirection"]; //Variables coming from command menu and client side APOC_cli_startAirdrop
private _type = _this select 0;
private _selectionNumber = _this select 1;
private _player = _this select 2;

diag_log format ["SERVER - Apoc's Airdrop Assistance - Player: %1, Drop Type: %2, Selection #: %3",name _player,_type,_selectionNumber];
//hint format ["Well we've made it this far! %1, %2, %3,",_player,_type,_selectionNumber];
private _selectionArray = [];

switch (_type) do
{
	case "Interceptors"  : {_selectionArray = Monkey_AirSupport_Options};
	case "Ground Support": {_selectionArray = Monkey_AirSupport_Options};
	default 		{_selectionArray = Monkey_AirSupport_Options; diag_log "AAA - Default Array Selected - Something broke";};
};

private _selectionName 	= (_selectionArray select _selectionNumber) select 0;
private _price 			= (_selectionArray select _selectionNumber) select 1;

// Let's handle the money
private _playerMoney = _player getVariable ["bmoney", 0];
private _abort = false;
if (_price > _playerMoney) Then
{
	_abort = true;
}
else
{
	private _balance = _player getVariable ["bmoney", 0];
	private _newBalance = _balance - _price;
	_player setVariable ["bmoney", _newBalance, true];
	[getPlayerUID _player, [["BankMoney", _newBalance]], []] call fn_saveAccount;
};

private _aiSide = west;
private _faction = "NATO";
private _role = "SupportAA";
private _aircraftType = "B_Plane_Fighter_01_F";
private _side = side _player;

switch (_side) do
{
	case west:
	{
		_aiSide = west;
		_faction = "NATO";
		switch (_type) do
		{
			case "Interceptors":
			{
				_aircraftType = "B_Plane_Fighter_01_F";
				_role = "SupportAA";				
			};
			case "Ground Support":
			{
				_aircraftType = "B_Plane_CAS_01_dynamicLoadout_F";
				_role = "SupportAG";
			};
		};
	};
	case east:
	{
		_aiSide = east;
		_faction = "CSAT";
		switch (_type) do
		{
			case "Interceptors":
			{
				_aircraftType = "O_Plane_Fighter_02_F";
				_role = "SupportAA";
			};
			case "Ground Support":
			{
				_aircraftType = "O_Plane_CAS_02_dynamicLoadout_F";
				_role = "SupportAG";
			};
		};
	};
	case independent:
	{
		_aiSide = independent;
		_faction = "AAF";
		switch (_type) do
		{
			case "Interceptors":
			{
				_aircraftType = "I_Plane_Fighter_04_F";
				_role = "SupportAA";
			};
			case "Ground Support":
			{
				_aircraftType = "I_Plane_Fighter_04_F";
				_role = "SupportAG";
			};
		};
	};
};
diag_log format ["Air Supprt Type: %1 Side: %2 Faction: %3 Role: %4", _type, _aiSide, _faction, _role];
private _markers = [];
{
		if (["Airsupport_", _x] call fn_startsWith) then
		{
			_markers pushBack _x;
		};
} forEach allMapMarkers;

private _forEachIndex = 1;
private _nearestM = 0;
private _furtherestM = 0;
private _checkingM = 0;
private _holdingM = 0;
private _playerPos = getPosASL _player;
private _nearestMarkerPos = [];
private _furtherestMarkerPos = [];

_holdingM = getMarkerPos (_markers select 0);
_nearestM = _holdingM distance _playerPos;
_furtherestM = _holdingM distance _playerPos;

while {_forEachIndex < count _markers} do {

_checkingM = _holdingM distance _playerPos;

if (_checkingM <= _nearestM) then {_nearestMarkerPos = (_markers select _forEachIndex); _nearestM = _checkingM;};
if (_checkingM >= _furtherestM) then {_furtherestMarkerPos = (_markers select _forEachIndex); _furtherestM = _checkingM;};

_forEachIndex = _forEachIndex + 1;
_holdingM = getMarkerPos (_markers select _forEachIndex);
};

private _SpawnLocation = getMarkerPos _nearestMarkerPos;
private _SpawnLocation_x = _SpawnLocation select 0;
private _SpawnLocation_y = _SpawnLocation select 1;
private _SpawnLocation_z = 1000;
diag_log format ["Airsupport Spawn Location is: %1", _SpawnLocation];
private _Jet1 = [[_aircraftType, _role], [ _SpawnLocation_x     , _SpawnLocation_y     , _SpawnLocation_z], 1, 1, 0, 1000,1, 0,0, "Air Support System"] call createMissionVehicle;
private _Jet2 = [[_aircraftType, _role], [ _SpawnLocation_x + 20 , _SpawnLocation_y + 20 , _SpawnLocation_z], 1, 1, 0, 1000,1, 0,0, "Air Support System"] call createMissionVehicle;
private _Jet3 = [[_aircraftType, _role], [ _SpawnLocation_x - 20, _SpawnLocation_y - 20, _SpawnLocation_z], 1, 1, 0, 1000,1, 0,0, "Air Support System"] call createMissionVehicle;

_Jet1 setVehicleReportRemoteTargets true;
_Jet1 setVehicleReceiveRemoteTargets true;
_Jet1 setVehicleRadar 1;
_Jet1 confirmSensorTarget [west, true];
_Jet1 confirmSensorTarget [east, true];
_Jet1 confirmSensorTarget [resistance, true];

_Jet2 setVehicleReportRemoteTargets true;
_Jet2 setVehicleReceiveRemoteTargets true;
_Jet2 setVehicleRadar 1;
_Jet2 confirmSensorTarget [west, true];
_Jet2 confirmSensorTarget [east, true];
_Jet2 confirmSensorTarget [resistance, true];

_Jet3 setVehicleReportRemoteTargets true;
_Jet3 setVehicleReceiveRemoteTargets true;
_Jet3 setVehicleRadar 1;
_Jet3 confirmSensorTarget [west, true];
_Jet3 confirmSensorTarget [east, true];
_Jet3 confirmSensorTarget [resistance, true];

private _aircraft = [_Jet1, _Jet2, _Jet3];
private _grp = createGroup _aiSide;
{
	_soldier =[_grp, _SpawnLocation, _faction, "JetPilot"] call createsoldier;	
	_soldier moveInDriver _x;
	_x flyInHeight 1000;
} foreach _aircraft;
_grp setbehaviour "COMBAT";
_grp setCombatMode "RED";
_grp setFormation "VEE";
//First Fly to player
_waypoint0 = _grp addWaypoint [(getPosASL _player), 0];

/*if ((_Jet1 distance2D _player) < 1500 || (_Jet2 distance2D _player) < 1500 || (_Jet3 distance2D _player) < 1500) then
{
	playSound3D [call currMissionDir + "media\airdrop.ogg", _player, false, getPosATL _player, 1, 1, 1500];
	_player groupChat format ["Hey %1, see you are in need of some support", name _player];
	sleep 1;
	_player groupChat format ["1 click out, rounds Live Gentlemen, I repeat rounds Live. Going in!!"];	
	_waypoint0 setWaypointCombatMode "RED";
	_waypoint0 setWaypointBehaviour "COMBAT";
	_waypoint0 setWaypointFormation "VEE";
};*/
	
//Then Fly to Despawn Loaction
private _DespawnLocation = getMarkerPos _nearestMarkerPos;
_waypoint1 = _grp addWaypoint [_DespawnLocation, 0];
_waypoint1 setWaypointCombatMode "RED";
_waypoint1 setWaypointBehaviour "COMBAT";
_waypoint1 setWaypointFormation "VEE";
[_aircraft, _grp] spawn
{
	private _aircraft = _this select 0;
	private _grp = _this select 1;
	sleep (15 * 60);
	{ deleteVehicle _x; } forEach units _grp;
	{ deleteVehicle _x; } forEach _aircraft;
};

[_Jet1, _player] spawn
{
	private _Jet1 = _this select 0;
	private _player = _this select 1;

	waitUntil { (_Jet1 distance2D _player) < 2500 };

	playSound3D [call currMissionDir + "media\airdrop.ogg", _player, false, getPosATL _player, 1, 1, 300];
	_player groupChat format ["Hey %1, see you are in need of some support", name _player];
	sleep 1;
	_player groupChat format ["1 click out, rounds Live Gentlemen, I repeat rounds Live. Going in!!"];	
};
