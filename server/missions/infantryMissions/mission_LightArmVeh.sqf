// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_LightArmVeh.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev
//	@file Created: 08/12/2012 15:19

if (!isServer) exitwith {};
#include "infantryMissionDefines.sqf";

private ["_vehicleClass", "_nbUnits"];

_setupVars =
{
	_vehicleClass =
	[
		"O_T_LSV_02_armed_F",
		"B_T_LSV_01_armed_F",
		"I_MRAP_03_hmg_F",
		"B_T_LSV_01_armed_F",
		"O_T_LSV_02_armed_F",
		"O_T_LSV_02_AT_F"
	] call BIS_fnc_selectRandom;

	_missionType = "Light Armed Vehicle";
	_locationsArray = MissionSpawnMarkers;

	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
	/*_reinforceChance = 0; // Chance of reinforcements being called
	_minReinforceGroups = 1; //minimum number of paradrop groups that will respond to call
	_maxReinforceGroups = 1; //maximum number of paradrop groups that will respond to call*/		
};

_this call mission_VehicleCapture;
