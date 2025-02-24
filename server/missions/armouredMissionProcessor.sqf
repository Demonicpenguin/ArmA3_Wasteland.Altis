// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: armouredMissionProcessor.sqf
//	@file Author: AgentRev

#define MISSION_PROC_TYPE_NAME "Armoured"
#define MISSION_PROC_TIMEOUT (["A3W_armouredMissionTimeout", 60*60] call getPublicVar)
#define MISSION_PROC_COLOR_DEFINE armouredMissionColor

#include "armouredMissions\armouredMissionDefines.sqf"
#include "missionProcessor.sqf";
