// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_HackLaptop.sqf
//	@file Author: JoSchaap, AgentRev, LouD

if (!isServer) exitwith {};
#include "occupationMissionDefines.sqf";

private ["_bargate", "_obj1", "_obj2", "_obj3", "_mine"];

private _minemarkers = ["minemarker_0", "minemarker_1", "minemarker_2", "minemarker_3", "minemarker_4", "minemarker_5", "minemarker_6", "minemarker_7", "minemarker_8","minemarker_9","minemarker_10", "_minesToDelete"];

private _randomdistance = 5;

_setupVars =
{
	_missionType = "The Maze";
	_locationsArray = MazeMissionMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_markerDir = markerDir _missionLocation;
	
	[mazeEntrance, true] call fn_hideObjectGlobal;	

	_bargate = createVehicle ["O_CargoNet_01_ammo_F", _missionPos, [], 0, "NONE"];
	_bargate setDir _markerDir;
	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach [_bargate];
	
	_obj1 = createVehicle ["I_HMG_01_high_F", _missionPos,[], 10,"none"]; 
	_obj1 setPosATL [23725,16244.8,0];
	
	_obj2 = createVehicle ["I_HMG_01_high_F", _missionPos,[], 10,"none"]; 
	_obj2 setPosATL [23715.9,16235.8,0];
	
	_obj3 = createVehicle ["I_HMG_01_high_F", _missionPos,[], 10,"none"]; 
	_obj3 setPosATL [23733,16236.3,0];
	
	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach [_obj1, _obj2, _obj3];	
	
	{
		_mine = createVehicle [(selectRandom ["APERSMine_Range_Ammo", "APERSBoundingMine_Range_Ammo"]), getMarkerPos "minemarker_0", ["minemarker_1","minemarker_2","minemarker_3","minemarker_4","minemarker_5","minemarker_6","minemarker_7","minemarker_8","minemarker_9","minemarker_10"], _randomdistance, "NONE"];
	}foreach _minemarkers;	

	_aiGroup = createGroup CIVILIAN;
	[_aiGroup,_missionPos,24,20] spawn createCustomGroup3;

	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "COMBAT";	
	
	//[_aiGroup, _missionPos] call defendArea;	
	
	_missionPicture = "media\maze.paa";
	
	_missionHintText = format ["<t color='%2'>The Maze</t> is now under occupation. At its centre is a cash reward and valuable supplies. Navigate your way through the labyrinth, but watch out for those maze guards and MINES!", occupationMissionColor];
	playSound3D [call currMissionDir + "SFX\inception.ogg", player, false, getPosASL player, 1, 1, 50000];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	
	// Delete minefield
	_minesToDelete = (_missionPos nearObjects ["MineBase", 100]);	
	{ deleteVehicle _x } forEach _minesToDelete;
	

	{ deleteVehicle _x } forEach [_bargate, _obj1, _obj2, _obj3];
	};

_successExec =
{
	// Mission completed
	
	// Delete minefield
	_minesToDelete = (_missionPos nearObjects ["MineBase", 100]);	
	{ deleteVehicle _x } forEach _minesToDelete;	
	
	for "_x" from 1 to 10 do
	{
		_cash = "Land_Money_F" createVehicle markerPos _marker;
		_cash setPos ((markerPos _marker) vectorAdd ([[2 + random 2,0,0], random 360] call BIS_fnc_rotateVector2D));
		_cash setDir random 360;
		_cash setVariable["cmoney",100000,true];
		_cash setVariable["owner","world",true];
	};	

	{ deleteVehicle _x } forEach [_obj1, _obj2, _obj3];
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_bargate];
	
	[mazeEntrance, false] call fn_hideObjectGlobal;
	playSound3D [call currMissionDir + "media\lock.ogg", mazeEntrance, false, mazeEntrance, 15, 1, 500];
	
	_successHintMessage = format ["Congratulations! but the Maze is now sealed, collect your $1000000 fee for liberating the Maze and the crate full of supplies. Now can you find your way out via the teleport pad located near the main entrance"];
};

_this call occupationMissionProcessor;