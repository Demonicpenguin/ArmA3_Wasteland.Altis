// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.2
//	@file Name: playerActions.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, [GoT] JoSchaap, AgentRev
//	@file Created: 20/11/2012 05:19

{ [player, _x] call fn_addManagedAction } forEach
[
	["Holster Weapon", { player action ["SwitchWeapon", player, player, 100] }, [], -11, false, false, "", "vehicle player == player && currentWeapon player != '' && (stance player != 'CROUCH' || currentWeapon player != handgunWeapon player)"], // A3 v1.58 bug, holstering handgun while crouched causes infinite anim loop
	["Unholster Primary Weapon", { player action ["SwitchWeapon", player, player, 0] }, [], -11, false, false, "", "vehicle player == player && currentWeapon player == '' && primaryWeapon player != ''"],
	
	//Spawn Beacon Detector
	["<t color='#FFE496'><img image='client\icons\spawnbeacon.paa'/> Spawn Beacon Detector On</t>", "addons\spawnBeaconDetector\spawnBeaconDetector.sqf",0,-10,false,false,"","('MineDetector' in (items player)) && !spawnBeaconDetectorInProgress && vehicle player == player"],
	["<t color='#FFE0000'><img image='client\icons\spawnbeacon.paa'/> Spawn Beacon Detector Off</t>", {spawnBeaconDetectorInProgress = false},0,-10,false,false,"","(spawnBeaconDetectorInProgress)"],

	[format ["<img image='client\icons\playerMenu.paa' color='%1'/> <t color='%1'>[</t>Player Menu<t color='%1'>]</t>", "#FF8000"], "client\systems\playerMenu\init.sqf", [], -10, false], //, false, "", ""],

	//Air Drop
	[format ["<img image='\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\supplydrop_ca.paa' color='%1'/> <t color='%1'>[</t>Airdrop Menu<t color='%1'>]</t>", "#FF0000"],"addons\APOC_Airdrop_Assistance\APOC_cli_menu.sqf",[], -99, false, false, "","vehicle player == player"],	

	//Air Support
	[format ["<t color='%1'>[</t>Air Support Menu<t color='%1'>]</t>", "#FF0000"],"addons\Monkeys_Air_Support\Monkey_cli_menu.sqf",[], 1, false, false],

	["<img image='client\icons\money.paa'/> Pickup Money", "client\actions\pickupMoney.sqf", [], 1, false, false, "", "{_x getVariable ['owner', ''] != 'mission'} count (player nearEntities ['Land_Money_F', 5]) > 0"],

	["<img image='addons\buryDeadBody\buryDeadBody.paa'/> Bury Dead Body", "addons\buryDeadBody\buryDeadBody.sqf", [], 1.1, false, false, "", "!(([allDeadMen,[],{player distance _x},'ASCEND',{((player distance _x) < 2) && !(_x getVariable ['buryDeadBodyBurried',false])}] call BIS_fnc_sortBy) isEqualTo [])"],
	//["<img image='client\icons\cancel.paa'/> Hide Body", "client\actions\hide.sqf", [], 1.1, false, false, "", "!isNull cursorTarget && !alive cursorTarget && {cursorTarget isKindOf 'AllVehicles' && (cursorTarget isKindOf 'Man') && player distance cursorTarget <= (sizeOf typeOf cursorTarget / 3) max 2}"],
	["<img image='client\icons\r3f_unlock.paa'/> Break in and hotwire", "addons\breakLock\breakLock.sqf", [cursorTarget], -5,false,false,"","!isNull cursorTarget && vehicle player == player && {{ cursorTarget isKindOf _x } count ['LandVehicle', 'Ship', 'Air'] > 0 ;} && cursorTarget getVariable ['ownerUID',''] != getPlayerUID player && locked cursorTarget >= 2 && cursorTarget distance player < 7 && ('ToolKit' in (items player)) && isNil {cursorTarget getVariable 'A3W_Truck'}"],

	// If you have a custom vehicle licence system, simply remove/comment the following action
	["<img image='client\icons\r3f_unlock.paa'/> Acquire Vehicle Ownership", "client\actions\takeOwnership.sqf", [], 1, false, false, "", "[] call fn_canTakeOwnership isEqualTo ''"],

	[format ["<img image='client\icons\stop.paa' color='%1'/> <t color='%1'>[</t>Hide Mission Message<t color='%1'>]</t>", "#FF8000"], "client\actions\hideMessage.sqf", [], -10, false], //, false, "", ""],

	//Camo Nets - Now Handled by PlayerHud
	//["Deploy Camo Nets", "client\actions\CustomizeVehicle.sqf",["DeployCamo"], -99, false, true, "", "{cursorObject isKindOf _x} count ['Tank_F', 'Wheeled_APC_F']>0 && !(cursorObject getvariable ['CamoDeployed', false])"],
	//["Stow Camo Nets", "client\actions\CustomizeVehicle.sqf",["StowCamo"], -99, false, true, "", "{cursorObject isKindOf _x} count ['Tank_F', 'Wheeled_APC_F']>0 && (cursorObject getvariable ['CamoDeployed', false])"],

	//BulletCam
	//["<img image='client\icons\ammo.paa'/> Bullet Cam On/off", "client\actions\toggleBulletCam.sqf", [], 1, false, false, "", "{currentWeapon player == _x} count ['rhs_weap_M107_w','srifle_DMR_02_F','srifle_DMR_02_camo_F','srifle_DMR_02_sniper_F','rhs_weap_M107','rhs_weap_M107_d','rhs_weap_M107_w','rhs_weap_XM2010','rhs_weap_XM2010_wd','rhs_weap_XM2010_d','rhs_weap_XM2010_sa','rhs_weap_m24sws','rhs_weap_m24sws_blk','rhs_weap_m24sws_ghillie','rhs_weap_svdp','rhs_weap_svdp_wd','rhs_weap_svdp_wd_npz','rhs_weap_svdp_npz','rhs_weap_svds','rhs_weap_svds_npz','rhs_weap_vss','rhs_weap_vss_grip','rhs_weap_vss_grip_npz','rhs_weap_vss_npz','srifle_GM6_F','srifle_GM6_camo_F','srifle_GM6_ghex_F','srifle_LRR_camo_F','srifle_LRR_tna_F','srifle_LRR_F','srifle_DMR_05_blk_F','srifle_DMR_05_hex_F','srifle_DMR_05_tan_f']>0"],
		
	//Take Gear
	["<img image='client\icons\cancel.paa'/> Take Gear", "client\actions\TakeGear.sqf", [], 1, false, false, "", "!isNull cursorObject && !alive cursorObject && {cursorObject isKindOf 'Man' && player distance cursorObject <= (sizeOf typeOf cursorObject / 3) max 2}"], // && side player != west && side player != east"

	//Re-initialize UAV
	["Re-Initilize UAV", "client\actions\reinitializeUAV.sqf", ["Re-Initilize"], 1, false, false, "", "{_x in ['B_UavTerminal','O_UavTerminal','I_UavTerminal']} count assignedItems player > 0 && {cursorTarget iskindof _x} count ['UAV_02_base_F', 'UAV_04_base_F', 'UAV_03_base_F', 'UGV_01_base_F', 'StaticWeapon', 'UAV_05_Base_F', 'B_Radar_System_01_F', 'O_SAM_System_04_F', 'O_Radar_System_02_F', 'B_SAM_System_03_F'] >0"],
	//Disable UAV
	["Disable UAV", "client\actions\disableUAV.sqf", [], 1, false, false, "", "{_x in ['B_UavTerminal','O_UavTerminal','I_UavTerminal']} count assignedItems player > 0 && {cursorTarget iskindof _x} count ['UAV_02_base_F', 'UAV_04_base_F', 'UAV_03_base_F', 'UGV_01_base_F', 'StaticWeapon', 'UAV_05_Base_F'] >0"],
	
	//Attach Static Weapon To Vehicle
	["Attach To Vehicle", "client\actions\AttachtoVehicle.sqf", [], -10, false, false, "", "(cursorTarget iskindof 'StaticWeapon' || cursorTarget iskindof 'Reammobox_F')&& !(cursorTarget getVariable ['Attached', false])"],
	// //Dettach Static Object To Vehicle
	["Dettach From Vehicle", "client\actions\DetachFromVehicle.sqf", [], -10, false, false, "", "cursorTarget iskindof 'Car_F' && cursorTarget getVariable ['Attached', false]"],

	//Remote Base Access
	["Acess Remote Base Management", "client\actions\BaseManegement.sqf", [], -98, false, true, "","{_x in ['B_UavTerminal','O_UavTerminal','I_UavTerminal']} count assignedItems player > 0"],
	//Base Cracking
	/*["Hack Base", "client\actions\BaseCracking.sqf", [], 99, false, false, "", "(vehicle player) iskindof 'O_Truck_03_device_F'"],*/
	

	["<img image='\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\transport_ca.paa'/> <t color='#FFFFFF'>Cancel Action</t>", { doCancelAction = true }, [], 1, false, false, "", "mutexScriptInProgress"],

	["<img image='client\icons\repair.paa'/> Salvage", "client\actions\salvage.sqf", [], 1.1, false, false, "", "!isNull cursorTarget && !alive cursorTarget && {cursorTarget isKindOf 'AllVehicles' && !(cursorTarget isKindOf 'Man') && player distance cursorTarget <= (sizeOf typeOf cursorTarget / 3) max 3}"],

	// If you have a custom vehicle licence system, simply remove/comment the following action
	//["<img image='client\icons\r3f_unlock.paa'/> Acquire Vehicle Ownership", "client\actions\takeOwnership.sqf", [], 1, false, false, "", "[] call fn_canTakeOwnership isEqualTo ''"],

	["[0]"] call getPushPlaneAction,
	["Push vehicle", "server\functions\pushVehicle.sqf", [2.5, true], 1, false, false, "", "[2.5] call canPushVehicleOnFoot"],
	["Push vehicle forward", "server\functions\pushVehicle.sqf", [2.5], 1, false, false, "", "[2.5] call canPushWatercraft"],
	["Push vehicle backward", "server\functions\pushVehicle.sqf", [-2.5], 1, false, false, "", "[-2.5] call canPushWatercraft"],


	["<img image='client\icons\driver.paa'/> Enable driver assist", fn_enableDriverAssist, [], 0.5, false, true, "", "_veh = objectParent player; alive _veh && !alive driver _veh && {effectiveCommander _veh == player && player in [gunner _veh, commander _veh] && {_veh isKindOf _x} count ['LandVehicle','Ship'] > 0 && !(_veh isKindOf 'StaticWeapon')}"],
	["<img image='client\icons\driver.paa'/> Disable driver assist", fn_disableDriverAssist, [], 0.5, false, true, "", "_driver = driver objectParent player; isAgent teamMember _driver && {(_driver getVariable ['A3W_driverAssistOwner', objNull]) in [player,objNull]}"],
	[format ["<t color='#FF0000'>Emergency eject (Ctrl+%1)</t>", (actionKeysNamesArray "GetOver") param [0,"<'Step over' keybind>"]],  { [[], fn_emergencyEject] execFSM "call.fsm" }, [], -9, false, true, "", "(vehicle player) isKindOf 'Air' && !((vehicle player) isKindOf 'ParachuteBase')"],
	[format ["<t color='#FF00FF'>Open magic parachute (%1)</t>", (actionKeysNamesArray "GetOver") param [0,"<'Step over' keybind>"]], A3W_fnc_openParachute, [], 20, true, true, "", "vehicle player == player && (getPos player) select 2 > 2.5"],
	["<t color='#FFE496'><img image='client\icons\search.paa'/> Mark your stuff on the map</t>", "addons\scripts\markOwned.sqf", [], -95,false,false,"","{_x in ['ItemGPS','B_UavTerminal','O_UavTerminal','I_UavTerminal']} count assignedItems player > 0"]	


];

//Door Locking
// For some reason this diesn't work with add managed action.
player addaction ["Lock Door","client\actions\DoorLocking.sqf", ["lock"], -99, false, true, "", "(cursorObject getVariable [format ['bis_disabled_%1',getCursorObjectParams select 1 select 0], 0]) == 0 && {[['door_'],getCursorObjectParams select 1 select 0] call fn_startsWith} && cursorObject getVariable ['objectLocked', false]"];
player addaction ["Unlock Door","client\actions\DoorLocking.sqf", ["unlock"], -99, false, true, "", "(cursorObject getVariable [format ['bis_disabled_%1',getCursorObjectParams select 1 select 0], 0]) == 1 && {[['door_'],getCursorObjectParams select 1 select 0] call fn_startsWith} && cursorObject getVariable ['objectLocked', false]"];
player addaction ["Set Door PIN","client\actions\DoorLocking.sqf", ["ChangePin"], -99, false, true, "", "(cursorObject getVariable 'ownerUID') == (getPlayerUID player) && {[['door_'],getCursorObjectParams select 1 select 0] call fn_startsWith}"];


/*if (["A3W_vehicleLocking"] call isConfigOn) then
{
	[player, ["<img image='client\icons\r3f_unlock.paa'/> Pick Lock", "addons\scripts\lockPick.sqf", [cursorTarget], 1, false, false, "", "alive cursorTarget && player distance cursorTarget <= (sizeOf typeOf cursorTarget / 3) max 3 && {{cursorTarget isKindOf _x} count ['LandVehicle','Ship','Air'] > 0 && {locked cursorTarget == 2 && !(cursorTarget getVariable ['A3W_lockpickDisabled',false]) && cursorTarget getVariable ['ownerUID','0'] != getPlayerUID player && 'ToolKit' in items player}}"]] call fn_addManagedAction;

};*/

// Karts DLC
if !(288520 in getDLCs 1) then
{
	[player, ["<t color='#00FFFF'>Get in as Driver</t>", "client\actions\moveInDriver.sqf", [], 6, true, true, "", "locked cursorTarget != 2 && cursorTarget isKindOf 'Kart_01_Base_F' && player distance cursorTarget < 3.4 && isNull driver cursorTarget"]] call fn_addManagedAction;
};

// Helicopters DLC
if !(304380 in getDLCs 1) then 
{
	[player, ["<t color='#00FFFF'>Get in as Pilot</t>", "client\actions\moveInDriver.sqf", [], 6, true, true, "", "locked cursorTarget != 2 && {cursorTarget isKindOf _x} count ['Heli_Transport_03_base_F','Heli_Transport_04_base_F'] > 0 && player distance cursorTarget < 10 && isNull driver cursorTarget"]] call fn_addManagedAction;
	[player, ["<t color='#00FFFF'>Get in as Copilot</t>", "client\actions\moveInTurret.sqf", [0], 6, true, true, "", "locked cursorTarget != 2 && {cursorTarget isKindOf _x} count ['Heli_Transport_03_base_F','Heli_Transport_04_base_F'] > 0 && player distance cursorTarget < 10 && isNull (cursorTarget turretUnit [0])"]] call fn_addManagedAction;
	[player, ["<t color='#00FFFF'>Get in as Left door gunner</t>", "client\actions\moveInTurret.sqf", [1], 6, true, true, "", "locked cursorTarget != 2 && cursorTarget isKindOf 'Heli_Transport_03_base_F' && player distance cursorTarget < 10 && isNull (cursorTarget turretUnit [1])"]] call fn_addManagedAction;
	[player, ["<t color='#00FFFF'>Get in as Right door gunner</t>", "client\actions\moveInTurret.sqf", [2], 6, true, true, "", "locked cursorTarget != 2 && cursorTarget isKindOf 'Heli_Transport_03_base_F' && player distance cursorTarget < 10 && isNull (cursorTarget turretUnit [2])"]] call fn_addManagedAction;
};

// Apex DLC
if !(395180 in getDLCs 1) then 
{
	[player, ["<t color='#00FFFF'>Get in as Driver</t>", "client\actions\moveInDriver.sqf", [], 6, true, true, "", "locked cursorTarget != 2 && {cursorTarget isKindOf _x} count ['Offroad_02_base_F','LSV_01_base_F','LSV_02_base_F','Scooter_Transport_01_base_F','Boat_Transport_02_base_F'] > 0 && player distance cursorTarget < 6 && isNull driver cursorTarget"]] call fn_addManagedAction;
	[player, ["<t color='#00FFFF'>Get in as Commander</t>", "client\actions\moveInCommanderTurret.sqf", [0], 6, true, true, "", "locked cursorTarget != 2 && {cursorTarget isKindOf _x} count ['B_T_LSV_01_armed_F','B_T_LSV_01_AT_F'] > 0 && player distance cursorTarget < 6 && isNull (cursorTarget turretUnit [1])"]] call fn_addManagedAction;
	[player, ["<t color='#00FFFF'>Get in as Gunner</t>", "client\actions\moveInGunner.sqf", [1], 6, true, true, "", "locked cursorTarget != 2 && {cursorTarget isKindOf _x} count ['I_C_Offroad_02_LMG_F','I_C_Offroad_02_AT_F','B_T_LSV_01_armed_F','B_T_LSV_01_AT_F','O_T_LSV_02_armed_F','O_T_LSV_02_armed_F'] > 0 && player distance cursorTarget < 6 && isNull gunner cursorTarget"]] call fn_addManagedAction;

	[player, ["<t color='#00FFFF'>Get in as Pilot</t>", "client\actions\moveInDriver.sqf", [], 6, true, true, "", "locked cursorTarget != 2 && {cursorTarget isKindOf _x} count ['Plane_Civil_01_base_F','VTOL_01_base_F','VTOL_02_base_F'] > 0 && player distance cursorTarget < 10 && isNull driver cursorTarget"]] call fn_addManagedAction;
	[player, ["<t color='#00FFFF'>Get in as Copilot</t>", "client\actions\moveInTurret.sqf", [0], 6, true, true, "", "locked cursorTarget != 2 && {cursorTarget isKindOf _x} count ['Plane_Civil_01_base_F','VTOL_01_base_F'] > 0 && player distance cursorTarget < 10 && isNull (cursorTarget turretUnit [0])"]] call fn_addManagedAction;
	[player, ["<t color='#00FFFF'>Get in as Gunner</t>", "client\actions\moveInGunner.sqf", [0], 6, true, true, "", "locked cursorTarget != 2 && cursorTarget isKindOf 'VTOL_02_base_F' && player distance cursorTarget < 10 && isNull gunner cursorTarget"]] call fn_addManagedAction;
	[player, ["<t color='#00FFFF'>Get in as Passenger (Left Seat)</t>", "client\actions\moveInTurret.sqf", [1], 6, true, true, "", "locked cursorTarget != 2 && cursorTarget isKindOf 'B_T_VTOL_01_infantry_F' && player distance cursorTarget < 10 && isNull (cursorTarget turretUnit [1])"]] call fn_addManagedAction;
	[player, ["<t color='#00FFFF'>Get in as Passenger (Right Seat)</t>", "client\actions\moveInTurret.sqf", [2], 6, true, true, "", "locked cursorTarget != 2 && cursorTarget isKindOf 'B_T_VTOL_01_infantry_F' && player distance cursorTarget < 10 && isNull (cursorTarget turretUnit [2])"]] call fn_addManagedAction;
	[player, ["<t color='#00FFFF'>Get in as Left door gunner</t>", "client\actions\moveInTurret.sqf", [1], 6, true, true, "", "locked cursorTarget != 2 && cursorTarget isKindOf 'B_T_VTOL_01_armed_F' && player distance cursorTarget < 10 && isNull (cursorTarget turretUnit [1])"]] call fn_addManagedAction;
	[player, ["<t color='#00FFFF'>Get in as Right door gunner</t>", "client\actions\moveInTurret.sqf", [2], 6, true, true, "", "locked cursorTarget != 2 && cursorTarget isKindOf 'B_T_VTOL_01_armed_F' && player distance cursorTarget < 10 && isNull (cursorTarget turretUnit [2])"]] call fn_addManagedAction;
};

// Lords of War DLC
if !(571710 in getDLCs 1) then 
{
	[player, ["<t color='#00FFFF'>Get in as Driver</t>", "client\actions\moveInDriver.sqf", [], 6, true, true, "", "locked cursorTarget != 2 && cursorTarget isKindOf 'Van_02_base_F' && player distance cursorTarget < 6 && isNull driver cursorTarget"]] call fn_addManagedAction;
};

// Jets DLC
if !(601670 in getDLCs 1) then 
{
	[player, ["<t color='#00FFFF'>Get in as Pilot</t>", "client\actions\moveInDriver.sqf", [], 6, true, true, "", "locked cursorTarget != 2 && {cursorTarget isKindOf _x} count ['Plane_Fighter_04_Base_F','Plane_Fighter_01_Base_F','Plane_Fighter_02_Base_F'] > 0 && player distance cursorTarget < 8 && isNull driver cursorTarget"]] call fn_addManagedAction;
};

// Tanks DLC
if !(798390 in getDLCs 1) then 
{
	[player, ["<t color='#00FFFF'>Get in as Driver</t>", "client\actions\moveInDriver.sqf", [], 6, true, true, "", "locked cursorTarget != 2 && {cursorTarget isKindOf _x} count ['AFV_Wheeled_01_base_F','LT_01_base_F','MBT_04_base_F'] > 0 && player distance cursorTarget < 7 && isNull driver cursorTarget"]] call fn_addManagedAction;
	[player, ["<t color='#00FFFF'>Get in as Commander</t>", "client\actions\moveInCommander.sqf", [0], 6, true, true, "", "locked cursorTarget != 2 && {cursorTarget isKindOf _x} count ['AFV_Wheeled_01_base_F','LT_01_base_F','MBT_04_base_F'] > 0 && player distance cursorTarget < 7 && isNull commander cursorTarget"]] call fn_addManagedAction;
	[player, ["<t color='#00FFFF'>Get in as Gunner</t>", "client\actions\moveInGunner.sqf", [1], 6, true, true, "", "locked cursorTarget != 2 && {cursorTarget isKindOf _x} count ['AFV_Wheeled_01_base_F','MBT_04_base_F'] > 0 && player distance cursorTarget < 7 && isNull gunner cursorTarget"]] call fn_addManagedAction;
};

if (["A3W_savingMethod", "profile"] call getPublicVar == "extDB") then
{
	if (["A3W_vehicleSaving"] call isConfigOn) then
	{
		[player, ["<img image='client\icons\save.paa'/> Force Save Vehicle", { cursorTarget call fn_forceSaveVehicle }, [], -9.5, false, true, "", "call canForceSaveVehicle"]] call fn_addManagedAction;
	};

	if (["A3W_staticWeaponSaving"] call isConfigOn) then
	{
		[player, ["<img image='client\icons\save.paa'/> Force Save Turret", { cursorTarget call fn_forceSaveObject }, [], -9.5, false, true, "", "call canForceSaveStaticWeapon"]] call fn_addManagedAction;
	};
};

player addAction ["Carpet Bomb",
{
if (currentWeapon player == "Laserdesignator_02" && isLaserOn player) then
	{
		if (isNull cursorObject) then
		{
			_pos = screenToWorld [0.5,0.5];
			_bomb = ["", _pos,270,15,200] remoteExec ["GOM_fnc_carpetbombing",2,false];
		} else {
			_pos = getPos cursorObject;
			_bomb = ["", _pos,270,15,200] remoteExec ["GOM_fnc_carpetbombing",2,false];
		};
  	player removeWeapon "Laserdesignator_02";
	}
	else
	{
		systemChat "You're not designating anything!";
	};
}, [], 1, false, true, "", " ""Laserdesignator_02"" in (Assigneditems _this)"];
