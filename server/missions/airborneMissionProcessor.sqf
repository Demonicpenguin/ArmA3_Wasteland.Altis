// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: airborneMissionProcessor.sqf
//	@file Author: AgentRev, edit by GriffinSZ

#define MISSION_PROC_TYPE_NAME "Airborne"
#define MISSION_PROC_TIMEOUT (["A3W_airborneMissionTimeout", 45*60] call getPublicVar)
#define MISSION_PROC_COLOR_DEFINE airborneMissionColor
#define MISSION_PROC_COLOR "colorCivilian"

#include "airborneMissions\airborneMissionDefines.sqf"
#include "missionProcessor.sqf";
