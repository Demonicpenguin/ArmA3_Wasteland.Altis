// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_SunkenSupplies.sqf
//	@file Author: JoSchaap, AgentRev

if (!isServer) exitwith {};
#include "marineMissionDefines.sqf"

private ["_activated", "_wreck", "_wreckagePos", "_box1", "_box2", "_boxPos", "_activation"];

_setupVars =
{
	_missionType = "Destroy Nuclear Warhead";
	_locationsArray = SunkenMissionMarkers;
	
	_activation = ["Activated"];
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;

	_wreck = createVehicle ["Land_UWreck_MV22_F", _missionPos, [], 5, "None"];
	
	warHeadActivated = _activation select 0;
	
	warHead = createVehicle ["Land_Device_disassembled_F", _missionPos, [], 5, "None"];
	warHead setVariable ["warHeadActivated",warHeadActivated,true];
	warHead setVariable ["activate","Nope",true];

	{
		_wreckagePos = getPosASL _x;
		_wreckagePos set [2, getTerrainHeightASL _wreckagePos + 1];
		_x setPos _wreckagePos;
		_x setDir random 360;
		_x setVariable ["R3F_LOG_disabled", true, true];
	} forEach [_wreck, warHead];
	
	warHead attachTo [_wreck,[1.8,-2,-2.5]];	
	
	[[warHead, [ "<t color='#FF0000'>Activate Self Destruct Sequence</t>", {HintSilent format ["Well Done %1. Warhead Self Destruct sequence Activated, ***WARNING - CLEAR THE AREA!!! *** detonation in 20 seconds!!!", name player];nul = [player,"explosion"] call fn_netSay3D;warHead setVariable ["activate", "Activated",true]}, "_this distance cursortarget < 3"]],"addAction",true,true] call BIS_fnc_MP;
	//[[warHead, [ "<t color='#FF0000'>Activate Self Destruct Sequence</t>", {HintSilent format ["Well Done %1. Warhead Self Destruct sequence Activated, ***WARNING - CLEAR THE AREA!!! *** detonation in 20 seconds!!!", name player];playSound3D [call currMissionDir + "media\warhead.ogg", player, false, getPosASL player, 5,1,2000];warHead setVariable ["activate", "Activated",true]}, "_this distance cursortarget < 3"]],"addAction",true,true] call BIS_fnc_MP;

		publicVariable "activate";
		publicVariable "warHeadActivated";
		publicVariable "warHead";	

	_aiGroup = createGroup CIVILIAN;
	[_aiGroup, _missionPos] spawn createLargeDivers;
	
	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "COMBAT";
	
	_missionPicture = "media\warhead.jpg";
	_missionHintText = format ["<br/>An enemy VTOL carrying a <t color='%1'>Nuclear Warhead</t> has has been discovered in the ocean near the marker, it is heavily guarded. Go there, kill the enemy and Destroy that Warhead. Our lives are depending on you Soldier.", marineMissionColor];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_ignoreAiDeaths = true;
_waitUntilCondition = {((warHead getVariable "activate") !=  "Nope") && ((warHead getVariable "activate") != (warHead getVariable "warHeadActivated"))};
_waitUntilSuccessCondition = {((warHead getVariable "activate") == (warHead getVariable "warHeadActivated"))};

_failedExec =
{
	// Mission failed
	//{ deleteVehicle _x } forEach [_wreck, warHead];	
};

_successExec =
{
	// Mission completed
	
	sleep 23;
	
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

		_bomb = "Bo_GBU12_LGB_MI10" createVehicle (getPos warHead);
		_bomb setVelocity [_xVel,_yVel,_zVel-50];
	};

	//destroying target
	{_x setdamage 1; } foreach nearestObjects [getPos  warHead, [],45];
	addCamShake [1+random 5,1+random 3, 5+random 15];
	{deleteVehicle _x;} forEach [_wreck, warHead];

	sleep 3;

	{deleteVehicle _x;}forEach units _aiGroup; deleteGroup _aiGroup;	// now delete the Ai Group that survive the blast

	// reward	
	
	_box1 = createVehicle ["Box_IND_WpsSpecial_F", _missionPos, [], 5, "None"];
	_box1 setDir random 360;
	[_box1, "mission_Main_A3snipers"] call fn_refillbox;

	_box2 = createVehicle ["Box_NATO_WpsSpecial_F", _missionPos, [], 5, "None"];
	_box2 setDir random 360;
	[_box2, "mission_USSpecial2"] call fn_refillbox;


	{
		_boxPos = getPosASL _x;
		_boxPos set [2, getTerrainHeightASL _boxPos + 1];
		_x setPos _boxPos;
		_x setVariable ["R3F_LOG_disabled", false, true];
	} forEach [_box1, _box2];
	
	_box1 setVariable ["cmoney", 250000, true];
	_box2 setVariable ["cmoney", 250000, true];	

	_successHintMessage = "Again, Great job on a task well done. The whole of Altis can rest easy now. Find your reward in the surviving Cargo. Thank you Soldier";
};

_this call marineMissionProcessor;	
