// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: createAAFRegular.sqf
//	Author: GMG_Monkey
/*
 * Creates a random Soldier.
 */

// if (!isServer && hasinterface) exitWith {};
private _group = _this select 0;
private _position = _this select 1;
private _faction = _this select 2;
private _type = _this select 3;

private _soldierTypes = selectrandom ["C_man_polo_1_F", "C_man_polo_2_F", "C_man_polo_3_F", "C_man_polo_4_F", "C_man_polo_5_F", "C_man_polo_6_F"];
private _uniformTypes = [];
private _vestTypes = [];
private _BackpackTypes = [];
private _weaponTypesRifle = [];
private _weaponTypesLauncher = [];
private _weaponTypesPistor = [];
private _weaponSight = [];
private _weaponsRail = [];
private _weaponsBipod = [];
private _BinocularTypes = [];
private _TerminalTypes = [];
private _itemsList = [];
private _headgear = [];
private _faceItems = [];
private _allowFleeing = 1; // can the unit flee? 0 = no 1 = yes
private _rank = "PRIVATE"; //  PRIVATE, CORPORAL, SERGEANT, LIEUTENANT, CAPTAIN, MAJOR or COLONEL
//Soldier Skills are set from 0 to 1; 
private _Accuracy = 1; //Soldier accuracy;
private _Courage = 1; //Affects unit's subordinates' morale (Higher value = more courage)
private _aimingShake = 1; //Affects how steadily the AI can hold a weapon (Higher value = less weapon sway)
private _aimingSpeed = 1; //Affects how quickly the AI can rotate and stabilize its aim (Higher value = faster, less error)
private _spotDistance = 1; //Affects the AI ability to spot targets within it's visual or audible range (Higher value = more likely to spot)
private _spotTime = 1; //Affects how quick the AI react to death, damage or observing an enemy (Higher value = quicker reaction)
private _reloadSpeed = 1; //Affects the delay between switching or reloading a weapon (Higher value = less delay)
private _commanding = 1; //Affects how quickly recognized targets are shared with the group (Higher value = faster reporting)	

//Uniform
	switch (_faction) do
	{
		case "NATO":
		{
			switch (_type) do
			{
				case "Sniper": {_uniformTypes = ["U_B_FullGhillie_ard","U_B_T_FullGhillie_tna_F","U_B_FullGhillie_lsh","U_B_FullGhillie_sard","U_B_T_Sniper_F","U_B_GhillieSuit"]};
				case "Diver": {_uniformTypes = ["U_B_survival_uniform","U_B_Wetsuit"]};
				case "HeliCrew": {_uniformTypes = ["U_B_HeliPilotCoveralls"]};
				case "Helipilot": {_uniformTypes = ["U_B_HeliPilotCoveralls"]};
				case "JetPilot": {_uniformTypes = ["U_B_PilotCoveralls"]};
				case "CTRG": {_uniformTypes = ["U_B_CTRG_Soldier_F"]};
				default {_uniformTypes = ["U_B_CTRG_3","U_B_CTRG_2","U_B_CTRG_1","U_B_CombatUniform_mcam_tshirt","U_B_T_Soldier_F","U_B_CombatUniform_mcam","U_B_CombatUniform_mcam_vest"]};
			};
		};
		case "CSAT":
		{
			switch (_type) do
			{
				case "Sniper": {_uniformTypes = ["U_O_FullGhillie_ard","U_O_T_FullGhillie_tna_F","U_O_FullGhillie_lsh","U_O_FullGhillie_sard","U_O_T_Sniper_F","U_O_GhillieSuit"]};
				case "Diver": {_uniformTypes = ["U_O_Wetsuit"]};
				case "HeliCrew": {_uniformTypes = ["U_0_HeliPilotCoveralls"]};
				case "Helipilot": {_uniformTypes = ["U_0_HeliPilotCoveralls"]};
				case "JetPilot": {_uniformTypes = ["U_0_PilotCoveralls"]};
				case "Viper": {_uniformTypes = ["U_O_V_Soldier_Viper_F","U_O_V_Soldier_Viper_hex_F"]};
				default {_uniformTypes = ["U_O_OfficerUniform_ocamo","U_O_officer_noInsignia_hex_F","U_O_T_Officer_F","U_O_CombatUniform_ocamo","U_O_CombatUniform_oucamo"]};
			};
		};
		case "AAF":
		{
			switch (_type) do
			{
				case "Sniper": {_uniformTypes = ["U_I_CombatUniform", "U_I_CombatUniform_shortsleeve", "U_I_GhillieSuit"]};
				case "Diver": {_uniformTypes = ["U_I_Wetsuit"]};
				case "HeliCrew": {_uniformTypes = ["U_I_HeliPilotCoveralls"]};
				case "Helipilot": {_uniformTypes = ["U_I_HeliPilotCoveralls"]};
				case "JetPilot": {_uniformTypes = ["U_I_PilotCoveralls"]};
				default {_uniformTypes = ["U_I_CombatUniform","U_I_CombatUniform_shortsleeve"]};
			};
		};
		case "GEN":
		{
			switch (_type) do
			{
				case "Commander": {_uniformTypes = ["U_B_GEN_Commander_F"]};
				default {_uniformTypes = ["U_B_GEN_Soldier_F"]};
			};
		};
		case "SYN":
		{
			switch (_type) do
			{
				default {_uniformTypes = ["U_I_C_Soldier_Bandit_1_F","U_I_C_Soldier_Bandit_2_F","U_I_C_Soldier_Bandit_3_F","U_I_C_Soldier_Bandit_4_F","U_I_C_Soldier_Bandit_5_F","U_C_ConstructionCoverall_Black_F","U_C_ConstructionCoverall_Blue_F","U_C_ConstructionCoverall_Red_F","U_C_ConstructionCoverall_Vrana_F","U_BG_Guerilla1_2_F","U_BG_Guerrilla_6_1","U_BG_Guerilla2_2",	"U_BG_Guerilla2_1","U_BG_Guerilla2_3","U_BG_Guerilla3_1","U_BG_leader","U_C_Mechanic_01_F","U_I_C_Soldier_Para_1_F","U_I_C_Soldier_Para_2_F","U_I_C_Soldier_Para_3_F","U_I_C_Soldier_Para_4_F","U_I_C_Soldier_Para_5_F","U_C_Poloshirt_stripped","U_C_Poloshirt_burgundy","U_Competitor","U_C_Poloshirt_blue","U_Rangemaster","U_C_Poloshirt_redwhite","U_C_Poloshirt_salmon","U_C_Poloshirt_tricolour","U_C_Driver_1_black","U_C_Driver_1_blue","U_C_Driver_2","U_C_Driver_1",	"U_C_Driver_1_green","U_C_Driver_1_orange","U_C_Driver_1_red","U_C_Driver_3","U_C_Driver_4","U_C_Driver_1_white","U_C_Driver_1_yellow","U_I_C_Soldier_Camo_F","U_C_Poor_1","U_C_WorkerCoveralls"]};
			};
		};
		case "IDAP":
		{
			switch (_type) do
			{
				case "Paramedic": {_uniformTypes = ["U_C_Paramedic_01_F"]};
				default {_uniformTypes = ["U_C_IDAP_Man_cargo_F","U_C_IDAP_Man_casual_F","U_C_IDAP_Man_Jeans_F","U_C_IDAP_Man_shorts_F","U_C_IDAP_Man_TeeShorts_F","U_C_IDAP_Man_Tee_F"]};
			};
		};
	};
//Vest
	switch (_faction) do
	{
		case "NATO":
		{
			switch (_type) do
			{
				case "Diver":{_vestTypes = ["V_RebreatherB"]};
				case "HeliPilot":{_vestTypes = ["objNull"]};
				case "JetPilot":{_vestTypes = ["objNull"]};
				case "Grenedier":{_vestTypes = ["V_PlateCarrierGL_blk","V_PlateCarrierGL_rgr","V_PlateCarrierGL_mtp","V_PlateCarrierGL_tna_F","V_PlateCarrierIAGL_dgtl","V_PlateCarrierIAGL_oli"]};
				case "CTRG":{_vestTypes = ["V_PlateCarrierL_CTRG","V_PlateCarrierH_CTRG","V_PlateCarrier2_tna_F","V_PlateCarrierSpec_blk","V_PlateCarrierSpec_rgr","V_PlateCarrierSpec_mtp","V_PlateCarrierSpec_tna_F"]};
				default {_vestTypes = []};
			};
		};
		case "CSAT":
		{
			switch (_type) do
			{
				case "Diver":{_vestTypes = ["V_RebreatherIR"]};
				case "HeliPilot":{_vestTypes = ["objNull"]};
				case "JetPilot":{_vestTypes = ["objNull"]};
				case "Viper":{_vestTypes = ["objNull"]};
				default {_vestTypes = ["V_HarnessOSpec_gry","V_HarnessO_ghex_F","V_HarnessOSpec_brn","V_HarnessOGL_gry","V_HarnessOGL_ghex_F","V_HarnessOGL_brn","V_HarnessO_gry","V_HarnessO_brn"]};
			};
		};
		case "AAF":
		{
			switch (_type) do
			{
				case "Diver":{_vestTypes = ["V_RebreatherIA"]};
				case "HeliPilot":{_vestTypes = ["objNull"]};
				case "JetPilot":{_vestTypes = ["objNull"]};
				default {_vestTypes = ["V_Chestrig_oli","V_Chestrig_rgr"]};
			};
		};
		case "GEN":{_vestTypes = ["V_TacVest_gen_F"]};
		case "SYN":{_vestTypes = ["objNull","objNull","objNull","objNull","objNull","objNull","V_BandollierB_blk","V_BandollierB_cbr","V_BandollierB_ghex_F","V_BandollierB_rgr","V_BandollierB_khk","V_BandollierB_oli"]};
		case "IDAP":{_vestTypes = ["objNull","objNull","objNull","objNull","objNull","objNull","V_EOD_IDAP_blue_F","V_Pocketed_black_F","V_Pocketed_coyote_F","V_Pocketed_olive_F","V_Plain_crystal_F","V_Safety_blue_F","V_Safety_orange_F","V_Safety_yellow_F"]};
		default {_vestTypes = ["objNull"]};
	};
//Backpack
	switch (_type) do
	{
		case "AT":
		{
			switch (_faction) do
			{
				case "NATO":{_BackpackTypes = ["B_TacticalPack_mcamo","B_Kitbag_mcamo","B_Carryall_mcamo",	"B_Bergen_mcamo_F"]};
				case "CSAT":{_BackpackTypes = ["B_FieldPack_oucamo","B_FieldPack_ocamo","B_FieldPack_ghex_F","B_TacticalPack_ocamo","B_Carryall_oucamo","B_Carryall_ghex_F"]};
				case "AAF":{_BackpackTypes = ["B_AssaultPack_rgr","B_Kitbag_rgr","B_TacticalPack_rgr","B_TacticalPack_oli","B_Carryall_oli"]};
				case "SYN":{_BackpackTypes = ["B_FieldPack_blk","B_FieldPack_cbr","B_FieldPack_khk","B_Kitbag_cbr","B_Kitbag_sgg","B_TacticalPack_blk","B_TacticalPack_rgr","B_Carryall_khk","B_Carryall_cbr"]};
			};
		};
		case "AA":
		{
			switch (_faction) do
			{
				case "NATO":{_BackpackTypes = ["B_TacticalPack_mcamo","B_Kitbag_mcamo","B_Carryall_mcamo",	"B_Bergen_mcamo_F"]};
				case "CSAT":{_BackpackTypes = ["B_FieldPack_oucamo","B_FieldPack_ocamo","B_FieldPack_ghex_F","B_TacticalPack_ocamo","B_Carryall_oucamo","B_Carryall_ghex_F"]};
				case "AAF":{_BackpackTypes = ["B_AssaultPack_rgr","B_Kitbag_rgr","B_TacticalPack_rgr","B_TacticalPack_oli","B_Carryall_oli"]};
			};
		};
		case "Viper":
		{
			_BackpackTypes = ["objNull","objNull","objNull","objNull","objNull","objNull","B_ViperLightHarness_blk_F","B_ViperLightHarness_hex_F","B_ViperLightHarness_ghex_F","B_ViperLightHarness_khk_F","B_ViperLightHarness_oli_F","B_ViperHarness_blk_F","B_ViperHarness_hex_F","B_ViperHarness_ghex_F","B_ViperHarness_khk_F","B_ViperHarness_oli_F"];
		};
		case "CTRG":
		{
			_BackpackTypes = ["objNull","objNull","objNull","objNull","objNull","objNull","B_Carryall_khk","B_Carryall_cbr","B_Carryall_mcamo","B_Carryall_oli","B_Bergen_dgtl_F","B_Bergen_mcamo_F","B_Bergen_tna_F"];
		};
		default
		{
			switch (_faction) do
			{
				case "NATO":{_BackpackTypes = ["objNull","objNull","objNull","B_AssaultPack_mcamo","B_Kitbag_mcamo","B_TacticalPack_mcamo"]};
				case "CSAT":{_BackpackTypes = ["objNull","objNull","objNull","B_AssaultPack_ocamo","B_FieldPack_oucamo","B_FieldPack_ocamo","B_TacticalPack_ocamo"]};
				case "AAF":{_BackpackTypes = ["objNull","objNull","objNull","B_AssaultPack_rgr","B_Kitbag_rgr","B_TacticalPack_rgr","B_TacticalPack_oli"]};
				case "SYN":{_BackpackTypes = ["objNull","objNull","objNull", "B_LegStrapBag_black_F","B_LegStrapBag_coyote_F","B_LegStrapBag_olive_F","B_Messenger_Black_F","B_Messenger_Coyote_F","B_Messenger_Gray_F","B_Messenger_Olive_F","B_AssaultPack_blk","B_AssaultPack_rgr"]};
				case "IDAP":{_BackpackTypes = ["objNull","objNull","objNull","objNull","objNull","objNull","objNull","objNull","objNull","B_Messenger_IDAP_F"]};
				default {_BackpackTypes = ["objNull"]};
			};
		};
	};
//Primary Weapon
	switch (_type) do
	{
		case "Crew":
		{
			_weaponTypesRifle = ["objNull"];
		};
		case "HeliCrew":
		{
			_weaponTypesRifle = ["objNull"];
		};
		case "HeliPilot":
		{
			_weaponTypesRifle = ["objNull"];
		};
		case "JetPilot":
		{
			_weaponTypesRifle = ["objNull"];
		};
		case "Medic":
		{
			_weaponTypesRifle = ["objNull"];
		};
		case "Diver":
		{
			_weaponTypesRifle = ["arifle_SDAR_F"];
		};
		case "Grenedier":
		{
			switch (_faction) do
			{
				case "NATO":{_weaponTypesRifle = ["arifle_Mk20_GL_plain_F","arifle_Mk20_GL_F","arifle_MX_GL_F","arifle_MX_GL_Black_F","arifle_MX_GL_khk_F"]};
				case "CSAT":{_weaponTypesRifle = ["arifle_Katiba_GL_F","arifle_CTAR_GL_blk_F","arifle_CTAR_GL_hex_F","arifle_CTAR_GL_ghex_F"]};
				case "AAF":{_weaponTypesRifle = ["arifle_TRG21_GL_F"]};
			};
		};
		case "Marksman":
		{
			switch (_faction) do
			{
				case "NATO":{_weaponTypesRifle = ["arifle_MXM_F","arifle_MXM_Black_F","arifle_MXM_khk_F","srifle_EBR_F","arifle_SPAR_03_blk_F","arifle_SPAR_03_khk_F","arifle_SPAR_03_snd_F","srifle_DMR_03_F","srifle_DMR_03_multicam_F","srifle_DMR_03_khaki_F","srifle_DMR_03_tan_F","srifle_DMR_03_woodland_F"]};
				case "CSAT":{_weaponTypesRifle = ["srifle_DMR_01_F","srifle_DMR_07_blk_F","srifle_DMR_07_hex_F","srifle_DMR_07_ghex_F"]};
				case "AAF":{_weaponTypesRifle = ["srifle_DMR_06_camo_F","srifle_DMR_06_olive_F"]};
			};
		};
		case "SAW":
		{
			switch (_faction) do
			{
				case "NATO":{_weaponTypesRifle = ["arifle_MX_SW_F","arifle_MX_SW_Black_F","arifle_MX_SW_khk_F","arifle_SPAR_02_blk_F","arifle_SPAR_02_khk_F","arifle_SPAR_02_snd_F","LMG_03_F"]};
				case "CSAT":{_weaponTypesRifle = ["LMG_Zafir_F","arifle_CTARS_blk_F","arifle_CTARS_hex_F","arifle_CTARS_ghex_F"]};
				case "AAF":{_weaponTypesRifle = ["LMG_Mk200_F"]};
			};
		};
		case "Sniper":
		{
			switch (_faction) do
			{
				case "NATO":{_weaponTypesRifle = ["srifle_LRR_LRPS_F","srifle_LRR_camo_LRPS_F","srifle_LRR_tna_LRPS_F"]};
				case "CSAT":{_weaponTypesRifle = ["srifle_GM6_LRPS_F","srifle_GM6_camo_LRPS_F","srifle_GM6_ghex_LRPS_F"]};
				case "AAF":{_weaponTypesRifle = ["srifle_DMR_02_F","srifle_DMR_02_camo_F","srifle_DMR_02_sniper_F","srifle_DMR_05_blk_F","srifle_DMR_05_hex_F","srifle_DMR_05_tan_f"]};
			};
		};
		case "Viper":
		{
			switch (_faction) do
			{
				case "CSAT":{_weaponTypesRifle = ["arifle_ARX_blk_F","arifle_ARX_hex_F","arifle_ARX_ghex_F","srifle_DMR_05_blk_F","srifle_DMR_05_hex_F","srifle_DMR_05_tan_f","srifle_GM6_LRPS_F","srifle_GM6_camo_LRPS_F","srifle_GM6_ghex_LRPS_F","MMG_01_tan_F","MMG_01_hex_F"]};
			};
		};
		case "CTRG":
		{
			switch (_faction) do
			{
				case "NATO":{_weaponTypesRifle = ["arifle_SPAR_03_blk_F","arifle_SPAR_03_khk_F","arifle_SPAR_03_snd_F","srifle_DMR_05_blk_F","srifle_DMR_05_hex_F","srifle_DMR_05_tan_f","srifle_LRR_LRPS_F","srifle_LRR_camo_LRPS_F","srifle_LRR_tna_LRPS_F","srifle_DMR_04_F","srifle_DMR_04_tan_F","MMG_02_sand_F","MMG_02_camo_F","MMG_02_black_F"]};
			};
		};
		default
		{
			switch (_faction) do
			{
				case "NATO":{_weaponTypesRifle = ["arifle_MXC_F","arifle_MXC_Black_F","arifle_MXC_khk_F","arifle_MX_F","arifle_MX_Black_F","arifle_MX_khk_F","arifle_SPAR_01_blk_F","arifle_SPAR_01_khk_F","arifle_SPAR_01_snd_F"]};
				case "CSAT":{_weaponTypesRifle = ["arifle_Katiba_C_F","arifle_Katiba_F","arifle_CTAR_blk_F","arifle_CTAR_hex_F","arifle_CTAR_ghex_F"]};
				case "AAF":{_weaponTypesRifle = ["arifle_Mk20C_plain_F","arifle_Mk20C_F","arifle_Mk20_plain_F","arifle_Mk20_F","arifle_TRG20_F","arifle_TRG21_F"]};
				case "SYN":{_weaponTypesRifle = ["arifle_AKS_F","arifle_AKM_F","arifle_AK12_F"]};
				case "IDAP":{_weaponTypesRifle = ["objNull"]};
				case "GEN":{_weaponTypesRifle = ["SMG_05_F"]};
				default {_weaponTypesRifle = ["objNull"]};
			};
		};
	};
//Launcher
	switch (_type) do
	{
		case ("AA"):
		{
			switch (_faction) do
			{
				case "NATO":{_weaponTypesLauncher = ["launch_Titan_F","launch_B_Titan_tna_F"]};
				case "CSAT":{_weaponTypesLauncher = ["launch_O_Titan_F","launch_O_Titan_ghex_F"]};
				case "AAF":{_weaponTypesLauncher = ["launch_Titan_F","launch_I_Titan_F"]};
			};
		};
		case "AT":
		{
			switch (_faction) do
			{
				case "NATO":{_weaponTypesLauncher = ["launch_NLAW_F","launch_NLAW_F","launch_NLAW_F","launch_NLAW_F","launch_NLAW_F","launch_NLAW_F","launch_Titan_short_F","launch_B_Titan_short_tna_F"]};
				case "CSAT":{_weaponTypesLauncher = ["launch_NLAW_F","launch_NLAW_F","launch_NLAW_F","launch_NLAW_F","launch_NLAW_F","launch_NLAW_F","launch_O_Titan_short_F","launch_O_Titan_short_ghex_F"]};
				case "AAF":{_weaponTypesLauncher = ["launch_NLAW_F","launch_NLAW_F","launch_NLAW_F","launch_NLAW_F","launch_NLAW_F","launch_NLAW_F","launch_Titan_short_F","launch_I_Titan_short_F"]};
				case "SYN":{_weaponTypesLauncher = ["launch_RPG7_F","launch_RPG32_F","launch_RPG32_ghex_F"];
			};
		};
		case "Viper":
		{
			switch (_faction) do
			{
				case "CSAT":{_weaponTypesLauncher = ["objNull","objNull","objNull","objNull","objNull","objNull","objNull","objNull","objNull","objNull","launch_O_Titan_F","launch_O_Titan_ghex_F","launch_NLAW_F","launch_NLAW_F","launch_NLAW_F","launch_NLAW_F","launch_NLAW_F","launch_NLAW_F","launch_O_Titan_short_F","launch_O_Titan_short_ghex_F"]};
			};
		};
		case "CTRG":
		{
			switch (_faction) do
			{
				case "NATO":{_weaponTypesLauncher = ["objNull","objNull","objNull","objNull","objNull","objNull","objNull","objNull","objNull","objNull","launch_Titan_F","launch_B_Titan_tna_F","launch_NLAW_F","launch_NLAW_F","launch_NLAW_F","launch_NLAW_F","launch_NLAW_F","launch_NLAW_F","launch_Titan_short_F","launch_B_Titan_short_tna_F"]};
			};
		};
		default
		{
			_weaponTypesLauncher = ["objNull"]};
		};
	};
//Pistol
	switch (_type) do
	{
		case "Crew":
		{
			switch (_faction) do
			{
				case "NATO":{_weaponTypesRifle = ["hgun_ACPC2_F"]};
				case "CSAT":{_weaponTypesRifle = ["hgun_Rook40_F"]};
				case "AAF":{_weaponTypesRifle = ["hgun_P07_F","hgun_P07_khk_F"]};
				default {_weaponTypesRifle = ["objNull"]};
			};
		};
		case "HeliCrew":
		{
			switch (_faction) do
			{
				case "NATO":{_weaponTypesRifle = ["hgun_ACPC2_F"]};
				case "CSAT":{_weaponTypesRifle = ["hgun_Rook40_F"]};
				case "AAF":{_weaponTypesRifle = ["hgun_P07_F","hgun_P07_khk_F"]};
				default {_weaponTypesRifle = ["objNull"]};
			};
		};
		case "HeliPilot":
		{
			switch (_faction) do
			{
				case "NATO":{_weaponTypesRifle = ["hgun_ACPC2_F"]};
				case "CSAT":{_weaponTypesRifle = ["hgun_Rook40_F"]};
				case "AAF":{_weaponTypesRifle = ["hgun_P07_F","hgun_P07_khk_F"]};
				default {_weaponTypesRifle = ["objNull"]};
			};
		};
		case "JetPilot":
		{
			switch (_faction) do
			{
				case "NATO":{_weaponTypesRifle = ["hgun_ACPC2_F"]};
				case "CSAT":{_weaponTypesRifle = ["hgun_Rook40_F"]};
				case "AAF":{_weaponTypesRifle = ["hgun_P07_F","hgun_P07_khk_F"]};
				default {_weaponTypesRifle = ["objNull"]};
			};
		};
		case "Medic":
		{
			switch (_faction) do
			{
				case "NATO":{_weaponTypesRifle = ["hgun_ACPC2_F"]};
				case "CSAT":{_weaponTypesRifle = ["hgun_Rook40_F"]};
				case "AAF":{_weaponTypesRifle = ["hgun_P07_F","hgun_P07_khk_F"]};
				default {_weaponTypesRifle = ["objNull"]};
			};
		};
		case "Viper":
		{
			switch (_faction) do
			{
				case "CSAT":{_weaponTypesPistor = ["objNull","objNull","objNull","hgun_Pistol_heavy_02_F"]};
			};
		};
		case "CTRG":
		{
			switch (_faction) do
			{
				case "NATO":{_weaponTypesPistor = ["objNull","objNull","objNull","hgun_Pistol_heavy_01_F"]};
			};
		};
		default
		{
			_weaponTypesPistor = ["objNull"];
		};
	};
//Sight
	switch (_type) do
	{
		case "Marksman":
		{
			_weaponSight = ["optic_SOS","optic_SOS_khk_F","optic_DMS","optic_DMS_ghex_F","optic_KHS_old","optic_KHS_blk","optic_KHS_hex","optic_KHS_tan","optic_AMS","optic_AMS_khk","optic_AMS_snd","optic_LRPS","optic_LRPS_ghex_F","optic_LRPS_tna_F","optic_NVS"];
		};
		case "Sniper":
		{
			_weaponSight = ["optic_SOS","optic_SOS_khk_F","optic_DMS","optic_KHS_old","optic_KHS_blk","optic_KHS_tan","optic_AMS","optic_AMS_khk","optic_AMS_snd","optic_LRPS","optic_NVS","optic_tws","optic_tws_mg","optic_Nightstalker"];
		};
		case "Viper":
		{
			switch (_faction) do
			{
				case "CSAT":{_weaponSight = ["optic_tws","optic_tws_mg","optic_Nightstalker"]};
			};
		};
		case "CTRG":
		{
			switch (_faction) do
			{
				case "NATO":{_weaponSight = ["optic_tws","optic_tws_mg","optic_Nightstalker"]};
			};
		};
		default
		{
			_weaponSight = ["objNull","optic_Aco","optic_Aco_grn","optic_Holosight"];
		};
	};
//Rail
	switch (_type) do
	{
		case "Marksman":
		{
			_weaponsRail = ["objNull","objNull","acc_pointer_IR"];
		};
		case "Sniper":
		{
			_weaponsRail = ["objNull","objNull","acc_pointer_IR"];
		};
		case "Viper":
		{
			switch (_faction) do
			{
				case "CSAT":{_weaponsRail = ["objNull","objNull","acc_pointer_IR"]};
			};
		};
		case "CTRG":
		{
			switch (_faction) do
			{
				case "NATO":{_weaponsRail = ["objNull","objNull","acc_pointer_IR"]};
			};
		};
		default
		{
			_weaponsRail = ["objNull","objNull","acc_flashlight"];
		};
	};
//Bipod
	switch (_faction) do
	{
		case "NATO":
		{
			switch (_type) do
			{
				case "Marksman":{_weaponsBipod = ["bipod_01_F_blk","bipod_01_F_mtp"]};
				case "Sniper":{_weaponsBipod = ["bipod_01_F_blk","bipod_01_F_mtp"]};
				default{_weaponsBipod = ["objNull","objNull","objNull","bipod_01_F_blk","bipod_01_F_mtp"]};
			};
		};
		case "CSAT":
		{
			switch (_type) do
			{
				case "Marksman":{_weaponsBipod = ["bipod_02_F_blk","bipod_02_F_hex"]};
				case "Sniper":{_weaponsBipod = ["bipod_02_F_blk","bipod_02_F_hex"]};
				default{_weaponsBipod = ["objNull","objNull","objNull","bipod_02_F_blk","bipod_02_F_hex"]};
			};
		};
		case "AAF":
		{
			switch (_type) do
			{
				case "Marksman":{_weaponsBipod = ["bipod_03_F_blk","bipod_03_F_oli","bipod_01_F_snd","bipod_02_F_tan","bipod_01_F_khk"]};
				case "Sniper":{_weaponsBipod = ["bipod_03_F_blk","bipod_03_F_oli","bipod_01_F_snd","bipod_02_F_tan","bipod_01_F_khk"]};
				default{_weaponsBipod = ["objNull","objNull","objNull","bipod_03_F_blk","bipod_03_F_oli","bipod_01_F_snd","bipod_02_F_tan","bipod_01_F_khk"]};
			};
		};
		default {_weaponsBipod = ["objNull"]};
	};
//Binoculars
	switch (_type) do
	{
		case "Marksman": {_BinocularTypes = ["Rangefinder"]};
		case "Sniper": {_BinocularTypes = ["Rangefinder"]};
		case "Viper": {_BinocularTypes = ["objNull","objNull","objNull","objNull","objNull","objNull","Rangefinder","Rangefinder","Laserdesignator"]};
		case "CTRG": {_BinocularTypes = ["objNull","objNull","objNull","objNull","objNull","objNull","Rangefinder","Rangefinder","Laserdesignator"]};
		default {_BinocularTypes = ["objNull","objNull","Binocular"]};
	};
//Terminal
	switch (_type) do
	{
		default {_TerminalTypes = ["objNull","objNull","ItemGPS"]};
	};
//Items
	switch (_type) do
	{
		case "Medic":{_itemsList = ["FirstAidKit","Medikit"]};
		case "Engineer":{_itemsList = ["MineDetector","FirstAidKit","ToolKit"]};
		case "Diver":{_itemsList = ["objNull"]};
		default {_itemsList = ["objNull","SmokeShellBlue","SmokeShellGreen","SmokeShellOrange",	"SmokeShellPurple","SmokeShellRed","SmokeShell","SmokeShellYellow","Chemlight_blue","Chemlight_green","Chemlight_red","Chemlight_yellow","FirstAidKit"]};
	};
//headgear
	switch (_faction) do
	{
		case "CSAT":
		{
			switch (_type) do
			{
				case "Diver":{_headgear = ["objNull"]};
				case "Crew":{_headgear = ["H_HelmetCrew_O","H_HelmetCrew_O_ghex_F"]};
				case "HeliPilot":{_headgear = ["H_PilotHelmetHeli_O"]};
				case "HeliCrew":{_headgear = ["H_CrewHelmetHeli_O","H_HelmetCrew_O_ghex_F"]};
				case "JetPilot":{_headgear = ["H_PilotHelmetFighter_O"]};
				case "Viper":{_headgear = ["H_HelmetO_ViperSP_ghex_F","H_HelmetO_ViperSP_hex_F"]};
				default{_headgear = ["H_HelmetSpecO_blk","H_HelmetSpecO_ocamo",	"H_HelmetSpecO_ghex_F","H_MilCap_ocamo","H_MilCap_rucamo","H_HelmetO_ocamo","H_HelmetO_ghex_F","H_HelmetO_oucamo"]};
			};
		};
		case "NATO":
		{
			switch (_type) do
			{
				case "Diver":{_headgear = ["objNull"]};
				case "Crew":{_headgear = ["H_HelmetCrew_B"]};
				case "HeliPilot":{_headgear = ["H_PilotHelmetHeli_B"]};
				case "HeliCrew":{_headgear = ["H_CrewHelmetHeli_B"]};
				case "JetPilot":{_headgear = ["H_PilotHelmetFighter_B"]};
				case "CTRG":{_headgear = ["H_HelmetB_TI_tna_F"]};
				default{_headgear = ["H_Cap_tan","H_HelmetB","H_HelmetB_black","H_HelmetB_camo","H_HelmetB_desert","H_HelmetB_grass","H_HelmetB_sand","H_HelmetB_snakeskin","H_HelmetB_tna_F","H_HelmetSpecB","H_HelmetSpecB_blk","H_HelmetSpecB_paint2","H_HelmetSpecB_paint1","H_HelmetSpecB_sand","H_HelmetSpecB_snakeskin","H_HelmetB_Enh_tna_F","H_HelmetB_light","H_HelmetB_light_black","H_HelmetB_light_desert","H_HelmetB_light_grass","H_HelmetB_light_sand","H_HelmetB_light_snakeskin","H_HelmetB_Light_tna_F","H_MilCap_mcamo"]};
			};
		};
		case "AAF":
		{
			switch (_type) do
			{
				case "Diver":{_headgear = ["objNull"]};
				case "Crew":{_headgear = ["H_HelmetCrew_I"]};
				case "HeliPilot":{_headgear = ["H_PilotHelmetHeli_I"]};
				case "HeliCrew":{_headgear = ["H_CrewHelmetHeli_I"]};
				case "JetPilot":{_headgear = ["H_PilotHelmetFighter_I"]};
				default{_headgear = ["H_MilCap_dgtl", "H_HelmetIA"]};
			};
		};
		case "GEN":
		{
			_headgear = ["H_Beret_gen_F","H_MilCap_gen_F"];
		};
		case "SYN":
		{
			_headgear = ["H_Bandanna_gry","H_Bandanna_sand","H_Bandanna_surfer","H_Bandanna_surfer_blk","H_Bandanna_cbr","H_Bandanna_gry","H_Bandanna_khk","H_Bandanna_sgg","H_BandMask_blk","H_BandMask_demon","H_BandMask_khk","H_BandMask_reaper","H_PASGT_basic_blue_F","H_PASGT_basic_olive_F","H_PASGT_neckprot_blue_press_F","H_PASGT_basic_white_F","H_Watchcap_blk","H_Watchcap_sgg","H_Watchcap_cbr","H_Watchcap_camo","H_Watchcap_khk","H_TurbanO_blk","H_WirelessEarpiece_F","H_Cap_grn_BI","H_Cap_grn_BI","H_Cap_blk","H_Cap_blu","H_Cap_blk_CMMG","H_Cap_blk_CMMG","H_Cap_grn","H_Cap_blk_ION","H_Cap_blk_ION","H_Cap_oli","H_Cap_oli_hs","H_Cap_red","H_Cap_surfer","H_Cap_tan","H_Construction_earprot_black_F","H_Construction_headset_black_F","H_Construction_basic_black_F","H_Construction_earprot_orange_F","H_Construction_headset_orange_F","H_Construction_basic_orange_F","H_Construction_earprot_red_F","H_Construction_headset_red_F","H_Construction_basic_red_F","H_Construction_earprot_vrana_F","H_Construction_headset_vrana_F","H_Construction_basic_vrana_F","H_Construction_earprot_white_F","H_Construction_headset_white_F","H_Construction_basic_white_F","H_Construction_earprot_yellow_F","H_Construction_headset_yellow_F","H_Construction_basic_yellow_F","H_EarProtectors_black_F","H_EarProtectors_orange_F","H_EarProtectors_red_F","H_EarProtectors_white_F","H_EarProtectors_yellow_F","H_Hat_blue","H_Hat_brown","H_Hat_camo","H_Hat_checker","H_Hat_grey","H_Hat_tan","H_HeadBandage_bloody_F","H_HeadBandage_clean_F","H_HeadBandage_stained_F","H_HeadSet_black_F","H_HeadSet_orange_F","H_HeadSet_red_F","H_HeadSet_white_F","H_HeadSet_yellow_F","H_RacingHelmet_1_black_F","H_RacingHelmet_1_blue_F","H_RacingHelmet_2_F","H_RacingHelmet_1_F","H_RacingHelmet_1_green_F","H_RacingHelmet_1_orange_F","H_RacingHelmet_1_red_F","H_RacingHelmet_3_F","H_RacingHelmet_4_F","H_RacingHelmet_1_white_F","H_RacingHelmet_1_yellow_F","H_Cap_headphones","H_Hat_Safari_olive_F","H_Hat_Safari_sand_F","H_ShemagOpen_tan","H_Shemag_olive","H_Shemag_olive_hs","H_ShemagOpen_khk","H_Shemag_khk","H_Shemag_olive","H_Shemag_tan"];
		};
		case "IDAP":
		{
			_headgear = ["H_Cap_Black_IDAP_F","H_Cap_Orange_IDAP_F","H_Cap_White_IDAP_F"];
		};
	};
//Face Items
	switch (_type) do
	{
		case "CTRG": {_faceItems = ["G_Balaclava_TI_blk_F","G_Balaclava_TI_G_blk_F","G_Balaclava_TI_tna_F","G_Balaclava_TI_G_tna_F"]};
		default {_faceItems = ["G_Aviator","G_Combat","G_Lady_Red","G_Lady_Mirror","G_Lady_Dark","G_Lady_Blue","G_Lowprofile","G_Shades_Black","G_Shades_Blue","G_Shades_Green","G_Shades_Red","G_Spectacles","G_Sport_Red","G_Sport_Blackyellow","G_Sport_BlackWhite","G_Sport_Checkered","G_Sport_Blackred","G_Sport_Greenblack","G_Squares_Tinted","G_Squares","G_Tactical_Clear","G_Tactical_Clear","G_Tactical_Black","G_Spectacles_Tinted"]};
	};
//Soldier Skill and Attributes
	Switch (_type) do
	{
		case "Sniper":
		{
			_allowFleeing = 1; // can the unit flee? 0 = no 1 = yes
			_rank = "SERGEANT"; //  PRIVATE, CORPORAL, SERGEANT, LIEUTENANT, CAPTAIN, MAJOR or COLONEL
			//Soldier Skills are set from 0 to 1; 
			_Accuracy = 1; //Soldier accuracy;
			_Courage = 1; //Affects unit's subordinates' morale (Higher value = more courage)
			_aimingShake = 1; //Affects how steadily the AI can hold a weapon (Higher value = less weapon sway)
			_aimingSpeed = 1; //Affects how quickly the AI can rotate and stabilize its aim (Higher value = faster, less error)
			_spotDistance = 1; //Affects the AI ability to spot targets within it's visual or audible range (Higher value = more likely to spot)
			_spotTime = 1; //Affects how quick the AI react to death, damage or observing an enemy (Higher value = quicker reaction)
			_reloadSpeed = 1; //Affects the delay between switching or reloading a weapon (Higher value = less delay)
			_commanding = 1; //Affects how quickly recognized targets are shared with the group (Higher value = faster reporting)	
		};
		case "Diver":
		{
			_allowFleeing = 1; // can the unit flee? 0 = no 1 = yes
			_rank = "LIEUTENANT"; //  PRIVATE, CORPORAL, SERGEANT, LIEUTENANT, CAPTAIN, MAJOR or COLONEL
			//Soldier Skills are set from 0 to 1; 
			_Accuracy = 0.1; //Soldier accuracy;
			_Courage = 1; //Affects unit's subordinates' morale (Higher value = more courage)
			_aimingShake = 1; //Affects how steadily the AI can hold a weapon (Higher value = less weapon sway)
			_aimingSpeed = 1; //Affects how quickly the AI can rotate and stabilize its aim (Higher value = faster, less error)
			_spotDistance = 1; //Affects the AI ability to spot targets within it's visual or audible range (Higher value = more likely to spot)
			_spotTime = 1; //Affects how quick the AI react to death, damage or observing an enemy (Higher value = quicker reaction)
			_reloadSpeed = 1; //Affects the delay between switching or reloading a weapon (Higher value = less delay)
			_commanding = 1; //Affects how quickly recognized targets are shared with the group (Higher value = faster reporting)	
		};
		case "HeliCrew":
		{
			_allowFleeing = 1; // can the unit flee? 0 = no 1 = yes
			_rank = "SERGEANT"; //  PRIVATE, CORPORAL, SERGEANT, LIEUTENANT, CAPTAIN, MAJOR or COLONEL
			//Soldier Skills are set from 0 to 1; 
			_Accuracy = 1; //Soldier accuracy;
			_Courage = 1; //Affects unit's subordinates' morale (Higher value = more courage)
			_aimingShake = 1; //Affects how steadily the AI can hold a weapon (Higher value = less weapon sway)
			_aimingSpeed = 1; //Affects how quickly the AI can rotate and stabilize its aim (Higher value = faster, less error)
			_spotDistance = 1; //Affects the AI ability to spot targets within it's visual or audible range (Higher value = more likely to spot)
			_spotTime = 1; //Affects how quick the AI react to death, damage or observing an enemy (Higher value = quicker reaction)
			_reloadSpeed = 1; //Affects the delay between switching or reloading a weapon (Higher value = less delay)
			_commanding = 1; //Affects how quickly recognized targets are shared with the group (Higher value = faster reporting)	
		};
		case "Helipilot":
		{
			_allowFleeing = 1; // can the unit flee? 0 = no 1 = yes
			_rank = "CAPTAIN"; //  PRIVATE, CORPORAL, SERGEANT, LIEUTENANT, CAPTAIN, MAJOR or COLONEL
			//Soldier Skills are set from 0 to 1; 
			_Accuracy = 1; //Soldier accuracy;
			_Courage = 1; //Affects unit's subordinates' morale (Higher value = more courage)
			_aimingShake = 1; //Affects how steadily the AI can hold a weapon (Higher value = less weapon sway)
			_aimingSpeed = 1; //Affects how quickly the AI can rotate and stabilize its aim (Higher value = faster, less error)
			_spotDistance = 1; //Affects the AI ability to spot targets within it's visual or audible range (Higher value = more likely to spot)
			_spotTime = 1; //Affects how quick the AI react to death, damage or observing an enemy (Higher value = quicker reaction)
			_reloadSpeed = 1; //Affects the delay between switching or reloading a weapon (Higher value = less delay)
			_commanding = 1; //Affects how quickly recognized targets are shared with the group (Higher value = faster reporting)	
		};
		case "JetPilot":
		{
			_allowFleeing = 1; // can the unit flee? 0 = no 1 = yes
			_rank = "MAJOR"; //  PRIVATE, CORPORAL, SERGEANT, LIEUTENANT, CAPTAIN, MAJOR or COLONEL
			//Soldier Skills are set from 0 to 1; 
			_Accuracy = 1; //Soldier accuracy;
			_Courage = 1; //Affects unit's subordinates' morale (Higher value = more courage)
			_aimingShake = 1; //Affects how steadily the AI can hold a weapon (Higher value = less weapon sway)
			_aimingSpeed = 1; //Affects how quickly the AI can rotate and stabilize its aim (Higher value = faster, less error)
			_spotDistance = 1; //Affects the AI ability to spot targets within it's visual or audible range (Higher value = more likely to spot)
			_spotTime = 1; //Affects how quick the AI react to death, damage or observing an enemy (Higher value = quicker reaction)
			_reloadSpeed = 1; //Affects the delay between switching or reloading a weapon (Higher value = less delay)
			_commanding = 1; //Affects how quickly recognized targets are shared with the group (Higher value = faster reporting)	
		};
		case "CTRG":
		{
			_allowFleeing = 1; // can the unit flee? 0 = no 1 = yes
			_rank = "CAPTAIN"; //  PRIVATE, CORPORAL, SERGEANT, LIEUTENANT, CAPTAIN, MAJOR or COLONEL
			//Soldier Skills are set from 0 to 1; 
			_Accuracy = 1; //Soldier accuracy;
			_Courage = 1; //Affects unit's subordinates' morale (Higher value = more courage)
			_aimingShake = 1; //Affects how steadily the AI can hold a weapon (Higher value = less weapon sway)
			_aimingSpeed = 1; //Affects how quickly the AI can rotate and stabilize its aim (Higher value = faster, less error)
			_spotDistance = 1; //Affects the AI ability to spot targets within it's visual or audible range (Higher value = more likely to spot)
			_spotTime = 1; //Affects how quick the AI react to death, damage or observing an enemy (Higher value = quicker reaction)
			_reloadSpeed = 1; //Affects the delay between switching or reloading a weapon (Higher value = less delay)
			_commanding = 1; //Affects how quickly recognized targets are shared with the group (Higher value = faster reporting)	
		};
		case "Viper":
		{
			_allowFleeing = 1; // can the unit flee? 0 = no 1 = yes
			_rank = "CAPTAIN"; //  PRIVATE, CORPORAL, SERGEANT, LIEUTENANT, CAPTAIN, MAJOR or COLONEL
			//Soldier Skills are set from 0 to 1; 
			_Accuracy = 1; //Soldier accuracy;
			_Courage = 1; //Affects unit's subordinates' morale (Higher value = more courage)
			_aimingShake = 1; //Affects how steadily the AI can hold a weapon (Higher value = less weapon sway)
			_aimingSpeed = 1; //Affects how quickly the AI can rotate and stabilize its aim (Higher value = faster, less error)
			_spotDistance = 1; //Affects the AI ability to spot targets within it's visual or audible range (Higher value = more likely to spot)
			_spotTime = 1; //Affects how quick the AI react to death, damage or observing an enemy (Higher value = quicker reaction)
			_reloadSpeed = 1; //Affects the delay between switching or reloading a weapon (Higher value = less delay)
			_commanding = 1; //Affects how quickly recognized targets are shared with the group (Higher value = faster reporting)	
		};
		case "Commander":
		{
			_allowFleeing = 1; // can the unit flee? 0 = no 1 = yes
			_rank = "LIEUTENANT"; //  PRIVATE, CORPORAL, SERGEANT, LIEUTENANT, CAPTAIN, MAJOR or COLONEL
			//Soldier Skills are set from 0 to 1; 
			_Accuracy = 0.6; //Soldier accuracy;
			_Courage = 1; //Affects unit's subordinates' morale (Higher value = more courage)
			_aimingShake = 1; //Affects how steadily the AI can hold a weapon (Higher value = less weapon sway)
			_aimingSpeed = 1; //Affects how quickly the AI can rotate and stabilize its aim (Higher value = faster, less error)
			_spotDistance = 1; //Affects the AI ability to spot targets within it's visual or audible range (Higher value = more likely to spot)
			_spotTime = 1; //Affects how quick the AI react to death, damage or observing an enemy (Higher value = quicker reaction)
			_reloadSpeed = 1; //Affects the delay between switching or reloading a weapon (Higher value = less delay)
			_commanding = 1; //Affects how quickly recognized targets are shared with the group (Higher value = faster reporting)	
		};
		case "AT":
		{
			_allowFleeing = 1; // can the unit flee? 0 = no 1 = yes
			_rank = "LIEUTENANT"; //  PRIVATE, CORPORAL, SERGEANT, LIEUTENANT, CAPTAIN, MAJOR or COLONEL
			//Soldier Skills are set from 0 to 1; 
			_Accuracy = 0.7; //Soldier accuracy;
			_Courage = 1; //Affects unit's subordinates' morale (Higher value = more courage)
			_aimingShake = 1; //Affects how steadily the AI can hold a weapon (Higher value = less weapon sway)
			_aimingSpeed = 1; //Affects how quickly the AI can rotate and stabilize its aim (Higher value = faster, less error)
			_spotDistance = 1; //Affects the AI ability to spot targets within it's visual or audible range (Higher value = more likely to spot)
			_spotTime = 1; //Affects how quick the AI react to death, damage or observing an enemy (Higher value = quicker reaction)
			_reloadSpeed = 1; //Affects the delay between switching or reloading a weapon (Higher value = less delay)
			_commanding = 1; //Affects how quickly recognized targets are shared with the group (Higher value = faster reporting)	
		};
		case "AA":
		{
			_allowFleeing = 1; // can the unit flee? 0 = no 1 = yes
			_rank = "LIEUTENANT"; //  PRIVATE, CORPORAL, SERGEANT, LIEUTENANT, CAPTAIN, MAJOR or COLONEL
			//Soldier Skills are set from 0 to 1; 
			_Accuracy = 0.5; //Soldier accuracy;
			_Courage = 1; //Affects unit's subordinates' morale (Higher value = more courage)
			_aimingShake = 1; //Affects how steadily the AI can hold a weapon (Higher value = less weapon sway)
			_aimingSpeed = 1; //Affects how quickly the AI can rotate and stabilize its aim (Higher value = faster, less error)
			_spotDistance = 1; //Affects the AI ability to spot targets within it's visual or audible range (Higher value = more likely to spot)
			_spotTime = 1; //Affects how quick the AI react to death, damage or observing an enemy (Higher value = quicker reaction)
			_reloadSpeed = 1; //Affects the delay between switching or reloading a weapon (Higher value = less delay)
			_commanding = 1; //Affects how quickly recognized targets are shared with the group (Higher value = faster reporting)	
		};
		case "Crew":
		{
			_allowFleeing = 1; // can the unit flee? 0 = no 1 = yes
			_rank = "LIEUTENANT"; //  PRIVATE, CORPORAL, SERGEANT, LIEUTENANT, CAPTAIN, MAJOR or COLONEL
			//Soldier Skills are set from 0 to 1; 
			_Accuracy = 0.1; //Soldier accuracy;
			_Courage = 1; //Affects unit's subordinates' morale (Higher value = more courage)
			_aimingShake = 1; //Affects how steadily the AI can hold a weapon (Higher value = less weapon sway)
			_aimingSpeed = 1; //Affects how quickly the AI can rotate and stabilize its aim (Higher value = faster, less error)
			_spotDistance = 1; //Affects the AI ability to spot targets within it's visual or audible range (Higher value = more likely to spot)
			_spotTime = 1; //Affects how quick the AI react to death, damage or observing an enemy (Higher value = quicker reaction)
			_reloadSpeed = 1; //Affects the delay between switching or reloading a weapon (Higher value = less delay)
			_commanding = 1; //Affects how quickly recognized targets are shared with the group (Higher value = faster reporting)	
		};
		case "Medic":
		{
			_allowFleeing = 1; // can the unit flee? 0 = no 1 = yes
			_rank = "LIEUTENANT"; //  PRIVATE, CORPORAL, SERGEANT, LIEUTENANT, CAPTAIN, MAJOR or COLONEL
			//Soldier Skills are set from 0 to 1; 
			_Accuracy = 0.1; //Soldier accuracy;
			_Courage = 1; //Affects unit's subordinates' morale (Higher value = more courage)
			_aimingShake = 1; //Affects how steadily the AI can hold a weapon (Higher value = less weapon sway)
			_aimingSpeed = 1; //Affects how quickly the AI can rotate and stabilize its aim (Higher value = faster, less error)
			_spotDistance = 1; //Affects the AI ability to spot targets within it's visual or audible range (Higher value = more likely to spot)
			_spotTime = 1; //Affects how quick the AI react to death, damage or observing an enemy (Higher value = quicker reaction)
			_reloadSpeed = 1; //Affects the delay between switching or reloading a weapon (Higher value = less delay)
			_commanding = 1; //Affects how quickly recognized targets are shared with the group (Higher value = faster reporting)	
		};
		case "Grenedier":
		{
			_allowFleeing = 1; // can the unit flee? 0 = no 1 = yes
			_rank = "LIEUTENANT"; //  PRIVATE, CORPORAL, SERGEANT, LIEUTENANT, CAPTAIN, MAJOR or COLONEL
			//Soldier Skills are set from 0 to 1; 
			_Accuracy = 0.4; //Soldier accuracy;
			_Courage = 1; //Affects unit's subordinates' morale (Higher value = more courage)
			_aimingShake = 1; //Affects how steadily the AI can hold a weapon (Higher value = less weapon sway)
			_aimingSpeed = 1; //Affects how quickly the AI can rotate and stabilize its aim (Higher value = faster, less error)
			_spotDistance = 1; //Affects the AI ability to spot targets within it's visual or audible range (Higher value = more likely to spot)
			_spotTime = 1; //Affects how quick the AI react to death, damage or observing an enemy (Higher value = quicker reaction)
			_reloadSpeed = 1; //Affects the delay between switching or reloading a weapon (Higher value = less delay)
			_commanding = 1; //Affects how quickly recognized targets are shared with the group (Higher value = faster reporting)	
		};
		case "Marksman":
		{
			_allowFleeing = 1; // can the unit flee? 0 = no 1 = yes
			_rank = "LIEUTENANT"; //  PRIVATE, CORPORAL, SERGEANT, LIEUTENANT, CAPTAIN, MAJOR or COLONEL
			//Soldier Skills are set from 0 to 1; 
			_Accuracy = 0.8; //Soldier accuracy;
			_Courage = 1; //Affects unit's subordinates' morale (Higher value = more courage)
			_aimingShake = 1; //Affects how steadily the AI can hold a weapon (Higher value = less weapon sway)
			_aimingSpeed = 1; //Affects how quickly the AI can rotate and stabilize its aim (Higher value = faster, less error)
			_spotDistance = 1; //Affects the AI ability to spot targets within it's visual or audible range (Higher value = more likely to spot)
			_spotTime = 1; //Affects how quick the AI react to death, damage or observing an enemy (Higher value = quicker reaction)
			_reloadSpeed = 1; //Affects the delay between switching or reloading a weapon (Higher value = less delay)
			_commanding = 1; //Affects how quickly recognized targets are shared with the group (Higher value = faster reporting)	
		};
		case "SAW":
		{
			_allowFleeing = 1; // can the unit flee? 0 = no 1 = yes
			_rank = "LIEUTENANT"; //  PRIVATE, CORPORAL, SERGEANT, LIEUTENANT, CAPTAIN, MAJOR or COLONEL
			//Soldier Skills are set from 0 to 1; 
			_Accuracy = 0.2; //Soldier accuracy;
			_Courage = 1; //Affects unit's subordinates' morale (Higher value = more courage)
			_aimingShake = 1; //Affects how steadily the AI can hold a weapon (Higher value = less weapon sway)
			_aimingSpeed = 1; //Affects how quickly the AI can rotate and stabilize its aim (Higher value = faster, less error)
			_spotDistance = 1; //Affects the AI ability to spot targets within it's visual or audible range (Higher value = more likely to spot)
			_spotTime = 1; //Affects how quick the AI react to death, damage or observing an enemy (Higher value = quicker reaction)
			_reloadSpeed = 1; //Affects the delay between switching or reloading a weapon (Higher value = less delay)
			_commanding = 1; //Affects how quickly recognized targets are shared with the group (Higher value = faster reporting)	
		};
		default
		{
			_allowFleeing = 1; // can the unit flee? 0 = no 1 = yes
			_rank = "PRIVATE"; //  PRIVATE, CORPORAL, SERGEANT, LIEUTENANT, CAPTAIN, MAJOR or COLONEL
			//Soldier Skills are set from 0 to 1; 
			_Accuracy = 0.3; //Soldier accuracy;
			_Courage = 1; //Affects unit's subordinates' morale (Higher value = more courage)
			_aimingShake = 0.7; //Affects how steadily the AI can hold a weapon (Higher value = less weapon sway)
			_aimingSpeed = 0.4; //Affects how quickly the AI can rotate and stabilize its aim (Higher value = faster, less error)
			_spotDistance = 0.5; //Affects the AI ability to spot targets within it's visual or audible range (Higher value = more likely to spot)
			_spotTime = 0.5; //Affects how quick the AI react to death, damage or observing an enemy (Higher value = quicker reaction)
			_reloadSpeed = 0.4; //Affects the delay between switching or reloading a weapon (Higher value = less delay)
			_commanding = 0.2; //Affects how quickly recognized targets are shared with the group (Higher value = faster reporting)	
		};
	};
//Spawn the Soldier
	private _soldier = _group createUnit [_soldierTypes, _position, [], 20, "NONE"];
//Give soldier a uniform
	_soldier forceaddUniform (selectrandom _uniformTypes);
//Give Soldier a Vest
	_soldier addVest (selectrandom _vestTypes);
//Maybe give the soldier a backpack
	_soldier addBackpack (selectrandom _BackpackTypes);
//Maybe Give the Soldier a weapon
	[_soldier,selectrandom  _weaponTypesRifle, 3] call BIS_fnc_addWeapon;
//Maybe give the soldier a Launcher
	[_soldier,selectrandom  _weaponTypesLauncher, 3] call BIS_fnc_addWeapon;
//Maybe give the soldier a pistol
	[_soldier,selectrandom  _weaponTypesPistor, 3] call BIS_fnc_addWeapon;
//Maybe give the soldier some gun bling
	_soldier addPrimaryWeaponItem (selectrandom _weaponSight);
	_soldier addPrimaryWeaponItem (selectrandom _weaponsRail);
	_soldier addPrimaryWeaponItem (selectrandom _weaponsBipod);
//Maybe give the soldier some binoculars
	_bino = selectrandom _BinocularTypes;
	_soldier additem _bino;
	_soldier linkitem _bino;
//Give the soldier a hat
	_soldier addHeadgear (selectrandom _headgear);
//Maybe give the soldier some glasses
	_faceItem = selectrandom _faceItems;
	_soldier additem _faceItem;
	_soldier linkItem _faceItem;
//Give the soldier some stuff
	for "_i" from 1 to 10 do
	{
		private _item = selectrandom _itemsList;
		_soldier additem _item;
	};
//Maybe give the soldier a GPS or UAV Terminal
	_terminal = selectrandom _TerminalTypes;
	_soldier additem _terminal;
	_soldier linkitem _terminal;
//Set the Soldiers rank and Skills
	_soldier setRank _rank;
	_soldier allowFleeing 0;
	_soldier setSkill ["aimingAccuracy", _Accuracy];
	_soldier setSkill ["courage", _Courage];
	_soldier setskill ["aimingShake", _aimingShake];
	_soldier setskill ["aimingSpeed", _aimingSpeed];
	_soldier setskill ["spotDistance", _spotDistance];
	_soldier setskill ["spotTime", _spotTime];
	_soldier setskill ["commanding", _commanding];
	_soldier setskill ["reloadSpeed", _reloadSpeed];
//Finish up
	_soldier triggerDynamicSimulation true;
	_soldier addEventHandler ["Killed", server_playerDied];
	_soldier
