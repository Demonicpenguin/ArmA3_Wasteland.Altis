// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_HackLaptop.sqf
//	@file Author: JoSchaap, AgentRev, LouD

if (!isServer) exitwith {};
#include "premiumMissionDefines.sqf";

private ["_positions", "_camonet", "_laptop", "_obj1", "_obj2", "_mortar1", "_mortar2", "_vehicleName","_table", "_aaSupport", "_armyPos"];

_setupVars =
{
	_missionType = "Hackers";
	_locationsArray = HackMissionMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_armyPos = _missionPos vectorAdd ([[25 + random 20, 0, 0], random 360] call BIS_fnc_rotateVector2D);
    _aaPos = _armyPos vectorAdd ([[50 + random 25, 0, 0], random 360] call BIS_fnc_rotateVector2D);	
	
	//delete existing base parts and vehicles at location
	_baseToDelete = nearestObjects [_missionPos, ["All"], 25];
	{ deleteVehicle _x } forEach _baseToDelete;

	noArtyZone = createMarker ["noArtillery", _missionPos];
	noArtyZone setMarkerShape "ELLIPSE";
	"noArtillery" setMarkerColor "ColorRed";
	"noArtillery" setMarkerSize [100, 100];
	"noArtillery" setMarkerBrush "Border";	
	
	_camonet = createVehicle ["CamoNet_INDP_big_F", [_missionPos select 0, _missionPos select 1], [], 0, "CAN COLLIDE"];
	_camonet allowdamage false;
	_camonet setDir random 360;
	_camonet setVariable ["R3F_LOG_disabled", false];

	_missionPos = getPosATL _camonet;

	_table = createVehicle ["Land_WoodenTable_small_F", _missionPos, [], 0, "CAN COLLIDE"];
	_table setPosATL [_missionPos select 0, _missionPos select 1, _missionPos select 2];
	
	_laptop = createVehicle ["Land_Laptop_unfolded_F", _missionPos, [], 0, "CAN COLLIDE"];
	_laptop attachTo [_table,[0,0,0.60]];

	_obj1 = createVehicle ["I_GMG_01_high_F", _missionPos,[], 10,"None"]; 
	_obj1 setPosATL [(_missionPos select 0) - 2, (_missionPos select 1) + 2, _missionPos select 2];
		
	_obj2 = createVehicle ["B_Radar_System_01_F", _missionPos,[], 10,"CAN COLLIDE"]; 
	_obj2 setPosATL [(_missionPos select 0) + 22, (_missionPos select 1) + 22, _missionPos select 2];
	_obj2 allowdamage false;
	_obj2 setDir random 360;

	_obj2 setVehicleReportRemoteTargets true;
	_obj2 setVehicleReceiveRemoteTargets true;
	_obj2 setVehicleRadar 1;
	_obj2 confirmSensorTarget [west, true];
	_obj2 confirmSensorTarget [east, true];
	_obj2 confirmSensorTarget [resistance, true];	

	_mortar1 = createVehicle ["B_SAM_System_01_F", _missionPos,[], 10,"CAN COLLIDE"]; 
	_mortar1 setPosATL [(_missionPos select 0) - 22, (_missionPos select 1) - 22, _missionPos select 2];
	_mortar1 allowdamage false;
	_mortar1 setDir random 360;	

	_mortar1 setVehicleReportRemoteTargets true;
	_mortar1 setVehicleReceiveRemoteTargets true;
	_mortar1 setVehicleRadar 1;
	_mortar1 confirmSensorTarget [west, true];
	_mortar1 confirmSensorTarget [east, true];
	_mortar1 confirmSensorTarget [resistance, true];	
	
	_mortar2 = createVehicle ["I_GMG_01_high_F", _missionPos,[], 10,"None"];
	_mortar2 setPosATL [(_missionPos select 0) + 2, (_missionPos select 1) - 2, _missionPos select 2];

	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach [_obj1, _obj2, _mortar1, _mortar2, _camonet];	

    _aaSupport = createVehicle ["O_APC_Tracked_02_AA_F", _aaPos, [], 5, "None"];
    _soldier = [_aiGroup, _aaPos] call createRandomSoldier;
    _soldier moveInDriver _aaSupport;

    _soldier = [_aiGroup, _aaPos] call createRandomSoldier;
    _soldier moveInGunner _aaSupport;	
	
	AddLaptopHandler = _laptop;
	publicVariable "AddLaptopHandler";

	_laptop setVariable [ "Done", false, true ];

	_aiGroup = createGroup CIVILIAN;
	[_aiGroup,_missionPos,24,20] spawn createCustomGroup3;

	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "COMBAT";	
	
	_vehicleName = "Laptop";
	_missionHintText = format ["<t color='%2'>Hackers</t> are using a laptop to hack your bank accounts. Hacking the laptop successfully will steal 7.5 percent from each on-line players bank account! HURRY TO DEFEND YOUR BANK ACCOUNT OR HACK OTHERS BANK ACCOUNTS!", _vehicleName, premiumMissionColor];
};

_waitUntilMarkerPos = nil;
_waitUntilExec =
{
	AddLaptopHandler = _laptop;
	publicVariable "AddLaptopHandler";
};
_waitUntilCondition = nil;
_waitUntilSuccessCondition = { _laptop getVariable ["Done", false] };
_ignoreAiDeaths = true;

_failedExec =
{
	// Mission failed
	RemoveLaptopHandler = _laptop;
	publicVariable "RemoveLaptopHandler";
	{ deleteVehicle _x } forEach [_camonet, _obj1, _obj2, _mortar1, _mortar2, _laptop, _table];
	deleteMarker "noArtillery";
};

_successExec =
{
	// Mission completed
	RemoveLaptopHandler = _laptop;
	publicVariable "RemoveLaptopHandler";
	{ deleteVehicle _x } forEach [_camonet, _laptop, _table, _obj1, _obj2, _mortar1, _mortar2];
	//{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_obj1, _obj2, _mortar1, _mortar2];
	//{ _x setVariable ["allowDamage", true, true] } forEach [_obj1, _obj2, _mortar1, _mortar2];
	deleteMarker "noArtillery";	

	_successHintMessage = format ["The laptop is hacked. Go and kill the hacker to get your money back!"];
};

_this call premiumMissionProcessor;