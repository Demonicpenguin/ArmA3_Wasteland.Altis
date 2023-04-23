//	@file Version: 1.0
//	@file Name: adminHunt.sqf
//	@file Author: James32

#define HINT_DELAY 360  // number of seconds between each reminder hint
#define MARKER_REFRESH 20  // number of seconds between each Admin marker refresh

if (isServer) then
{
	["Admin_deleteMarker", "onPlayerDisconnected", { deleteMarker ("Admin_" + _uid) }] call BIS_fnc_addStackedEventHandler;
};

if (!hasInterface) exitWith {};

waitUntil {sleep 0.1; alive player && !(player getVariable ["playerSpawning", true])};

_lastHint = -HINT_DELAY;
_lastMarker = -MARKER_REFRESH;
_markerTarget = objNull;
_hasMarker = false;
_Name=profileName;

while {true} do
{
	_isrogue = (player getVariable ["rogueAdmin",false] && alive player && !(player getVariable ["playerSpawning", true]));
	if (_isrogue && diag_tickTime - _lastHint >= HINT_DELAY) then
	{
		hint parseText ([
			"<t color='#FFD27F' size='1.5' align='center'>ROGUE ADMIN</t>",
			//profileName,
			"<t color='#FFFFFF' shadow='1' shadowColor='#000000' align='center'>You have gone rogue and have been granted gear, money and vastly reduced damage!</t>"
		] joinString "<br/>");
		[format ["SERVER EVENT MESSAGE: Staff Member %1 Has Gone rogue, Their position is marked on the map, hunt them down and kill them for a reward", _Name], "A3W_fnc_titleTextMessage"] call A3W_fnc_MP;
		_lastHint = diag_tickTime;
	};

	if (diag_tickTime - _lastMarker >= MARKER_REFRESH || (!alive _markerTarget && _hasMarker)) then
	{
		_markerName = "Admin_" + getPlayerUID player;

		if (_hasMarker) then
		{
			deleteMarker _markerName;
			_hasMarker = false;
		};

		if (_isrogue) then
		{
			createMarker [_markerName, getPosWorld player];
			_markerName setMarkerColor "ColorBlue";
			_markerName setMarkerText format ["Rogue Admin:%1",profileName];
			_markerName setMarkerSize [0.75, 0.75];
			_markerName setMarkerShape "ICON";
			_markerName setMarkerType "mil_warning";

			_lastMarker = diag_tickTime;
			_markerTarget = player;
			_hasMarker = true;
			playSound "Topic_Done";
		};
	};

	sleep 0.5;
};
