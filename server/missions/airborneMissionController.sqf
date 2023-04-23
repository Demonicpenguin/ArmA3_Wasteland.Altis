// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: airMissionController.sqf
//	@file Author: AgentRev, edit GriffinSZ

#define MISSION_CTRL_PVAR_LIST AirborneMissions
#define MISSION_CTRL_TYPE_NAME "Airborne"
#define MISSION_CTRL_FOLDER "airborneMissions"
#define MISSION_CTRL_DELAY (["A3W_airborneMissionDelay", 15*60] call getPublicVar)
#define MISSION_CTRL_COLOR_DEFINE airborneMissionColor

#include "airborneMissions\airborneMissionDefines.sqf"
#include "missionController.sqf";
