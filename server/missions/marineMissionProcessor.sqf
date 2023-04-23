// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: marineMissionProcessor.sqf
//	@file Author: AgentRev, edit by GriffinSZ

#define MISSION_PROC_TYPE_NAME "Marine"
#define MISSION_PROC_TIMEOUT (["A3W_marineMissionTimeout", 60*60] call getPublicVar)
#define MISSION_PROC_COLOR_DEFINE marineMissionColor

#include "marineMissions\marineMissionDefines.sqf"
#include "missionProcessor.sqf";
