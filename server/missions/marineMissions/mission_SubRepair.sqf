// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_ArmedDiversquad.sqf
//	@file Author: JoSchaap, AgentRev

if (!isServer) exitwith {};
#include "marineMissionDefines.sqf";

private ["_vehicleClass", "_vehicle", "_vehicleName", "_depth"];

_setupVars =
{
	_missionType = "Hunter Killer";
	_locationsArray = SubMissionMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	
	_depth = -35;	

	_vehicleClass = ["HAFM_Virginia", "HAFM_Yasen"] call BIS_fnc_selectRandom;

	_vehicle = [_vehicleClass, _missionPos] call createMissionVehicle2;
	_vehicle setPosASL _missionPos;
	
	//_vehicle enableSimulation false;	
	//_vehicle setPosATL [getPosATL _vehicle select 0, getPosATL _vehicle select 1, (getPosATL _vehicle select 2) -20];	//submerge the sub 20 feet under the water

	[_vehicle, 20] spawn HAFM_fnc_Dive;
	[_vehicle, 3] call HAFM_fnc_SubAttachment;

	_vehicle lockDriver true; // lock vehicle driver position
	_vehicle setFuel 0;	

	_aiGroup = createGroup CIVILIAN;
	[_aiGroup, _missionPos, _depth] call createSubDivers;


	[_vehicle, _aiGroup] spawn checkMissionVehicleLock;
	
	_missionPicture = getText (configFile >> "CfgVehicles" >> _vehicleClass >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _vehicleClass >> "displayName");	

	_missionHintText = format ["A <t color='%3'>%1</t> Submarine is undergoing repairs 20 metres down in Altis Waters. It is protected by a group of armed Special Forces diving Specialists.</t>.<br/>Eliminate them to claim salvage rights to the Submarine.", _vehicleName, marineMissionColor];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed

};

// _vehicle is automatically deleted or unlocked in missionProcessor depending on the outcome

_successExec =
{
	// Mission complete
	
	//_vehicle enableSimulation true;

	[_vehicle, 0] spawn HAFM_fnc_Dive;	
	_vehicle lockDriver false; // unlock vehicle
	_vehicle setFuel 1;		
	playSound3D [call currMissionDir + "media\sub.ogg", _vehicle, false, _vehicle, 15, 1, 500];	

	_successHintMessage = "Great job, Team. The Special Forces Diving Specialists have been neutralised. The sub will now surface and is now yours. Get your crew aboard and get out of here FAST";
};

_this call marineMissionProcessor;
