/*******************************************************************************************
* This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com
********************************************************************************************
* @file Name: STFillSniperCrate.sqf
* @author: The Scotsman
*
* Loads a specialty sniper crate with random (and rare) sniper items
* Arguments: [ _box ]:
*
*/
#include "..\..\..\STConstants.h"

if (!isServer) exitWith {};

params ["_box"];

private _isVehicle = (_box isKindOf "AllVehicles");

_box allowDamage false;
_box setVariable [call vChecksum, true];
_box setVariable ["allowDamage", _isVehicle, true];
_box setVariable ["A3W_inventoryLockR3F", !_isVehicle, true];

//Ensure Empty
clearBackpackCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearWeaponCargoGlobal _box;
clearItemCargoGlobal _box;

_loadCrateAmount = 0;
_loadCrateWithWhat = "";

_backPacks = [
	"B_AssaultPack_blk", // Assault Pack (Black)
	"B_AssaultPack_dgtl", // Assault Pack (Digi)
	"B_AssaultPack_khk", // Assault Pack (Khaki)
	"B_AssaultPack_mcamo", // Assault Pack (MTP)
	"B_AssaultPack_ocamo", // Assault Pack (Hex)
	"B_AssaultPack_rgr", // Assault Pack (Green)
	"B_AssaultPack_sgg", // Assault Pack (Sage)
	"B_AssaultPack_tna_F", // Assault Pack (Tropic)
	"B_Carryall_cbr", // Carryall Backpack (Coyote)
	"B_Carryall_ghex_F", // Carryall Backpack (Green Hex)
	"B_FieldPack_blk", // Field Pack (Black)
	"B_FieldPack_ocamo", // Field Pack (Hex)
	"B_FieldPack_oli", // Field Pack (Olive)
	"B_FieldPack_oucamo", // Field Pack (Urban)
	"B_TacticalPack_blk", // Tactical Backpack (Black)
	"B_TacticalPack_mcamo", // Tactical Backpack (MTP)
	"B_TacticalPack_oli", // Tactical Backpack (Olive)
	"B_TacticalPack_rgr", // Tactical Backpack (Green)
	"B_UAV_01_backpack_F", // UAV Bag [NATO]
	"I_UAV_01_backpack_F", // UAV Bag [AAF]
	"O_UAV_01_backpack_F" // UAV Bag [CSAT]
];

_binoculars = [
	"Laserdesignator", // Laser Designator (Sand) BINOCULAR"
	"Laserdesignator_01_khk_F", // Laser Designator (Khaki) BINOCULAR"
	"Laserdesignator_02", // Laser Designator (Hex) BINOCULAR"
	"Laserdesignator_02_ghex_F", // Laser Designator (Green Hex) BINOCULAR"
	"Laserdesignator_03", // Laser Designator (Olive) BINOCULAR"
	"O_NVGoggles_ghex_F", // Compact NVG (Green Hex) BINOCULAR"
	"O_NVGoggles_hex_F", // Compact NVG (Hex) BINOCULAR"
	"O_NVGoggles_urb_F", // Compact NVG (Urban) BINOCULAR"
	"Rangefinder" // Rangefinder BINOCULAR"
];

_bipods = [
	"bipod_01_F_blk", // Bipod (Black) [NATO] BIPOD"
	"bipod_01_F_khk", // Bipod (Khaki) [NATO] BIPOD"
	"bipod_01_F_mtp", // Bipod (MTP) [NATO] BIPOD"
	"bipod_01_F_snd", // Bipod (Sand) [NATO] BIPOD"
	"bipod_02_F_blk", // Bipod (Black) [CSAT] BIPOD"
	"bipod_02_F_hex", // Bipod (Hex) [CSAT] BIPOD"
	"bipod_02_F_tan", // Bipod (Tan) [CSAT] BIPOD"
	"bipod_03_F_blk", // Bipod (Black) [AAF] BIPOD"
	"bipod_03_F_oli" // Bipod (Olive) [AAF] BIPOD"
];

_headGear = [
	"H_Beret_02", // Beret [NATO]
	"H_Beret_blk", // Beret (Black)
	"H_Beret_Colonel", // Beret [NATO] (Colonel)
	"H_Beret_gen_F", // Beret (Gendarmerie)
	"H_Booniehat_dgtl", // Booniehat [AAF]
	"H_Booniehat_khk", // Booniehat (Khaki)
	"H_Booniehat_khk_hs", // Booniehat (Headset)
	"H_Booniehat_mcamo", // Booniehat (MTP)
	"H_Booniehat_oli", // Booniehat (Olive)
	"H_Booniehat_tan", // Booniehat (Sand)
	"H_Booniehat_tna_F", // Booniehat (Tropic)
	"H_Cap_blk", // Cap (Black)
	"H_Cap_blk_CMMG", // Cap (CMMG)
	"H_Cap_blk_ION", // Cap (ION)
	"H_Cap_blk_Raven", // Cap [AAF]
	"H_Cap_blu", // Cap (Blue)
	"H_Cap_brn_SPECOPS", // Cap [OPFOR]
	"H_Cap_grn", // Cap (Green)
	"H_Cap_grn_BI", // Cap (BI)
	"H_Cap_headphones", // Rangemaster Cap
	"H_HelmetB", // Combat Helmet
	"H_HelmetB_black", // Combat Helmet (Black)
	"H_HelmetB_camo", // Combat Helmet (Camo)
	"H_HelmetB_desert", // Combat Helmet (Desert)
	"H_HelmetB_Enh_tna_F", // Enhanced Combat Helmet (Tropic)
	"H_HelmetB_grass", // Combat Helmet (Grass)
	"H_HelmetB_light_black", // Light Combat Helmet (Black)
	"H_HelmetB_light_desert", // Light Combat Helmet (Desert)
	"H_HelmetB_light_grass", // Light Combat Helmet (Grass)
	"H_HelmetB_light_sand", // Light Combat Helmet (Sand)
	"H_HelmetB_light_snakeskin", // Light Combat Helmet (Snakeskin)
	"H_HelmetB_Light_tna_F", // Light Combat Helmet (Tropic)
	"H_HelmetB_sand", // Combat Helmet (Sand)
	"H_HelmetB_snakeskin", // Combat Helmet (Snakeskin)
	"H_HelmetB_TI_tna_F", // Stealth Combat Helmet
	"H_HelmetB_tna_F", // Combat Helmet (Tropic)
	"H_HelmetSpecB", // Enhanced Combat Helmet
	"H_HelmetSpecB_blk", // Enhanced Combat Helmet (Black)
	"H_HelmetSpecB_sand", // Enhanced Combat Helmet (Sand)
	"H_HelmetSpecO_blk", // Assassin Helmet (Black)
	"H_HelmetSpecO_ghex_F", // Assassin Helmet (Green Hex)
	"H_HelmetSpecO_ocamo", // Assassin Helmet (Hex)
	"H_Helmet_Skate", // Skate Helmet
	"H_MilCap_blue", // Military Cap (Blue)
	"H_MilCap_dgtl", // Military Cap [AAF]
	"H_MilCap_gen_F", // Military Cap (Gendarmerie)
	"H_MilCap_ghex_F", // Military Cap (Green Hex)
	"H_MilCap_gry", // Military Cap (Grey)
	"H_MilCap_mcamo", // Military Cap (MTP)
	"H_MilCap_ocamo", // Military Cap (Hex)
	"H_MilCap_tna_F", // Military Cap (Tropic)
	"H_Watchcap_blk", // Beanie
	"H_Watchcap_camo", // Beanie (Green)
	"H_Watchcap_cbr", // Beanie (Coyote)
	"H_Watchcap_khk" // Beanie (Khaki)
];

_items = [
	"B_UavTerminal", // UAV Terminal [NATO]
	"FirstAidKit", // First Aid Kit
	"FirstAidKit", // First Aid Kit
	"FirstAidKit", // First Aid Kit
	"FirstAidKit", // First Aid Kit
	"ItemGPS", // GPS
	"I_UavTerminal", // UAV Terminal [AAF]
	"Medikit", // Medikit
	"Medikit", // Medikit
	"O_UavTerminal", // UAV Terminal [CSAT]
	"ToolKit",// Toolkit
	"ToolKit"// Toolkit
];

_magazines = [
	"100Rnd_580x42_Mag_F", // 5.8 mm 100Rnd Mag
	"100Rnd_580x42_Mag_Tracer_F", // 5.8 mm 100Rnd Tracer (Green) Mag
	"100Rnd_65x39_caseless_mag", // 6.5 mm 100Rnd Mag
	"100Rnd_65x39_caseless_mag_Tracer", // 6.5 mm 100Rnd Tracer (Red) Mag
	"10Rnd_127x54_Mag", // 12.7mm 10Rnd Mag
	"10Rnd_338_Mag", // .338 LM 10Rnd Mag
	"10Rnd_50BW_Mag_F", // .50 BW 10Rnd Caseless Mag
	"10Rnd_762x51_Mag", // 7.62mm 10Rnd Mag
	"10Rnd_762x54_Mag", // 7.62mm 10Rnd Mag
	"10Rnd_93x64_DMR_05_Mag", // 9.3mm 10Rnd Mag
	"10Rnd_9x21_Mag", // 9 mm 10Rnd Mag
	"11Rnd_45ACP_Mag", // .45 ACP 11Rnd Mag
	"130Rnd_338_Mag", // .338 NM 130Rnd Belt
	"150Rnd_556x45_Drum_Mag_F", // 5.56 mm 150Rnd Mag
	"150Rnd_556x45_Drum_Mag_Tracer_F", // 5.56 mm 150Rnd Tracer (Red) Mag
	"150Rnd_762x51_Box", // 7.62 mm 150Rnd Box
	"150Rnd_762x51_Box_Tracer", // 7.62 mm 150Rnd Tracer (Green) Box
	"150Rnd_762x54_Box", // 7.62 mm 150Rnd Box
	"150Rnd_762x54_Box_Tracer", // 7.62 mm 150Rnd Tracer (Green) Box
	"150Rnd_93x64_Mag", // 9.3mm 150Rnd Belt
	"16Rnd_9x21_green_Mag", // 9 mm 16Rnd Reload Tracer (Green) Mag
	"16Rnd_9x21_Mag", // 9 mm 16Rnd Mag
	"16Rnd_9x21_red_Mag", // 9 mm 16Rnd Reload Tracer (Red) Mag
	"16Rnd_9x21_yellow_Mag", // 9 mm 16Rnd Reload Tracer (Yellow) Mag
	"1Rnd_HE_Grenade_shell", // 40 mm HE Grenade Round
	"1Rnd_SmokeRed_Grenade_shell", // Smoke Round (Red)
	"1Rnd_SmokeYellow_Grenade_shell", // Smoke Round (Yellow)
	"1Rnd_Smoke_Grenade_shell", // Smoke Round (White)
	"200Rnd_556x45_Box_F", // 5.56 mm 200Rnd Reload Tracer (Yellow) Box
	"200Rnd_556x45_Box_Red_F", // 5.56 mm 200Rnd Reload Tracer (Red) Box
	"200Rnd_556x45_Box_Tracer_F", // 5.56 mm 200Rnd Tracer (Yellow) Box
	"200Rnd_556x45_Box_Tracer_Red_F", // 5.56 mm 200Rnd Tracer (Red) Box
	"200Rnd_65x39_cased_Box", // 6.5 mm 200Rnd Belt
	"200Rnd_65x39_cased_Box_Tracer", // 6.5 mm 200Rnd Belt Tracer (Yellow)
	"20Rnd_556x45_UW_mag", // 5.56 mm 20Rnd Dual Purpose Mag
	"20Rnd_650x39_Cased_Mag_F", // 6.5 mm 20Rnd Mag
	"20Rnd_762x51_Mag", // 7.62 mm 20Rnd Mag
	"30Rnd_45ACP_Mag_SMG_01", // .45 ACP 30Rnd Vermin Mag
	"30Rnd_45ACP_Mag_SMG_01_Tracer_Green", // .45 ACP 30Rnd Vermin Tracers (Green) Mag
	"30Rnd_45ACP_Mag_SMG_01_Tracer_Red", // .45 ACP 30Rnd Vermin Tracers (Red) Mag
	"30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow", // .45 ACP 30Rnd Vermin Tracers (Yellow) Mag
	"30Rnd_545x39_Mag_F", // 5.45 mm 30Rnd Reload Tracer (Yellow) Mag
	"30Rnd_545x39_Mag_Green_F", // 5.45 mm 30Rnd Reload Tracer (Green) Mag
	"30Rnd_545x39_Mag_Tracer_F", // 5.45 mm 30Rnd Tracer (Yellow) Mag
	"30Rnd_545x39_Mag_Tracer_Green_F", // 5.45 mm 30Rnd Tracer (Green) Mag
	"30Rnd_556x45_Stanag", // 5.56 mm 30rnd STANAG Reload Tracer (Yellow) Mag
	"30Rnd_556x45_Stanag_green", // 5.56 mm 30rnd STANAG Reload Tracer (Green) Mag
	"30Rnd_556x45_Stanag_red", // 5.56 mm 30rnd STANAG Reload Tracer (Red) Mag
	"30Rnd_556x45_Stanag_Tracer_Green", // 5.56 mm 30rnd Tracer (Green) Mag
	"30Rnd_556x45_Stanag_Tracer_Red", // 5.56 mm 30rnd Tracer (Red) Mag
	"30Rnd_556x45_Stanag_Tracer_Yellow", // 5.56 mm 30rnd Tracer (Yellow) Mag
	"30Rnd_580x42_Mag_F", // 5.8 mm 30Rnd Mag
	"30Rnd_580x42_Mag_Tracer_F", // 5.8 mm 30Rnd Tracer (Green) Mag
	"30Rnd_65x39_caseless_green", // 6.5mm 30Rnd Caseless Mag
	"30Rnd_65x39_caseless_green_mag_Tracer", // 6.5 mm 30Rnd Tracer (Green) Caseless Mag
	"30Rnd_65x39_caseless_mag", // 6.5 mm 30Rnd STANAG Mag
	"30Rnd_65x39_caseless_mag_Tracer", // 6.5 mm 30Rnd Tracer (Red) Mag
	"30Rnd_762x39_Mag_F", // 7.62 mm 30Rnd Reload Tracer (Yellow) Mag
	"30Rnd_762x39_Mag_Green_F", // 7.62 mm 30Rnd Reload Tracer (Green) Mag
	"30Rnd_762x39_Mag_Tracer_F", // 7.62 mm 30Rnd Tracer (Yellow) Mag
	"30Rnd_762x39_Mag_Tracer_Green_F", // 7.62 mm 30Rnd Tracer (Green) Mag
	"30Rnd_9x21_Green_Mag", // 9 mm 30Rnd Reload Tracer (Green) Mag
	"30Rnd_9x21_Mag", // 9 mm 30Rnd Mag
	"30Rnd_9x21_Mag_SMG_02", // 9 mm 30Rnd Mag
	"30Rnd_9x21_Mag_SMG_02_Tracer_Green", // 9 mm 30Rnd Reload Tracer (Green) Mag
	"30Rnd_9x21_Mag_SMG_02_Tracer_Red", // 9 mm 30Rnd Reload Tracer (Red) Mag
	"30Rnd_9x21_Mag_SMG_02_Tracer_Yellow", // 9 mm 30Rnd Reload Tracer (Yellow) Mag
	"30Rnd_9x21_Red_Mag", // 9 mm 30Rnd Reload Tracer (Red) Mag
	"30Rnd_9x21_Yellow_Mag", // 9 mm 30Rnd Reload Tracer (Yellow) Mag
	"3Rnd_HE_Grenade_shell", // 40 mm 3Rnd HE Grenade
	"3Rnd_SmokeYellow_Grenade_shell", // 3Rnd 3GL Smoke Rounds (Yellow)
	"3Rnd_UGL_FlareCIR_F", // 3Rnd 3GL Flares (IR)
	"3Rnd_UGL_FlareWhite_F", // 3Rnd 3GL Flares (White)
	"5Rnd_127x108_APDS_Mag", // 12.7mm 5Rnd APDS Mag
	"5Rnd_127x108_Mag", // 12.7 mm 5Rnd Mag
	"6Rnd_45ACP_Cylinder", // .45 ACP 6Rnd Cylinder
	"6Rnd_GreenSignal_F", // 6Rnd Signal Cylinder (Green)
	"6Rnd_RedSignal_F", // 6Rnd Signal Cylinder (Red)
	"7Rnd_408_Mag", // .408 7Rnd LRR Mag
	"9Rnd_45ACP_Mag", // .45 ACP 9Rnd Mag
  "rhsusf_mag_10Rnd_STD_50BMG_M33",
  "rhsusf_5Rnd_300winmag_xm2010",
  "rhsusf_5Rnd_762x51_AICS_m118_special_Mag",
  "rhsusf_5Rnd_300winmag_xm2010",
  "rhsusf_5Rnd_762x51_m118_special_Mag"
];

_throwables = [
	"HandGrenade", // RGO Grenade
	"HandGrenade", // RGO Grenade
	"MiniGrenade", // RGN Grenade
	"MiniGrenade", // RGN Grenade
	"SmokeShellBlue", // Smoke Grenade (Blue)
	"SmokeShellGreen", // Smoke Grenade (Green)
	"SmokeShellRed", // Smoke Grenade (Red)
	"SmokeShellYellow" // Smoke Grenade (Yellow)
];

_muzzles = [
	"muzzle_snds_338_black", // Sound Suppressor (.338, Black)
	"muzzle_snds_338_green", // Sound Suppressor (.338, Green)
	"muzzle_snds_338_sand", // Sound Suppressor (.338, Sand)
	"muzzle_snds_58_blk_F", // Stealth Sound Suppressor (5.8 mm, Black)
	"muzzle_snds_58_ghex_F", // Stealth Sound Suppressor (5.8 mm, Green Hex)
	"muzzle_snds_58_hex_F", // Sound Suppressor (5.8 mm, Hex)
	"muzzle_snds_65_TI_blk_F", // Stealth Sound Suppressor (6.5 mm, Black)
	"muzzle_snds_65_TI_ghex_F", // Stealth Sound Suppressor (6.5 mm, Green Hex)
	"muzzle_snds_65_TI_hex_F", // Stealth Sound Suppressor (6.5 mm, Hex)
	"muzzle_snds_93mmg", // Sound Suppressor (9.3mm, Black)
	"muzzle_snds_93mmg_tan", // Sound Suppressor (9.3mm, Tan)
	"muzzle_snds_acp", // Sound Suppressor (.45 ACP)
	"muzzle_snds_B", // Sound Suppressor (7.62 mm)
	"muzzle_snds_B_khk_F", // Sound Suppressor (7.62 mm, Khaki)
	"muzzle_snds_B_snd_F", // Sound Suppressor (7.62 mm, Sand)
	"muzzle_snds_H", // Sound Suppressor (6.5 mm)
	"muzzle_snds_H_khk_F", // Sound Suppressor (6.5 mm, Khaki)
	"muzzle_snds_H_snd_F", // Sound Suppressor (6.5 mm, Sand)
	"muzzle_snds_L", // Sound Suppressor (9 mm)
	"muzzle_snds_M", // Sound Suppressor (5.56 mm)
	"muzzle_snds_m_khk_F", // Sound Suppressor (5.56 mm, Khaki)
	"muzzle_snds_m_snd_F" // Sound Suppressor (5.56 mm, Sand)
];

_optics = [
	"optic_KHS_blk", // Kahlia (Black)
	"optic_KHS_hex", // Kahlia (Hex)
	"optic_KHS_old", // Kahlia (Old)
	"optic_KHS_tan", // Kahlia (Tan)
	"optic_LRPS", // LRPS
	"optic_LRPS_ghex_F", // LRPS (Green Hex)
	"optic_LRPS_tna_F", // LRPS (Tropic)
	"optic_MRCO", // MRCO
	"optic_MRD", // MRD
	"optic_Nightstalker", // Nightstalker
	"optic_NVS", // NVS
	"optic_SOS", // MOS
	"optic_SOS_khk_F", // MOS (Khaki)
	"optic_tws", // TWS
	"optic_tws_mg", // TWS MG
	"optic_Yorris" // Yorris J2
];

_primaryWeapons = [
	"srifle_DMR_01_ACO_F", // Rahim 7.62 mm
	"srifle_DMR_01_ARCO_F", // Rahim 7.62 mm
	"srifle_DMR_01_DMS_BI_F", // Rahim 7.62 mm
	"srifle_DMR_01_DMS_F", // Rahim 7.62 mm
	"srifle_DMR_01_DMS_snds_BI_F", // Rahim 7.62 mm
	"srifle_DMR_01_DMS_snds_F", // Rahim 7.62 mm
	"srifle_DMR_01_F", // Rahim 7.62 mm
	"srifle_DMR_01_MRCO_F", // Rahim 7.62 mm
	"srifle_DMR_01_SOS_F", // Rahim 7.62 mm
	"srifle_DMR_02_ACO_F", // MAR-10 .338 (Black)
	"srifle_DMR_02_ARCO_F", // MAR-10 .338 (Black)
	"srifle_DMR_02_camo_AMS_LP_F", // MAR-10 .338 (Camo)
	"srifle_DMR_02_camo_F", // MAR-10 .338 (Camo)
	"srifle_DMR_02_DMS_F", // MAR-10 .338 (Black)
	"srifle_DMR_02_F", // MAR-10 .338 (Black)
	"srifle_DMR_02_MRCO_F", // MAR-10 .338 (Black)
	"srifle_DMR_02_sniper_AMS_LP_S_F", // MAR-10 .338 (Sand)
	"srifle_DMR_02_sniper_F", // MAR-10 .338 (Sand)
	"srifle_DMR_02_SOS_F", // MAR-10 .338 (Black)
	"srifle_DMR_03_ACO_F", // Mk-I EMR 7.62 mm (Black)
	"srifle_DMR_03_AMS_F", // Mk-I EMR 7.62 mm (Black)
	"srifle_DMR_03_ARCO_F", // Mk-I EMR 7.62 mm (Black)
	"srifle_DMR_03_DMS_F", // Mk-I EMR 7.62 mm (Black)
	"srifle_DMR_03_DMS_snds_F", // Mk-I EMR 7.62 mm (Black)
	"srifle_DMR_03_F", // Mk-I EMR 7.62 mm (Black)
	"srifle_DMR_03_khaki_F", // Mk-I EMR 7.62 mm (Khaki)
	"srifle_DMR_03_MRCO_F", // Mk-I EMR 7.62 mm (Black)
	"srifle_DMR_03_multicam_F", // Mk-I EMR 7.62 mm (Camo)
	"srifle_DMR_03_SOS_F", // Mk-I EMR 7.62 mm (Black)
	"srifle_DMR_03_tan_AMS_LP_F", // Mk-I EMR 7.62 mm (Sand)
	"srifle_DMR_03_tan_F", // Mk-I EMR 7.62 mm (Sand)
	"srifle_DMR_03_woodland_F", // Mk-I EMR 7.62 mm (Woodland)
	"srifle_DMR_04_ACO_F", // ASP-1 Kir 12.7 mm (Black)
	"srifle_DMR_04_ARCO_F", // ASP-1 Kir 12.7 mm (Black)
	"srifle_DMR_04_DMS_F", // ASP-1 Kir 12.7 mm (Black)
	"srifle_DMR_04_F", // ASP-1 Kir 12.7 mm (Black)
	"srifle_DMR_04_MRCO_F", // ASP-1 Kir 12.7 mm (Black)
	"srifle_DMR_04_NS_LP_F", // ASP-1 Kir 12.7 mm (Black)
	"srifle_DMR_04_SOS_F", // ASP-1 Kir 12.7 mm (Black)
	"srifle_DMR_04_Tan_F", // ASP-1 Kir 12.7 mm (Tan)
	"srifle_DMR_05_ACO_F", // Cyrus 9.3 mm (Black)
	"srifle_DMR_05_ARCO_F", // Cyrus 9.3 mm (Black)
	"srifle_DMR_05_blk_F", // Cyrus 9.3 mm (Black)
	"srifle_DMR_05_DMS_F", // Cyrus 9.3 mm (Black)
	"srifle_DMR_05_DMS_snds_F", // Cyrus 9.3 mm (Black)
	"srifle_DMR_05_hex_F", // Cyrus 9.3 mm (Hex)
	"srifle_DMR_05_KHS_LP_F", // Cyrus 9.3 mm (Black)
	"srifle_DMR_05_MRCO_F", // Cyrus 9.3 mm (Black)
	"srifle_DMR_05_SOS_F", // Cyrus 9.3 mm (Black)
	"srifle_DMR_05_tan_f", // Cyrus 9.3 mm (Tan)
	"srifle_DMR_06_camo_F", // Mk14 7.62 mm (Camo)
	"srifle_DMR_06_camo_khs_F", // Mk14 7.62 mm (Camo)
	"srifle_DMR_06_olive_F", // Mk14 7.62 mm (Olive)
	"srifle_DMR_07_blk_DMS_F", // CMR-76 6.5 mm (Black)
	"srifle_DMR_07_blk_DMS_Snds_F", // CMR-76 6.5 mm (Black)
	"srifle_DMR_07_blk_F", // CMR-76 6.5 mm (Black)
	"srifle_DMR_07_ghex_F", // CMR-76 6.5 mm (Green Hex)
	"srifle_DMR_07_hex_F", // CMR-76 6.5 mm (Hex)
	"srifle_EBR_ACO_F", // Mk18 ABR 7.62 mm
	"srifle_EBR_ARCO_pointer_F", // Mk18 ABR 7.62 mm
	"srifle_EBR_ARCO_pointer_snds_F", // Mk18 ABR 7.62 mm
	"srifle_EBR_DMS_F", // Mk18 ABR 7.62 mm
	"srifle_EBR_DMS_pointer_snds_F", // Mk18 ABR 7.62 mm
	"srifle_EBR_F", // Mk18 ABR 7.62 mm
	"srifle_EBR_Hamr_pointer_F", // Mk18 ABR 7.62 mm
	"srifle_EBR_MRCO_LP_BI_F", // Mk18 ABR 7.62 mm
	"srifle_EBR_MRCO_pointer_F", // Mk18 ABR 7.62 mm
	"srifle_EBR_SOS_F", // Mk18 ABR 7.62 mm
	"srifle_GM6_camo_F", // GM6 Lynx 12.7 mm (Camo)
	"srifle_GM6_camo_LRPS_F", // GM6 Lynx 12.7 mm (Camo)
	"srifle_GM6_camo_SOS_F", // GM6 Lynx 12.7 mm (Camo)
	"srifle_GM6_F", // GM6 Lynx 12.7 mm
	"srifle_GM6_ghex_F", // GM6 Lynx 12.7 mm (Green Hex)
	"srifle_GM6_ghex_LRPS_F", // GM6 Lynx 12.7 mm (Green Hex)
	"srifle_GM6_LRPS_F", // GM6 Lynx 12.7 mm
	"srifle_GM6_SOS_F", // GM6 Lynx 12.7 mm
	"srifle_LRR_camo_F", // M320 LRR .408 (Camo)
	"srifle_LRR_camo_LRPS_F", // M320 LRR .408 (Camo)
	"srifle_LRR_camo_SOS_F", // M320 LRR .408 (Camo)
	"srifle_LRR_F", // M320 LRR .408
	"srifle_LRR_LRPS_F", // M320 LRR .408
	"srifle_LRR_SOS_F", // M320 LRR .408
	"srifle_LRR_tna_F", // M320 LRR .408 (Tropic)
	"srifle_LRR_tna_LRPS_F" // M320 LRR .408 (Tropic)
];
_uniforms = [
	"U_BG_Guerilla1_1", // Guerilla Garment
	"U_BG_Guerilla2_1", // Guerilla Outfit (Plain, Dark)
	"U_BG_Guerilla2_2", // Guerilla Outfit (Pattern)
	"U_BG_Guerilla2_3", // Guerilla Outfit (Plain, Light)
	"U_BG_Guerilla3_1", // Guerilla Smocks
	"U_BG_Guerrilla_6_1", // Guerilla Apparel
	"U_BG_leader", // Guerilla Uniform
	"U_B_CombatUniform_mcam", // Combat Fatigues (MTP)
	"U_B_CombatUniform_mcam_tshirt", // Combat Fatigues (MTP) (Tee)
	"U_B_CombatUniform_mcam_vest", // Recon Fatigues (MTP)
	"U_B_CombatUniform_mcam_worn", // Worn Combat Fatigues (MTP)
	"U_B_CTRG_1", // CTRG Combat Uniform
	"U_B_CTRG_2", // CTRG Combat Uniform (Tee)
	"U_B_CTRG_3", // CTRG Combat Uniform (Rolled-up)
	"U_B_CTRG_Soldier_2_F", // CTRG Stealth Uniform (Tee)
	"U_B_CTRG_Soldier_3_F", // CTRG Stealth Uniform (Rolled-up)
	"U_B_CTRG_Soldier_F", // CTRG Stealth Uniform
	"U_B_CTRG_Soldier_urb_1_F", // CTRG Urban Uniform
	"U_B_CTRG_Soldier_urb_2_F", // CTRG Urban Uniform (Tee)
	"U_B_CTRG_Soldier_urb_3_F", // CTRG Urban Uniform (Rolled-up)
	"U_B_FullGhillie_ard", // Full Ghillie (Arid) [NATO]
	"U_B_FullGhillie_lsh", // Full Ghillie (Lush) [NATO]
	"U_B_FullGhillie_sard", // Full Ghillie (Semi-Arid) [NATO]
	"U_B_GEN_Commander_F", // Gendarmerie Commander Uniform
	"U_B_GEN_Soldier_F", // Gendarmerie Uniform
	"U_B_GhillieSuit", // Ghillie Suit [NATO]
	"U_B_HeliPilotCoveralls", // Heli Pilot Coveralls [NATO]
	"U_B_PilotCoveralls", // Pilot Coveralls [NATO]
	"U_B_survival_uniform", // Survival Fatigues
	"U_B_T_FullGhillie_tna_F", // Full Ghillie (Jungle) [NATO]
	"U_B_T_Sniper_F", // Ghillie Suit (Tropic) [NATO]
	"U_B_T_Soldier_AR_F", // Combat Fatigues (Tropic, Tee)
	"U_B_T_Soldier_F", // Combat Fatigues (Tropic)
	"U_B_T_Soldier_SL_F", // Recon Fatigues (Tropic)
	"U_B_Wetsuit", // Wetsuit [NATO]
	"U_I_CombatUniform", // Combat Fatigues [AAF]
	"U_I_CombatUniform_shortsleeve", // Combat Fatigues [AAF] (Rolled-up)
	"U_I_C_Soldier_Camo_F", // Syndikat Uniform
	"U_I_C_Soldier_Para_1_F", // Paramilitary Garb (Tee)
	"U_I_C_Soldier_Para_2_F", // Paramilitary Garb (Jacket)
	"U_I_C_Soldier_Para_3_F", // Paramilitary Garb (Shirt)
	"U_I_C_Soldier_Para_4_F", // Paramilitary Garb (Tank Top)
	"U_I_C_Soldier_Para_5_F", // Paramilitary Garb (Shorts)
	"U_I_FullGhillie_ard", // Full Ghillie (Arid) [AAF]
	"U_I_FullGhillie_lsh", // Full Ghillie (Lush) [AAF]
	"U_I_FullGhillie_sard", // Full Ghillie (Semi-Arid) [AAF]
	"U_I_GhillieSuit", // Ghillie Suit [AAF]
	"U_I_G_resistanceLeader_F", // Combat Fatigues (Stavrou)
	"U_I_G_Story_Protagonist_F", // Worn Combat Fatigues (Kerry)
	"U_I_OfficerUniform", // Combat Fatigues [AAF] (Officer)
	"U_OrestesBody", // Jacket and Shorts
	"U_O_CombatUniform_ocamo", // Fatigues (Hex) [CSAT]
	"U_O_CombatUniform_oucamo", // Fatigues (Urban) [CSAT]
	"U_O_FullGhillie_ard", // Full Ghillie (Arid) [CSAT]
	"U_O_FullGhillie_lsh", // Full Ghillie (Lush) [CSAT]
	"U_O_FullGhillie_sard", // Full Ghillie (Semi-Arid) [CSAT]
	"U_O_GhillieSuit", // Ghillie Suit [CSAT]
	"U_O_OfficerUniform_ocamo", // Officer Fatigues (Hex)
	"U_O_PilotCoveralls", // Pilot Coveralls [CSAT]
	"U_O_SpecopsUniform_ocamo", // Recon Fatigues (Hex)
	"U_O_T_FullGhillie_tna_F", // Full Ghillie (Jungle) [CSAT]
	"U_O_T_Officer_F", // Officer Fatigues (Green Hex) [CSAT]
	"U_O_T_Sniper_F", // Ghillie Suit (Green Hex) [CSAT]
	"U_O_T_Soldier_F", // Fatigues (Green Hex) [CSAT]
	"U_O_V_Soldier_Viper_F", // Special Purpose Suit (Green Hex)
	"U_O_V_Soldier_Viper_hex_F" // Special Purpose Suit (Hex)
	];

_vests = [
	"V_I_G_resistanceLeader_F", // Tactical Vest (Stavrou)
	"V_PlateCarrier1_blk", // Carrier Lite (Black)
	"V_PlateCarrier1_rgr", // Carrier Lite (Green)
	"V_PlateCarrier1_rgr_noflag_F", // Carrier Lite (Green, No Flag)
	"V_PlateCarrier1_tna_F", // Carrier Lite (Tropic)
	"V_PlateCarrier2_blk", // Carrier Rig (Black)
	"V_PlateCarrier2_rgr", // Carrier Rig (Green)
	"V_PlateCarrier2_rgr_noflag_F", // Carrier Rig (Green, No Flag)
	"V_PlateCarrier2_tna_F", // Carrier Rig (Tropic)
	"V_PlateCarrierGL_blk", // Carrier GL Rig (Black)
	"V_PlateCarrierGL_mtp", // Carrier GL Rig (MTP)
	"V_PlateCarrierGL_rgr", // Carrier GL Rig (Green)
	"V_PlateCarrierGL_tna_F", // Carrier GL Rig (Tropic)
	"V_PlateCarrierH_CTRG", // CTRG Plate Carrier Rig Mk.2 (Heavy)
	"V_PlateCarrierIA1_dgtl", // GA Carrier Lite (Digi)
	"V_PlateCarrierIA2_dgtl", // GA Carrier Rig (Digi)
	"V_PlateCarrierIAGL_dgtl", // GA Carrier GL Rig (Digi)
	"V_PlateCarrierIAGL_oli", // GA Carrier GL Rig (Olive)
	"V_PlateCarrierL_CTRG", // CTRG Plate Carrier Rig Mk.1 (Light)
	"V_PlateCarrierSpec_blk", // Carrier Special Rig (Black)
	"V_PlateCarrierSpec_mtp", // Carrier Special Rig (MTP)
	"V_PlateCarrierSpec_rgr", // Carrier Special Rig (Green)
	"V_PlateCarrierSpec_tna_F", // Carrier Special Rig (Tropic)
	"V_PlateCarrier_Kerry", // US Plate Carrier Rig (Kerry)
	"V_Rangemaster_belt", // Rangemaster Belt
	"V_TacChestrig_cbr_F", // Tactical Chest Rig (Coyote)
	"V_TacChestrig_grn_F", // Tactical Chest Rig (Green)
	"V_TacChestrig_oli_F", // Tactical Chest Rig (Olive)
	"V_TacVestIR_blk", // Raven Vest
	"V_TacVest_blk", // Tactical Vest (Black)
	"V_TacVest_brn", // Tactical Vest (Brown)
	"V_TacVest_camo", // Tactical Vest (Camo)
	"V_TacVest_gen_F", // Gendarmerie Vest
	"V_TacVest_khk", // Tactical Vest (Khaki)
	"V_TacVest_oli" // Tactical Vest (Olive)
];

_weaponAccessories = [
	"acc_flashlight", // Flashlight
	"acc_pointer_IR" // IR Laser Pointer
];

_goggles = [
	"G_B_Diving", // Diving Goggles [NATO]
	"G_Combat", // Combat Goggles
	"G_Combat_Goggles_tna_F", // Combat Goggles (Green)
	"G_Diving", // Diving Goggles
	"G_Lowprofile" // "Low Profile Goggles
];

_specials = [
  "rhs_weap_M107",
  "rhs_weap_M107_d",
  "rhs_weap_M107_w",
  "rhs_weap_XM2010",
  "rhs_weap_XM2010_wd",
  "rhs_weap_m40a5",
  "rhs_weap_m40a5_d",
  "rhs_weap_m40a5_wd",
  "rhs_weap_XM2010",
  "rhs_weap_XM2010_wd",
  "rhs_weap_XM2010_d",
  "rhs_weap_XM2010_sa",
  "rhs_weap_m24sws",
  "rhs_weap_m24sws_d",
  "rhs_weap_m24sws_wd"
];

_specialOptics = [
  "rhsusf_acc_ACOG2_USMC",
  "rhsusf_acc_ACOG3_USMC",
  "rhsusf_acc_ACOG_USMC",
  "rhsusf_acc_anpvs27",
  "rhsusf_acc_M8541_low",
  "rhsusf_acc_M8541",
  "rhsusf_acc_M8541_low_d",
  "rhsusf_acc_M8541_low_wd",
  "rhsusf_acc_premier_low",
  "rhsusf_acc_LEUPOLDMK4",
  "rhsusf_acc_LEUPOLDMK4_d",
  "rhsusf_acc_LEUPOLDMK4_wd",
  "rhsusf_acc_LEUPOLDMK4_2_d",
  "rhsusf_acc_su230",
  "rhsusf_acc_su230_c",
  "rhsusf_acc_su230_mrds",
  "rhsusf_acc_su230_mrds_c",
  "rhsusf_acc_su230a",
  "rhsusf_acc_su230a_c",
  "rhsusf_acc_su230a_mrds",
  "rhsusf_acc_su230a_mrds_c",
  "rhsusf_acc_ACOG_MDO",
  "rhsusf_acc_ACOG_d",
  "rhsusf_acc_ACOG_wd"
];

_overallLoopAmount = floor (round (random 8) + 3); // minimum 2, maximum 10
_backPackAmount = floor (round (random 2) + 1); // minimum 3, maximum 6
_binocularAmount = floor (round (random 5) + 2); // minimum 3, maximum 7
_bipodAmount = floor (round (random 3) + 2); // minimum 2, maximum 5
_headGearAmount = floor (round (random 1) + 1); // minimum 5, maximum 8
_itemAmount = floor (round (random 3) + 5); // minimum 5, maximum 8
_launcherAmount = floor (round (random 3) + 4); // minimum 2, maximum 5
_magazineAmount = floor (round (random 5) + 5); // minimum 5, maximum 10
_throwableAmount = floor (round (random 3) + 3); // minimum 3, maximum 6
_muzzleAmount = floor (round (random 2) + 2); // minimum 2, maximum 4
_opticAmount = floor (round (random 4) + 5); // minimum 5, maximum 9
_primaryWeaponAmount = floor (round (random 5) + 5); // minimum 5, maximum 10
_secondaryWeaponAmount = floor (round (random 3) + 2); // minimum 2, maximum 5
_uniformAmount = floor (round (random 1) + 1); // minimum 3, maximum 7
_vestAmount = floor (round (random 2) + 1); // minimum 3, maximum 7
_weaponAccessoryAmount = floor (round (random 3) + 2); // minimum 2, maximum 5
_goggleAmount = floor (round (random 2) + 2); // minimum 2, maximum 4

//% Chance of special weapons being present
if( random 100 <= 5 ) then { _primaryWeapons pushBack (selectRandom _specials); };

//% Chance of special scopes being present
if( random 100 <= 5 ) then { __optics pushBack (selectRandom _specialOptics ); };


_loadCrateWithWhatArray = [
	"_backPacks",
	"_binoculars",
	"_bipods",
	"_headGear",
	"_items",
	"_magazines",
	"_throwables",
	"_muzzles",
	"_optics",
	"_primaryWeapons",
	"_uniforms",
	"_vests",
	"_weaponAccessories",
	"_goggles"
];


for [{_i = 0},{_i < _overallLoopAmount},{_i = _i + 1}] do {

	_loadCrateWithWhat = selectRandom _loadCrateWithWhatArray;

	#ifdef __DEBUG__
		diag_log format ["%1 -> %2",(_i + 1),_loadCrateWithWhat];
	#endif

	switch (_loadCrateWithWhat) do
	{
		case "_backPacks": {
			_loadCrateAmount = _backPackAmount;
			for [{_lootCount = 0 },{_lootCount < _loadCrateAmount},{_lootCount = _lootCount + 1}] do
			{
				_loadCrateItem = selectRandom _backPacks;
				_box addBackpackCargoGlobal [_loadCrateItem, 1];
				#ifdef __DEBUG__
					diag_log format [" + %1 added -> 1x %2",_loadCrateWithWhat,_loadCrateItem];
				#endif
			};
		};
		case "_binoculars": {
			_loadCrateAmount = _binocularAmount;
			for [{_lootCount = 0},{_lootCount < _loadCrateAmount},{_lootCount = _lootCount + 1}] do
			{
				_loadCrateItem = selectRandom _binoculars;
				_box addItemCargoGlobal [_loadCrateItem, 1];
				#ifdef __DEBUG__
					diag_log format [" + %1 added -> 1x %2",_loadCrateWithWhat,_loadCrateItem];
				#endif
			};
		};
		case "_bipods": {
			_loadCrateAmount = _bipodAmount;
			for [{_lootCount = 0},{_lootCount < _loadCrateAmount},{_lootCount = _lootCount + 1}] do
			{
				_loadCrateItem = selectRandom _bipods;
				_box addItemCargoGlobal [_loadCrateItem, 1];
				#ifdef __DEBUG__
					diag_log format [" + %1 added -> 1x %2",_loadCrateWithWhat,_loadCrateItem];
				#endif
			};
		};
		case "_headGear": {
			_loadCrateAmount = _headGearAmount;
			for [{_lootCount = 0},{_lootCount < _loadCrateAmount},{_lootCount = _lootCount + 1}] do
			{
				_loadCrateItem = selectRandom _headGear;
				_box addItemCargoGlobal [_loadCrateItem, 1];
				#ifdef __DEBUG__
					diag_log format [" + %1 added -> 1x %2",_loadCrateWithWhat,_loadCrateItem];
				#endif

			};
		};
		case "_items": {
			_loadCrateAmount = _itemAmount;
			for [{_lootCount = 0},{_lootCount < _loadCrateAmount},{_lootCount = _lootCount + 1}] do
			{
				_loadCrateItem = selectRandom _items;
				_box addItemCargoGlobal [_loadCrateItem, 1];
				#ifdef __DEBUG__
					diag_log format [" + %1 added -> 1x %2",_loadCrateWithWhat,_loadCrateItem];
				#endif

			};
		};
		case "_magazines": {
			_loadCrateAmount = _magazineAmount;
			for [{_lootCount = 0},{_lootCount < _loadCrateAmount},{_lootCount = _lootCount + 1}] do
			{
				_loadCrateItem = selectRandom _magazines;
				_loadCrateLootMagazineNum = [2,10] call BIS_fnc_randomInt; // floor (round (random 4) + 2); // minimum 2, maximum 6
				_box addMagazineCargoGlobal [_loadCrateItem, _loadCrateLootMagazineNum];
				#ifdef __DEBUG__
					diag_log format [" + %1 added -> %2x %3 magazines",_loadCrateWithWhat,_loadCrateLootMagazineNum,_loadCrateItem];
				#endif

			};
		};
		case "_throwables": {
			_loadCrateAmount = _throwableAmount;
			for [{_lootCount = 0},{_lootCount < _loadCrateAmount},{_lootCount = _lootCount + 1}] do
			{
				_loadCrateItem = selectRandom _throwables;
				_loadCrateLootMagazineNum = floor (round (random 8) + 2); // minimum 2, maximum 10
				_box addMagazineCargoGlobal [_loadCrateItem, _loadCrateLootMagazineNum];
				#ifdef __DEBUG__
					diag_log format [" + %1 added -> %2x %3",_loadCrateWithWhat,_loadCrateLootMagazineNum,_loadCrateItem];
				#endif
			};
		};
		case "_muzzles": {
			_loadCrateAmount = _muzzleAmount;
			for [{_lootCount = 0},{_lootCount < _loadCrateAmount},{_lootCount = _lootCount + 1}] do
			{
				_loadCrateItem = selectRandom _muzzles;
				_box addItemCargoGlobal [_loadCrateItem, 1];
				#ifdef __DEBUG__
					diag_log format [" + %1 added -> 1x %2",_loadCrateWithWhat,_loadCrateItem];
				#endif
			};
		};
		case "_optics": {
			_loadCrateAmount = _opticAmount;
			for [{_lootCount = 0},{_lootCount < _loadCrateAmount},{_lootCount = _lootCount + 1}] do
			{
				_loadCrateItem = selectRandom _optics;
				_box addItemCargoGlobal [_loadCrateItem, 1];
				#ifdef __DEBUG__
					diag_log format [" + %1 added -> 1x %2",_loadCrateWithWhat,_loadCrateItem];
				#endif
			};
		};
		case "_primaryWeapons": {
			_loadCrateAmount = _primaryWeaponAmount;
			for [{_lootCount = 0},{_lootCount < _loadCrateAmount},{_lootCount = _lootCount + 1}] do
			{
				_loadCrateItem = selectRandom _primaryWeapons;
				_loadCrateLootMagazine = getArray (configFile / "CfgWeapons" / _loadCrateItem / "magazines");
				_loadCrateLootMagazineClass = selectRandom _loadCrateLootMagazine;
				_loadCrateLootMagazineNum = floor (round (random 6) + 4); // minimum 4, maximum 10
				_box addMagazineCargoGlobal [_loadCrateLootMagazineClass, _loadCrateLootMagazineNum];
				_box addWeaponCargoGlobal [_loadCrateItem, 1];
				#ifdef __DEBUG__
					diag_log format [" + %1 added -> 1x %2 with %3x %4 magazines",_loadCrateWithWhat,_loadCrateItem,_loadCrateLootMagazineNum,_loadCrateLootMagazineClass];
				#endif
			};
		};
		case "_uniforms": {
			_loadCrateAmount = _uniformAmount;
			for [{_lootCount = 0},{_lootCount < _loadCrateAmount},{_lootCount = _lootCount + 1}] do
			{
				_loadCrateItem = selectRandom _uniforms;
				_box addItemCargoGlobal [_loadCrateItem, 1];
				#ifdef __DEBUG__
					diag_log format [" + %1 added -> 1x %2",_loadCrateWithWhat,_loadCrateItem];
				#endif
			};
		};
		case "_vests": {
			_loadCrateAmount = _vestAmount;
			for [{_lootCount = 0},{_lootCount < _loadCrateAmount},{_lootCount = _lootCount + 1}] do
			{
				_loadCrateItem = selectRandom _vests;
				_box addItemCargoGlobal [_loadCrateItem, 1];
				#ifdef __DEBUG__
					diag_log format [" + %1 added -> 1x %2",_loadCrateWithWhat,_loadCrateItem];
				#endif
			};
		};
		case "_weaponAccessories": {
			_loadCrateAmount = _weaponAccessoryAmount;
			for [{_lootCount = 0},{_lootCount < _loadCrateAmount},{_lootCount = _lootCount + 1}] do
			{
				_loadCrateItem = selectRandom _weaponAccessories;
				_box addItemCargoGlobal [_loadCrateItem, 1];
				#ifdef __DEBUG__
					diag_log format [" + %1 added -> 1x %2",_loadCrateWithWhat,_loadCrateItem];
				#endif
			};
		};
		case "_goggles": {
			_loadCrateAmount = _goggleAmount;
			for [{_lootCount = 0},{_lootCount < _loadCrateAmount},{_lootCount = _lootCount + 1}] do
			{
				_loadCrateItem = selectRandom _goggles;
				_loadCrateLootMagazineNum = floor (round (random 2) + 2); // minimum 2, maximum 4
				_box addItemCargoGlobal [_loadCrateItem, _loadCrateLootMagazineNum];
				#ifdef __DEBUG__
					diag_log format [" + %1 added -> %2x %3",_loadCrateWithWhat,_loadCrateLootMagazineNum,_loadCrateItem];
				#endif
			};
		};
	};
};

_box
