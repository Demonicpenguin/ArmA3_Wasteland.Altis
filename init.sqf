// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.2
//	@file Name: init.sqf
//	@file Author: [404] Deadbeat, [GoT] JoSchaap, AgentRev
//	@file Description: The main init.


#include "debugFlag.hpp"

#ifdef A3W_DEBUG
#define DEBUG true
#else
#define DEBUG false
#endif

enableSaving [false, false];
A3W_sessionTimeStart = diag_tickTime;

_descExtPath = str missionConfigFile;
currMissionDir = compileFinal str (_descExtPath select [0, count _descExtPath - 15]);

vasOnServer = [];	// global variable to store Virtual Arsenals Ids on server
haloOnServer = [];	// global variable to store Halo Jump Booth Ids on server
satOnServer = [];	// global variable to store Base Management System Ids on server

//radPosRepeat = 0;

X_Server = false;
X_Client = false;
X_JIP = false;
warHeadActive = 0; publicVariable "warHeadActive";


CHVD_allowNoGrass = false;
CHVD_allowTerrain = false; // terrain option has been disabled out from the menu due to terrible code, this variable has currently no effect
CHVD_maxView = 4000; // Set maximum view distance (default: 12000)
CHVD_maxObj = 4000; // Set maximimum object view distance (default: 12000)

// versionName = ""; // Set in STR_WL_WelcomeToWasteland in stringtable.xml

if (isServer) then { X_Server = true };
if (!isDedicated) then { X_Client = true };
if (isNull player) then { X_JIP = true };

A3W_scriptThreads = [];

[DEBUG] call compile preprocessFileLineNumbers "globalCompile.sqf";

//init Wasteland Core
[] execVM "config.sqf";
[] execVM "storeConfig.sqf"; // Separated as its now v large
[] execVM "briefing.sqf";

if (!isDedicated) then
{
	[] spawn
	{
		if (hasInterface) then // Normal player
		{
			9999 cutText ["Welcome to A3Wasteland, please wait for your client to initialize", "BLACK", 0.01];

			waitUntil {!isNull player};
			player setVariable ["playerSpawning", true, true];
			playerSpawning = true;

			removeAllWeapons player;
			client_initEH = player addEventHandler ["Respawn", { removeAllWeapons (_this select 0) }];
			
			[] spawn HALs_killfeed_fnc_initModule;
			
			// Reset group & side
			[player] joinSilent createGroup playerSide;

			execVM "client\init.sqf";

			if ((vehicleVarName player) select [0,17] == "BIS_fnc_objectVar") then { player setVehicleVarName "" }; // undo useless crap added by BIS
		}
		else // Headless
		{
			waitUntil {!isNull player};
			if (getText (configFile >> "CfgVehicles" >> typeOf player >> "simulation") == "headlessclient") then
			{
				execVM "client\headless\init.sqf";
			};
		};
	};
		
};

if (isServer) then
{
	diag_log format ["############################# %1 #############################", missionName];
	diag_log "WASTELAND SERVER - Initializing Server";
	[] execVM "server\init.sqf";
};

/*MISSION_ROOT = call {
    private "_arr";
    _arr = toArray __FILE__;
    _arr resize (count _arr - 8);
    toString _arr
};*/

if (hasInterface || isServer) then
{
	//init 3rd Party Scripts
	//[] execVM "addons\scripts\intro.sqf";	//move to after ToparmaInfo input
	[] execVM "addons\scripts\real_weather.sqf";	
	[] execVM "addons\parking\functions.sqf";
	[] execVM "addons\storage\functions.sqf";
	[] execVM "addons\vactions\functions.sqf";
	[] execVM "addons\R3F_LOG\init.sqf";
	[] execVM "addons\proving_ground\init.sqf";
	[] execVM "addons\JumpMF\init.sqf";
	[] execVM "addons\JTS_PM\Functions.sqf";	
	[] execVM "addons\APOC_Airdrop_Assistance\init.sqf";
	[] execVM "addons\Monkeys_Air_Support\init.sqf";
    [] execVM "addons\HvT\HvT.sqf";						// High Value Player
	[] execVM "addons\HvT\HvD.sqf";                     // High Value Drugrunner
	[] execVM "addons\Grenades\initGrenades.sqf";
    [] execVM "addons\laptop\init.sqf";
	[] execVM "addons\outlw_magrepack\MagRepack_init.sqf";
	[] execVM "addons\scripts\servercredits.sqf";
	[] execVM "addons\cruisecontrol\init.sqf";
	[] execVM "addons\scripts\loyalty.sqf";  			// Loyalty Rewards	
	[] execVM "addons\Vcom\VcomInit.sqf";
	[] execVM "addons\VCOM_Driving\init.sqf";
	//[] execVM "client\items\bushkit\cleanup.sqf";
	[] execVM "addons\scripts\ir_to_incendiary.sqf";
	[] execVM "addons\Scripts\adminHunt.sqf";
	//[] execVM "addons\scripts\AALSSW.sqf";
	
	//enableTeamSwitch true;
	
	[] execVM "addons\lsd_nvg\init.sqf";
	[] execVM "addons\stickyCharges\init.sqf";
	//if (isNil "drn_DynamicWeather_MainThread") then { drn_DynamicWeather_MainThread = [] execVM "addons\scripts\DynamicWeatherEffects.sqf" };


	[] execVM "addons\outOfBounds\outOfBoundsHeli.sqf";					// out of bounds audible and visual warning system	
	[] execVM "addons\outOfBounds\outOfBoundsLandVehicle.sqf";	// out of bounds audible and visual warning system
	[] execVM "addons\outOfBounds\outOfBoundsPlane.sqf";				// out of bounds audible and visual warning system
	[] execVM "addons\outOfBounds\outOfBoundsPlayer.sqf";				// out of bounds audible and visual warning system
	[] execVM "addons\outOfBounds\outOfBoundsRemote.sqf";			// out of bounds audible and visual warning system
	[] execVM "addons\outOfBounds\outOfBoundsRemoteStore.sqf";	// out of bounds audible and visual warning system
	[] execVM "addons\outOfBounds\outOfBoundsShip.sqf";					// out of bounds audible and visual warning system	
	
	[] execVM "addons\carpetBomb\GOM_fnc_carpetBombing.sqf";
	
	[] execVM "addons\AdvancedRappelling\AR_AdvancedRappelling\functions\fn_advancedRappellingInit.sqf";
	[] execVM "addons\AdvancedRappelling\AUR_AdvancedUrbanRappelling\functions\fn_advancedUrbanRappellingInit.sqf";
	
	// Restart Warnings	
	[] ExecVM "ScarCode\sRestartWarnings.sqf";

	//nul = [300,500,600,1200,2,[1,1,1],player,["default"],1,2000,nil,["COMBAT","SAD"],false] execVM "addons\AI_spawn\ambientCombat.sqf";
 	//nul = [player,0,1000,[true,true],[true,true,true],false,[2,2],[1,1],["default"],nil,nil,nil] execVM "addons\AI_spawn\militarize.sqf";
	//nul = [player,3,true,2,[10,10],2,0.5,nil,nil,nil] execVM "addons\AI_spawn\fillHouse.sqf";
	//nul = [player,false,2,1,false,true,player,"random",1000,false,false,10,[0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5],[false,false,false,false],nil,nil,nil,true] execVM "addons\AI_spawn\reinforcementChopper.sqf";
	//nul = [player,3,true,true,1500,"random",true,500,400,8,0.5,150,true,false,false,true,player,false,[0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5],nil,nil,nil,true] execVM "addons\AI_spawn\heliParadrop.sqf";
	//nul = [[1],[player],700,false,true] execVM "addons\AI_spawn\LV_functions\LV_fnc_simpleCache.sqf";	
};



if (!(isServer)) then 
{
ClientPreComp_AnnounceMessages = compileFinal preprocessFileLineNumbers "addons\announceMessages\client_AnnounceMessages.sqf";

[] call ClientPreComp_AnnounceMessages;
};

	waitUntil {!isnull player};
	player setVariable ["respawn", serverTime, true];

	player addEventHandler ["Respawn", {
			player setVariable ["respawn", serverTime, true];
	}];

	fn_netSay3D = compile preprocessFileLineNumbers "client\functions\fn_netSay3D.sqf";
	if (isNil "PVEH_netSay3D") then {
		PVEH_NetSay3D = [objNull,0];
	};
	 
	"PVEH_netSay3D" addPublicVariableEventHandler {
		  private["_array"];
		  _array = _this select 1;
		 (_array select 0) say3D (_array select 1);
	};


// Remove line drawings from map
(createTrigger ["EmptyDetector", [0,0,0], false]) setTriggerStatements
[
	"!triggerActivated thisTrigger", 
	"thisTrigger setTriggerTimeout [30,30,30,false]",
	"{if (markerShape _x == 'POLYLINE') then {deleteMarker _x}} forEach allMapMarkers"
];



