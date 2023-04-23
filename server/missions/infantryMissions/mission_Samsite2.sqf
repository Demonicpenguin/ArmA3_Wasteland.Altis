// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_militaryPatrol.sqf
//	@file Author: JoSchaap, AgentRev, LouD

if (!isServer) exitwith {};
#include "infantryMissionDefines.sqf";

private ["_positions", "_radar", "_laptop", "_obj1", "_obj2", "_obj3", "_obj4", "_box1", "_box2", "_box3", "_box4"];

_setupVars =
{
	_missionType = "Defender of Altis Skies";
	_locationsArray = SamsiteMissionMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_markerDir = markerDir _missionLocation;
	
	//delete existing base parts and vehicles at location
	_baseToDelete = nearestObjects [_missionPos, ["All"], 25];
	{ deleteVehicle _x } forEach _baseToDelete; 		
	
	_radar = createVehicle ["B_Radar_System_01_F", [_missionPos select 0, _missionPos select 1], [], 0, "CAN COLLIDE"];
	_radar allowdamage false;
	_radar setDir random 360;
	_radar setVariable ["R3F_LOG_disabled", false];

	_missionPos = getPosATL _radar;	
	
	_obj1 = createVehicle ["B_SAM_System_03_F", _missionPos,[], 10,"None"]; 
	_obj1 setPosATL [(_missionPos select 0) - 30, (_missionPos select 1) + 30, _missionPos select 2];
	
		_obj1 setVehicleReportRemoteTargets true;
		_obj1 setVehicleReceiveRemoteTargets true;
		_obj1 setVehicleRadar 1;
		_obj1 confirmSensorTarget [west, true];
		_obj1 confirmSensorTarget [east, true];
		_obj1 confirmSensorTarget [resistance, true];	
	
	_obj2 = createVehicle ["B_SAM_System_01_F", _missionPos,[], 10,"None"]; 
	_obj2 setPosATL [(_missionPos select 0) + 30, (_missionPos select 1) + 30, _missionPos select 2];
	
		_obj2 setVehicleReportRemoteTargets true;
		_obj2 setVehicleReceiveRemoteTargets true;
		_obj2 setVehicleRadar 1;
		_obj2 confirmSensorTarget [west, true];
		_obj2 confirmSensorTarget [east, true];
		_obj2 confirmSensorTarget [resistance, true];	
	
	_obj3 = createVehicle ["B_SAM_System_03_F", _missionPos,[], 10,"None"]; 
	_obj3 setPosATL [(_missionPos select 0) - 30, (_missionPos select 1) - 30, _missionPos select 2];
	
		_obj3 setVehicleReportRemoteTargets true;
		_obj3 setVehicleReceiveRemoteTargets true;
		_obj3 setVehicleRadar 1;
		_obj3 confirmSensorTarget [west, true];
		_obj3 confirmSensorTarget [east, true];
		_obj3 confirmSensorTarget [resistance, true];	
	
	_obj4 = createVehicle ["B_SAM_System_02_F", _missionPos,[], 10,"None"]; 
	_obj4 setPosATL [(_missionPos select 0) + 30, (_missionPos select 1) - 30, _missionPos select 2];
	
		_obj4 setVehicleReportRemoteTargets true;
		_obj4 setVehicleReceiveRemoteTargets true;
		_obj4 setVehicleRadar 1;
		_obj4 confirmSensorTarget [west, true];
		_obj4 confirmSensorTarget [east, true];
		_obj4 confirmSensorTarget [resistance, true];	

	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach [_radar, _obj1, _obj2, _obj3, _obj4];	
	
	_aiGroup = createGroup CIVILIAN;
	[_aiGroup,_missionPos,24,20] spawn createCustomGroup3;

	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "COMBAT";
	
	_missionPicture = "media\sam.paa";
	//_vehicleName = getText (configFile >> "CfgVehicles" >> _obj1 >> "displayName");	
	
	_missionHintText = format ["<br/>A Long range Sam site Installation protected by a patrol of soldiers are operating in the area. The Skies are no longer safe.<br/>Go there, Destroy the Missle site and make the skies safe.", infantryMissionColor];	
	
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;



_failedExec =
{
	// Mission failed
	
	{ deleteVehicle _x } forEach [_radar, _obj1, _obj2, _obj3, _obj4];
	
};



_successExec =
{
	// Mission completed
	
	{ deleteVehicle _x } forEach [_radar, _obj1, _obj2, _obj3, _obj4];	

	for "_x" from 1 to 10 do
	{
		_cash = "Land_Money_F" createVehicle markerPos _marker;
		_cash setPos ((markerPos _marker) vectorAdd ([[2 + random 2,0,0], random 360] call BIS_fnc_rotateVector2D));
		_cash setDir random 360;
		_cash setVariable["cmoney",50000,true];
		_cash setVariable["owner","world",true];
	};
	
	_box1 = "Box_East_Wps_F" createVehicle getMarkerPos _marker;
	_box1 setVariable ["moveable", true, true];
    [_box1,"mission_USLaunchers"] call fn_refillbox;
	_box1 allowDamage false;
	
	_box2 = "Box_NATO_Wps_F" createVehicle getMarkerPos _marker;
	_box2 setVariable ["moveable", true, true];
    [_box2,"mission_USSpecial2"] call fn_refillbox;
	_box2 allowDamage false;
	
	_box3 = "Box_NATO_Support_F" createVehicle getMarkerPos _marker;
	_box3 setVariable ["moveable", true, true];
    [_box3,"mission_Main_A3snipers"] call fn_refillbox;
	_box3 allowDamage false;
	
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2, _box3];
	
	_successHintMessage = "The Samsite has been destroyed and all soldiers have been eliminated, the money, crates and vehicles are yours to take.";
};

_this call infantryMissionProcessor;