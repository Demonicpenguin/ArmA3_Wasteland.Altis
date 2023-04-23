// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: moneyMissionController.sqf
//	@file Author: AgentRev

#define MISSION_CTRL_PVAR_LIST ArmouredMissions
#define MISSION_CTRL_TYPE_NAME "Armoured"
#define MISSION_CTRL_FOLDER "armouredMissions"
#define MISSION_CTRL_DELAY (["A3W_armouredMissionDelay", 10*60] call getPublicVar)
#define MISSION_CTRL_COLOR_DEFINE armouredMissionColor

#include "armouredMissions\armouredMissionDefines.sqf";
#include "missionController.sqf";
