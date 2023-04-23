//	@file Version: 1.0
//	@file Name: createSquadAssault.sqf
//	@file Author: [509th] Coyote Rogue
//	@file Created: 20/02/2019 21:27

if (!isServer) exitWith {};

private ["_group", "_pos", "_nbUnits", "_unitTypes", "_uPos", "_unit"];

_group = _this select 0;
_pos = _this select 1;
_nbUnits = param [2, 7, [0]];
_radius = param [3, 10, [0]];

_unitTypes =
[
	"C_man_polo_1_F", "C_man_polo_1_F_euro", "C_man_polo_1_F_afro", "C_man_polo_1_F_asia",
	"C_man_polo_2_F", "C_man_polo_2_F_euro", "C_man_polo_2_F_afro", "C_man_polo_2_F_asia",
	"C_man_polo_3_F", "C_man_polo_3_F_euro", "C_man_polo_3_F_afro", "C_man_polo_3_F_asia",
	"C_man_polo_4_F", "C_man_polo_4_F_euro", "C_man_polo_4_F_afro", "C_man_polo_4_F_asia",
	"C_man_polo_5_F", "C_man_polo_5_F_euro", "C_man_polo_5_F_afro", "C_man_polo_5_F_asia",
	"C_man_polo_6_F", "C_man_polo_6_F_euro", "C_man_polo_6_F_afro", "C_man_polo_6_F_asia"
];

for "_i" from 1 to _nbUnits do
{
	_uPos = _pos vectorAdd ([[random _radius, 0, 0], random 360] call BIS_fnc_rotateVector2D);
	_unit = _group createUnit [(selectRandom _unitTypes), _uPos, [], 0, "Form"];
	_unit setPosATL _uPos;

	removeAllWeapons _unit;
	removeAllAssignedItems _unit;
	removeUniform _unit;
	removeVest _unit;
	removeBackpack _unit;
	removeHeadgear _unit;
	removeGoggles _unit;

	_unit addUniform "U_B_CTRG_1";
	_unit addVest "V_HarnessOSpec_brn";
	_unit addHeadgear "H_Booniehat_mcamo";
	_unit addGoggles "G_Balaclava_blk";	

	switch (true) do
	{
		// Marksman with AT every 3 units, starting from #2
		case ((_i + 2) % 4 == 0):
		{
			_unit addBackpack "B_FieldPack_ocamo";
			_unit addItem "NVGoggles";
			_unit assignItem "NVGoggles";
			_unit addMagazine "30Rnd_65x39_caseless_mag";
			_unit addWeapon "arifle_MXM_RCO_pointer_snds_F";
			_unit addPrimaryWeaponItem "optic_Hamr";
			_unit addMagazine "30Rnd_65x39_caseless_mag";
			_unit addMagazine "30Rnd_65x39_caseless_mag";
			_unit addMagazine "HandGrenade";
			_unit addMagazine "Titan_AT";
			_unit addWeapon "launch_I_Titan_short_F";
			_unit addMagazine "Titan_AT";
		};
		// Carbine with AA every 6 units, starting from #6
		case ((_i + 3) % 4 == 0):
		{
			_unit addBackpack "B_FieldPack_ocamo";
			_unit addMagazine "30Rnd_65x39_caseless_mag";
			_unit addWeapon "arifle_MX_F";
			_unit addPrimaryWeaponItem "optic_Holosight";
			_unit addMagazine "30Rnd_65x39_caseless_mag";
			_unit addMagazine "Titan_AA";
			_unit addWeapon "launch_Titan_F";
			_unit addMagazine "Titan_AA";
		};						
		// LMG every 6 units, starting from #3
		case ((_i + 4) % 3 == 0):
		{
			_unit addBackpack "B_FieldPack_ocamo";
			_unit addMagazine "130Rnd_338_Mag";
			_unit addWeapon "MMG_02_sand_F";
			_unit addPrimaryWeaponItem "optic_Holosight";
			_unit addMagazine "130Rnd_338_Mag";
			_unit addMagazine "HandGrenade";
		};
		// RPG every 6 units, starting from #3
		case ((_i + 5) % 3 == 0):
		{
			_unit addBackpack "B_FieldPack_ocamo";
			_unit addWeapon "srifle_DMR_01_F";
			_unit addPrimaryWeaponItem "optic_Holosight";
			_unit addMagazine "10Rnd_762x51_Mag";
			_unit addMagazine "10Rnd_762x51_Mag";
			_unit addMagazine "RPG7_F";
			_unit addWeapon "launch_RPG7_F";
			_unit addMagazine "RPG7_F";
			_unit addMagazine "RPG7_F";
		};
		// ASP-1 Kir Rifle every 6 units, starting from #3
		case ((_i + 6) % 2 == 0):
		{
			_unit addMagazine "10Rnd_127x54_Mag";
			_unit addWeapon "srifle_DMR_04_F";
			_unit addPrimaryWeaponItem "optic_Holosight";
			_unit addMagazine "10Rnd_127x54_Mag";
			_unit addMagazine "10Rnd_127x54_Mag";
			_unit addMagazine "HandGrenade";
		};
		// Rifleman Grenadier
		default
		{

			if (_unit == leader _group) then
			{
				_unit addBackpack "B_FieldPack_ocamo";
				_unit addMagazine "30Rnd_556x45_Stanag";
				_unit addPrimaryWeaponItem "optic_Holosight";
				_unit addMagazine "1Rnd_HE_Grenade_shell";
				_unit addWeapon "arifle_TRG21_GL_F";
				_unit addMagazine "1Rnd_HE_Grenade_shell";
				_unit addMagazine "1Rnd_HE_Grenade_shell";
				_unit addMagazine "30Rnd_556x45_Stanag";
				_unit addMagazine "30Rnd_556x45_Stanag";
				_unit addMagazine "HandGrenade";
				_unit setRank "SERGEANT";
			}
			else
			{
				_unit addBackpack "B_FieldPack_ocamo";
				_unit addMagazine "30Rnd_556x45_Stanag";
				_unit addPrimaryWeaponItem "optic_Holosight";
				_unit addMagazine "1Rnd_HE_Grenade_shell";
				_unit addWeapon "arifle_TRG21_GL_F";
				_unit addMagazine "1Rnd_HE_Grenade_shell";
				_unit addMagazine "1Rnd_HE_Grenade_shell";
				_unit addMagazine "30Rnd_556x45_Stanag";
				_unit addMagazine "30Rnd_556x45_Stanag";
			};
		};
	};

	_unit addRating 9999999;
	_unit spawn addMilCap;
	_unit spawn refillPrimaryAmmo;
	_unit call setMissionSkill2;
	_unit addEventHandler ["Killed", server_playerDied];
	_unit call setEliteSkill;	
};

[_group, _pos] call defendArea;
