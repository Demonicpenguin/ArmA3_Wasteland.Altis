// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_ArmedHeli.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev
//	@file Created: 08/12/2012 15:19

if (!isServer) exitwith {};
#include "infantryMissionDefines.sqf";

private ["_vehicleClass", "_nbUnits"];

_setupVars =
{
	_vehicleClass =
	[
		"RHS_T50_vvs_generic_ext",
		"RHS_T50_vvs_051",
		"RHS_T50_vvs_052",
		"RHS_T50_vvs_053",
		"RHS_T50_vvs_054",
		"RHS_T50_vvs_blueonblue"		

	] call BIS_fnc_selectRandom;

	_missionType = "Abandoned Jet";
	_locationsArray = MissionSpawnMarkers;

	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };

};

_this call mission_VehicleCapture;
