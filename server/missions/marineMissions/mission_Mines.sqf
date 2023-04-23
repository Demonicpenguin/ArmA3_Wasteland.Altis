/********************************************************************************************************************************************/
/*																																			*/
/*	Land_Destroyer_01_base_F - USS Liberty																									*/
/*																																			*/
/*	Ship		[25284.6,25401.2,-0.0153809]	Ship/object offset				Dir			location										*/
/*																																			*/
/*	Satelite	[25285.7,25368.3,10.5278]		[1.1,-32.9,10.5431809]						corridor under bridge							*/
/*	Satelite	[25290.8,25381.3,10.5342]		[6.2,-19.9,10.5495809]						corridor under bridge amidships					*/		
/*	Satelite	[25286.7,25372.2,16.9709]		[2.1,-29,16.9862809]			253.918		staircase to bridge								*/
/*	Satelite	[25285.8,25405,7.44277]			[1.2,4.5,7.4581509]				37.817		second compartment from aft						*/
/*	Satelite	[25288.6,25412.4,12.0544]		[4,11.2,12.0697809]				210.444		port entrance on catwalk						*/
/*	Satelite	[25275.1,25434.9,11.3126]		[-9.5,33.7,11.3279809]			210.444		catwalk aft entrance							*/
/*	Satelite	[25273.2,25411.9,12.1179]		[-11.4,10.7,12.1332809]			210.444		catwalk starboard entrance						*/
/*	Satelite	[25283.8,25414.5,12.0544]		[-0.8,13.3,12.0697809]			210.444		between catwalks port and starboard				*/
/*	Satelite	[25294.2,25491.4,8.93747]		[9.6,90.2,8.9528509]			42.661		rear heli deck									*/
/*	Satelite	[25294.9,25358.8,10.5529]		[10.3,-42.4,10.5682809]			42.661		starboard entrance under bridge weather deck	*/
/*	Satelite									[3.1,-42,33.3019]							bridge roof outside								*/
/*	Satelite									[-0.0175781,-78.95,11.9841]					forward of bridge weather deck					*/
/*	Satelite									[3.1,-42.4,19.3920809]						in bridge										*/
/*	bubbles		[25299.2,25399.8,10.7067]		[-14.5,-1.4,10.7220809]						port side of ship								*/
/*	bubbles2	[25288.5,25385.7,125.135]		[-3.9,-15.5,125.1503809]					port side of ship								*/
/*																																			*/
/* 	This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com													*/ 
/*																																			*/
/*	@file Version: 1.0																														*/
/*	@file Name: mission_geoCache.sqf																										*/
/*	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev, edit by CRE4MPIE & LouD;															*/
/*	@file Created: 08/12/2012 15:19																											*/
/*	@file Edit: 27/04/2018 by [509th] Coyote Rogue																							*/
/*	@file Edit: 28/03/2020 by [RAW] SoulStlaker_Sco																							*/
/*																																			*/
/********************************************************************************************************************************************/	


if (!isServer) exitwith {};
#include "marineMissionDefines.sqf"

private ["_activation", "_activated", "_bubbleOrigin", "_offset1", "_offset2", "_satalitePos", "_satX", "_satY", "_satZ", "_worldPos1", "_worldPos2", "_ship", "_mineClass", "_geoCachePos", "_randomDepth", "_geoPos", "_geoCache", "_cash", "_moneyAmount", "_marker1", "_minesToDelete", "_boxes1", "_box1", "_para", "_smoke"];

_moneyAmount = Tier_1_Reward; //Reward amount for completing mission

_setupVars =
{
	_missionType = "Mine Fantastic";
	_locationsArray = SunkenMissionMarkers;	
	
	_activation = ["Activated"];	
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	
	_mineClass = ["UnderwaterMine", "UnderwaterMineAB"] call BIS_fnc_selectRandom;

	_satalitePos = [
						[1.1,-32.9,10.5431809],
						[6.2,-19.9,10.5495809],
						[2.1,-29,16.9862809],
						[1.2,4.5,7.4581509],
						[4,11.2,12.0697809],
						[-9.5,33.7,11.3279809],
						[-11.4,10.7,12.1332809],
						[-0.8,13.3,12.0697809],
						[9.6,90.2,8.9528509],
						[10.3,-42.4,10.5682809],
						[3.1,-42,33.3019],
						[-0.0175781,-78.95,11.9841],
						[3.1,-42.4,19.3920809]
	] call BIS_fnc_selectRandom;

	_satX = _satalitePos select 0;
	_satY = _satalitePos select 1;
	_satZ = _satalitePos select 2;	

	_geoPos = _missionPos vectorAdd ([[25 + random 20, 0, 0], random 360] call BIS_fnc_rotateVector2D);
	warHead2 = createVehicle ["Land_SatellitePhone_F",[(_geoPos select 0), (_geoPos select 1),0],[], 5, "NONE"];
	_ship = createVehicle ["Land_Destroyer_01_base_F", [(_geoPos select 0), (_geoPos select 1),0], [], 5, "None"];	
	_bubbleOrigin = createVehicle ["Land_Leaflet_03_F",[(_geoPos select 0), (_geoPos select 1),0],[], 5, "NONE"];

	_offset1 =  [_satX,_satY,_satZ];
	_worldPos1 = _ship modelToWorld _offset1;
	warHead2 setPos _worldPos1;

	_offset2 =  [-14.5,-1.4,10.7220809];
	_worldPos2 = _ship modelToWorld _offset2;
	_bubbleOrigin setPos _worldPos2;

	_bubbleOrigin hideObjectGlobal true;

	bubbles = [getPos _bubbleOrigin, 1, 0.01, [0,0,-1], 5] call TAG_fnc_BUBBLES;
	
	warHeadActivated = _activation select 0;
	
	warHead2 setVariable ["warHeadActivated",warHeadActivated,true];
	warHead2 setVariable ["activate","Nope",true];

	//[[warHead2, [ "<t color='#FF0000'>Intel Found - Now Activate self Destruct</t>", {HintSilent format ["Well Done %1. Intel Self Destruct sequence Activated, ***WARNING - CLEAR THE AREA!!! *** detonation in 20 seconds!!!", name player];nul = [player,"explosion"] call fn_netSay3D;warHead2 setVariable ["activate", "Activated",true]}, "_this distance cursortarget < 3"]],"addAction",true,true] call BIS_fnc_MP;
	[[warHead2, [ "<t color='#FF0000'>Intel Found - Now Activate self Destruct</t>", {HintSilent format ["Well Done %1. Intel Self Destruct sequence Activated, ***WARNING - CLEAR THE AREA!!! *** detonation in 20 seconds!!!", name player];playSound3D [call currMissionDir + "media\warhead.ogg", player, false, getPosASL player, 1,1,0];warHead2 setVariable ["activate", "Activated",true]}, "_this distance cursortarget < 3"]],"addAction",true,true] call BIS_fnc_MP;

		publicVariable "activate";
		publicVariable "warHeadActivated";
		publicVariable "warHead2";
		publicVariable "bubbles";		

	
	// Create minefield	
	for "_i" from 1 to 200 do
	{
		_randomDepth = floor (random -30);
		_mine = createMine ["UnderwaterMine", [(_missionPos select 0), (_missionPos select 1),_randomDepth], [], 50];
	};
		
	for "_i" from 1 to 100 do
	{
		_randomDepth = floor (random -30);
		_mineAB = createMine ["UnderwaterMineAB", [(_missionPos select 0), (_missionPos select 1),_randomDepth], [], 50];
	};
	
	{
		_geoCachePos = getPosASL _x;
		_geoCachePos set [2, getTerrainHeightASL _geoCachePos + 1];
		_x setPos _geoCachePos;
		_x setDir random 360;
		_x setVariable ["R3F_LOG_disabled", true, true];
	} forEach [_ship];
		
	_ship setVectorDirAndUp [[32.521,13.773,-0.804],[0,0,0]];		
		
	_marker1 = createMarker ["Minefield", _missionPos];
	_marker1 setMarkerShape "ELLIPSE";
	_marker1 setMarkerSize [100,100];	
	_marker1 setMarkerBrush "FDiagonal";
	_marker1 setMarkerColor "colorOPFOR";
		
	_aiGroup = createGroup CIVILIAN;
	[_aiGroup, _missionPos] call createLargeDivers;

	[_vehicle, _aiGroup] spawn checkMissionVehicleLock;		
		
	_missionPicture = "media\mines.jpg";		
	
	_missionHintText = format ["The USS Liberty has been sunk hitting a mine field.<br/>Foreign Forces are trying to retrieve Vital Documents on a Laptop<br/>Get there, kill them, find the laptop and destroy all evidence<br/><br/><t color='%1'>TURN VOLUME DOWN ON EARPHONES!</t>", marineMissionColor];
};

_ignoreAiDeaths = true;
_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = {((warHead2 getVariable "activate") !=  "Nope") && ((warHead2 getVariable "activate") != (warHead2 getVariable "warHeadActivated"))};
_waitUntilSuccessCondition = {((warHead2 getVariable "activate") == (warHead2 getVariable "warHeadActivated"))};

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach [warHead2, bubbles, _bubbleOrigin];
	deleteVehicle _ship;
	// Delete minefield
	_minesToDelete = (_geoPos nearObjects ["MineBase", 100]);	
	{ deleteVehicle _x } forEach _minesToDelete;
	deleteMarker "Minefield"; 	
};



// Mission completed

_successExec =
{
	sleep 23;
	
	// Delete minefield
	_minesToDelete = (_geoPos nearObjects ["MineBase", 100]);	
	{ deleteVehicle _x } forEach _minesToDelete;	
	
	//bombcode
	_count = 0;
	for "_i" from 0 to (8) do {
	for "_j" from 0 to 1 do {
	switch (_j) do
	{ case 0: {if (random 1 == 1) then {_xVel = -1*_xVel }};
	case 1: {if (random 1 == 1) then {_yVel = -1*_yVel }};
	};
	}; 
		_xVel = random 10;
		_yVel = random 10;
		_zVel = random 20;
		_xCoord = random 15;
		_yCoord = random 15;
		_zCoord = random 5;

		_bomb = "Bo_GBU12_LGB_MI10" createVehicle (getPos warHead2);
		_bomb setVelocity [_xVel,_yVel,_zVel-50];
	};

	//destroying target
	{_x setdamage 1; } foreach nearestObjects [getPos  warHead2, [],45];
	addCamShake [1+random 5,1+random 3, 5+random 15];
	
	sleep 0.5;
	
	{deleteVehicle _x;} forEach [warHead2, bubbles, _bubbleOrigin];
	deleteVehicle _ship;

	{
		if (_x isKindOf "Land_Destroyer_01_Boat_Rack_01_Base_F" || _x isKindOf "Land_Destroyer_01_Boat_Rack_01_F" || 
		_x isKindOf "Land_Destroyer_01_hull_01_F" || _x isKindOf "Land_Destroyer_01_hull_02_F" || 
		_x isKindOf "Land_Destroyer_01_hull_03_F" || _x isKindOf "Land_Destroyer_01_hull_04_F" || 
		_x isKindOf "Land_Destroyer_01_hull_05_F" || _x isKindOf "Land_Destroyer_01_interior_02_F" ||
		_x isKindOf "Land_Destroyer_01_interior_03_F" || _x isKindOf "Land_Destroyer_01_interior_04_F") then {deleteVehicle _x;};
	} forEach nearestObjects [_missionPos, ["All"], 100];	
	
	sleep 3;

	{deleteVehicle _x;}forEach units _aiGroup; deleteGroup _aiGroup;	// now delete the Ai Group that survive the blast

	deleteMarker "Minefield"; 		
	
	_boxes1 = selectRandom ["I_supplyCrate_F", "B_CargoNet_01_ammo_F", "c_IDAP_supplyCrate_F", "c_supplyCrate_F"];
	_box1 = createVehicle [_boxes1,[(_missionPos select 0), (_missionPos select 1),200],[], 0, "NONE"];
	_box1 setDir random 360;
	[_box1, "special_mass"] call fn_refillbox; //Special large box	
	_box1 allowDamage false;
	_box1 setVariable ["cmoney", 1500000, true];	
	
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1];
	
	nul = [player,"airdrop"] call fn_netSay3D;

	_para = createVehicle [format ["I_parachute_02_F"], [0,0,999999], [], 0, "NONE"];

	_para setDir getDir _box1;
	_para setPosATL getPosATL _box1;

	_para attachTo [_box1, [0, 0, 0]];
	uiSleep 2;

	detach _para;
	_box1 attachTo [_para, [0, 0, 0]];

	while {(getPos _box1) select 2 > 3 && attachedTo _box1 == _para} do
	{
		_para setVectorUp [0,0,1];
		_para setVelocity [0, 0, (velocity _para) select 2];
		uiSleep 0.1;
	};

	detach _box1;
	
	// Land safely
	WaitUntil {((((position _box1) select 2) < 0.6) || (isNil "_para"))};
	detach _box1;
	_box1 SetVelocity [0,0,-5];           
	sleep 0.3;
	_box1 setPos [(position _box1) select 0, (position _box1) select 1, 1];
	_box1 SetVelocity [0,0,0];		
	
	_smoke = "SmokeShellBlue" createVehicle getPos _para;

	_successHintMessage = "Great Job in retrieving the intel and destroying all evidence. Your reward, supplies and cash have been delivered by parachute!";
};

_this call marineMissionProcessor;
