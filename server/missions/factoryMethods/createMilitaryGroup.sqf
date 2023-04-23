// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: createMilitarySquad.sqf
//	@file Author: Nurdism
if (!isServer) exitWith {};

private ["_group", "_pos", "_nbUnits", "_unitTypes", "_uniformTypes", "_vestTypes", "_weaponTypes", "_uPos", "_unit"];

_group = _this select 0;
_pos = _this select 1;
_nbUnits = param [2, 7, [0]];
_radius = param [3, 10, [0]];

_unitTypes = ["C_man_polo_1_F", "C_man_polo_2_F", "C_man_polo_3_F", "C_man_polo_4_F", "C_man_polo_5_F", "C_man_polo_6_F"];
_uniformTypes = ["U_B_CombatUniform_mcam_vest", "U_B_CombatUniform_mcam_tshirt" ,"U_B_CombatUniform_mcam"];
_vestTypes = ["V_PlateCarrier1_rgr","V_PlateCarrier2_rgr"];
_weaponTypes = ["arifle_TRG20_F","LMG_Mk200_F","arifle_MXM_F","arifle_MX_GL_F"];

for "_i" from 1 to _nbUnits do {
	_uPos = _pos vectorAdd ([[random _radius, 0, 0], random 360] call BIS_fnc_rotateVector2D);
	_unit = _group createUnit [_unitTypes call BIS_fnc_selectRandom, _uPos, [], 0, "Form"];
	_unit setPosATL _uPos;

	removeAllWeapons _unit;
	removeAllAssignedItems _unit;
	removeUniform _unit;
	removeVest _unit;

	_unit addVest (_vestTypes call BIS_fnc_selectRandom);
	_unit addUniform (_uniformTypes call BIS_fnc_selectRandom);

	switch (true) do
	{
		// Grenadier every 3 units
		case (_i % 3 == 0):	{
			[_unit, "arifle_TRG21_GL_F", 4] call BIS_fnc_addWeapon;
			_unit addMagazine "1Rnd_HE_Grenade_shell";
			_unit addMagazine "1Rnd_HE_Grenade_shell";
			_unit addMagazine "1Rnd_HE_Grenade_shell";
		};

    // AT every 5 units
		case (_i % 5 == 0): {
			removeBackpack _unit;
			_unit addBackpack "B_Carryall_oli";
			[_unit, "arifle_MXM_Black_F", 4] call BIS_fnc_addWeapon;
			_unit addPrimaryWeaponItem "optic_Hamr";
			_unit addMagazine "Titan_AT";
			_unit addWeapon "launch_Titan_short_F";
			_unit addMagazine "Titan_AT";
			_unit addMagazine "Titan_AT";
			_unit selectWeapon "launch_Titan_short_F";
		};

		// Sniper every 6 units
		case (_i % 6 == 0): {
			[_unit, "srifle_LRR_SOS_F", 4] call BIS_fnc_addWeapon;
			_unit addPrimaryWeaponItem "optic_tws";
		};

		// AA every 7 units
		case (_i % 7 == 0): {
			removeBackpack _unit;
			_unit addBackpack "B_Carryall_oli";
			[_unit, "arifle_MXM_Black_F", 4] call BIS_fnc_addWeapon;
			_unit addPrimaryWeaponItem "optic_Hamr";
			_unit addMagazine "Titan_AA";
			_unit addWeapon "launch_I_Titan_F";
			_unit addMagazine "Titan_AA";
			_unit addMagazine "Titan_AA";
			_unit selectWeapon "launch_I_Titan_F";
		};

		// Rifleman
		default {
			if (_unit == leader _group) then {
				[_unit, "arifle_MXM_Black_F", 4] call BIS_fnc_addWeapon;
				_unit setRank "SERGEANT";
			} else {
				[_unit, (_weaponTypes call BIS_fnc_selectRandom), 4] call BIS_fnc_addWeapon;
			};
		};
	};

	_unit addPrimaryWeaponItem "acc_flashlight";
	_unit enablegunlights "forceOn";

	_unit addRating 1e11;
	_unit spawn refillPrimaryAmmo;
	_unit call setMissionSkill;
	_unit addEventHandler ["Killed", server_playerDied];
};
