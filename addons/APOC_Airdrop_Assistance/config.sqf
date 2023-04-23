//Configuration for Airdrop Assistance
//Author: Apoc
#include "..\..\STConstants.h"

APOC_AA_VehOptions =
[
// ["Menu Text",        ItemClassname,                      Price,  "Drop type"]
["Quadbike (Civilian)", "C_Quadbike_01_F",                  1200,   "vehicle"],
["Rescue Boat",         "C_Rubberboat",                     2500,   "vehicle"],
["Assault Boat", 		"B_Boat_Transport_01_F", 			4900, 	"vehicle"],
["Hatchback Sport", 	"C_Hatchback_01_sport_F", 			5000, 	"vehicle"],
["SUV", 				"C_SUV_01_F", 						5200, 	"vehicle"],
["MB 4WD",				"I_C_Offroad_02_unarmed_F", 		5500,	"vehicle"],
["Strider",             "I_MRAP_03_F",                      10000,  "vehicle"]
];

APOC_AA_LightOptions =
[
// ["Menu Text",        ItemClassname,                      Price,  "Drop type"]	
["Strider HMG",         "I_MRAP_03_hmg_F",                  30000,  "Armoured"],
["Strider GMG",         "I_MRAP_03_gmg_F",                  50000,  "Armoured"],
["Prowler HMG", 		"B_T_LSV_01_armed_F", 				90000, 	"Armoured"],
["Qilin Minigun", 		"O_T_LSV_02_armed_F", 				12000, 	"Armoured"],
["Ifrit HMG", 			"O_MRAP_02_hmg_F", 					30000, 	"Armoured"],
["MSE-3 Marid",			"O_APC_Wheeled_02_rcws_F", 			90000,	"Armoured"],
//["CRV-6e Bobcat",       "B_APC_Tracked_01_CRV_F",         45000,  "Armoured"],
["MSE-3 Marid",         "O_APC_Wheeled_02_rcws_F",          50000,  "Armoured"],
["FV-720 Mora", 		"I_APC_tracked_03_cannon_F", 		90000, 	"Armoured"]
];


APOC_AA_TankOptions =
[
// ["Menu Text",        ItemClassname,                      Price,  "Drop type"]
["ZSU-39 Tigris AA", 	"O_APC_Tracked_02_AA_F", 			130000,	"Tanks"],
["M2A4 Slammer HMG", 	"B_MBT_01_TUSK_F", 					120000, "Tanks"],
["T-100 Varsuk",        "O_MBT_02_cannon_F",                175000, "Tanks"],
["MBT-52 Kuma",         "I_MBT_03_cannon_F",                200000, "Tanks"]
];



APOC_AA_HeliOptions =
[
// ["Menu Text",        ItemClassname,                      Price,  "Drop type"]
["M-900 Civilian", 		"C_Heli_Light_01_civil_F", 			8000,  	"Helicoptors"],
["UH-80 Ghost Hawk",    "B_Heli_Transport_01_camo_F",       15000,  "Helicoptors"],
["Pawnee", 				"B_Heli_Light_01_armed_F", 			60000, 	"Helicoptors"],
["Helicat", 			"I_Heli_light_03_dynamicLoadout_F", 130000, "Helicoptors"]
];

APOC_AA_BoatOptions =
[
["Rescue Boat",         "C_Rubberboat",                     2500,   "Boats"],
["Assault Boat", 		"B_Boat_Transport_01_F", 			4900, 	"Boats"],
["SDV", 				"I_SDV_01_F", 						5200, 	"Boats"]
];

APOC_AA_SupOptions =
[
// ["stringItemName",   "fn_refillBox crate,                Price,  "Drop type"]
["General Supplies",    "General_supplies",                 30000,  "supply"],
["Diving Gear",         "Diving_Gear",                      30000,  "supply"],
["Black Box",			"mission_Gear_BlackBox",			30000,	"supply"],
["Hunter",				"mission_Gear_Hunter",				40000,	"supply"],
["Random XL",			"mission_Gear_RandomXL",			50000,	"supply"],
["Random XS",			"mission_Gear_RandomXS",			50000,	"supply"],
["Sniper Rifles",       "airdrop_Snipers",                  55000,  "supply"],
["Launchers",           "mission_USLaunchers",              60000,  "supply"],
["Anti-Tank Pack", 		ST_ATCONVENIENCEKIT, 				400000, "supply"],
["Anti-Air Pack", 		ST_AACONVENIENCEKIT, 				400000, "supply"]
];

APOC_AA_BaseOptions =
[
//"Menu Text",             "Base carrier",                  Price,  "Drop type"]
["Base in a Box (Medium)", "Land_Cargo20_yellow_F",         150000, "base1"],
["Base in a Box (Large)",  "Land_Cargo40_white_F",          250000, "base2"]
];


// Optional boxes to drop
/*
	["General Supplies","General_supplies",30000,  "supply"],
	["Diving Gear","Diving_Gear",30000,  "supply"],
	["Ammo Drop","Ammo_Drop",60000,"supply"],
	["Assault Rifles","mission_USSpecial",40000,  "supply"],
	["DLC Rifles","airdrop_DLC_Rifles",45000,  "supply"],
	["DLC LMGs","airdrop_DLC_LMGs",50000,  "supply"],
	["Sniper Rifles","airdrop_Snipers", 55000,  "supply"],
	["Launchers","mission_USLaunchers",60000,  "supply"],
	["Anti-Tank Pack",ST_ATCONVENIENCEKIT,400000, "supply"],
	["Anti-Air Pack",ST_AACONVENIENCEKIT,400000, "supply"]
	["Launchers", "mission_Launchers1", 100000, "supply"],
	["Assault Rifles", "mission_Assault1", 80000, "supply"],
	["Sniper Rifles", "mission_Snipers2", 90000, "supply"],
	["Sniper Rifles #2", "mission_Snipers3", 97500, "supply"],
	["Machine Guns", "mission_LMGs1", 75000, "supply"],
	["Marksmen DLC Box", "mission_DLC_marks", 85000, "supply"],
	["Apex DLC Box", "mission_DLC_apex", 85000, "supply"],
	["Contact DLC Box", "mission_DLC_contact", 90000, "supply"],
	["Dive Gear", "mission_Gear_Diving", 20000, "supply"],
	["Night Event Box","mission_Gear_Night", 10000, "supply"]
	["Launchers #1","mission_Launchers1",1,"supply"], 
	["Launchers #2","mission_Launchers2",1,"supply"],
	["Launchers #3","mission_Launchers3",1,"supply"],
	["LMGs Box","mission_LMGs1",1,"supply"],
	["Weapons Box #1","mission_Weapon1",1,"supply"],
	["Weapons Box #2","mission_Weapon2",1,"supply"],
	["Weapons Box #3","mission_Weapon3",1,"supply"],
	["Weapon_camo *New Box","mission_Weapon_camo",1,"supply"],
	["Weapon_green *New Box","mission_Weapon_green",1,"supply"],
	["Weapon_tropic *New Box","mission_Weapon_tropic",1,"supply"],
	["Weapon_sand *New Box","mission_Weapon_sand",1,"supply"],
	["Sniper Box #1","mission_Snipers1",1,"supply"],
	["Sniper Box #2","mission_Snipers2",1,"supply"],
	["Sniper Box #3","mission_Snipers3",1,"supply"],
	["Sniper Box #4","mission_Snipers4",1,"supply"],
	["DLC Marksmen Box","mission_DLC_marks",1,"supply"],
	["DLC Apex Box","mission_DLC_apex",1,"supply"],
	["DLC Contact Box","mission_DLC_contact",1,"supply"],
	["Cop Box","mission_Gear_Cop",1,"supply"],
	["Ammo Box","mission_Gear_Ammo",1,"supply"],
	["Diving Box","mission_Gear_Diving",1,"supply"],
	["Black Box","mission_Gear_BlackBox",1,"supply"],
	["Hunter *New Box","mission_Gear_Hunter",1,"supply"],
	["Biohazard *New Box","mission_Gear_Biohazard",1,"supply"],
	["Night *New Box","mission_Gear_Night",1,"supply"],
	["Random XL *New Box","mission_Gear_RandomXL",1,"supply"],
	["Random XS *New Box","mission_Gear_RandomXS",1,"supply"]
*/