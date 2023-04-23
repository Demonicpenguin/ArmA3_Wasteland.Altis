// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_APC.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev
//	@file Created: 08/12/2012 15:19

if (!isServer) exitwith {};
#include "infantryMissionDefines.sqf";

private ["_vehicleClass", "_nbUnits"];

_setupVars =
{
	_vehicleClass =
	[
		"B_APC_Wheeled_01_cannon_F",//Marshall
		"O_APC_Wheeled_02_rcws_F",//Marid
		"I_APC_Wheeled_03_cannon_F"//Gorgan
		"B_APC_Tracked_01_rcws_F",//Panther
		"O_APC_Tracked_02_cannon_F",//Kamysh
		"I_APC_tracked_03_cannon_F",//Mora
		"B_APC_Tracked_01_AA_F",//Cheetah
		"O_APC_Tracked_02_AA_F"//Tigris
	] call BIS_fnc_selectRandom;

	_missionType = switch (true) do
	{
		case ({_vehicleClass isKindOf _x} count ["B_APC_Tracked_01_AA_F", "O_APC_Tracked_02_AA_F"] > 0): { "Anti Aircraft Vehicle" };
		case (_vehicleClass isKindOf "Tank_F"):                                                          { "Infantry Fighting Vehicle" };
		default                                                                                          { "Armored Personnel Carrier" };
	};

	_locationsArray = MissionSpawnMarkers;

	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
	/*_reinforceChance = 80; // Chance of reinforcements being called
	_minReinforceGroups = 1; //minimum number of paradrop groups that will respond to call
	_maxReinforceGroups = 3; //maximum number of paradrop groups that will respond to call*/	
};

_this call mission_VehicleCapture;
