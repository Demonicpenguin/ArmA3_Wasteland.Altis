// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.1
//	@file Name: spawnRandom.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, [GoT] JoSchaap, AgentRev
private _preload = param [1, false, [false]];

private _randomLoc = (call cityList) call BIS_fnc_selectRandom;

private _pos = getMarkerPos (_randomLoc select 0);
private _rad = _randomLoc select 1;
private _townName = _randomLoc select 2;

private _playerPos = [[_pos select 0, _pos select 1, 700],_rad,_rad + 150,1,0,0,0] call findSafePos;
if (_preload) then { waitUntil {sleep 0.1; preloadCamera _playerPos} };

waitUntil {!isNil "bis_fnc_init" && {bis_fnc_init}};

player setPos _playerPos;

respawnDialogActive = false;
closeDialog 0;

_townName spawn
{
	_townName = _this;
	sleep 1;

	_hour = date select 3;
	_mins = date select 4;
	["Wasteland", _townName, format ["%1:%3%2", _hour, _mins, if (_mins < 10) then {"0"} else {""}]] spawn BIS_fnc_infoText;
};