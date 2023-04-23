// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. 								    *
// ******************************************************************************************
//	@file Name: createEliteSoldier.sqf
//  @file Author: [509th] Coyote Rogue
// 	@file Description: Creates a ELITE soldier with higher than normal health and skills.
// ****************************************************************************************** 

if (!isServer) exitWith {};

private ["_soldierTypes", "_group", "_position", "_rank", "_soldier", "_unit", "_selection", "_selections", "_damage", "_curDamage", "_newDamage", "_olddamage", "_gethit"];

_soldierTypes = ["C_man_polo_1_F", "C_man_polo_2_F", "C_man_polo_3_F", "C_man_polo_4_F", "C_man_polo_5_F", "C_man_polo_6_F"];

_group = _this select 0;
_position = _this select 1;
_rank = param [2, "", [""]];

_soldier = _group createUnit [_soldierTypes call BIS_fnc_selectRandom, _position, [], 0, "NONE"];
removeAllWeapons _soldier;
removeAllAssignedItems _soldier;
removeUniform _soldier;
removeVest _soldier;
removeBackpack _soldier;
removeHeadgear _soldier;
removeGoggles _soldier;

// Add special uniform & equipment;
_soldier addUniform "U_I_pilotCoveralls";
_soldier addVest "V_TacVestIR_blk";
_soldier addHeadgear "H_CrewHelmetHeli_I";
_soldier addMagazine "30Rnd_762x39_Mag_F";
_soldier addMagazine "1Rnd_HE_Grenade_shell";
_soldier addWeapon "arifle_AK12_GL_F";
_soldier addPrimaryWeaponItem "optic_ERCO_blk_F";
_soldier addMagazine "30Rnd_762x39_Mag_F";
_soldier addMagazine "30Rnd_762x39_Mag_F";
_soldier addMagazine "1Rnd_HE_Grenade_shell";

if (_rank != "") then
{
	_soldier setRank _rank;
};

// Add some body armor
		_soldier setVariable ["selections", []];
		_soldier setVariable ["gethit", []];
		_soldier addEventHandler
			[
				"HandleDamage",
				{
					_unit = _this select 0;
					_selections = _unit getVariable ["selections", []];
					_gethit = _unit getVariable ["gethit", []];
					_selection = _this select 1;
					if !(_selection in _selections) then
					{
						_selections set [count _selections, _selection];
						_gethit set [count _gethit, 0];
					};
					_i = _selections find _selection;
					_olddamage = _gethit select _i;
					_damage = _olddamage + ((_this select 2) - _olddamage) * 0.20; // The lower the number, the higher the armor
					_gethit set [_i, _damage];
					_damage;
				}
			];	
_soldier spawn refillPrimaryAmmo;
_soldier call setEliteSkill;

_soldier
