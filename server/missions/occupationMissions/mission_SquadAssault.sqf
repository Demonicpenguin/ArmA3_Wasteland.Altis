// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2019 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_SquadAssault.sqf
//	@file Author: [509th] Coyote Rogue
//	@file Created: 20/02/2019 21:27

#define GHOSTHOTEL ["Land_GH_MainBuilding_left_F", "Land_GH_MainBuilding_middle_F","Land_GH_MainBuilding_right_F"]
#define HOSPITAL ["Land_Hospital_main_F", "Land_Hospital_side1_F", "Land_Hospital_side2_F"]
#define OFFICES ["Land_Offices_01_V1_F"]
#define AIRPORT ["Land_Airport_left_F", "Land_Airport_center_F", "Land_Airport_right_F"]   	
#define BARRACKS ["Land_i_Barracks_V2_F", "Land_u_Barracks_V2_F", "Land_i_Barracks_V1_F"]



if (!isServer) exitwith {};



#include "occupationMissionDefines.sqf";

private ["_aiGroup", "_buildings", "_buildingnames", "_center", "_reward", "_nbUnit","_nbUnits", "_moneyAmount", "_boxes1", "_box1", "_box2", "_box3", "_moneyText", "_missionPos", "_missionType", "_cash"];

_setupVars = {

	_missionType = "Squad Assault";
	_buildingnames = selectRandom [GHOSTHOTEL, HOSPITAL, OFFICES, AIRPORT, BARRACKS];

	//Find the center of the world, find the first occurence of the first building in the named set
	_center =  getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition");
	_missionPos = getPos ((nearestObjects [_center, [(_buildingnames select 0)], 25000]) select 0);
	
	_moneyAmount = 500000; //Reward amount for completing mission	

};

_setupObjects = {

	//Find local buildings
	_buildings = nearestObjects [_missionPos, _buildingnames, 100];

	//Create AI Group
	_nbUnit = 10;
	_aiGroup = createGroup CIVILIAN;
	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "COMBAT";

	//Keep a count of how many were spawned
	private _count = 0;
	private _units = 0;

	//Determine the number of position in each building, and randomize them
	_nbUnits = _nbUnit + round(random ((_nbUnit)*0.5));
	[_aiGroup, _missionPos, _nbUnits, 5] call createsquadAssault;	

	// move them into buildings
	[_aiGroup, _missionPos, 25, true, true] call moveIntoBuildings;
	
	[_aiGroup, _missionPos] call defendArea;

	_missionPicture = "media\soldier.paa";	
	_missionHintText = format ["An elite special forces squad is staged in a building preparing for a raid.<br/>Conduct a counter assault before they can deploy!", occupationMissionColor];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	
	//{ deleteVehicle _x } forEach [_barGate, _obj1, _obj2];
	
};

_successExec =
{
	// Mission completed
	
		for "_i" from 1 to 10 do
		{
			_cash = createVehicle ["Land_Money_F", _lastPos, [], 5, "NONE"];


			_cash setPos ([_lastPos, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
			_cash setDir random 360;
			_cash setVariable ["cmoney", _moneyAmount / 10, true];
			_cash setVariable ["owner", "world", true];
		};

	_boxes1 = selectRandom ["Box_NATO_Wps_F","Box_East_Wps_F","Box_IND_Wps_F", "Box_IND_Ammo_F","Box_IND_AmmoOrd_F","Box_IND_Grenades_F","Box_IND_Support_F","Box_IND_WpsLaunch_F","Box_IND_WpsSpecial_F"];
	
	_box1 = createVehicle [_boxes1, _lastPos, [], 5, "NONE"];
	_box1 setVariable ["moveable", true, true];
    [_box1,"mission_USLaunchers"] call fn_refillbox;
	_box1 allowDamage false;
	
	_box2 = createVehicle [_boxes1, _lastPos, [], 5, "NONE"];
	_box2 setVariable ["moveable", true, true];
    [_box2,"mission_USSpecial2"] call fn_refillbox;
	_box2 allowDamage false;
	
	_box3 = createVehicle [_boxes1, _lastPos, [], 5, "NONE"];
	_box3 setVariable ["moveable", true, true];
    [_box3,"mission_Main_A3snipers"] call fn_refillbox;
	_box3 allowDamage false;
	
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2, _box3];
	

	_successHintMessage = format ["Well done! These jerks of merchants are dead. Save the crates, pocket the cash and make for the ATM!"];
};

_this call occupationMissionProcessor;
