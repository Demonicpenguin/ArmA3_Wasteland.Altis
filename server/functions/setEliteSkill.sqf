// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: setEliteSkill.sqf
//	@file Author: AgentRev
//	@file Edit: [509th] Coyote Rogue]
//	@file Created: 21/10/2013 19:14

if (!isServer) exitWith {};

private ["_unit"];
_unit = _this;

_unit allowFleeing 0;
_unit setSkill 1;
_unit setSkill ["aimingAccuracy", 1];
_unit setSkill ["aimingSpeed", 1];
_unit setSkill ["commanding", 1];
_unit setSkill ["courage", 1];
_unit setSkill ["reloadSpeed", 1];
_unit setSkill ["spotDistance", 1];
_unit setSkill ["spotTime", 1];
_unit setSkill ["aimingSpeed", 1];
_unit setSkill ["aimingShake", 1];

// Available skills are explained here: http://community.bistudio.com/wiki/AI_Sub-skills
// Skill values are between 0 and 1
