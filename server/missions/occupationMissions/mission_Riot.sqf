// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_Riot.sqf
//	@file Author: JoSchaap, AgentRev, LouD
//	@file Tanoa Edit: GriffinZS

if (!isServer) exitwith {};
#include "occupationMissionDefines.sqf";

private [ "_box1", "_box2", "_barGate", "_obj1","_obj2", "_smokemarker"];

_setupVars =
{
	_missionType = "Violent Riot";
	_locationsArray = RiotMissionMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_markerDir = markerDir _missionLocation;
	
	//delete existing base parts and vehicles at location
	_baseToDelete = nearestObjects [_missionPos, ["All"], 25];
	{ deleteVehicle _x } forEach _baseToDelete; 	
	
	_bargate = createVehicle ["Flag_Altis_F", _missionPos, [], 0, "NONE"];
	_bargate setDir _markerDir;
	_obj1 = createVehicle ["MetalBarrel_burning_F", _bargate modelToWorld [6.5,-2,-4.1], [], 0, "NONE"];
	_obj2 = createVehicle ["MetalBarrel_burning_F", _bargate modelToWorld [-8,-2,-4.1], [], 0, "NONE"];
	
	_aiGroup = createGroup CIVILIAN;
	[_aiGroup,_missionPos,10,15] spawn createCustomGroup6;
	
	_missionHintText = format ["<br/>Riots have been spotted in the village - marked on map.<br/>Go there and try to calm them down. If this won't work, you have permission to eliminate them.", occupationMissionColor];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	
	{ deleteVehicle _x } forEach [_barGate, _obj1, _obj2];
	
};

_successExec =
{
	// Mission completed
	
	_box1 = "Box_East_Wps_F" createVehicle getMarkerPos _marker;
    [_box1,"mission_USLaunchers"] call fn_refillbox;
	_box1 allowDamage false;
	
	_box2 = "Box_NATO_Wps_F" createVehicle getMarkerPos _marker;
    [_box2,"mission_USSpecial2"] call fn_refillbox;
	_box2 allowDamage false;
	
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2];
	
	{ deleteVehicle _x } forEach [_barGate, _obj1, _obj2];
	

	_successHintMessage = format ["<br/>Not the best way, but finally the riots have been dismantled .."];
};

_this call occupationMissionProcessor;