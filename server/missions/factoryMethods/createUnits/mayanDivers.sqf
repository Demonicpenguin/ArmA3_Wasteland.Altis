// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: largeDivers.sqf
//	@file Author: [GoT] JoSchaap, AgentRev

if (!isServer) exitWith {};

private ["_group", "_pos", "_leader", "_man2", "_man3", "_man4", "_man5", "_man6", "_man7", "_man8", "_man9", "_man10", "_man11","_man12", "_man13", "_man14", "_man15", "_man16"];

_group = _this select 0;
_pos = _this select 1;

// Rifleman
_leader = _group createUnit ["C_man_polo_1_F", [_pos select 0, _pos select 1, -100], [], 1, "Form"];

removeAllAssignedItems _leader;
_leader addVest "V_RebreatherB";
_leader addUniform "U_B_Wetsuit";
_leader addGoggles "G_Diving";
_leader addMagazine "20Rnd_556x45_UW_Mag";
_leader addWeapon "arifle_SDAR_F";
_leader addMagazine "20Rnd_556x45_UW_Mag";
_leader addMagazine "20Rnd_556x45_UW_Mag";



// Rifleman
_man2 = _group createUnit ["C_man_polo_2_F", [_pos select 0, _pos select 1, -100], [], 1, "Form"];

removeAllAssignedItems _man2;
_man2 addUniform "U_B_Wetsuit";
_man2 addVest "V_RebreatherB";
_man2 addGoggles "G_Diving";
_man2 addMagazine "20Rnd_556x45_UW_Mag";
_man2 addWeapon "arifle_SDAR_F";
_man2 addMagazine "20Rnd_556x45_UW_Mag";
_man2 addMagazine "20Rnd_556x45_UW_Mag";


// Rifleman
_man3 = _group createUnit ["C_man_polo_3_F", [_pos select 0, _pos select 1, -100], [], 1, "Form"];
_man3 swimInDepth -80;
removeAllAssignedItems _man3;
_man3 addUniform "U_B_Wetsuit";
_man3 addVest "V_RebreatherB";
_man3 addGoggles "G_Diving";
_man3 addMagazine "20Rnd_556x45_UW_Mag";
_man3 addWeapon "arifle_SDAR_F";
_man3 addMagazine "20Rnd_556x45_UW_Mag";
_man3 addMagazine "20Rnd_556x45_UW_Mag";


// Rifleman
_man4 = _group createUnit ["C_man_polo_4_F", [_pos select 0, _pos select 1, -100], [], 1, "Form"];

removeAllAssignedItems _man4;
_man4 addUniform "U_B_Wetsuit";
_man4 addVest "V_RebreatherB";
_man4 addGoggles "G_Diving";
_man4 addMagazine "20Rnd_556x45_UW_Mag";
_man4 addWeapon "arifle_SDAR_F";
_man4 addMagazine "20Rnd_556x45_UW_Mag";
_man4 addMagazine "20Rnd_556x45_UW_Mag";


// Rifleman
_man5 = _group createUnit ["C_man_polo_5_F", [_pos select 0, _pos select 1, -100], [], 1, "Form"];

removeAllAssignedItems _man5;
_man5 addUniform "U_B_Wetsuit";
_man5 addVest "V_RebreatherB";
_man5 addGoggles "G_Diving";
_man5 addMagazine "20Rnd_556x45_UW_Mag";
_man5 addWeapon "arifle_SDAR_F";
_man5 addMagazine "20Rnd_556x45_UW_Mag";
_man5 addMagazine "20Rnd_556x45_UW_Mag";


// Rifleman
_man6 = _group createUnit ["C_man_polo_4_F", [_pos select 0, _pos select 1, -100], [], 1, "Form"];

removeAllAssignedItems _man6;
_man6 addUniform "U_B_Wetsuit";
_man6 addVest "V_RebreatherB";
_man6 addGoggles "G_Diving";
_man6 addMagazine "20Rnd_556x45_UW_Mag";
_man6 addWeapon "arifle_SDAR_F";
_man6 addMagazine "20Rnd_556x45_UW_Mag";
_man6 addMagazine "20Rnd_556x45_UW_Mag";


// Rifleman
_man7 = _group createUnit ["C_man_polo_4_F", [_pos select 0, _pos select 1, -100], [], 1, "Form"];

removeAllAssignedItems _man7;
_man7 addUniform "U_B_Wetsuit";
_man7 addVest "V_RebreatherB";
_man7 addGoggles "G_Diving";
_man7 addMagazine "20Rnd_556x45_UW_Mag";
_man7 addWeapon "arifle_SDAR_F";
_man7 addMagazine "20Rnd_556x45_UW_Mag";
_man7 addMagazine "20Rnd_556x45_UW_Mag";


// Rifleman
_man8 = _group createUnit ["C_man_polo_4_F", [_pos select 0, _pos select 1, -100], [], 1, "Form"];

removeAllAssignedItems _man8;
_man8 addUniform "U_B_Wetsuit";
_man8 addVest "V_RebreatherB";
_man8 addGoggles "G_Diving";
_man8 addMagazine "20Rnd_556x45_UW_Mag";
_man8 addWeapon "arifle_SDAR_F";
_man8 addMagazine "20Rnd_556x45_UW_Mag";
_man8 addMagazine "20Rnd_556x45_UW_Mag";


// Rifleman
_man9 = _group createUnit ["C_man_polo_4_F", [_pos select 0, _pos select 1, -100], [], 1, "Form"];

removeAllAssignedItems _man9;
_man9 addUniform "U_B_Wetsuit";
_man9 addVest "V_RebreatherB";
_man9 addGoggles "G_Diving";
_man9 addMagazine "20Rnd_556x45_UW_Mag";
_man9 addWeapon "arifle_SDAR_F";
_man9 addMagazine "20Rnd_556x45_UW_Mag";
_man9 addMagazine "20Rnd_556x45_UW_Mag";


// Rifleman
_man10 = _group createUnit ["C_man_polo_4_F", [_pos select 0, _pos select 1, -100], [], 1, "Form"];

removeAllAssignedItems _man10;
_man10 addUniform "U_B_Wetsuit";
_man10 addVest "V_RebreatherB";
_man10 addGoggles "G_Diving";
_man10 addMagazine "20Rnd_556x45_UW_Mag";
_man10 addWeapon "arifle_SDAR_F";
_man10 addMagazine "20Rnd_556x45_UW_Mag";
_man10 addMagazine "20Rnd_556x45_UW_Mag";


// Rifleman
_man11 = _group createUnit ["C_man_polo_4_F", [_pos select 0, _pos select 1, -100], [], 1, "Form"];

removeAllAssignedItems _man11;
_man11 addUniform "U_B_Wetsuit";
_man11 addVest "V_RebreatherB";
_man11 addGoggles "G_Diving";
_man11 addMagazine "20Rnd_556x45_UW_Mag";
_man11 addWeapon "arifle_SDAR_F";
_man11 addMagazine "20Rnd_556x45_UW_Mag";
_man11 addMagazine "20Rnd_556x45_UW_Mag";


// Rifleman
_man12 = _group createUnit ["C_man_polo_4_F", [_pos select 0, _pos select 1, -100], [], 1, "Form"];

removeAllAssignedItems _man12;
_man12 addUniform "U_B_Wetsuit";
_man12 addVest "V_RebreatherB";
_man12 addGoggles "G_Diving";
_man12 addMagazine "20Rnd_556x45_UW_Mag";
_man12 addWeapon "arifle_SDAR_F";
_man12 addMagazine "20Rnd_556x45_UW_Mag";
_man12 addMagazine "20Rnd_556x45_UW_Mag";


// Rifleman
_man13= _group createUnit ["C_man_polo_4_F", [_pos select 0, _pos select 1, -100], [], 1, "Form"];

removeAllAssignedItems _man13;
_man13 addUniform "U_B_Wetsuit";
_man13 addVest "V_RebreatherB";
_man13 addGoggles "G_Diving";
_man13 addMagazine "20Rnd_556x45_UW_Mag";
_man13 addWeapon "arifle_SDAR_F";
_man13 addMagazine "20Rnd_556x45_UW_Mag";
_man13 addMagazine "20Rnd_556x45_UW_Mag";


// Rifleman
_man14= _group createUnit ["C_man_polo_4_F", [_pos select 0, _pos select 1, -100], [], 1, "Form"];

removeAllAssignedItems _man14;
_man14 addUniform "U_B_Wetsuit";
_man14 addVest "V_RebreatherB";
_man14 addGoggles "G_Diving";
_man14 addMagazine "20Rnd_556x45_UW_Mag";
_man14 addWeapon "arifle_SDAR_F";
_man14 addMagazine "20Rnd_556x45_UW_Mag";
_man14 addMagazine "20Rnd_556x45_UW_Mag";


// Rifleman
_man15= _group createUnit ["C_man_polo_4_F", [_pos select 0, _pos select 1, -100], [], 1, "Form"];

removeAllAssignedItems _man15;
_man15 addUniform "U_B_Wetsuit";
_man15 addVest "V_RebreatherB";
_man15 addGoggles "G_Diving";
_man15 addMagazine "20Rnd_556x45_UW_Mag";
_man15 addWeapon "arifle_SDAR_F";
_man15 addMagazine "20Rnd_556x45_UW_Mag";
_man15 addMagazine "20Rnd_556x45_UW_Mag";


// Rifleman
_man16= _group createUnit ["C_man_polo_4_F", [_pos select 0, _pos select 1, -100], [], 1, "Form"];

removeAllAssignedItems _man16;
_man16 addUniform "U_B_Wetsuit";
_man16 addVest "V_RebreatherB";
_man16 addGoggles "G_Diving";
_man16 addMagazine "20Rnd_556x45_UW_Mag";
_man16 addWeapon "arifle_SDAR_F";
_man16 addMagazine "20Rnd_556x45_UW_Mag";
_man16 addMagazine "20Rnd_556x45_UW_Mag";


_leader = leader _group;

{
	_x spawn refillPrimaryAmmo;
	_x call setMissionSkill;
	_x addRating 9999999;
	_x addEventHandler ["Killed", server_playerDied];
	_x call setEliteSkill;
} forEach units _group;


//[_group, _pos] call defendArea;

_leader swimInDepth -100;
