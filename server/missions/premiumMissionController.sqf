// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: PrimaryMissionController.sqf
//	@file Author: AgentRev

#define MISSION_CTRL_PVAR_LIST PremiumMissions
#define MISSION_CTRL_TYPE_NAME "Premium"
#define MISSION_CTRL_FOLDER "premiumMissions"
#define MISSION_CTRL_DELAY (["A3W_PremiumMissionDelay", 60*60] call getPublicVar)
#define MISSION_CTRL_COLOR_DEFINE premiumMissionColor

#include "premiumMissions\premiumMissionDefines.sqf"
#include "missionController.sqf";
