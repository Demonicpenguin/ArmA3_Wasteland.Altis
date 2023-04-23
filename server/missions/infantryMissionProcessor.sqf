// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: infantryMissionProcessor.sqf
//	@file Author: AgentRev

#define MISSION_PROC_TYPE_NAME "Infantry"
#define MISSION_PROC_TIMEOUT (["A3W_infantryMissionTimeout", 45*60] call getPublicVar)
#define MISSION_PROC_COLOR_DEFINE infantryMissionColor

#include "infantryMissions\infantryMissionDefines.sqf"
#include "missionProcessor.sqf";
