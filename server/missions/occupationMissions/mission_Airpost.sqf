// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_Airpost.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, JoSchaap, AgentRev
//	@file Created: 08/12/2012 15:19

if (!isServer) exitwith {};
#include "occupationMissionDefines.sqf";

private ["_nbUnits", "_airpost", "_objects", "_box1", "_box2", "_box3"];

_setupVars =
{
	_missionType = "Airport Outpost";
	_locationsArray = AirpostMissionMarkers;
	_nbUnits = AI_GROUP_MEDIUM;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	
	//delete existing base parts and vehicles at location
	_baseToDelete = nearestObjects [_missionPos, ["All"], 25];
	{ deleteVehicle _x } forEach _baseToDelete;	

	_airpost = (call compile preprocessFileLineNumbers "server\missions\airposts\airpostsList.sqf") call BIS_fnc_selectRandom;
	_objects = [_airpost, _missionPos, 0] call createAirpost;

	_aiGroup = createGroup CIVILIAN;
	[_aiGroup, _missionPos, _nbUnits, 5] call createCustomGroup4;
	
	_missionPicture = "media\airfield.jpg";	

	_missionHintText = format ["<br/>Attention! A group of armed units <br/><t color='%1'>blockades a local airport</t>.<br/>Head there, eliminate them all and break this blockade!", occupationMissionColor];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach _objects;
};

_successExec =
{
	// Mission complete
	
	//delete existing base parts and vehicles at location
	_baseToDelete = nearestObjects [_missionPos, ["All"], 25];
	{ if (!(_x isKindOf "LandVehicle")) then {deleteVehicle _x} } forEach _baseToDelete;		

	for "_x" from 1 to 10 do
	{
		_cash = "Land_Money_F" createVehicle markerPos _marker;
		_cash setPos ((markerPos _marker) vectorAdd ([[2 + random 2,0,0], random 360] call BIS_fnc_rotateVector2D));
		_cash setDir random 360;
		_cash setVariable["cmoney",50000,true];
		_cash setVariable["owner","world",true];
	};
	
	_box1 = "B_supplyCrate_F" createVehicle getMarkerPos _marker;
    [_box1,"Launchers_Tier_2"] call fn_refillbox2;
	_box1 allowDamage false;
	_box1 setVariable ["moveable", true, true];
	

	_box2 = "Box_NATO_Wps_F" createVehicle getMarkerPos _marker;
    [_box2,"mission_USSpecial2"] call fn_refillbox2;
	_box2 allowDamage false;
	_box2 setVariable ["moveable", true, true];


	_box3 = "Box_NATO_Support_F" createVehicle getMarkerPos _marker;
    [_box3,"mission_snipers"] call fn_refillbox2;
	_box3 allowDamage false;
	_box3 setVariable ["moveable", true, true];
	
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2, _box3];	
	

	_successHintMessage = format ["<br/>Well done! The airport is free again!"];
};

_this call occupationMissionProcessor;
