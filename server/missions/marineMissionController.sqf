// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: waterMissionController.sqf
//	@file Author: AgentRev, edit GriffinSZ

#define MISSION_CTRL_PVAR_LIST MarineMissions
#define MISSION_CTRL_TYPE_NAME "Marine"
#define MISSION_CTRL_FOLDER "marineMissions"
#define MISSION_CTRL_DELAY (["A3W_marineMissionDelay", 25*60] call getPublicVar)
#define MISSION_CTRL_COLOR_DEFINE marineMissionColor

#include "marineMissions\marineMissionDefines.sqf"
#include "missionController.sqf";
