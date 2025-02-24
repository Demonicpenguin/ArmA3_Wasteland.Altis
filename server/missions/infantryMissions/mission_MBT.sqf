// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_MBT.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev
//	@file Created: 08/12/2012 15:19

if (!isServer) exitwith {};
#include "infantryMissionDefines.sqf";

private ["_vehicleClass", "_nbUnits"];

_setupVars =
{
	_vehicleClass =
	[
		"B_MBT_01_cannon_F",
		"O_MBT_02_cannon_F",
		"I_MBT_03_cannon_F",
		"RHS_M2A3_BUSKIII",
		"O_MBT_04_command_F",
		"O_APC_Tracked_02_AA_F",
		"rhsusf_m1a2sep1tuskiiwd_usarmy",
		"B_AFV_Wheeled_01_cannon_F",
		"B_AFV_Wheeled_01_up_cannon_F"		
	] call BIS_fnc_selectRandom;

	_missionType = "Main Battle Tank";
	_locationsArray = MissionSpawnMarkers;

	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
	/*_reinforceChance = 70; // Chance of reinforcements being called
	_minReinforceGroups = 2; //minimum number of paradrop groups that will respond to call
	_maxReinforceGroups = 4; //maximum number of paradrop groups that will respond to call*/		
};

_this call mission_VehicleCapture;
