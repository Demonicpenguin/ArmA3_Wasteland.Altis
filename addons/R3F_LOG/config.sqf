/**
 * MAIN CONFIGURATION FILE
 * 
 * English and French comments
 * Commentaires anglais et français
 * 
 * (EN)
 * This file contains the configuration variables of the logistics system.
 * For the configuration of the creation factory, see the file "config_creation_factory.sqf".
 * IMPORTANT NOTE : when a logistics feature is given to an object/vehicle class name, all the classes which inherit
 *                  of the parent/generic class (according to the CfgVehicles) will also have this feature.
 *                  CfgVehicles tree view example : http://madbull.arma.free.fr/A3_stable_1.20.124746_CfgVehicles_tree.html
 * 
 * (FR)
 * Fichier contenant les variables de configuration du système de logistique.
 * Pour la configuration de l'usine de création, voir le fichier "config_creation_factory.sqf".
 * NOTE IMPORTANTE : lorsqu'une fonctionnalité logistique est accordée à un nom de classe d'objet/véhicule, les classes
 *                   héritant de cette classe mère/générique (selon le CfgVehicles) se verront également dotées de cette fonctionnalité.
 *                   Exemple d'arborescence du CfgVehicles : http://madbull.arma.free.fr/A3_stable_1.20.124746_CfgVehicles_tree.html
 */
 
#include "..\..\STConstants.h" 

/**
 * DISABLE LOGISTICS ON OBJECTS BY DEFAULT
 * 
 * (EN)
 * Define if objects and vehicles have logistics features by default,
 * or if it must be allowed explicitely on specific objects/vehicles.
 * 
 * If false : all objects are enabled according to the class names listed in this configuration file
 *            You can disable some objects with : object setVariable ["R3F_LOG_disabled", true];
 * If true :  all objects are disabled by default
 *            You can enable some objects with : object setVariable ["R3F_LOG_disabled", false];
 * 
 * 
 * (FR)
 * Défini si les objets et véhicules disposent des fonctionnalités logistiques par défaut,
 * ou si elles doivent être autorisés explicitement sur des objets/véhicules spécifiques.
 * 
 * Si false : tous les objets sont actifs en accord avec les noms de classes listés dans ce fichier
 *            Vous pouvez désactiver certains objets avec : objet setVariable ["R3F_LOG_disabled", true];
 * Si true :  tous les objets sont inactifs par défaut
 *            Vous pouvez activer quelques objets avec : objet setVariable ["R3F_LOG_disabled", false];
 */
R3F_LOG_CFG_disabled_by_default = false;

/**
 * LOCK THE LOGISTICS FEATURES TO SIDE, FACTION OR PLAYER
 * 
 * (EN)
 * Define the lock mode of the logistics features for an object.
 * An object can be locked to the a side, faction, a player (respawn) or a unit (life).
 * If the object is locked, the player can unlock it according to the
 * value of the config variable R3F_LOG_CFG_unlock_objects_timer.
 * 
 * If "none" : no lock features, everyone can used the logistics features.
 * If "side" : the object is locked to the last side which interacts with it.
 * If "faction" : the object is locked to the last faction which interacts with it.
 * If "player" : the object is locked to the last player which interacts with it. The lock is transmitted after respawn.
 * If "unit" : the object is locked to the last player which interacts with it. The lock is lost when the unit dies.
 * 
 * Note : for military objects (not civilian), the lock is initialized to the object's side.
 * 
 * See also the config variable R3F_LOG_CFG_unlock_objects_timer.
 * 
 * (FR)
 * Défini le mode de verrouillage des fonctionnalités logistics pour un objet donné.
 * Un objet peut être verrouillé pour une side, une faction, un joueur (respawn) ou une unité (vie).
 * Si l'objet est verrouillé, le joueur peut le déverrouiller en fonction de la
 * valeur de la variable de configiration R3F_LOG_CFG_unlock_objects_timer.
 * 
 * Si "none" : pas de verrouillage, tout le monde peut utiliser les fonctionnalités logistiques.
 * Si "side" : l'objet est verrouillé pour la dernière side ayant interagit avec lui.
 * Si "faction" : l'objet est verrouillé pour la dernière faction ayant interagit avec lui.
 * Si "player" : l'objet est verrouillé pour le dernier joueur ayant interagit avec lui. Le verrou est transmis après respawn.
 * Si "unit" : l'objet est verrouillé pour le dernier joueur ayant interagit avec lui. Le verrou est perdu quand l'unité meurt.
 * 
 * Note : pour les objets militaires (non civils), le verrou est initialisé à la side de l'objet.
 * 
 * Voir aussi la variable de configiration R3F_LOG_CFG_unlock_objects_timer.
 */
R3F_LOG_CFG_lock_objects_mode = "none";

/**
 * COUNTDOWN TO UNLOCK AN OBJECT
 * 
 * Define the countdown duration (in seconds) to unlock a locked object.
 * Set to -1 to deny the unlock of objects.
 * See also the config variable R3F_LOG_CFG_lock_objects_mode.
 * 
 * Défini la durée (en secondes) du compte-à-rebours pour déverrouiller un objet.
 * Mettre à -1 pour qu'on ne puisse pas déverrouiller les objets.
 * Voir aussi la variable de configiration R3F_LOG_CFG_lock_objects_mode.
 */
R3F_LOG_CFG_unlock_objects_timer = 1;

/**
 * ALLOW NO GRAVITY OVER GROUND
 * 
 * Define if movable objects with no gravity simulation can be set in height over the ground (no ground contact).
 * The no gravity objects corresponds to most of decoration and constructions items.
 * 
 * Défini si les objets déplaçable sans simulation de gravité peuvent être position en hauteur sans être contact avec le sol.
 * Les objets sans gravité correspondent à la plupart des objets de décors et de construction.
 */
R3F_LOG_CFG_no_gravity_objects_can_be_set_in_height_over_ground = true;

/**
 * LANGUAGE
 * 
 * Automatic language selection according to the game language.
 * New languages can be easily added (read below).
 * 
 * Sélection automatique de la langue en fonction de la langue du jeu.
 * De nouveaux langages peuvent facilement être ajoutés (voir ci-dessous).
 */
R3F_LOG_CFG_language = switch (language) do
{
	case "English":{"en"};
	case "French":{"fr"};
	
	// Feel free to create you own language file named "XX_strings_lang.sqf", where "XX" is the language code.
	// Make a copy of an existing language file (e.g. en_strings_lang.sqf) and translate it.
	// Then add a line with this syntax : case "YOUR_GAME_LANGUAGE":{"LANGUAGE_CODE"};
	// For example :
	
	//case "Czech":{"cz"}; // Not supported. Need your own "cz_strings_lang.sqf"
	//case "Polish":{"pl"}; // Not supported. Need your own "pl_strings_lang.sqf"
	//case "Portuguese":{"pt"}; // Not supported. Need your own "pt_strings_lang.sqf"
	//case "YOUR_GAME_LANGUAGE":{"LANGUAGE_CODE"};  // Need your own "LANGUAGE_CODE_strings_lang.sqf"
	
	default {"en"}; // If language is not supported, use English
};

/**
 * CONDITION TO ALLOW LOGISTICS
 * 
 * (EN)
 * This variable allow to set a dynamic SQF condition to allow/deny all logistics features only on specific clients.
 * The variable must be a STRING delimited by quotes and containing a valid SQF condition to evaluate during the game.
 * For example you can allow logistics only on few clients having a known game ID by setting the variable to :
 * "getPlayerUID player in [""76xxxxxxxxxxxxxxx"", ""76yyyyyyyyyyyyyyy"", ""76zzzzzzzzzzzzzzz""]"
 * Or based on the profile name : "profileName in [""john"", ""jack"", ""james""]"
 * Or only for the server admin : "serverCommandAvailable "#kick"""
 * The condition is evaluted in real time, so it can use condition depending on the mission progress : "alive officer && taskState task1 == ""Succeeded"""
 * Or to deny logistics in a circular area defined by a marker : "player distance getMarkerPos ""markerName"" > getMarkerSize ""markerName"" select 0"
 * Note that quotes of the strings inside the string condition must be doubled.
 * Note : if the condition depends of the aimed objects/vehicle, you can use the command cursorTarget
 * To allow the logistics to everyone, just set the condition to "true".
 * 
 * (FR)
 * Cette variable permet d'utiliser une condition SQF dynamique pour autoriser ou non les fonctions logistiques sur des clients spécifiques.
 * La variable doit être une CHAINE de caractères délimitée par des guillemets et doit contenir une condition SQF valide qui sera évaluée durant la mission.
 * Par exemple pour autoriser la logistique sur seulement quelques joueurs ayant un ID de jeu connu, la variable peut être défini comme suit :
 * "getPlayerUID player in [""76xxxxxxxxxxxxxxx"", ""76yyyyyyyyyyyyyyy"", ""76zzzzzzzzzzzzzzz""]"
 * Ou elle peut se baser sur le nom de profil : "profileName in [""maxime"", ""martin"", ""marc""]"
 * Ou pour n'autoriser que l'admin de serveur : "serverCommandAvailable "#kick"""
 * Les condition sont évaluées en temps réel, et peuvent donc dépendre du déroulement de la mission : "alive officier && taskState tache1 == ""Succeeded"""
 * Ou pour interdire la logistique dans la zone défini par un marqueur circulaire : "player distance getMarkerPos ""markerName"" > getMarkerSize ""markerName"" select 0"
 * Notez que les guillemets des chaînes de caractères dans la chaîne de condition doivent être doublés.
 * Note : si la condition dépend de l'objet/véhicule pointé, vous pouvez utiliser la commande cursorTarget
 * Pour autoriser la logistique chez tout le monde, il suffit de définir la condition à "true".
 */
R3F_LOG_CFG_string_condition_allow_logistics_on_this_client = "true";

/**
 * CONDITION TO ALLOW CREATION FACTORY
 * 
 * (EN)
 * This variable allow to set a dynamic SQF condition to allow/deny the access to the creation factory only on specific clients.
 * The variable must be a STRING delimited by quotes and containing a valid SQF condition to evaluate during the game.
 * For example you can allow the creation factory only on few clients having a known game ID by setting the variable to :
 * "getPlayerUID player in [""76xxxxxxxxxxxxxxx"", ""76yyyyyyyyyyyyyyy"", ""76zzzzzzzzzzzzzzz""]"
 * Or based on the profile name : "profileName in [""john"", ""jack"", ""james""]"
 * Or only for the server admin : "serverCommandAvailable "#kick"""
 * Note that quotes of the strings inside the string condition must be doubled.
 * Note : if the condition depends of the aimed objects/véhicule, you can use the command cursorTarget
 * Note also that the condition is evaluted in real time, so it can use condition depending on the mission progress :
 * "alive officer && taskState task1 == ""Succeeded"""
 * To allow the creation factory to everyone, just set the condition to "true".
 * 
 * (FR)
 * Cette variable permet d'utiliser une condition SQF dynamique pour rendre accessible ou non l'usine de création sur des clients spécifiques.
 * La variable doit être une CHAINE de caractères délimitée par des guillemets et doit contenir une condition SQF valide qui sera évaluée durant la mission.
 * Par exemple pour autoriser l'usine de création sur seulement quelques joueurs ayant un ID de jeu connu, la variable peut être défini comme suit :
 * "getPlayerUID player in [""76xxxxxxxxxxxxxxx"", ""76yyyyyyyyyyyyyyy"", ""76zzzzzzzzzzzzzzz""]"
 * Ou elle peut se baser sur le nom de profil : "profileName in [""maxime"", ""martin"", ""marc""]"
 * Ou pour n'autoriser que l'admin de serveur : "serverCommandAvailable "#kick"""
 * Notez que les guillemets des chaînes de caractères dans la chaîne de condition doivent être doublés.
 * Note : si la condition dépend de l'objet/véhicule pointé, vous pouvez utiliser la commande cursorTarget
 * Notez aussi que les condition sont évaluées en temps réel, et peuvent donc dépendre du déroulement de la mission :
 * "alive officier && taskState tache1 == ""Succeeded"""
 * Pour autoriser l'usine de création chez tout le monde, il suffit de définir la condition à "true".
 */
R3F_LOG_CFG_string_condition_allow_creation_factory_on_this_client = "false";

/*
 ********************************************************************************************
 * BELOW IS THE CLASS NAMES CONFIGURATION / CI-DESSOUS LA CONFIGURATION DES NOMS DE CLASSES *
 ********************************************************************************************
 * 
 * (EN)
 * There are two ways to manage new objects with the logistics system. The first one is to add these objects in the
 * following appropriate lists. The second one is to create a new external file in the /addons_config/ directory,
 * based on /addons_config/TEMPLATE.sqf, and to add a #include below to.
 * The first method is better to add/fix only some various class names.
 * The second method is better to take into account an additional addon.
 * 
 * These variables are based on the inheritance principle according to the CfgVehicles tree.
 * It means that a features accorded to a class name, is also accorded to all child classes.
 * Inheritance tree view : http://madbull.arma.free.fr/A3_1.32_CfgVehicles_tree.html
 * 
 * (FR)
 * Deux moyens existent pour gérer de nouveaux objets avec le système logistique. Le premier consiste à ajouter
 * ces objets dans les listes appropriées ci-dessous. Le deuxième est de créer un fichier externe dans le répertoire
 * /addons_config/ basé sur /addons_config/TEMPLATE.sqf, et d'ajouter un #include ci-dessous.
 * La première méthode est préférable lorsqu'il s'agit d'ajouter ou corriger quelques classes diverses.
 * La deuxième méthode est préférable s'il s'agit de prendre en compte le contenu d'un addon supplémentaire.
 * 
 * Ces variables sont basées sur le principe d'héritage utilisés dans l'arborescence du CfgVehicles.
 * Cela signifie qu'une fonctionnalité accordée à une classe, le sera aussi pour toutes ses classes filles.
 * Vue de l'arborescence d'héritage : http://madbull.arma.free.fr/A3_1.32_CfgVehicles_tree.html
 */

/****** LIST OF ADDONS CONFIG TO INCLUDE / LISTE DES CONFIG D'ADDONS A INCLURE ******/
//#include "addons_config\A3_vanilla.sqf"
//#include "addons_config\All_in_Arma.sqf"
//#include "addons_config\R3F_addons.sqf"
//#include "addons_config\YOUR_ADDITIONAL_ADDON.sqf"

/****** TOW WITH VEHICLE / REMORQUER AVEC VEHICULE ******/

/**
 * List of class names of ground vehicles which can tow objects.
 * Liste des noms de classes des véhicules terrestres pouvant remorquer des objets.
 */
R3F_LOG_CFG_can_tow = R3F_LOG_CFG_can_tow +
[
	// e.g. : "MyTowingVehicleClassName1", "MyTowingVehicleClassName2"
	//Base Classes
	"Ship_F",
	"Tank_F",
	"Car_F",
	"SUV_01_base_F",
	"Offroad_01_base_F",
	"Offroad_02_base_F",
	"Van_01_base_F",
	"Van_02_base_F",
	"LSV_01_base_F",
	"LSV_02_base_F",
	"MRAP_01_base_F",
	"MRAP_02_base_F",
	"MRAP_03_base_F",
	"LT_01_base_F",
	"RHS_Ural_Zu23_MSV_01",
	"rhsusf_m109_usarmy",
	"Boat_Armed_01_base_F",
	"rhs_t80u",
	"rhs_t90am_tv",
	"rhs_t90sm_tv",
	"rhs_t72bd_tv",
	"rhs_sprut_vdv",
	"rhs_M6",
	"rhs_M6_wd",
	"RHS_M2A3_BUSKI",
	"RHS_M2A3_BUSKIII",
	"rhs_zsu234_aa",
	"rhs_t72bd_tv",
	"rhs_t80u",
	"rhs_t90am_tv",
	"rhs_t90sm_tv",
	"rhs_sprut_vdv",
	"rhs_bmd1k",
	"rhs_bmd1p",
	"rhs_bmd1pk",
	"rhs_bmd1r",
	"rhs_bmd1",
	"rhs_bmd2",
	"rhs_bmd2k",
	"rhs_bmd2m",
	"rhs_bmd4_vdv",
	"rhs_bmd4ma_vdv",
	"rhs_bmd4m_vdv",
	"rhs_brm1k_vdv",
	"rhsusf_m1a1aim_tuski_d",
	"rhsusf_m1a2sep1tuskid_usarmy",
	"rhsusf_m1a2sep1tuskiid_usarmy",
	"rhsusf_m1a2sep1tuskiiwd_usarmy",
	"RHS_M2A2_BUSKI",
	"rhs_zsu234_aa"


	/*"SUV_01_base_F",
	"Offroad_01_base_F",
	"Van_01_base_F",
	"MRAP_01_base_F",
	"MRAP_02_base_F",
	"MRAP_03_base_F",
	"Truck_01_base_F",
	"Truck_02_base_F",
	"Truck_03_base_F",
	"Wheeled_APC_F",
	"APC_Tracked_01_base_F",
	"APC_Tracked_02_base_F",
	"APC_Tracked_03_base_F",
	"MBT_01_base_F",
	"MBT_02_base_F",
	"MBT_03_base_F",
	"I_LT_01_scout_F",
	"I_LT_01_cannon_F",
	"I_LT_01_AT_F",
	"I_LT_01_AA_F",
	"Boat_Armed_01_base_F",
	"B_T_VTOL_01_infantry_F",
	"B_T_VTOL_01_vehicle_F",
	"B_T_VTOL_01_armed_F",
	"I_C_Offroad_02_unarmed_F",
	"C_Offroad_02_unarmed_F",
	"B_T_UAV_03_F",
	"C_Plane_Civil_01_F",
	"C_Plane_Civil_01_Racing_F",
	"B_CTRG_LSV_01_light_F",
	"B_T_LSV_01_unarmed_F",
	"B_T_LSV_01_armed_F",
	"O_T_LSV_02_unarmed_F",
	"O_T_LSV_02_armed_F",
	"C_Scooter_Transport_01_F",
	"Land_Cargo20_military_green_F"*/
];

/**
 * List of class names of objects which can be towed.
 * Liste des noms de classes des objets remorquables.
 */
R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed +
[
	// e.g. : "MyTowableObjectClassName1", "MyTowableObjectClassName2"
	//Base Classes
	"Car_F",
	"Ship_F",
	"Tank_F",
	"Air",
	"Car_F",
	"Ship_F",
	"Plane",
	"LT_01_base_F",
	"UAV_03_base_F",
	"Heli_Light_01_base_F",
	"Heli_Light_02_base_F",
	"Heli_light_03_base_F",
	"Heli_Attack_01_base_F",
	"Wheeled_APC_F",
	"APC_Tracked_01_base_F",
	"APC_Tracked_02_base_F",
	"APC_Tracked_03_base_F",
	"MBT_01_base_F",
	"MBT_02_base_F",
	"MBT_03_base_F",
	"MBT_04_base_F",
	"Heli_Attack_02_base_F",
	"Heli_Transport_01_base_F",
	"Heli_Transport_02_base_F",
	"Heli_Transport_03_base_F",
	"Heli_Transport_04_base_F",
	"VTOL_base_F",
	"UAV_05_Base_F",
	"Plane_Fighter_01_Base_F",
	"Plane_Fighter_02_Base_F",
	"Plane_CAS_01_base_F",
	"RHS_Ural_Zu23_MSV_01",
	"rhsusf_m109_usarmy",
	"RHS_M119_WD",
	"Plane_CAS_02_base_F",
	"rhs_t80u",
	"rhs_t90am_tv",
	"rhs_t90sm_tv",
	"rhs_t72bd_tv",
	"rhs_sprut_vdv",
	"rhs_M6",
	"rhs_M6_wd",
	"RHS_M2A3_BUSKI",
	"RHS_M2A3_BUSKIII",
	"rhs_zsu234_aa",
	"rhs_t72bd_tv",
	"rhs_t80u",
	"rhs_t90am_tv",
	"rhs_t90sm_tv",
	"rhs_sprut_vdv",
	"rhs_bmd1k",
	"rhs_bmd1p",
	"rhs_bmd1pk",
	"rhs_bmd1r",
	"rhs_bmd1",
	"rhs_bmd2",
	"rhs_bmd2k",
	"rhs_bmd2m",
	"rhs_bmd4_vdv",
	"rhs_bmd4ma_vdv",
	"rhs_bmd4m_vdv",
	"rhs_brm1k_vdv",
	"rhsusf_m1a1aim_tuski_d",
	"rhsusf_m1a2sep1tuskid_usarmy",
	"rhsusf_m1a2sep1tuskiid_usarmy",
	"rhsusf_m1a2sep1tuskiiwd_usarmy",
	"RHS_M2A2_BUSKI",
	"rhs_zsu234_aa"	


	/*"Hatchback_01_base_F",
	"SUV_01_base_F",
	"Offroad_01_base_F",
	"Van_01_base_F",
	"MRAP_01_base_F",
	"MRAP_02_base_F",
	"MRAP_03_base_F",
	"Truck_01_base_F",
	"Truck_02_base_F",
	"Truck_03_base_F",
	"UGV_01_base_F",
	"SDV_01_base_F",
	"Boat_Civil_01_base_F",
	"Boat_Armed_01_base_F",
	"Helicopter_Base_F",
	"Wheeled_APC_F",
	"APC_Tracked_01_base_F",
	"APC_Tracked_02_base_F",
	"APC_Tracked_03_base_F",
	"MBT_01_base_F",
	"MBT_02_base_F",
	"MBT_03_base_F",
	"I_LT_01_scout_F",
	"I_LT_01_cannon_F",
	"I_LT_01_AT_F",
	"I_LT_01_AA_F",
	"Plane",
	"B_T_VTOL_01_infantry_F",
	"B_T_VTOL_01_vehicle_F",
	"B_T_VTOL_01_armed_F",
	"O_T_VTOL_02_vehicle_F",
	"C_Offroad_02_unarmed_F",
	"I_C_Offroad_02_unarmed_F",
	"B_T_UAV_03_F",
	"C_Plane_Civil_01_F",
	"C_Plane_Civil_01_Racing_F",
	"B_CTRG_LSV_01_light_F",
	"B_T_LSV_01_unarmed_F",
	"B_T_LSV_01_armed_F",
	"O_T_LSV_02_unarmed_F",
	"O_T_LSV_02_armed_F",
	"C_Scooter_Transport_01_F",
	"Land_Cargo20_military_green_F"*/
];


/****** LIFT WITH VEHICLE / HELIPORTER AVEC VEHICULE ******/

/**
 * List of class names of helicopters which can lift objects.
 * Liste des noms de classes des hélicoptères pouvant héliporter des objets.
 */
R3F_LOG_CFG_can_lift = R3F_LOG_CFG_can_lift +
[
	// e.g. : "MyLifterVehicleClassName1", "MyLifterVehicleClassName2"
	"Heli_Transport_03_base_F",
	"I_Heli_Transport_02_F",
	"Heli_Transport_04_base_F", //added from here
	//"Helicopter_Base_F"
	//"Heli_Light_01_base_F",
	"Heli_Light_02_base_F",
	"Heli_light_03_base_F",
	"Heli_Attack_01_base_F",
	"Heli_Attack_02_base_F",
	"Heli_Transport_01_base_F",
	"rhsusf_CH53E_USMC",	
	"VTOL_base_F"	
];

/**
 * List of class names of objects which can be lifted.
 * Liste des noms de classes des objets héliportables.
 */
R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
	// e.g. : "MyLiftableObjectClassName1", "MyLiftableObjectClassName2"
	//Base Classes
	"Ship_F",
	"Tank_F",
	"Car_F",
	//"ReammoBox_F",
	"Land_Pod_Heli_Transport_04_box_F",
	"Land_Pod_Heli_Transport_04_repair_F",
	"Land_Pod_Heli_Transport_04_fuel_F",
	"Land_Pod_Heli_Transport_04_ammo_F",	
	//"Land_Cargo20_yellow_F",
	//"Land_Cargo40_white_F",
	"B_T_UAV_03_F",
	"C_Plane_Civil_01_F",
	"C_Plane_Civil_01_Racing_F",
	"B_CTRG_LSV_01_light_F",
	"B_T_LSV_01_unarmed_F",
	"B_T_LSV_01_armed_F",
	"O_T_LSV_02_unarmed_F",
	//"Land_Cargo40_white_F",
	//"Land_Cargo20_yellow_F",
	//"Land_CargoBox_V1_F",	
	"O_T_LSV_02_armed_F",
	"LT_01_base_F",
	"UAV_03_base_F",
	"Heli_Light_01_base_F",
	"Wheeled_APC_F",
	"APC_Tracked_01_base_F",
	"APC_Tracked_02_base_F",
	"APC_Tracked_03_base_F",
	"MBT_01_base_F",
	"MBT_02_base_F",
	"MBT_03_base_F",
	"MBT_04_base_F",
	"Heli_Light_02_base_F",
	"Heli_light_03_base_F",
	"Heli_Attack_01_base_F",
	"Heli_Attack_02_base_F",
	"Heli_Transport_01_base_F",
	"Heli_Transport_02_base_F",
	"Heli_Transport_03_base_F",
	"Heli_Transport_04_base_F",
	"Plane_CAS_01_base_F",
	"Plane_CAS_02_base_F",
	"Plane_Fighter_03_base_F",
	"VTOL_01_base_F",
	"RHS_Ural_Zu23_MSV_01",
	"rhsusf_m109_usarmy",
	"VTOL_02_base_F",
	"rhs_t80u",
	"rhs_t90am_tv",
	"rhs_t90sm_tv",
	"rhs_t72bd_tv",
	"rhs_sprut_vdv",
	"rhs_M6",
	"rhs_M6_wd",
	"RHS_M2A3_BUSKI",
	"RHS_M2A3_BUSKIII",
	"rhs_zsu234_aa",
	"rhs_t72bd_tv",
	"rhs_t80u",
	"rhs_t90am_tv",
	"rhs_t90sm_tv",
	"rhs_sprut_vdv",
	"rhs_bmd1k",
	"rhs_bmd1p",
	"rhs_bmd1pk",
	"rhs_bmd1r",
	"rhs_bmd1",
	"rhs_bmd2",
	"rhs_bmd2k",
	"rhs_bmd2m",
	"rhs_bmd4_vdv",
	"rhs_bmd4ma_vdv",
	"rhs_bmd4m_vdv",
	"rhs_brm1k_vdv",
	"rhsusf_m1a1aim_tuski_d",
	"rhsusf_m1a2sep1tuskid_usarmy",
	"rhsusf_m1a2sep1tuskiid_usarmy",
	"rhsusf_m1a2sep1tuskiiwd_usarmy",
	"RHS_M2A2_BUSKI",
	"rhs_zsu234_aa"	
	


	/*"ReammoBox_F",
	"Hatchback_01_base_F",
	"SUV_01_base_F",
	"Offroad_01_base_F",
	"Van_01_base_F",
	"MRAP_01_base_F",
	"MRAP_02_base_F",
	"MRAP_03_base_F",
	"Truck_01_base_F",
	"Truck_02_base_F",
	"Truck_03_base_F",
	"UGV_01_base_F",
	"SDV_01_base_F",
	"Boat_Civil_01_base_F",
	"Boat_Armed_01_base_F",
	"Wheeled_APC_F",
	"APC_Tracked_01_base_F",
	"APC_Tracked_02_base_F",
	"APC_Tracked_03_base_F",
	"MBT_01_base_F",
	"MBT_02_base_F",
	"MBT_03_base_F",
	"I_LT_01_scout_F",
	"I_LT_01_cannon_F",
	"I_LT_01_AT_F",
	"I_LT_01_AA_F",
	"Land_Pod_Heli_Transport_04_box_F",
	"Land_Cargo20_yellow_F",
	"Land_Cargo40_white_F",
    "B_T_VTOL_01_infantry_F",
	"B_T_VTOL_01_vehicle_F",
	"B_T_VTOL_01_armed_F",
	"O_T_VTOL_02_vehicle_F",
	"I_C_Offroad_02_unarmed_F",
	"C_Offroad_02_unarmed_F",
	"B_T_UAV_03_F",
	"C_Plane_Civil_01_F",
	"C_Plane_Civil_01_Racing_F",
	"B_CTRG_LSV_01_light_F",
	"B_T_LSV_01_unarmed_F",
	"B_T_LSV_01_armed_F",
	"O_T_LSV_02_unarmed_F",
	"O_T_LSV_02_armed_F",
	"C_Scooter_Transport_01_F",
	"Land_Cargo20_military_green_F"*/

];


/****** LOAD IN VEHICLE / CHARGER DANS LE VEHICULE ******/

/*
* (EN)
 * This section uses a numeric quantification of capacity and cost of the objets.
 * For example, in a vehicle has a capacity of 100, we will be able to load in 5 objects costing 20 capacity units.
 * The capacity doesn't represent a real volume or weight, but a choice made for gameplay.
 * 
 * (FR)
 * Cette section utilise une quantification numérique de la capacité et du coût des objets.
 * Par exemple, dans un véhicule d'une capacité de 100, nous pouvons charger 5 objets coûtant 20 unités de capacité.
 * La capacité ne représente ni un poids, ni un volume, mais un choix fait pour la jouabilité.
 */

/**
 * List of class names of vehicles or cargo objects which can transport objects.
 * The second element of the nested arrays is the load capacity (in relation with the capacity cost of the objects).
 * 
 * Liste des noms de classes des véhicules ou "objets contenant" pouvant transporter des objets.
 * Le deuxième élément des sous-tableaux est la capacité de chargement (en relation avec le coût de capacité des objets).
 */
R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo +
[
	// e.g. : ["MyTransporterClassName1", itsCapacity], ["MyTransporterClassName2", itsCapacity]
	["Quadbike_01_base_F", 50],
	["UGV_01_base_F", 100],
	["Hatchback_01_base_F", 100],
	["SUV_01_base_F", 200],
	["Offroad_01_base_F", 20],
	["Offroad_02_base_F", 20],	
	["C_Rubberboat", 400],
	["B_Boat_Transport_01_F", 800],
	["I_SDV_01_F", 600],
	["Van_01_base_F", 400],
	["Van_02_base_F", 400],
	["LSV_01_base_F", 15],
	["LSV_02_base_F", 15],	
	["MRAP_01_base_F", 200],
	["MRAP_02_base_F", 200],
	["MRAP_03_base_F", 200],
	["B_Truck_01_box_F", 15000],
	["Truck_F", 2750],
	["Wheeled_APC_F", 300],
	["Tank_F", 1300],
	["I_LT_01_scout_F", 100],
	["I_LT_01_cannon_F", 100],
	["I_LT_01_AT_F", 100],
	["I_LT_01_AA_F", 100],
	["Rubber_duck_base_F", 100],
	["Boat_Civil_01_base_F", 100],
	["Boat_Armed_01_base_F", 200],
	["Heli_Light_01_base_F", 100],
	["Heli_Light_02_base_F", 200],
	["Heli_light_03_base_F", 200],
	["Heli_Transport_01_base_F", 1250],
	["Heli_Transport_02_base_F", 1300],
	["Heli_Transport_03_base_F", 1150],
	["Heli_Transport_04_base_F", 1300],
	["rhsusf_CH53E_USMC", 1300],
	["Heli_Attack_01_base_F", 100],
	["Heli_Attack_02_base_F", 200],
	["Land_Pod_Heli_Transport_04_box_F", 5000],
	["Land_Pod_Heli_Transport_04_repair_F", 5000],
	["Land_Pod_Heli_Transport_04_fuel_F", 5000],
	["Land_Pod_Heli_Transport_04_ammo_F", 5000],	
	["Land_CargoBox_V1_F", 50000],
	["Land_Cargo20_yellow_F", 10000],
	["Land_Cargo40_white_F", 20000],
	["B_T_VTOL_01_infantry_F", 30000],
	["B_T_VTOL_01_vehicle_F", 30000],
	["B_T_VTOL_01_armed_F", 30000],
	["O_T_VTOL_02_vehicle_F", 30000],
	["C_Offroad_02_unarmed_F", 10000],
	["I_C_Offroad_02_unarmed_F", 10000],
	["B_T_UAV_03_F", 5000],
	["C_Plane_Civil_01_F", 5000],
	["C_Plane_Civil_01_Racing_F", 8500],
	["B_CTRG_LSV_01_light_F", 9500],
	["B_T_LSV_01_unarmed_F", 9500],
	["B_T_LSV_01_armed_F", 9500],
	["O_T_LSV_02_unarmed_F", 9500],
	["O_T_LSV_02_AT_F", 9500],	
	["O_T_LSV_02_armed_F", 950],
	["C_Scooter_Transport_01_F", 10000],	
	["B_Slingload_01_Cargo_F", 3000],
	[ST_CARGO_SMALL, 25],
	[ST_CARGO_LARGE, 800],	
	["Land_Cargo10_yellow_F", 5000],
	["rhsusf_m109_usarmy", 1300],
	["RHS_Ural_Zu23_MSV_01", 2750],
	["Land_Cargo40_yellow_F", 10000],	
	["Land_Cargo20_military_green_F", 10000],
	["Land_Cargo20_sand_F", 10000],	
	["rhs_t80u", 200],
	["rhs_t90am_tv", 200],
	["rhs_t90sm_tv", 200],
	["rhs_t72bd_tv", 200],
	["rhs_sprut_vdv", 200],
	["HAFM_CB90", 10000],
	["HAFM_GunBoat", 10000],
	["HAFM_GunBoat_BLU", 10000],
	["HAFM_CB90_BLU", 10000],
	["HAFM_Replenishment", 25000],
	["HAFM_Russen", 15000],
	["HAFM_Admiral", 15000],
	["HAFM_MEKO_TN", 15000],
	["HAFM_MEKO_HN", 15000],
	["HAFM_FREMM", 15000],
	["HAFM_ABurke", 15000],
	["HAFM_052C", 20000],
	["HAFM_052D", 20000],
	["HAFM_BUYAN", 15000],
	["HAFM_Virginia", 15000],
	["HAFM_Yasen", 15000],
	["HAFM_209", 10000],
	["HAFM_214", 10000],
	["rhs_M6", 300],
	["rhs_M6_wd", 300],
	["RHS_M2A3_BUSKI", 300],
	["RHS_M2A3_BUSKIII", 300],
	["rhs_zsu234_aa", 300],
	["rhs_t72bd_tv", 300],
	["rhs_t80u", 300],
	["rhs_t90am_tv", 300],
	["rhs_t90sm_tv", 300],
	["rhs_sprut_vdv", 300],
	["rhs_bmd1k", 300],
	["rhs_bmd1p", 300],
	["rhs_bmd1pk", 300],
	["rhs_bmd1r", 300],
	["rhs_bmd1", 300],
	["rhs_bmd2", 300],
	["rhs_bmd2k", 300],
	["rhs_bmd2m", 300],
	["rhs_bmd4_vdv", 300],
	["rhs_bmd4ma_vdv", 300],
	["rhs_bmd4m_vdv", 300],
	["rhs_brm1k_vdv", 300],
	["rhsusf_m1a1aim_tuski_d", 300],
	["rhsusf_m1a2sep1tuskid_usarmy", 300],
	["rhsusf_m1a2sep1tuskiid_usarmy", 300],
	["rhsusf_m1a2sep1tuskiiwd_usarmy", 300],
	["RHS_M2A2_BUSKI", 300],
	["rhs_zsu234_aa", 300]	
	
];

/**
 * List of class names of objects which can be loaded in transport vehicle/cargo.
 * The second element of the nested arrays is the cost capacity (in relation with the capacity of the vehicles).
 * 
 * Liste des noms de classes des objets transportables.
 * Le deuxième élément des sous-tableaux est le coût de capacité (en relation avec la capacité des véhicules).
 */
R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
	// e.g. : ["MyTransportableObjectClassName1", itsCost], ["MyTransportableObjectClassName2", itsCost]
	["Land_SatellitePhone_F", 10],           				//Re Locker
    ["Box_NATO_AmmoVeh_F", 10],                    			//Safe
    ["Land_Canal_Wall_10m_F", 10],           				//Base Door (Pillbox)
    ["Land_MapBoard_01_Wall_Altis_F", 5],      				//Base Door Key
	["ContainmentArea_01_forest_F", 25], 					//Base Roof (Retractable) Horizontal
	["ContainmentArea_01_sand_F", 25], 						//Base Roof (Retractable) Vertical		
	["Land_Bunker_01_blocks_1_F", 5], 						//Base Door (Man)
	["Land_Bunker_01_blocks_3_F", 8], 						//Base Door (Vehicle)
	//["Land_CargoBox_V1_F", 150], 							// Base in a Box (Small)
	["Land_Cargo20_sand_F", 250],							// Bulk Purchase
	["Land_Cargo20_yellow_F", 250], 						// Base in a Box (Medium)
	["Land_Cargo40_white_F", 300], 							// Base in a Box (Large)	
	["Land_NetFence_01_m_pole_F", 5],						// Base building tool
	["Land_Pier_Box_F", 25],								// Helipad
	["Land_PortableGenerator_01_F", 25],					// Helipad rearm 
	["Land_CargoBox_V1_F", 25],								// Virtual Arsenal
	["Land_PhoneBooth_01_malden_F", 50],					// Halo Booth
	["Land_ToolTrolley_02_F", 100],							// Vehicle Tuning Rig
	["Land_LampStreet_02_F", 5],
	["Land_Cargo_Tower_V1_F", 100],
	["Land_Pod_Heli_Transport_04_repair_F", 50],
	["Land_Pod_Heli_Transport_04_fuel_F", 50],
	["Land_Pod_Heli_Transport_04_ammo_F", 50],
	["Land_Pod_Heli_Transport_04_box_F", 50],	
	["Land_CobblestoneSquare_01_32m_F", 30],
	["Land_CobblestoneSquare_01_8m_F", 15],
	["Land_CobblestoneSquare_01_4m_F", 10],
	["Land_CobblestoneSquare_01_2m_F", 5],	
	["Land_Canal_Dutch_01_bridge_F", 45],	
	["Land_PortableLight_02_double_olive_F", 25],
	["Land_PortableLight_02_quad_olive_F", 25],
	["Land_Loudspeakers_F", 15],
	["Land_Tablet_02_F", 10],
	["Land_Pier_F", 300],
	[ST_HELIPAD_REARM, 150],
	["Campfire_burning_F", 10],	
	["FirePlace_burning_F", 10],	
	["Land_RepairDepot_01_green_F", 50],		
	["Land_FireEscape_01_short_F", 30],
	["Land_FireEscape_01_tall_F", 30],	
	["StaticWeapon", 5],
	["Box_NATO_AmmoVeh_F", 10],
    ["Box_NATO_Uniforms_F", 10],
    ["Box_NATO_Equip_F", 10],
	["B_supplyCrate_F", 5],
	["Box_T_East_Ammo_F", 5],
	["ReammoBox_F", 3],
	["Kart_01_Base_F", 5],
	["Quadbike_01_base_F", 10],
	["C_Scooter_Transport_01_F", 10],
	["Rubber_duck_base_F", 10],
	["Land_BagBunker_Large_F", 10],
	["Land_BagBunker_Small_F", 5],
	["Land_BagBunker_Tower_F", 7],
	["Land_BagFence_Corner_F", 2],
	["Land_BagFence_End_F", 2],
	["Land_BagFence_Long_F", 3],
	["Land_BagFence_Round_F", 2],
	["Land_BagFence_Short_F", 2],
	["Land_BarGate_F", 3],
    ["Land_Canal_Wall_Stairs_F", 7],
	//["Land_CargoBox_V1_F", 5],
	["Land_CncBarrier_F", 4],
	["Land_CncBarrierMedium_F", 4],
	["Land_CncBarrierMedium4_F", 4],
	["Land_CncShelter_F", 2],
	["Land_CncWall1_F", 3],
	["Land_CncWall4_F", 5],
	["Land_Crash_barrier_F", 5],
	["Land_HBarrierWall_corner_F", 5],
	["Land_HBarrierWall_corridor_F", 6],
	["Land_HBarrierBig_F", 5],
	["Land_HBarrierTower_F", 8],
	["Land_LampHarbour_F", 2],
	["Land_LampShabby_F", 2],
    ["Land_LampHalogen_F", 5],
    ["Land_PortableLight_double_F", 2],
	["Land_MetalBarrel_F", 2],
	["Land_Mil_ConcreteWall_F", 5],
	["Land_Mil_WallBig_4m_F", 5],
	["Land_Obstacle_Ramp_F", 5],
	["Land_RampConcreteHigh_F", 6],
	["Land_RampConcrete_F", 5],
	["BlockConcrete_F", 6],
	["Land_Scaffolding_F", 5],

	["Land_Stone_8m_F", 5],
    ["Land_GH_Platform_F", 8],
    ["Land_GH_Stairs_F", 5],
	["Land_SCF_01_shed_F", 100],

	["FlagPole_F", 3],
	["Land_ConcreteWall_01_l_4m_F", 10], 
	["Land_ConcreteWall_01_l_8m_F", 10], 
	["Land_ConcreteWall_01_l_gate_F", 10],
	["Land_Fortress_01_5m_F", 20],
	["Land_Fortress_01_10m_F", 30],
	["Land_Fortress_01_d_L_F", 20],
	["Land_Fortress_01_d_R_F", 20],
	["Land_Fortress_01_outterCorner_50_F", 30],
	["Land_Fortress_01_outterCorner_80_F", 30],
	["Land_Fortress_01_outterCorner_90_F", 30],
    ["Land_CzechHedgehog_01_F", 5],
    ["Land_Bunker_01_blocks_1_F", 3],
    ["Land_Bunker_01_blocks_3_F", 5],
    ["Land_Bunker_01_small_F", 5],
    ["Land_Bunker_01_tall_F", 13],
    ["Land_Bunker_01_big_F", 20],
    ["Land_Bunker_01_HQ_F", 20],
	["Land_HBarrier_01_line_1_green_F", 3], 
	["Land_HBarrier_01_line_3_green_F", 3],
	["Land_HBarrier_01_line_5_green_F", 3],
	["Land_HBarrier_01_big_4_green_F", 5], 
	["Land_HBarrier_01_wall_4_green_F", 5],  
	["Land_HBarrier_01_wall_6_green_F", 5], 
	["Land_HBarrier_01_wall_corner_green_F", 5], 
	["Land_HBarrier_01_wall_corridor_green_F", 5], 
	["Land_HBarrier_01_big_tower_green_F", 5], 
	["Land_HBarrier_01_wall_corner_green_F", 5], 
	["Land_BagFence_01_end_green_F", 5], 
	["Land_BagFence_01_long_green_F", 5],
	["Land_BagFence_01_round_green_F", 5],
	["Land_BagFence_01_short_green_F", 5],
    ["Land_SandbagBarricade_01_half_F", 5],
    ["Land_SandbagBarricade_01_F", 7],
    ["Land_SandbagBarricade_01_hole_F", 7],
	["Bag Bunker Tower (Tan)", 10],	
	["Land_Canal_WallSmall_10m_F", 10],
    ["MetalBarrel_burning_F", 10],	
	["Land_Canal_Dutch_01_plate_F", 100],
	["ReammoBox_F", 1],
	["StaticWeapon", 5],
	["ArrowDesk_L_F", 2],
	["ArrowDesk_R_F", 2],
	["B_CargoNet_01_ammo_F", 4],
	["B_supplyCrate_F", 2],
	["BlockConcrete_F", 25],
	["Box_AAF_Equip_F", 2],
	["Box_AAF_Uniforms_F", 2],
	["Box_Ammo_F", 2],
	["Box_CSAT_Equip_F", 2],
	["Box_CSAT_Uniforms_F", 2],
	["Box_East_AmmoVeh_F", 10],
	["Box_FIA_Support_F", 2],
	["Box_FIA_Wps_F", 2],
	["Box_IED_Exp_F", 2],
	["Box_IND_AmmoOrd_FF", 2],
	["Box_IND_AmmoVeh_F", 10],
	["Box_NATO_AmmoVeh_F", 10],
	["Box_NATO_Equip_F", 2],
	["Box_NATO_Uniforms_F", 2],
	["Box_Syndicate_Wps_F", 2],
	["Box_Syndicate_WpsLaunch_F", 2],
	["C_Scooter_Transport_01_F", 15],
	["C_supplyCrate_F", 2],
	["C_T_supplyCrate_F", 2],
	["CamoNet_BLUFOR_big_F", 10],
	["CamoNet_BLUFOR_F", 10],
	["CamoNet_BLUFOR_open_F", 10],
	["CamoNet_INDP_big_F", 10],
	["CamoNet_INDP_F", 10],
	["CamoNet_INDP_open_F", 10],
	["CamoNet_OPFOR_big_F", 10],
	["CamoNet_OPFOR_F", 10],
	["CamoNet_OPFOR_open_F", 10],
	["CargoNet_01_box_F", 2],
	//["ContainmentArea_01_forest_F", 10],
	//["ContainmentArea_01_sand_F", 10],
	//["ContainmentArea_02_forest_F", 10],
	//["ContainmentArea_02_sand_F", 10],
	["EAST_Box_Base", 1],
	["Land_PalmTotem_02_F", 40],
	["Land_TacticalBacon_F", 40],
	["FIA_Box_Base_F", 1],
	["Flag_AAF_F", 5],
	["Flag_AltisColonial_F", 5],
	["Flag_Altis_F", 5],
	["Flag_Blue_F", 5],
	["Flag_CSAT_F", 5],
	["Flag_CTRG_F", 5],
	["Flag_FIA_F", 5],
	["Flag_Fuel_F", 5],
	["Flag_Gendarmerie_F", 5],
	["Flag_Green_F", 5],
	["Flag_NATO_F", 5],
	["Flag_POWMIA_F", 5],
	["Flag_RedCrystal_F", 5],
	["Flag_Red_F", 5],
	["Flag_Syndikat_F", 5],
	["Flag_UK_F", 5],
	["Flag_UNO_F", 5],
	["Flag_US_F", 5],
	["Flag_Viper_F", 5],
	["Flag_White_F", 5],
	["FlexibleTank_01_sand_F", 30],
	["I_supplyCrate_F", 2],
	["IG_supplyCrate_F", 2],
	["IND_Box_Base", 2],
	["Kart_01_Base_F", 10],
	[ST_CARGO_SMALL, 25],
	[ST_CARGO_LARGE, 75],
	["Land_BagBunker_Large_F", 10],
	["Land_BagBunker_Small_F", 5],
	["Land_BagBunker_Tower_F", 7],
	["Land_BagFence_Corner_F", 2],
	["Land_BagFence_End_F", 2],
	["Land_BagFence_Long_F", 3],
	["Land_BagFence_Round_F", 2],
	["Land_BagFence_Short_F", 2],
	["Land_BarGate_F", 3],
	["Land_Canal_Wall_10m_F", 10],
	["Land_Canal_Wall_Stairs_F", 3],
	["Land_Canal_WallSmall_10m_F", 4],
	["Land_Cargo_Tower_V1_No5_F", 100],
	["Land_Cargo_Tower_V1_No6_F", 100],
	["Land_Cargo_Tower_V1_No1_F", 100],
	["Land_Cargo_Tower_V1_No7_F", 100],
	["Land_Cargo_Tower_V1_No2_F", 100],
	["Land_Cargo_Tower_V1_No3_F", 100],
	["Land_Cargo_Tower_V1_No4_F", 100],
	["Land_Castle_01_tower_F", 75],
	["Land_CncBarrier_F", 4],
	["Land_CncBarrierMedium4_F", 4],
	["Land_CncBarrierMedium_F", 4],
	["Land_CncShelter_F", 2],
	["Land_CncWall1_F", 3],
	["Land_CncWall4_F", 5],
	["Land_Concrete_SmallWall_4m_F", 2],
	["Land_Concrete_SmallWall_8m_F", 4],
	["Land_ConcretePipe_F",5],
	["Land_ConcreteWall_01_l_gate_F", 2],
	["Land_ConcreteWall_01_m_4m_F", 2],
	["Land_ConcreteWall_01_m_8m_F", 4],
	["Land_ConcreteWall_01_m_gate_F", 2],
	["Land_ConcreteWall_02_m_8m_F", 4],
	["Land_ConcreteWall_02_m_gate_F", 2],
	["Land_ConcreteWall_02_m_4m_F", 2],
	["Land_ConcreteWall_02_m_2m_F", 2],
	["Land_ShotTimer_01_F", 5],
	["Land_Graffiti_01_F", 2],
	["Land_GuardRailing_01_F", 2],
	["Land_HBarrier_1_F", 3],
	["Land_HBarrier_3_F", 4],
	["Land_HBarrier_5_F", 5],
	["Land_HBarrier_5_F", 5],
	["Land_HBarrier_Big_F", 5],
	["Land_HBarrierBig_F", 5],
	["Land_HBarrierTower_F", 8],
	["Land_HBarrierWall4_F", 4],
	["Land_HBarrierWall6_F", 6],
	["Land_HBarrierWall_corner_F", 7],
	["Land_HBarrierWall_corridor_F", 8],
	["Land_Hedge_01_s_2m_F", 2],
	["Land_Hedge_01_s_4m_F", 4],
	["Land_LampDecor_F", 5],
	["Land_LampHalogen_F", 5],
	["Land_LampHarbour_F", 5],
	["Land_LampShabby_F", 5],
	["Land_LampSolar_F", 5],
	["Land_LampStreet_F", 5],
	["Land_LampStreet_small_F", 5],
	["Land_MetalBarrel_F", 2],
	["Land_Obstacle_Bridge_F", 2],
	["Land_Obstacle_Climb_F", 2],
	["Land_Obstacle_Pass_F", 2],
	["Land_Obstacle_Ramp_F", 2],
	["Land_Obstacle_Saddle_F", 2],
	["Land_Pier_addon", 20],
	["Land_Pier_Box_F", 100],
	//["Land_Pier_F", 150],
	//["Land_Pier_small_F", 20],
	["Land_SatellitePhone_F", 1],
	["Land_Scaffolding_F", 5],
	["Land_SurvivalRadio_F", 2],
	["Land_LampAirport_F", 2],
	["NATO_Box_Base", 2],
	["Quadbike_01_base_F", 10],
	["RoadBarrier_F", 2],
	["SDV_01_base_F", 15],
	["Land_CzechHedgehog_01_F", 5],
	["Land_Bunker_01_blocks_3_F", 10],
	["Land_Bunker_01_big_F", 150],
	["Land_Bunker_01_blocks_1_F", 3],
	["Land_Bunker_01_HQ_F", 100],
	["Land_Bunker_01_small_F", 100],
	["Land_Bunker_01_tall_F", 150],
	["Land_SandbagBarricade_01_half_F", 3],
	["Land_SandbagBarricade_01_F", 5],
	["Land_SandbagBarricade_01_hole_F", 5],
	["Land_Cargo10_yellow_F", 1000],
	//[ST_CARGO_SMALL, 1000],
	//[ST_CARGO_LARGE, 1500],
	["I_CargoNet_01_ammo_F", 10],
	["O_CargoNet_01_ammo_F", 10],	
	["Slingload_base_F", 1000]
	
];

/****** MOVABLE-BY-PLAYER OBJECTS / OBJETS DEPLACABLES PAR LE JOUEUR ******/

/**
 * List of class names of objects which can be carried and moved by a player.
 * Liste des noms de classes des objets qui peuvent être portés et déplacés par le joueur.
 */
R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
	// e.g. : "MyMovableObjectClassName1", "MyMovableObjectClassName2"
	"Land_SatellitePhone_F",          //Re Locker
    "Box_NATO_AmmoVeh_F",                  //Safe
    "Land_Canal_Wall_10m_F",         //Base Door
    "Land_MapBoard_01_Wall_Altis_F",   //Base Door Key
	"ContainmentArea_01_forest_F",
	"ContainmentArea_01_sand_F",	
	"Land_NetFence_01_m_pole_F",		// Base building tool	
	"Land_Bunker_01_blocks_1_F", 		//Base Door (Man)
	"Land_CargoBox_V1_F",				// Virtual Arsenal
	"Land_Loudspeakers_F",
	"Land_Tablet_02_F",
	"Land_Pier_F",	
	"Land_Bunker_01_blocks_3_F",
	"Land_Pier_Box_F",
	"Land_PortableGenerator_01_F",
	"Land_Cargo40_white_F",
	"rhsusf_mags_crate",
	"Campfire_burning_F",
	"FirePlace_burning_F",	
	"Land_Cargo20_yellow_F",
	"Land_CargoBox_V1_F",
	"StaticWeapon",
	"ReammoBox_F",
    "Box_NATO_Uniforms_F",
    "Box_NATO_Equip_F",
	"Kart_01_Base_F",
	"Quadbike_01_base_F",
	"C_Scooter_Transport_01_F",
	"Rubber_duck_base_F",
	"SDV_01_base_F",
	"Land_BagBunker_Large_F",
	"Land_BagBunker_Small_F",
	"Land_BagBunker_Tower_F",
	"Land_BagFence_Corner_F",
	"Land_BagFence_End_F",
	"Land_BagFence_Long_F",
	"Land_BagFence_Round_F",
	"Land_BagFence_Short_F",
	"Land_BarGate_F",
	"Land_Canal_WallSmall_10m_F",
    "Land_Canal_Wall_Stairs_F",
	"Land_CargoBox_V1_F",
	"Land_CncBarrier_F",
	"Land_CncBarrierMedium_F",
	"Land_CncBarrierMedium4_F",
	"Land_CncShelter_F",
	"Land_CncWall1_F",
	"Land_CncWall4_F",
	"Land_Crash_barrier_F",
	"Land_HBarrierBig_F",
	"Land_HBarrierTower_F",
	"Land_HBarrierWall_corner_F",
	"Land_HBarrierWall_corridor_F",
    "Land_LampHarbour_F",
	"Land_LampShabby_F",
    "Land_LampHalogen_F",
    "Land_PortableLight_double_F",
	"Land_MetalBarrel_F",
	"Land_Mil_ConcreteWall_F",
	"Land_Mil_WallBig_4m_F",
	"Land_Obstacle_Ramp_F",
	"Land_Pipes_large_F",
	"Land_RampConcreteHigh_F",
	"Land_RampConcrete_F",
	"BlockConcrete_F",
	"Land_Sacks_goods_F",
	"Land_Scaffolding_F",


	"Land_Stone_8m_F",

	"Land_Laptop_F",

    "Land_GH_Platform_F",
    "Land_GH_Stairs_F",
	"Flag_NATO_F",
	"Flag_UNO_F",
	"Flag_US_F",
	"Flag_UK_F",
	"FlagPole_F",

	"Land_ConcreteWall_01_l_4m_F", 
	"Land_ConcreteWall_01_l_8m_F", 
	"Land_ConcreteWall_01_l_gate_F",
	"Land_Fortress_01_5m_F",
	"Land_Fortress_01_10m_F",
	"Land_Fortress_01_d_L_F",
	"Land_Fortress_01_d_R_F",
	"Land_Fortress_01_outterCorner_50_F",
	"Land_Fortress_01_outterCorner_80_F",
	"Land_Fortress_01_outterCorner_90_F", 
    "Land_CzechHedgehog_01_F",
    "Land_Bunker_01_blocks_1_F",
    "Land_Bunker_01_blocks_3_F",
    "Land_Bunker_01_small_F",
    "Land_Bunker_01_tall_F",
    "Land_Bunker_01_big_F",
    "Land_Bunker_01_HQ_F",
	"Land_HBarrier_01_line_1_green_F", 
	"Land_RepairDepot_01_green_F",	
	"Land_HBarrier_01_line_3_green_F",
	"Land_HBarrier_01_line_5_green_F",
	"Land_HBarrier_01_big_4_green_F", 
	"Land_HBarrier_01_wall_4_green_F",  
	"Land_HBarrier_01_wall_6_green_F", 
	"Land_HBarrier_01_wall_corner_green_F", 
	"Land_HBarrier_01_wall_corridor_green_F", 
	"Land_HBarrier_01_big_tower_green_F", 
	"Land_HBarrier_01_wall_corner_green_F", 
	"Land_BagFence_01_end_green_F", 
	"Land_BagFence_01_long_green_F",
	"Land_BagFence_01_round_green_F",
	"Land_BagFence_01_short_green_F",
    "Land_SandbagBarricade_01_half_F",
    "Land_SandbagBarricade_01_F",
    "Land_SandbagBarricade_01_hole_F",
	"Land_BagBunker_01_small_green_F",
	"Land_BagBunker_01_large_green_F",
	"Land_HBarrier_01_tower_green_F",
    "MetalBarrel_burning_F",	

	"Land_Canal_Dutch_01_plate_F",

	"ReammoBox_F",


	"B_CargoNet_01_ammo_F",
	"B_Slingload_01_Cargo_F",
	"B_Slingload_01_Medevac_F",
	"B_Slingload_01_Fuel_F",
	"B_Slingload_01_Ammo_F",
	"B_Slingload_01_Repair_F",
	"B_supplyCrate_F",
	"BlockConcrete_F",
	"Box_AAF_Equip_F",
	"Box_AAF_Uniforms_F",
	"Box_Ammo_F",
	"Box_CSAT_Equip_F",
	"Box_CSAT_Uniforms_F",
	"Box_East_AmmoVeh_F",
	"Box_FIA_Support_F",
	"Box_FIA_Wps_F",
	"Box_IED_Exp_F",
	"Box_IND_AmmoOrd_FF",
	"Box_IND_AmmoVeh_F",
	"Box_NATO_AmmoVeh_F",
	"Box_NATO_Equip_F",
	"Box_NATO_Uniforms_F",
	"Box_Syndicate_Wps_F",
	"Box_Syndicate_WpsLaunch_F",
	"Box_T_East_Ammo_F",	
	"C_supplyCrate_F",
	"C_T_supplyCrate_F",
	"CamoNet_BLUFOR_big_F",
	"CamoNet_BLUFOR_F",
	"CamoNet_BLUFOR_open_F",
	"CamoNet_INDP_big_F",
	"CamoNet_INDP_F",
	"CamoNet_INDP_open_F",
	"CamoNet_OPFOR_big_F",
	"CamoNet_OPFOR_F",
	"CamoNet_OPFOR_open_F",
	"CargoNet_01_box_F",
	//"ContainmentAera_2_sand_F",
	//"ContainmentArea_01_forest_F",
	//"ContainmentArea_02_sand_F",
	//"ContainmentArea_02_forest_F",
	//"ContainmentArea_1_sand_F",

	"EAST_Box_Base",
	"Land_PalmTotem_02_F",
	"Land_TacticalBacon_F",
	"FIA_Box_Base_F",
	"Flag_AAF_F",
	"Flag_AltisColonial_F",
	"Flag_Altis_F",
	"Flag_Blue_F",
	"Flag_CSAT_F",
	"Flag_CTRG_F",
	"Flag_FIA_F",
	"Flag_Fuel_F",
	"Flag_Gendarmerie_F",
	"Flag_Green_F",
	"Flag_NATO_F",
	"Flag_POWMIA_F",
	"Flag_RedCrystal_F",
	"Flag_Red_F",
	"Flag_Syndikat_F",
	"Flag_UK_F",
	"Flag_UNO_F",
	"Flag_US_F",
	"Flag_Viper_F",
	"Flag_White_F",
	"FlexibleTank_01_sand_F",
	"I_supplyCrate_F",
	"IG_supplyCrate_F",
	"IND_Box_Base",

	"Land_BagBunker_Large_F",
	"Land_BagBunker_Small_F",
	"Land_BagBunker_Tower_F",
	"Land_BagFence_Corner_F",
	"Land_BagFence_End_F",
	"Land_BagFence_Long_F",
	"Land_BagFence_Round_F",
	"Land_BagFence_Short_F",

	"Land_Canal_Wall_10m_F",
	"Land_Canal_Wall_Stairs_F",
	"Land_Canal_WallSmall_10m_F",
	"Land_Cargo_Tower_V1_No4_F",
	"Land_Cargo_Tower_V1_No3_F",
	"Land_Cargo_Tower_V1_No7_F",
	"Land_Cargo_Tower_V1_No1_F",
	"Land_Cargo_Tower_V1_No6_F",
	"Land_Cargo_Tower_V1_No2_F",
	"Land_Cargo_Tower_V1_No5_F",
	"Land_CargoBox_V1_F",

	"Land_cmp_Tower_F",
	"Land_CncBarrier_F",
	"Land_CncBarrier_stripes_F",
	"Land_CncBarrierMedium4_F",
	"Land_CncBarrierMedium_F",
	"Land_CncShelter_F",
	"Land_CncWall1_F",
	"Land_CncWall4_F",
	"Land_ConcretePipe_F",
	"Land_Concrete_SmallWall_4m_F",
	"Land_Concrete_SmallWall_8m_F",
	"Land_ConcreteWall_01_m_gate_F",
	"Land_ConcreteWall_01_l_gate_F",
	"Land_ConcreteWall_01_m_pole_F",
	"Land_ConcreteWall_01_l_pole_F",
	"Land_ConcreteWall_01_m_8m_F",
	"Land_ConcreteWall_01_m_4m_F",
	"Land_ConcreteWall_01_l_4m_F",
	"Land_ConcreteWall_01_l_8m_F",
	"Land_ConcreteWall_02_m_4m_F",
	"Land_ConcreteWall_02_m_8m_F",
	"Land_ConcreteWall_02_m_pole_F",
	"Land_ConcreteWall_02_m_gate_F",
	"Land_ConcreteWall_02_m_2m_F",

	"Land_HBarrier_1_F",
	"Land_HBarrier_3_F",
	"Land_HBarrier_5_F",
	"Land_HBarrier_Big_F",
	"Land_HBarrierBig_F",
	"Land_HBarrierTower_F",
	"Land_HBarrierWall4_F",
	"Land_HBarrierWall6_F",
	"Land_HBarrierWall_corner_F",
	"Land_HBarrierWall_corridor_F",
	"Land_Hedge_01_s_2m_F",
	"Land_Hedge_01_s_4m_F",
	
	"Land_SCF_01_shed_F",	

	"Land_LampAirport_F",
	"Land_LampDecor_F",
	"Land_LampHalogen_F",
	"Land_LampHarbour_F",
	"Land_LampShabby_F",
	"Land_LampSolar_F",
	"Land_LampStreet_F",
	"Land_LampStreet_small_F",


	"Land_Obstacle_Bridge_F",
	"Land_Obstacle_Climb_F",
	"Land_Obstacle_Pass_F",
	"Land_Obstacle_Ramp_F",
	"Land_Obstacle_Saddle_F",

	"Land_Pier_Box_F",
	//"Land_Pier_F",
	//"Land_Pier_small_F",

	"Land_RampConcrete_F",
	"Land_ShotTimer_01_F",	
	"Land_RampConcreteHigh_F",
	"Land_SatellitePhone_F",
	"Land_Scaffolding_F",
	"Land_Stone_4m_F",
	"Land_Stone_8m_F",
	"Land_Stone_pillar_F",
	"Land_StoneWall_01_s_10m_F",
	"Land_SurvivalRadio_F",
	"Static_Designator_01_base_F",
	"Static_Designator_02_base_F",
	"StaticWeapon",
	"Land_CzechHedgehog_01_F",
	"Land_Bunker_01_blocks_3_F",
	ST_HELIPAD_REARM,
	"Land_Bunker_01_big_F",
	"Land_Bunker_01_blocks_1_F",
	"Land_Bunker_01_HQ_F",
	"Land_Bunker_01_small_F",
	"Land_Bunker_01_tall_F",
	"Land_SandbagBarricade_01_half_F",
	"Land_SandbagBarricade_01_F",
	"Land_SandbagBarricade_01_hole_F",
	"Land_FireEscape_01_tall_F",
	"Land_Cargo10_yellow_F",
	ST_CARGO_SMALL,
	ST_CARGO_LARGE,
	"I_CargoNet_01_ammo_F",
	"O_CargoNet_01_ammo_F",
	"Land_Cargo40_yellow_F",
	"Land_Cargo20_sand_F",	
	"Land_PhoneBooth_01_malden_F",
	"Land_PortableLight_02_double_olive_F",
	"Land_Canal_Dutch_01_bridge_F",
	"Land_PortableLight_02_quad_olive_F",
	"Land_CobblestoneSquare_01_32m_F",
	"Land_CobblestoneSquare_01_8m_F",
	"Land_CobblestoneSquare_01_4m_F",
	"Land_CobblestoneSquare_01_2m_F",
	"Land_Pod_Heli_Transport_04_box_F",	
	"Land_Pod_Heli_Transport_04_repair_F",
	"Land_Pod_Heli_Transport_04_fuel_F",
	"Land_Pod_Heli_Transport_04_ammo_F",
	"Land_ToolTrolley_02_F",
	"Land_LampStreet_02_F",
	"Land_Cargo_Tower_V1_F",	
	"Land_FireEscape_01_short_F"
];