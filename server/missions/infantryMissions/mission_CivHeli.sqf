// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_CivHeli.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev
//	@file Created: 08/12/2012 15:19

if (!isServer) exitwith {};
#include "infantryMissionDefines.sqf";

private ["_vehicleClass", "_nbUnits"];

_setupVars =
{
	_vehicleClass = ["I_Heli_Transport_02_F", "B_Heli_Transport_03_unarmed_F", "O_Heli_Transport_04_F"] call BIS_fnc_selectRandom;

	_missionType = "Transport Helicopter";
	_locationsArray = MissionSpawnMarkers;

	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
	/*_reinforceChance = 0; // Chance of reinforcements being called
	_minReinforceGroups = 1; //minimum number of paradrop groups that will respond to call
	_maxReinforceGroups = 2; //maximum number of paradrop groups that will respond to call*/
};

_this call mission_VehicleCapture;
