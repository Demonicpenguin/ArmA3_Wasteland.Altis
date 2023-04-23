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

private ["_vehicle2", "_vehicle3", "_vehicle4", "_vehicle5", "_vehicle", "_vehicleClass", "_vehicleName", "_obj1", "_obj2", "_obj3", "_obj4", "_obj5", "_obj6", "_obj7", "_obj8", "_soldier"];

_setupVars =
{
	_missionType = "Inflitration of Oak Island";
	_locationsArray = SubBaseMissionMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_missionDir = markerDir _missionLocation;
	
	_vehicleClass = ["HAFM_Virginia", "HAFM_Yasen"] call BIS_fnc_selectRandom;	

	_vehicle = [_vehicleClass, [13663.8,-3049.34,186.222]] call createMissionVehicle2;
	_vehicle setDir 270;
	sleep 1;
	_vehicle setPosATL [7550.05,3048.77,183];	//185.97
	_vehicle lockDriver true; // lock vehicle driver position
	_vehicle setFuel 0;

	_vehicle2 = ["O_APC_Tracked_02_AA_F", [10241.1,6632.55,3.69549e-005]] call createMissionVehicle2;	// Crane
	_vehicle2 setVehicleReportRemoteTargets true;
	_vehicle2 setVehicleReceiveRemoteTargets true;
	_vehicle2 setVehicleRadar 1;
	_vehicle2 confirmSensorTarget [west, true];
	_vehicle2 confirmSensorTarget [east, true];
	_vehicle2 confirmSensorTarget [resistance, true];
	_vehicle2 setVariable ["R3F_LOG_disabled", true, true];
	_vehicle2 addEventHandler ["fired", {(_this select 0) setvehicleammo 1}];	
	_vehicle2 setDir 89;
	_vehicle2 setPosATL [7604.55,3024.23,197.122];
	_vehicle2 setVehicleLock "LOCKED";	

	_vehicle3 = ["O_APC_Tracked_02_AA_F", [10241.1,6632.55,3.69549e-005]] call createMissionVehicle2;	// Lighthouse	
	_vehicle3 setVehicleReportRemoteTargets true;
	_vehicle3 setVehicleReceiveRemoteTargets true;
	_vehicle3 setVehicleRadar 1;
	_vehicle3 confirmSensorTarget [west, true];
	_vehicle3 confirmSensorTarget [east, true];
	_vehicle3 confirmSensorTarget [resistance, true];
	_vehicle3 setVariable ["R3F_LOG_disabled", true, true];
	_vehicle3 addEventHandler ["fired", {(_this select 0) setvehicleammo 1}];	
	_vehicle3 setDir 257;
	_vehicle3 setPosATL [7498.77,3037.68,206.49];
	_vehicle3 setVehicleLock "LOCKED";	
	
	_vehicle4 = ["O_APC_Tracked_02_AA_F", [10241.1,6632.55,3.69549e-005]] call createMissionVehicle2;	// Church	
	_vehicle4 setVehicleReportRemoteTargets true;
	_vehicle4 setVehicleReceiveRemoteTargets true;
	_vehicle4 setVehicleRadar 1;
	_vehicle4 confirmSensorTarget [west, true];
	_vehicle4 confirmSensorTarget [east, true];
	_vehicle4 confirmSensorTarget [resistance, true];
	_vehicle4 setVariable ["R3F_LOG_disabled", true, true];
	_vehicle4 addEventHandler ["fired", {(_this select 0) setvehicleammo 1}];	
	_vehicle4 setDir 257;
	_vehicle4 setPosATL [7495.98,3107.39,197.036];
	_vehicle4 setVehicleLock "LOCKED";	
	
	/*_vehicle5 = ["HAFM_052D", [13663.8,-3049.34,186.222]] call createMissionVehicle2;					// Ship
	_vehicle5 setVehicleReportRemoteTargets true;
	_vehicle5 setVehicleReceiveRemoteTargets true;
	_vehicle5 setVehicleRadar 1;
	_vehicle5 confirmSensorTarget [west, true];
	_vehicle5 confirmSensorTarget [east, true];
	_vehicle5 confirmSensorTarget [resistance, true];
	_vehicle5 setVariable ["R3F_LOG_disabled", true, true];
	_vehicle5 addEventHandler ["fired", {(_this select 0) setvehicleammo 1}];
	_vehicle5 setDir 305;
	_vehicle5 setPosATL [7731.04,3118.28,181.139];	//185.97	
	_vehicle5 lockDriver true; // lock vehicle driver position
	_vehicle5 setFuel 0;*/

	_obj1 = createVehicle ["I_GMG_01_high_F", [10241.1,6632.55,3.69549e-005],[], 10,"NONE"];	// end of sub basin left
	_obj1 setDir 264;
	_obj1 setPosATL [7600.04,3062.14,187.038];
	
	_obj2 = createVehicle ["I_GMG_01_high_F", [10241.1,6632.55,3.69549e-005],[], 10,"NONE"]; 	// end of sub basin right
	_obj2 setDir 95;
	_obj2 setPosATL [7496.61,3061.66,187.039];	
	
	_obj3 = createVehicle ["I_GMG_01_high_F", [10241.1,6632.55,3.69549e-005],[], 10,"NONE"];	// left of lighthouse 
	_obj3 setDir 203;
	_obj3 setPosATL [7503.98,3011.26,196.831];
	
	_obj4 = createVehicle ["I_GMG_01_high_F", [10241.1,6632.55,3.69549e-005],[], 10,"NONE"];	// right of lighthouse 
	_obj4 setDir 276;
	_obj4 setPosATL [7486.05,3059.2,198.048];	
	
	_obj5 = createVehicle ["I_GMG_01_high_F", [10241.1,6632.55,3.69549e-005],[], 10,"NONE"];	// left of Heli 
	_obj5 setDir 185;
	_obj5 setPosATL [7556.09,3034.79,206.462];

	_obj6 = createVehicle ["I_GMG_01_high_F", [10241.1,6632.55,3.69549e-005],[], 10,"NONE"]; 	// right of Heli  
	_obj6 setDir 274;
	_obj6 setPosATL [7497.88,3051.93,206.48];

	_obj7 = createVehicle ["I_GMG_01_high_F", [10241.1,6632.55,3.69549e-005],[], 10,"NONE"]; 	// second tower from church
	_obj7 setDir 354;
	_obj7 setPosATL [7590.21,3054.51,225.534];

	_obj8 = createVehicle ["I_GMG_01_high_F", [10241.1,6632.55,3.69549e-005],[], 10,"NONE"];	// Jetty
	_obj8	setDir 184;
	_obj8 setPosATL [7541.89,3003.17,186.966];

	_aiGroup = createGroup CIVILIAN;

	[_aiGroup,_missionPos,11,30] spawn createoverWaterGroup;
	
	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "COMBAT";

	[_vehicle, _aiGroup] spawn checkMissionVehicleLock;
	
	_missionPicture = getText (configFile >> "CfgVehicles" >> _vehicleClass >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _vehicleClass >> "displayName");	
	
	_missionHintText = format ["Enemies have set up a secret Submarine base on Oak Island, harbouring a <t color='%3'>%1</t> Submarine. Its location has been leaked. Inflitrate the base and steal the Sub", _vehicleName, occupationMissionColor];
	
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	_vehicle2 removeEventHandler ["fired", 0];
	_vehicle3 removeEventHandler ["fired", 0];
	_vehicle4 removeEventHandler ["fired", 0];
	//_vehicle5 removeEventHandler ["fired", 0];
	
	{ deleteVehicle _x } forEach [_vehicle, _vehicle2,_vehicle3,_vehicle4, _obj1, _obj2, _obj3, _obj4, _obj5, _obj6, _obj7, _obj8];
};

// Mission completed

	_successExec =
	{
		_vehicle lockDriver false; // unlock vehicle
		_vehicle setFuel 1;

		_vehicle2 removeEventHandler ["fired", 0];
		_vehicle3 removeEventHandler ["fired", 0];
		_vehicle4 removeEventHandler ["fired", 0];
		//_vehicle5 removeEventHandler ["fired", 0];
			
		{ deleteVehicle _x } forEach [_vehicle2, _vehicle3, _vehicle4, _obj1, _obj2, _obj3, _obj4, _obj5, _obj6, _obj7, _obj8];		
		
		_successHintMessage = "Nice job all, careful when piloting your sub out of here.";
		
	};

_this call occupationMissionProcessor;
