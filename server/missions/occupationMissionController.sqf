// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: occupationMissionController.sqf
//	@file Author: AgentRev, edit GriffinSZ

#define MISSION_CTRL_PVAR_LIST OccupationMissions
#define MISSION_CTRL_TYPE_NAME "Occupation"
#define MISSION_CTRL_FOLDER "occupationMissions"
#define MISSION_CTRL_DELAY (["A3W_occupationMissionDelay", 20*60] call getPublicVar)
#define MISSION_CTRL_COLOR_DEFINE occupationMissionColor

#include "occupationMissions\occupationMissionDefines.sqf"
#include "missionController.sqf";
