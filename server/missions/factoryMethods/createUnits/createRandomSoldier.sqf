// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. 								    *
// ******************************************************************************************
//	@file Name: createRandomSoldier.sqf
//  @file Author: Unknown
//	@file Edit: 27/6/19 by [509th] Coyote Rogue
// 	@file Description: Creates a random soldier for use in a mission.
// ****************************************************************************************** 

if (!isServer) exitWith {};

private ["_soldierTypes", "_uniformTypes", "_vestTypes", "_weaponTypes", "_group", "_position", "_rank", "_soldier", "_unit", "_selection", "_selections", "_damage", "_curDamage", "_newDamage", "_olddamage", "_gethit"];

_soldierTypes = ["C_man_polo_1_F", "C_man_polo_2_F", "C_man_polo_3_F", "C_man_polo_4_F", "C_man_polo_5_F", "C_man_polo_6_F"];
_uniformTypes = ["U_B_CombatUniform_mcam_vest", "U_B_CombatUniform_mcam_tshirt" ,"U_B_CombatUniform_mcam"];
_vestTypes = ["V_PlateCarrier1_rgr","V_PlateCarrier2_rgr"];
_weaponTypes = ["arifle_TRG20_F","LMG_Mk200_F","arifle_MXM_F","arifle_MX_GL_F"];

_group = _this select 0;
_position = _this select 1;
_rank = param [2, "", [""]];

_soldier = _group createUnit [_soldierTypes call BIS_fnc_selectRandom, _position, [], 0, "NONE"];
_soldier addUniform (_uniformTypes call BIS_fnc_selectRandom);
_soldier addVest (_vestTypes call BIS_fnc_selectRandom);
_soldier addMagazine "HandGrenade";
[_soldier, _weaponTypes call BIS_fnc_selectRandom, 3] call BIS_fnc_addWeapon;

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
					_damage = _olddamage + ((_this select 2) - _olddamage) * 0.50; // The lower the number, the higher the armor
					_gethit set [_i, _damage];
					_damage;
				}
			];	

_soldier call setMissionSkill;
_soldier spawn refillPrimaryAmmo;
_soldier spawn addMilCap;
_soldier call setEliteSkill;

_soldier
