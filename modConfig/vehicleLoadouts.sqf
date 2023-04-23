// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2017 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: vehicleLoadouts.sqf
//	@file Author: AgentRev, GMG_Monkey

/*
	HOW TO CREATE A PYLON LOADOUT:
	 1. Create new scenario in Eden, add vehicle, adjust pylon loadout, and set Object Init to: copyToClipboard str getPylonMagazines this
	 3. Play scenario, wait until loaded, then pause game and return to Eden.
	 4. Your pylon array is now in the clipboard, which you can paste in this file, e.g. _pylons = ["PylonMissile_Missile_AA_R73_x1","","","","","","","","","","","","",""];

	Note: You can use any pylon type you want in the script, even if not shown in the editor, it should normally work! e.g. "PylonRack_12Rnd_missiles" for "B_Plane_Fighter_01_F"
*/
/*
PYLON OPTIONS:
	AIR TO GROUND MISSILES:
		"PylonRack_1Rnd_LG_scalpel"						SCALPEL X1
		"PylonRack_3Rnd_LG_scalpel"						SCALPEL X3
		"PylonRack_4Rnd_LG_scalpel"						SCALPEL X4
		"PylonRack_1Rnd_Missile_AGM_02_F"				MACER AGM X1
		"PylonRack_Missile_AGM_02_x1"					MACER II AGM X1
		"PylonMissile_Missile_AGM_02_x2"				MACER AGM X2
		"PylonRack_Missile_AGM_02_x2"					MACER II X2
		"PylonRack_3Rnd_Missile_AGM_02_F"				MACER AGM X3
		"PylonRack_12Rnd_PG_missiles"					DAGR X12
		"PylonRack_1Rnd_Missile_AGM_01_F"				SHARUR X1
		"PylonMissile_Missile_AGM_KH25_x1"				KH-25 X1

	AIR TO AIR MISSILES:
		"PylonRack_1Rnd_Missile_AA_04_F"				FALCHION 22 X1
		"PylonRack_1Rnd_AAA_missiles"					ASRAAM X1
		"PylonRack_Missile_AMRAAM_C_x1"					AMRAAM C X1
		"PylonRack_Missile_AMRAAM_C_x2"					AMRAAM C X2
		"PylonMissile_Missile_AMRAAM_D_INT_x1"			AMRAAM D X1
		"PylonRack_Missile_AMRAAM_D_x2"					AMRAAM D X2
		"PylonRack_Missile_BIM9X_x2"					BIM9X X2
		"PylonMissile_Missile_BIM9X_x1"					BIM8X X1
		"PylonRack_1Rnd_Missile_AA_03_F"				SAHR-3
		"PylonMissile_Missile_AA_R73_x1"				R-73 X1
		"PylonMissile_Missile_AA_R77_x1"				R-77 X1
		"PylonRack_1Rnd_GAA_missiles"					ZYPHER X1

	ROCKETS:
		"PylonRack_12Rnd_missiles"						DAR ROCKETS X12
		"PylonRack_7Rnd_Rocket_04_HE_F"					SHRIEKER HE ROCKETS X7
		"PylonRack_7Rnd_Rocket_04_AP_F"					SHRIEKER AP ROCKETS X7
		"PylonRack_20Rnd_Rocket_03_HE_F"				TRATNYR HE ROCKETS X20
		"PylonRack_20Rnd_Rocket_03_AP_F"				TRATNYR AP ROCKETS X20
		"PylonRack_19Rnd_Rocket_Skyfire"				SKYFIRE X19

	 Guided BOMBS:
		"PylonMissile_1Rnd_Bomb_04_F"					GBU-12 GUIDED BOMB NATO X1
		"PylonMissile_1Rnd_Bomb_03_F"					LOM-250G GUIDED BOMB CSAT X1
		"PylonMissile_Bomb_GBU12_x1"					GBU-12 LASER GUIDIED BOMB X1
		"PylonRack_Bomb_GBU12_x2"						GBU-12 LASER GUIDED BOMB X2
		"PylonMissile_Bomb_KAB250_x1"					KAB250 GUIDED BOMB X1
	Dumb Bombs:
	"PylonMissile_1Rnd_Mk82_F"							MK-82 DUMB BOMB X1
	GUNS:
		"PylonWeapon_300Rnd_20mm_shells"				20mm TWIN CANNON
		"PylonWeapon_2000Rnd_65x39_belt"				6.5mm GATTLING GUN (RIGHT SIDE)

		NUMBER OF PYLONS:
			GREYHAWK/ABABIL: 2
			UCAV SENTINEL: 2
			MQ-12 FALCON: 2
			AH-6 PAWNEE: 2+2GUNS
			WY-55 HELLCAT: 2+2GUNS
			PO-30 ORCA: 2
			AH-99 BLACKFOOT: 6+MAIN CANNON
			Mi-48 KAJMAN 4
			A-143 BUZZARD: 7
			A-149 GRYPHON: 7+CANNON
			A-164 WIPEOUT 10+CANNON
			F/A-181 BLACK WASP II: 12+CANNON
			F/A-181 BLACK WASP II STEALTH: 8+CANNON
			To-199 NEOPHRON: 10+CANNON
			To-201 SHIKRA: 13+CANNON
			To-201 SHIKRA STEALTH: 7+CANNON
			Y-32 XI'AN: 4+MAIN CANNON
*/
switch (true) do
{
	// AH-9 Pawnee
		case (_class isKindOf "B_Heli_Light_01_dynamicLoadout_F"):
		{
			switch (_variant) do
			{
			/* Sky Hunter */		case "PawneeSkyHunter":	{ _pylons = ["PylonRack_19Rnd_Rocket_Skyfire","PylonRack_1Rnd_Missile_AA_04_F"]};
			/* Tank Buster */		case "PawneeTankhunter":{ _pylons = ["PylonRack_12Rnd_PG_missiles","PylonRack_3Rnd_Missile_AGM_02_F"]};	
			/* Normal */			case "pawneeNormal":	{ _pylons = ["PylonRack_12Rnd_missiles","PylonWeapon_2000Rnd_65x39_belt"]};				
			/* 20MM */				case "pawnee20mm":		{ _pylons = ["PylonWeapon_300Rnd_20mm_shells","PylonWeapon_300Rnd_20mm_shells"]};
			/* DAR */				case "pawneeDAR":		{ _pylons = ["PylonRack_12Rnd_missiles","PylonRack_12Rnd_missiles"]};
			/* Shrieker HE */		case "pawneeS_HE":		{ _pylons = ["PylonRack_7Rnd_Rocket_04_HE_F","PylonRack_7Rnd_Rocket_04_HE_F"]};
			/* SHRIEKER AP */		case "pawneeS_AP":		{ _pylons = ["PylonRack_7Rnd_Rocket_04_AP_F","PylonRack_7Rnd_Rocket_04_AP_F"]};
			/* TRATNYR HE */		case "pawneeT_HE":		{ _pylons = ["PylonRack_20Rnd_Rocket_03_HE_F","PylonRack_20Rnd_Rocket_03_HE_F"]};
			/* TRATNYR AP */		case "pawneeT_AP":		{ _pylons = ["PylonRack_20Rnd_Rocket_03_AP_F","PylonRack_20Rnd_Rocket_03_AP_F"]};
			/* SCALPEL X4 */		case "pawneeSCALX4":	{ _pylons = ["PylonRack_4Rnd_LG_scalpel","PylonRack_4Rnd_LG_scalpel"]};
			/* FALCHION */			case "pawneeFALCHION":	{ _pylons = ["PylonRack_1Rnd_Missile_AA_04_F","PylonRack_1Rnd_Missile_AA_04_F"]};
			/* DAGT+SCAL */			case "PawneeGround":	{ _pylons = ["PylonRack_12Rnd_PG_missiles","PylonRack_1Rnd_LG_scalpel"]};
			/* Delta "/				case "pawneeDelta": 	{ _pylons = ["PylonWeapon_300Rnd_20mm_shells","PylonWeapon_2000Rnd_65x39_belt"] };

			/*GUN ONLY*/			default					{ _pylons = ["",""]};
			};
		};

	// PO-30 Orca
		case (_class isKindOf "O_Heli_Light_02_dynamicLoadout_F"):
		{
			switch (_variant) do
			{
			/* Unarmed */		case "Unarmed":			{ _pylons = ["",""]};
			/* Gun Only */		case "orcaGUN":			{ _pylons = ["PylonWeapon_2000Rnd_65x39_belt",""]};
			/* DAR */			case "orcaGUNDAR":		{ _pylons = ["PylonWeapon_2000Rnd_65x39_belt","PylonRack_12Rnd_missiles"]};
			/* DAGR */			default					{ _pylons = ["PylonWeapon_2000Rnd_65x39_belt","PylonRack_12Rnd_PG_missiles"]};
			};
		};

	// WY-55 HELLCAT (GUNS ONLY)
		case (_class isKindOf "I_Heli_light_03_dynamicLoadout_F"):
		{
			switch (_variant) do
			{
			/* Shrieker */			case "HellShrieker":	{ _pylons = ["PylonRack_7Rnd_Rocket_04_HE_F","PylonRack_7Rnd_Rocket_04_AP_F"]};
			/* DAGR + SCALx3 */		case "HellAT":			{ _pylons = ["PylonRack_12Rnd_PG_missiles","PylonRack_3Rnd_LG_scalpel"]};
			/* Gun Only */			case "HellGun":			{ _pylons = ["",""]};
			/* 20mm */				case "Hell20mm":		{ _pylons = ["PylonWeapon_300Rnd_20mm_shells","PylonWeapon_300Rnd_20mm_shells"]};
			/* DAGR */				case "HellDAGR":		{ _pylons = ["PylonRack_12Rnd_PG_missiles","PylonRack_12Rnd_PG_missiles"]};
			/* BOMB */				case "HellBOMB":		{ _pylons = ["PylonRack_Bomb_GBU12_x2","PylonRack_Bomb_GBU12_x2"]};
			/* DAR */				default 				{ _pylons = ["PylonRack_12Rnd_missiles","PylonRack_12Rnd_missiles"]};
			};
		};

	//Ghosthawk
		case (_class isKindOf "B_Heli_Transport_01_camo_F"):
		{
			switch (_variant) do
			{
			/* GMG */		case "Ghost+":
							{
								_mags =
								[
									["32Rnd_40mm_G_belt", [1]],
									["2000Rnd_65x39_Belt_Tracer_Green_Splash", [1]],
									["32Rnd_40mm_G_belt", [2]],
									["2000Rnd_65x39_Belt_Tracer_Green_Splash", [2]]

								];
								_weapons =
								[

									["GMG_40mm", [1]],
									["LMG_Minigun_Transport", [1]],
									["GMG_40mm", [2]],
									["LMG_Minigun_Transport", [2]]

								];
							};
			/* Standard */	default {};
			};
		};

	//Ceasar
		case (_class isKindOf "C_Plane_Civil_01_F"):
		{
			switch (_variant) do
			{
				case "Armed" :
				{
					_mags =
					[

						["500Rnd_127x99_mag_Tracer_Green", [-1]],
						["2Rnd_Mk82", [-1]]
					];
					_weapons =
					[
						["HMG_127_LSV_01", [-1]],
						["Mk82BombLauncher", [-1]]
					];
					_customCode =
					{
						_veh setMagazineTurretAmmo ["2Rnd_Mk82", 1, [-1]];
					};
				};
				default {};
			};
		};
		case (_class isKindOf "C_Plane_Civil_01_racing_F"):
		{
			switch (_variant) do
			{
				case "Armed":
				{
					_mags =
					[
						["1000Rnd_762x51_Belt_T_Red", [-1]],
						["12Rnd_missiles", [-1]]
					];
					_weapons =
					[
						["LMG_coax", [-1]],
						["missiles_DAR", [-1]]
					];
					_customCode =
					{
						_veh setMagazineTurretAmmo ["12Rnd_missiles", 4, [-1]];
					};
				};
				default {};
			};
		};

	// A-164 Wipeout CAS
		case (_class isKindOf "Plane_CAS_01_dynamicLoadout_base_F"):
		{
			_mags =
			[
				["1000Rnd_Gatling_30mm_Plane_CAS_01_F", [-1]], // extra gun mag (non-explosive ammo)
				["Laserbatteries", [-1]],
				["240Rnd_CMFlare_Chaff_Magazine", [-1]]
			];		
			switch (_variant) do
			{
			/* Air Support AG */	case "SupportAG":	{ _pylons = ["PylonRack_1Rnd_AAA_missiles","PylonRack_1Rnd_Missile_AGM_02_F","PylonRack_3Rnd_Missile_AGM_02_F","PylonRack_3Rnd_Missile_AGM_02_F","PylonRack_3Rnd_Missile_AGM_02_F","PylonRack_3Rnd_Missile_AGM_02_F","PylonRack_3Rnd_Missile_AGM_02_F","PylonRack_3Rnd_Missile_AGM_02_F","PylonRack_1Rnd_Missile_AGM_02_F","PylonRack_1Rnd_AAA_missiles"]};
									case "wipeoutAA": {_pylons = ["", "", "", "", "", "", "", "", "", ""] };
									case "wipeoutCAS": {_pylons = ["PylonMissile_1Rnd_Bomb_04_F", "PylonMissile_1Rnd_Bomb_04_F", "", "PylonRack_1Rnd_Missile_AGM_02_F", "PylonRack_1Rnd_Missile_AGM_02_F", "", "", "", "", "", "", "", ""] };
									case "wipeoutOP": {_pylons = ["", "", "", "", "", "", "", "", "", ""] };
			/* Standard */			default				{ _pylons = ["PylonRack_1Rnd_Missile_AA_04_F","PylonRack_7Rnd_Rocket_04_HE_F","PylonRack_3Rnd_Missile_AGM_02_F","PylonMissile_1Rnd_Bomb_04_F","PylonMissile_1Rnd_Bomb_04_F","PylonMissile_1Rnd_Bomb_04_F","PylonMissile_1Rnd_Bomb_04_F","PylonRack_3Rnd_Missile_AGM_02_F","PylonRack_7Rnd_Rocket_04_AP_F","PylonRack_1Rnd_Missile_AA_04_F"]};
			};
		};
	// Black Wasp
		case (_class isKindOf "B_Plane_Fighter_01_F"): //Standard Version
		{
			_weapons =
			[
				["weapon_Fighter_Gun20mm_AA", [-1]],
				["Laserdesignator_pilotCamera", [-1]],
				["CMFlareLauncher", [-1]]
			];
			_mags =
			[	
				["magazine_Fighter01_Gun20mm_AA_x450", [-1]],
				["magazine_Fighter01_Gun20mm_AA_x450", [-1]],
				["Laserbatteries", [-1]],
				["240Rnd_CMFlare_Chaff_Magazine", [-1]]
			];			
			switch (_variant) do
			{
			/* Air Support AA */	case "SupportAA":	{_pylons = ["PylonRack_Missile_AMRAAM_D_x2","PylonRack_Missile_AMRAAM_D_x2","PylonRack_Missile_AMRAAM_D_x2","PylonRack_Missile_AMRAAM_D_x2","PylonMissile_Missile_BIM9X_x1","PylonMissile_Missile_BIM9X_x1","PylonMissile_Missile_AMRAAM_D_INT_x1","PylonMissile_Missile_AMRAAM_D_INT_x1","PylonMissile_Missile_AMRAAM_D_INT_x1","PylonMissile_Missile_AMRAAM_D_INT_x1","PylonMissile_Missile_AMRAAM_D_INT_x1","PylonMissile_Missile_AMRAAM_D_INT_x1"]};
									case "blackwaspAA": {_pylons = ["PylonRack_Missile_AMRAAM_C_x1","PylonRack_Missile_AMRAAM_C_x1", "PylonRack_Missile_BIM9X_x2"] };
									case "blackwaspCAS": {_pylons = ["PylonMissile_Missile_AGM_02_x1", "PylonMissile_Missile_AGM_02_x1", "PylonMissile_Bomb_GBU12_x1", "PylonMissile_Bomb_GBU12_x1"] };
									case "blackwaspOP": {_pylons = ["PylonMissile_Missile_AGM_02_x1", "PylonMissile_Missile_AGM_02_x1", "PylonMissile_Missile_AGM_02_x1", "PylonMissile_Missile_AGM_02_x1", "PylonRack_Bomb_SDB_x4", "PylonRack_Missile_BIM9X_x2", "PylonRack_Missile_AMRAAM_C_x1", "PylonRack_Missile_AMRAAM_C_x1"] };
									case "blackwaspXL": { _pylons = ["PylonMissile_Missile_BIM9X_x1","PylonMissile_Missile_BIM9X_x1","PylonMissile_Missile_BIM9X_x1","PylonMissile_Missile_BIM9X_x1","PylonMissile_Missile_BIM9X_x1","PylonMissile_Missile_BIM9X_x1","PylonRack_Bomb_GBU12_x2","PylonRack_Missile_AGM_02_x1","PylonRack_Missile_AGM_02_x1"] };
									/* Standard */			default				{_pylons = ["PylonRack_Missile_AMRAAM_D_x1","PylonRack_Missile_AMRAAM_D_x1","PylonRack_Missile_AGM_02_x2","PylonRack_Missile_AGM_02_x2","PylonMissile_Missile_BIM9X_x1","PylonMissile_Missile_BIM9X_x1","PylonMissile_Missile_AMRAAM_D_INT_x1","PylonMissile_Missile_AMRAAM_D_INT_x1","","","PylonMissile_Bomb_GBU12_x1","PylonMissile_Bomb_GBU12_x1"]};
			};
		};
		case (_class isKindOf "B_Plane_Fighter_01_Stealth_F"): //Stealth Verions
		{
			_mags =
			[
				["magazine_Fighter01_Gun20mm_AA_x450", [-1]],
				["magazine_Fighter01_Gun20mm_AA_x450", [-1]],
				["magazine_Fighter01_Gun20mm_AA_x450", [-1]],
				["magazine_Fighter01_Gun20mm_AA_x450", [-1]],
				["magazine_Fighter01_Gun20mm_AA_x450", [-1]], // extra gun mags to make up for lack of pylons (non-explosive ammo)
				["Laserbatteries", [-1]],
				["240Rnd_CMFlare_Chaff_Magazine", [-1]]
			];	
			switch (_variant) do
			{
			/* Standard */	default	{_pylons = ["","","","","PylonMissile_Missile_BIM9X_x1","PylonMissile_Missile_BIM9X_x1","PylonMissile_Missile_AMRAAM_D_INT_x1","PylonMissile_Missile_AMRAAM_D_INT_x1","","","PylonMissile_Bomb_GBU12_x1","PylonMissile_Bomb_GBU12_x1"]};
			};
		};
	// To-199 Neophron
		case (_class isKindOf "Plane_CAS_02_dynamicLoadout_base_F"):
		{
			switch (_variant) do
			{
			/* Air Support AG */	case "SupportAG":	{ _pylons = ["PylonMissile_1Rnd_LG_scalpel","PylonRack_4Rnd_LG_scalpel","PylonRack_4Rnd_LG_scalpel","PylonRack_4Rnd_LG_scalpel","PylonRack_4Rnd_LG_scalpel","PylonRack_4Rnd_LG_scalpel","PylonRack_4Rnd_LG_scalpel","PylonRack_4Rnd_LG_scalpel","PylonRack_4Rnd_LG_scalpel","PylonMissile_1Rnd_LG_scalpel"]};
			/* Standard */			default             { _pylons = ["PylonRack_1Rnd_Missile_AA_03_F","PylonRack_1Rnd_Missile_AGM_01_F","PylonRack_20Rnd_Rocket_03_HE_F","PylonRack_1Rnd_Missile_AGM_01_F","PylonMissile_1Rnd_Bomb_03_F","PylonMissile_1Rnd_Bomb_03_F","PylonRack_1Rnd_Missile_AGM_01_F","PylonRack_20Rnd_Rocket_03_AP_F","PylonRack_1Rnd_Missile_AGM_01_F","PylonRack_1Rnd_Missile_AA_03_F"]};
			};
		};
		
		// Y-32 Xi'an
		case ({_class isKindOf _x} count ["VTOL_02_infantry_dynamicLoadout_base_F", "VTOL_02_vehicle_dynamicLoadout_base_F"] > 0):
		{
			_weapons =
			[
				["CMFlareLauncher_Triples", [-1]],
				["rockets_Skyfire", [-1]],
			    ["gatling_30mm_VTOL_02", [0]]
			];
			_mags =
			[
				["240Rnd_CMFlareMagazine", [-1]],
				["38Rnd_80mm_rockets", [-1]],
			    ["250Rnd_30mm_HE_shells", [0]],
				["250Rnd_30mm_HE_shells", [0]],
				["250Rnd_30mm_HE_shells", [0]],
				["250Rnd_30mm_APDS_shells", [0]],
				["250Rnd_30mm_APDS_shells", [0]],
				["250Rnd_30mm_APDS_shells", [0]]
			];
			switch (_variant) do
			{
				case "xianAntiInf": { _pylons = ["",""] };
				case "xianAG": { _pylons = ["PylonRack_1Rnd_Missile_AGM_01_F","PylonRack_1Rnd_Missile_AGM_01_F"] };
				case "xianDelta": { _pylons = ["PylonRack_4Rnd_LG_scalpel","PylonRack_4Rnd_LG_scalpel","PylonRack_1Rnd_Missile_AA_03_F","PylonRack_1Rnd_Missile_AA_03_F"] };
				case "xianEX": { _pylons = ["PylonRack_1Rnd_Missile_AA_03_F","PylonRack_1Rnd_Missile_AA_03_F","PylonRack_1Rnd_Missile_AA_03_F","PylonRack_1Rnd_Missile_AA_03_F","PylonRack_19Rnd_Rocket_Skyfire"] }; //by Aryx
				default           { _pylons = ["PylonRack_1Rnd_Missile_AGM_01_F","PylonRack_19Rnd_Rocket_Skyfire","PylonRack_19Rnd_Rocket_Skyfire","PylonRack_1Rnd_Missile_AGM_01_F"] };
			};
		};		

	// Shikra
		case (_class isKindOf "O_Plane_Fighter_02_F"): //Standard Version
		{
			_mags =
			[
				["magazine_Fighter02_Gun30mm_AA_x180", [-1]],
				["magazine_Fighter02_Gun30mm_AA_x180", [-1]],
				["magazine_Fighter02_Gun30mm_AA_x180", [-1]],
				["magazine_Fighter02_Gun30mm_AA_x180", [-1]],
				["magazine_Fighter02_Gun30mm_AA_x180", [-1]], // extra gun mag (non-explosive ammo)
				["Laserbatteries", [-1]],
				["240Rnd_CMFlare_Chaff_Magazine", [-1]]
			];		
			switch (_variant) do
			{
			/* Air Support AG */	case "SupportAA":	{ _pylons = ["PylonMissile_Missile_AA_R73_x1","PylonMissile_Missile_AA_R73_x1","PylonMissile_Missile_AA_R77_x1","PylonMissile_Missile_AA_R77_x1","PylonMissile_Missile_AA_R77_x1","PylonMissile_Missile_AA_R77_x1","PylonMissile_Missile_AA_R73_x1","PylonMissile_Missile_AA_R73_x1","PylonMissile_Missile_AA_R77_x1","PylonMissile_Missile_AA_R77_x1","PylonMissile_Missile_AA_R77_INT_x1","PylonMissile_Missile_AA_R77_INT_x1","PylonMissile_Missile_AA_R77_INT_x1"]};
									case "shikraAA": {_pylons = ["", "", "", "", "", "", "", "PylonMissile_Missile_AA_R73_x1", "PylonMissile_Missile_AA_R73_x1", "PylonMissile_Missile_AA_R77_x1", "PylonMissile_Missile_AA_R73_x1", "PylonMissile_Missile_AA_R77_x1", "PylonMissile_Missile_AA_R73_x1"] };
									case "shikraCAS": {_pylons = ["", "", "", "", "", "", "", "PylonMissile_Bomb_KAB250_x1", "PylonMissile_Bomb_KAB250_x1", "PylonMissile_Missile_AGM_KH25_x1", "PylonMissile_Missile_AGM_KH25_x1"] };
									case "shikraOP": {_pylons = ["PylonMissile_Missile_AA_R73_x1", "PylonMissile_Missile_AA_R73_x1", "PylonMissile_Missile_AA_R77_x1", "PylonMissile_Missile_AA_R77_x1", "", "", "PylonMissile_1Rnd_BombCluster_02_cap_F", "PylonMissile_1Rnd_BombCluster_02_cap_F", "PylonMissile_Missile_AGM_KH25_x1", "PylonMissile_Missile_AGM_KH25_x1", ""] };
									case "shikraXL": { _pylons = ["PylonMissile_Missile_AA_R73_x1","PylonMissile_Missile_AA_R73_x1","PylonMissile_Missile_AA_R77_x1","PylonMissile_Missile_AA_R77_x1","PylonMissile_Bomb_KAB250_x1","PylonMissile_Bomb_KAB250_x1","PylonMissile_Bomb_KAB250_x1","PylonMissile_Bomb_KAB250_x1","PylonMissile_Missile_AGM_KH25_x1","PylonMissile_Missile_AGM_KH25_x1"] };
									case "shikraEX": { _pylons = ["PylonMissile_Missile_AA_R73_x1","PylonMissile_Missile_AA_R73_x1","PylonMissile_Missile_AA_R77_x1","PylonMissile_Missile_AA_R77_x1","PylonMissile_Missile_AA_R77_x1"] };
									case "shikraDEF": { _pylons = ["PylonMissile_Missile_AGM_KH25_x1","PylonMissile_Missile_AGM_KH25_x1","PylonMissile_Bomb_KAB250_x1","PylonMissile_Bomb_KAB250_x1","PylonRack_20Rnd_Rocket_03_HE_F","PylonRack_20Rnd_Rocket_03_AP_F","PylonMissile_Missile_AA_R73_x1","PylonMissile_Missile_AA_R73_x1","PylonMissile_Missile_AA_R77_x1","PylonMissile_Missile_AA_R77_x1","PylonMissile_Missile_AA_R77_INT_x1","PylonMissile_Missile_AA_R77_INT_x1","PylonMissile_Bomb_KAB250_x1"] };
			/* Standard */			default             { _pylons = ["PylonMissile_Missile_AA_R73_x1","PylonMissile_Missile_AA_R73_x1","PylonMissile_Missile_AA_R77_x1","PylonMissile_Missile_AA_R77_x1","PylonMissile_Bomb_KAB250_x1","PylonMissile_Bomb_KAB250_x1","PylonMissile_Missile_AA_R73_x1","PylonMissile_Missile_AA_R73_x1","PylonMissile_Missile_AA_R77_x1","PylonMissile_Missile_AA_R77_x1","PylonMissile_Missile_AA_R77_INT_x1","PylonMissile_Missile_AA_R77_INT_x1","PylonMissile_Bomb_KAB250_x1"]};
			};
		};
		case (_class isKindOf "O_Plane_Fighter_02_Stealth_F"): //Stealth Version
		{
			_mags =
			[
				["magazine_Fighter02_Gun30mm_AA_x180", [-1]],
				["magazine_Fighter02_Gun30mm_AA_x180", [-1]],
				["magazine_Fighter02_Gun30mm_AA_x180", [-1]],
				["magazine_Fighter02_Gun30mm_AA_x180", [-1]],
				["magazine_Fighter02_Gun30mm_AA_x180", [-1]], // extra gun mags to make up for lack of pylons (non-explosive ammo)
				["Laserbatteries", [-1]],
				["240Rnd_CMFlare_Chaff_Magazine", [-1]]
			];	
			switch (_variant) do
			{
									case "shikraAA": {_pylons = ["", "", "", "", "", "", "", "PylonMissile_Missile_AA_R73_x1", "PylonMissile_Missile_AA_R73_x1", "PylonMissile_Missile_AA_R77_x1", "PylonMissile_Missile_AA_R73_x1", "PylonMissile_Missile_AA_R77_x1", "PylonMissile_Missile_AA_R73_x1"] };
									case "shikraCAS": {_pylons = ["", "", "", "", "", "", "", "PylonMissile_Bomb_KAB250_x1", "PylonMissile_Bomb_KAB250_x1", "PylonMissile_Missile_AGM_KH25_x1", "PylonMissile_Missile_AGM_KH25_x1"] };
									case "shikraOP": {_pylons = ["PylonMissile_Missile_AA_R73_x1", "PylonMissile_Missile_AA_R73_x1", "PylonMissile_Missile_AA_R77_x1", "PylonMissile_Missile_AA_R77_x1", "", "", "PylonMissile_1Rnd_BombCluster_02_cap_F", "PylonMissile_1Rnd_BombCluster_02_cap_F", "PylonMissile_Missile_AGM_KH25_x1", "PylonMissile_Missile_AGM_KH25_x1", ""] };
			/* Standard */			default             { _pylons = ["","","","","","","PylonMissile_Missile_AA_R73_x1","PylonMissile_Missile_AA_R73_x1","PylonMissile_Missile_AA_R77_x1","PylonMissile_Missile_AA_R77_x1","PylonMissile_Missile_AA_R77_INT_x1","PylonMissile_Missile_AA_R77_INT_x1","PylonMissile_Bomb_KAB250_x1"]};
			};
		};

	//Buzzard
		case (_class isKindOf "Plane_Fighter_03_dynamicLoadout_base_F"):
		{
			switch (_variant) do
			{
			/* AA */		case "buzzardAA":	{ _pylons = ["PylonRack_Missile_BIM9X_x1","PylonRack_1Rnd_GAA_missiles","PylonMissile_Missile_AA_R77_INT_x1","PylonWeapon_300Rnd_20mm_shells","PylonMissile_Missile_AA_R77_INT_x1","PylonRack_1Rnd_GAA_missiles","PylonRack_Missile_BIM9X_x1"]};
			/* CAS */		case "buzzardCAS":	{ _pylons = ["PylonMissile_Missile_AGM_KH25_INT_x1","PylonRack_7Rnd_Rocket_04_HE_F","PylonRack_Missile_AGM_02_x2","PylonWeapon_300Rnd_20mm_shells","PylonRack_Missile_AGM_02_x2","PylonRack_7Rnd_Rocket_04_AP_F","PylonMissile_Missile_AGM_KH25_INT_x1"]};
							case "buzzardEX": { _pylons = ["PylonRack_1Rnd_Missile_AA_04_F","PylonRack_1Rnd_GAA_missiles","PylonRack_1Rnd_GAA_missiles","PylonRack_1Rnd_GAA_missiles","PylonRack_1Rnd_GAA_missiles","PylonRack_1Rnd_Missile_AA_04_F"] };
			/* Standard */	default				{ _pylons = ["PylonRack_1Rnd_LG_scalpel","PylonRack_1Rnd_AAA_missiles","PylonMissile_1Rnd_Bomb_04_F","PylonWeapon_300Rnd_20mm_shells","PylonMissile_1Rnd_Bomb_04_F","PylonRack_1Rnd_AAA_missiles","PylonRack_1Rnd_LG_scalpel"]};
			};
			_customCode =
			{
				_veh setAmmoOnPylon [4, 500]; // 20mm gun
			};
		};

	//Gryphon
		case (_class isKindOf "Plane_Fighter_04_Base_F"):
		{
			_weapons =
			[
				["weapon_Fighter_Gun20mm_AA", [-1]],
				["Laserdesignator_pilotCamera", [-1]],
				["CMFlareLauncher", [-1]]
			];
			_mags =
			[	
				["magazine_Fighter04_Gun20mm_AA_x250", [-1]],
				["magazine_Fighter04_Gun20mm_AA_x250", [-1]],
				["magazine_Fighter04_Gun20mm_AA_x250", [-1]],
				["Laserbatteries", [-1]],
				["240Rnd_CMFlare_Chaff_Magazine", [-1]]
			];		
			switch (_variant) do
			{
			/* Air Support AG */	case "SupportAG":	{ _pylons = ["PylonRack_Missile_AMRAAM_C_x1","PylonRack_Missile_AMRAAM_C_x1","PylonRack_Missile_AGM_02_x1","PylonRack_Missile_AGM_02_x1","PylonRack_Missile_AGM_02_x2","PylonRack_Missile_AGM_02_x2"]};
			/* Air Support AA */	case "SupportAA":	{ _pylons = ["PylonMissile_Missile_BIM9X_x1","PylonMissile_Missile_BIM9X_x1","PylonRack_Missile_AMRAAM_C_x1","PylonRack_Missile_AMRAAM_C_x1","PylonRack_Missile_AMRAAM_C_x2","PylonRack_Missile_AMRAAM_C_x2"]};
									case "gryphonAA": {_pylons = ["PylonRack_Missile_AMRAAM_C_x1","PylonRack_Missile_AMRAAM_C_x1", "PylonMissile_Missile_BIM9X_x1", "PylonMissile_Missile_BIM9X_x1", "PylonMissile_Missile_BIM9X_x1", "PylonMissile_Missile_BIM9X_x1"] };
									case "gryphonCAS": {_pylons = ["PylonMissile_Missile_AGM_02_x1", "PylonMissile_Missile_AGM_02_x1", "PylonMissile_Bomb_GBU12_x1", "PylonMissile_Bomb_GBU12_x1"] };
									case "gryphonOP": {_pylons = ["PylonRack_Missile_AMRAAM_C_x1","PylonRack_Missile_BIM9X_x2", "PylonMissile_1Rnd_BombCluster_01_F", "PylonMissile_1Rnd_BombCluster_01_F", "PylonMissile_Missile_AGM_02_x2", "PylonRack_Missile_AMRAAM_C_x1"] };
									case "GryphonXL": { _pylons = ["PylonRack_Missile_AMRAAM_D_x1","PylonRack_Missile_AMRAAM_D_x1","PylonRack_Missile_AMRAAM_D_x1","PylonRack_Missile_AMRAAM_D_x1","PylonMissile_Missile_BIM9X_x1","PylonMissile_Missile_BIM9X_x1","PylonRack_Bomb_GBU12_x2","PylonRack_Bomb_GBU12_x2"] };
									/* Standard */			default 			{ _pylons =["PylonMissile_Missile_BIM9X_x1","PylonMissile_Missile_BIM9X_x1","PylonRack_Missile_AGM_02_x1","PylonRack_Missile_AGM_02_x1","PylonRack_Missile_AMRAAM_C_x1","PylonRack_Missile_AMRAAM_C_x1"]};
			};
		};
	//Greyhawk/Ababil
		case (_class isKindOf "UAV_02_dynamicLoadout_base_F"):
		{
			switch (_variant) do
			{
			/* Cluster */				case "greyhawkCluster":	{_pylons = ["PylonMissile_1Rnd_BombCluster_01_F","PylonMissile_1Rnd_BombCluster_01_F"]};
			/* Bombs */					case "greyhawkBomber":	{_pylons = ["PylonMissile_1Rnd_Bomb_04_F","PylonMissile_1Rnd_Bomb_04_F"]};
										case "greyhawkDAGR":    { _pylons = ["PylonRack_12Rnd_PG_missiles","PylonWeapon_2000Rnd_65x39_belt"] };
			/* Standard (missiles) */	default					{_pylons = ["PylonRack_3Rnd_LG_scalpel","PylonRack_3Rnd_LG_scalpel"]};
			};
		};

	//UCAV
		case (_class isKindOf "B_UAV_05_F"):
		{
			switch (_variant) do
			{
			/* Cluster Bombs */	case "sentinel_C_Bomber": 	{ _pylons = ["PylonMissile_1Rnd_BombCluster_01_F","PylonMissile_1Rnd_BombCluster_01_F"]};
			/* AA */			case "sentinel_AA_Missile":	{ _pylons = ["PylonRack_Missile_AMRAAM_D_x2","PylonRack_Missile_BIM9X_x2"]};
			/* AG */			case "sentinelMissile": 	{ _pylons = ["PylonMissile_Missile_AGM_02_x2","PylonMissile_Missile_AGM_02_x2"]};
			/* Standard */		default 					{_pylons = ["PylonMissile_Bomb_GBU12_x1","PylonMissile_Bomb_GBU12_x1"]}
			};
		};
	// MQ-12 Falcon UAV
		case (_class isKindOf "B_T_UAV_03_dynamicLoadout_F"):
		{
			switch (_variant) do
			{
			/* Scout */	case "FalconScout":
				{
					_mags =
					[
						["60Rnd_CMFlare_Chaff_Magazine", [-1]],
						["500Rnd_65x39_Belt_Tracer_Red_Splash", [0]],
						["Laserbatteries", [0]]
					];
					_weapons =
					[
						["CMFlareLauncher", [-1]],
						["LMG_Minigun2", [0]],
						["Laserdesignator_mounted", [0]]
					];
					_pylons = ["PylonRack_Missile_BIM9X_x2","PylonRack_1Rnd_LG_scalpel","PylonRack_1Rnd_LG_scalpel","PylonRack_Missile_BIM9X_x2"]
				};
			/*  */	case "FalconAT": { _pylons = ["PylonMissile_1Rnd_LG_scalpel","PylonRack_12Rnd_PG_missiles","PylonMissile_1Rnd_Bomb_04_F","PylonMissile_1Rnd_LG_scalpel"]};
			/* */	case "Falcon+":
				{
					_mags =
					[
						["60Rnd_CMFlare_Chaff_Magazine", [-1]],
						["500Rnd_65x39_Belt_Tracer_Red_Splash", [0]],
						["500Rnd_65x39_Belt_Tracer_Red_Splash", [0]],
						["Laserbatteries", [0]]
					];
					_weapons =
					[
						["CMFlareLauncher", [-1]],
						["LMG_Minigun2", [0]],
						["Laserdesignator_mounted", [0]]
					];
					_pylons = ["PylonRack_Missile_BIM9X_x2","PylonMissile_1Rnd_BombCluster_01_F","PylonRack_12Rnd_PG_missiles","PylonRack_4Rnd_LG_scalpel"];
				};
			/* Standard */	default {_pylons = ["PylonRack_12Rnd_missiles","PylonRack_3Rnd_LG_scalpel","PylonRack_3Rnd_LG_scalpel","PylonRack_12Rnd_missiles"]}
			};
		};

	// Subs NATO
		case (_class isKindOf "SDV_01_base_F"):
		{
			switch (_variant) do
			{
				case "Armed":
				{
					_mags =
					[
						["20Rnd_556x45_UW_mag", [0]],
						["20Rnd_556x45_UW_mag", [0]],
						["20Rnd_556x45_UW_mag", [0]],
						["20Rnd_556x45_UW_mag", [0]],
						["20Rnd_556x45_UW_mag", [0]],
						["30Rnd_556x45_Stanag", [0]],
						["30Rnd_556x45_Stanag", [0]],
						["30Rnd_556x45_Stanag", [0]],
						["Laserbatteries", [0]]
					];
					_weapons =
					[
						["arifle_SDAR_F", [0]],
						["Laserdesignator_mounted", [0]]
					];
				};
				default {};
			};
		};
};