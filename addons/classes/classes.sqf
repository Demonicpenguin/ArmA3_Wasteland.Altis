// Kit Loadouts Start here

	switch (true) do
		{
		case (["_sniper_", typeOf _player] call fn_findString != -1):
			{
			removeBackpack _player;
			removeAllWeapons _player;
			_player addBackpack "B_ViperHarness_ghex_F";
			_player forceAddUniform "U_B_T_FullGhillie_tna_F";
			_player addVest "V_TacChestrig_grn_F";
			_player addWeapon "Rangefinder";
			_player linkItem "ItemGPS";
			_player addWeapon "Laserdesignator_02_ghex_F";			
			_player addMagazine "20Rnd_650x39_Cased_Mag_F";
			_player addMagazine "20Rnd_650x39_Cased_Mag_F";
			_player addMagazine "20Rnd_650x39_Cased_Mag_F";
			_player addWeapon "srifle_DMR_07_ghex_F";
			_player addPrimaryWeaponItem "optic_DMS";
			_player addMagazine "11Rnd_45ACP_Mag";
			_player addMagazine "11Rnd_45ACP_Mag";
			_player addWeapon "hgun_Pistol_heavy_01_F";
			_player addHandgunItem "optic_MRD";
			_player addItem "APERSTripMine_Wire_Mag";
			_player addItem "APERSMine_Range_Mag";
			_player addItem "HandGrenade";
			_player addItem "HandGrenade";
			_player addItem "SmokeShell";
			_player addItem "SmokeShell";
			_player addItem "FirstAidKit";
			_player addItem "FirstAidKit";
			
			};

		case (["_diver_", typeOf _player] call fn_findString != -1):
			{
			removeBackpack _player;
			removeAllWeapons _player;
			_player addBackpack "B_ViperLightHarness_blk_F";
			_player forceAddUniform "U_I_Wetsuit";
			_player addVest "V_RebreatherIA";
			_player addGoggles "G_Diving";
			_player addWeapon "Laserdesignator_02_ghex_F";
			_player linkItem "ItemGPS";
			_player addMagazine "20Rnd_556x45_UW_mag";
			_player addMagazine "20Rnd_556x45_UW_mag";
			_player addMagazine "20Rnd_556x45_UW_mag";
			_player addWeapon "arifle_SDAR_F";
			_player addMagazine "11Rnd_45ACP_Mag";
			_player addMagazine "11Rnd_45ACP_Mag";
			_player addWeapon "hgun_Pistol_heavy_01_F";
			_player addHandgunItem "optic_MRD";
			_player addItem "HandGrenade";
			_player addItem "HandGrenade";
			_player addItem "SmokeShellYellow";
			_player addItem "SmokeShellYellow";
			_player addItem "SmokeShell";
			_player addItem "SmokeShell";
			_player addItemToBackpack "IEDLandSmall_Remote_Mag";
			_player addItemToBackpack "IEDUrbanSmall_Remote_Mag";
			_player addItem "FirstAidKit";
			_player addItem "FirstAidKit";
			};

		case (["_medic_", typeOf _player] call fn_findString != -1):
			{
			removeBackpack _player;
			removeAllWeapons _player;
			_player addBackpack "B_Kitbag_sgg";
			_player forceAddUniform "U_B_CTRG_1";
			_player addVest "V_PlateCarrierH_CTRG";
			_player addHeadgear "H_Cap_blk";
			_player addGoggles "G_Bandanna_beast";
			_player addWeapon "Laserdesignator_02_ghex_F";
			_player linkItem "ItemGPS";
			_player addMagazine "30Rnd_580x42_Mag_F";
			_player addMagazine "30Rnd_580x42_Mag_F";
			_player addMagazine "30Rnd_580x42_Mag_F";
			_player addWeapon "arifle_CTAR_blk_F";
			_player addPrimaryWeaponItem "acc_pointer_IR";
			_player addPrimaryWeaponItem "optic_Hamr";
			_player addMagazine "11Rnd_45ACP_Mag";
			_player addMagazine "11Rnd_45ACP_Mag";
			_player addWeapon "hgun_Pistol_heavy_01_F";
			_player addHandgunItem "optic_MRD";
			_player addItem "HandGrenade";
			_player addItem "HandGrenade";
			_player addItem "SmokeShell";
			_player addItem "SmokeShell";
			_player addItem "FirstAidKit";
			_player addItem "FirstAidKit";
            };

		case (["_engineer_", typeOf _player] call fn_findString != -1):
			{
			removeBackpack _player;
			removeAllWeapons _player;
			_player addBackpack "B_Carryall_mcamo";
			_player forceAddUniform "U_I_CombatUniform_shortsleeve";
			_player addVest "V_PlateCarrierSpec_blk";
			_player addMagazine "30Rnd_545x39_Mag_F";
			_player addMagazine "30Rnd_545x39_Mag_F";
			_player addMagazine "30Rnd_545x39_Mag_F";
			_player addWeapon "arifle_AKS_F";
			_player addItem "HandGrenade";
			_player addItem "HandGrenade";
			_player addItem "SmokeShell";
			_player addItem "SmokeShell";
			_player addMagazine "RPG32_F";
			_player addMagazine "RPG32_F";
			_player addWeapon "launch_RPG32_ghex_F";
			_player addMagazine "11Rnd_45ACP_Mag";
			_player addMagazine "11Rnd_45ACP_Mag";
			_player addWeapon "hgun_Pistol_heavy_01_F";
			_player addHandgunItem "optic_MRD";
			_player addItem "Toolkit";
			_player addItem "MineDetector";
			_player addWeapon "Laserdesignator_02_ghex_F";
			_player addItem "FirstAidKit";
			_player addItem "FirstAidKit";
			_player addItem "SLAMDirectionalMine_Wire_Mag";
			_player addItem "ClaymoreDirectionalMine_Remote_Mag";
			_player addHeadgear "H_Cap_blk_Raven";
			_player addGoggles "G_Bandanna_beast";
			_player linkItem "ItemGPS";
			};

		case (["_crew_", typeOf _player] call fn_findString != -1):
			{
			removeBackpack _player;
			removeAllWeapons _player;
			_player addVest "V_HarnessOGL_gry";
			_player forceAddUniform "U_I_G_resistanceLeader_F";
			_player addBackpack "B_AssaultPack_cbr";
			_player addItemToVest "MineDetector";
			_player addItemtoBackpack "SatchelCharge_Remote_Mag";
			_player addItemtoBackpack "SatchelCharge_Remote_Mag";
			_player addItemtoBackpack "SatchelCharge_Remote_Mag";
			_player addMagazine "6Rnd_45ACP_Cylinder";
			_player addMagazine "6Rnd_45ACP_Cylinder";
			_player addMagazine "6Rnd_45ACP_Cylinder";
			_player addWeapon "hgun_Pistol_heavy_02_F";
			_player addHeadgear "H_ShemagOpen_tan";
			};


			case (["_soldier_", typeOf _player] call fn_findString != -1):
			{
			removeBackpack _player;
			removeAllWeapons _player;
			_player addVest "V_Chestrig_khk";
			_player addBackpack "B_Kitbag_cbr";
			_player forceAddUniform "U_OrestesBody";
			_player addItemtoBackpack "DemoCharge_Remote_Mag";
			_player addItemtoBackpack "DemoCharge_Remote_Mag";
			_player addItem "MiniGrenade";
			_player addItem "MiniGrenade";
			_player addItem "FirstAidKit";
			_player addItem "FirstAidKit";
			_player addItemtoBackpack "APERSMine_Range_Mag";
			_player addItemtoBackpack "APERSMine_Range_Mag";
			_player addItemtoBackpack "ATMine_Range_Mag";
			_player addItemtoBackpack "SLAMDirectionalMine_Wire_Mag";
			_player addItemtoBackpack "SLAMDirectionalMine_Wire_Mag";
			_player addMagazine "30Rnd_65x39_caseless_mag";
			_player addMagazine "30Rnd_65x39_caseless_mag";
			_player addMagazine "30Rnd_65x39_caseless_mag";
			_player addWeapon "arifle_MXC_F";
			_player addPrimaryWeaponItem "optic_Holosight";
			};


			case (["_officer_", typeOf _player] call fn_findString != -1):
			{
			removeBackpack _player;
			removeAllWeapons _player;
			_player addVest "V_PlateCarrier1_blk";
			_player addBackpack "B_AssaultPack_blk";
			_player forceAddUniform "U_B_PilotCoveralls";
			_player addItem "SmokeShellYellow";
			_player addItem "SmokeShellYellow";
			_player addItem "SmokeShellYellow";
			_player addItem "SmokeShellYellow";
			_player addItem "FirstAidKit";
			_player addItem "FirstAidKit";
			_player addMagazine "130Rnd_338_Mag";
			_player addWeapon "MMG_02_black_F";
			_player addPrimaryWeaponItem "optic_aco_smg";
			_player addPrimaryWeaponItem "bipod_01_F_blk";
			_player addHeadgear "H_PilotHelmetFighter_B";
			};

			default
			{};
		};
