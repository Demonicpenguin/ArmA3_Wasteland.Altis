// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: sideMissionController.sqf
//	@file Author: AgentRev

#define MISSION_CTRL_PVAR_LIST InfantryMissions
#define MISSION_CTRL_TYPE_NAME "Infantry"
#define MISSION_CTRL_FOLDER "infantryMissions"
#define MISSION_CTRL_DELAY (["A3W_infantryMissionDelay", 5*60] call getPublicVar)
#define MISSION_CTRL_COLOR_DEFINE infantryMissionColor

#include "infantryMissions\infantryMissionDefines.sqf"
#include "missionController.sqf";
