// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2016 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_RoadBlock.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, JoSchaap, AgentRev, soulkobk
//	@file Created: 08/12/2012 15:19
//	@file Modified: 4:31 PM 06/07/2016 (soulkobk)
//	@file Edit: 27/04/2018 by [509th] Coyote Rogue

if (!isServer) exitwith {};

#include "occupationMissionDefines.sqf";

private ["_nbUnits", "_roadBlock", "_objects", "_loadout", "_boxes1", "_boxes2", "_box1", "_box2", "_currBox1","_randomBox","_currBox2"];

_moneyAmount = 50000; //Reward amount for completing mission

_setupVars =
{
	_missionType = "Road Block Variant";
	_locationsArray = RoadBlockMissionMarkers2;
};
_setupObjects =
{
	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
	_missionPos = markerPos _missionLocation;
	_missionDir = markerDir _missionLocation;

	//delete existing base parts and vehicles at location
	_baseToDelete = nearestObjects [_missionPos, ["All"], 25];
	{ deleteVehicle _x } forEach _baseToDelete;
		

	_roadBlock = selectRandom (call compile preprocessFileLineNumbers "server\missions\roadBlocks\roadBlockList.sqf");
	_objects = [_roadBlock, _missionPos, _missionDir] call createRoadBlock;
	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach _objects;
	_aiGroup = createGroup CIVILIAN;
	[_aiGroup, _missionPos, _nbUnits, 15] call createCustomGroup;
	_missionHintText = format ["Enemies have set up a road block and are stopping all traffic! Go and take it over!", occupationMissionColor];
	
	//Crates
	
	_boxes1 = ["Box_FIA_Support_F","Box_FIA_Wps_F","Box_FIA_Ammo_F"];
	_currBox1 = _boxes1 call BIS_fnc_selectRandom;
	_randomBox = ["mission_USLaunchers","mission_USSpecial","mission_Main_A3snipers","mission_HVSniper","mission_UAV","mission_HVLaunchers"] call BIS_fnc_selectRandom;
	_box1 = createVehicle [_currBox1,[(_missionPos select 0), (_missionPos select 1),0],[], 0, "NONE"];
	[_box1, _randomBox] call fn_refillbox;
	
	_boxes2 = ["Box_FIA_Support_F","Box_FIA_Wps_F","Box_FIA_Ammo_F"];
	_currBox2 = _boxes2 call BIS_fnc_selectRandom;
	_box2 = createVehicle [_currBox2,[(_missionPos select 0) - 5, (_missionPos select 1) - 8,0],[], 0, "NONE"];
	_box2 allowDamage false;
	_box2 setVariable ["R3F_LOG_disabled", true, true];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	{ deleteVehicle _x } forEach _objects;
};

// Mission completed

	_successExec =
	{

		//Money
		
		for "_i" from 1 to 10 do
		{
			_cash = createVehicle ["Land_Money_F", _missionPos, [], 5, "NONE"];
			_cash setPos ([_missionPos, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
			_cash setDir random 360;
			_cash setVariable ["cmoney", _moneyAmount / 10, true];
			_cash setVariable ["owner", "world", true];
		};
	
		//Crate Behavior	

		{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach _objects;		
		{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2];	//Allows crates to be picked up and carried		

		//Message
		
		_successHintMessage = "The road block has been taken over. Great work!";
	};

_this call occupationMissionProcessor;
