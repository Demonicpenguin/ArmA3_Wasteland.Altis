/********************************************************************************************/
/* This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com   */
/********************************************************************************************/
/*																							*/
/* @file Name: Soul_AutoLoad.sqf															*/
/* Autoloads purchased store items into HEMTT Box Truck (B_Truck_01_box_F)					*/
/* addAction applied to HEMTT box Truck at time of purchase in spawnStoreObject.sqf			*/
/* @file Created: 17/04/2020 by [RAW Gaming] SoulStalker									*/
/*																							*/
/********************************************************************************************/

private ["_player", "_vehicle"];

_player = _this select 0;
_vehicle = cursorTarget;

private _radius = 70;

_baseObjects =
[
	"Land_SatellitePhone_F",
	"ContainmentArea_01_forest_F",
	"ContainmentArea_01_sand_F",
 	"Land_Canal_Wall_10m_F",
  	"Land_MapBoard_01_Wall_Altis_F",
	"Land_CargoBox_V1_F",
	"Land_ToolTrolley_02_F",
	"Land_PhoneBooth_01_malden_F",
	"Box_NATO_AmmoVeh_F",
	"Land_NetFence_01_m_pole_F",
	"Land_Pier_Box_F",
	"Land_PortableGenerator_01_F",
	"Land_Loudspeakers_F",
	"Land_Pier_F",
	"Land_SCF_01_shed_F",
	"Land_Cargo20_yellow_F",
	"Land_Cargo40_white_F",
	"Land_Cargo20_sand_F",
	"Land_RepairDepot_01_green_F",
	"Land_FireEscape_01_short_F",
	"Land_FireEscape_01_tall_F",
	"Land_Canal_Dutch_01_bridge_F",
	"Land_LampAirport_F",
	"Land_LampHalogen_F",
	"Land_LampHarbour_F",
	"Land_PortableLight_double_F",
	"Land_PortableLight_single_F",
	"Land_PortableLight_02_double_olive_F",
	"Land_PortableLight_02_quad_olive_F",
	"Land_BarGate_F",
	"Land_SandbagBarricade_01_half_F",
	"Land_SandbagBarricade_01_F",
	"Land_SandbagBarricade_01_hole_F",
	"Land_BagBunker_Large_F",
	"Land_BagBunker_Small_F",
	"Land_BagBunker_Large_F",
	"Land_BagBunker_Tower_F",
	"Land_BagBunker_Tower_F",
	"Land_VergePost_01_F",
	"Land_CncBarrierMedium4_F",
	"Land_CncBarrierMedium_F",
	"Land_Bollard_01_F",
	"Land_Mil_ConcreteWall_F",
	"Land_CncBarrier_F",
	"RoadBarrier_F",
	"Land_Bunker_01_blocks_1_F",
	"Land_Bunker_01_blocks_3_F",
	"Land_Bunker_01_big_F",
	"Land_Bunker_01_small_F",
	"Land_Bunker_01_tall_F",
	"Land_Bunker_01_HQ_F",
	"B_Slingload_01_Cargo_F",
	"B_Slingload_01_Fuel_F",
	"B_Slingload_01_Medevac_F",
	"B_Slingload_01_Repair_F",
	"Land_Canal_Wall_10m_F",
	"Land_Canal_WallSmall_10m_F",
	"Land_Canal_Wall_Stairs_F",	
	"Land_Canal_Dutch_01_plate_F",
	"Land_CobblestoneSquare_01_32m_F",	
	"Land_CobblestoneSquare_01_8m_F",
	"Land_CobblestoneSquare_01_4m_F",
	"Land_CobblestoneSquare_01_2m_F",
	"Land_CncBarrier_F",
	"Land_CncBarrierMedium_F",
	"Land_CncBarrierMedium4_F",
 	"BlockConcrete_F",
	"Land_Wall_IndCnc_2deco_F",
	"Land_CncShelter_F",
	"Land_Wall_IndCnc_Pole_F",
	"Land_Wall_IndCnc_4_F",
	"Land_ConcreteWall_01_m_4m_F",
	"Land_ConcreteWall_01_m_8m_F",
	"Land_ConcreteWall_01_m_gate_F",
	"Land_ConcreteWall_01_m_pole_F",
	"Land_RampConcrete_F",
	"Land_RampConcreteHigh_F",
	"Land_CncWall1_F",
	"Land_CncWall4_F",
	"Land_Concrete_SmallWall_4m_F",
	"Land_Concrete_SmallWall_8m_F",
	"Land_ConcreteWall_01_l_4m_F",
	"Land_ConcreteWall_01_l_8m_F",
	"Land_ConcreteWall_01_l_gate_F",
	"Land_ConcreteWall_01_l_pole_F",
	"Land_SY_01_block_F",
	"Land_CzechHedgehog_01_F",
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
	"Flag_RedCrystal_F",
	"Flag_NATO_F",
	"Flag_POWMIA_F",
	"Flag_Red_F",
	"Flag_Syndikat_F",
	"Flag_UK_F",
	"Flag_UNO_F",
	"Flag_US_F",
	"Flag_Viper_F",
	"Flag_White_F",
	"Land_Fortress_01_5m_F",           
	"Land_Fortress_01_10m_F",
	"Land_Fortress_01_outterCorner_50_F",
 	"Land_Fortress_01_outterCorner_80_F",
	"Land_Fortress_01_outterCorner_90_F",
	"Land_GH_Platform_F",
	"Land_GH_Stairs_F",
	"Land_HBarrier_1_F",
	"Land_HBarrier_3_F",
	"Land_HBarrier_5_F",
	"Land_HBarrierWall_corridor_F",
	"Land_HBarrierWall4_F",
	"Land_HBarrierWall6_F",
	"Land_HBarrierWall_corner_F",
	"Land_HBarrierBig_F",				
	"Land_HBarrier_01_big_4_green_F",			
	"Land_HBarrierWall_corner_F",
	"Land_HBarrierWall_corridor_F",
	"Land_HBarrierTower_F",
	"Land_HBarrierTower_F",
	"Land_Cargo_Tower_V1_No1_F",
	"Land_Cargo_Tower_V1_No2_F",
	"Land_Cargo_Tower_V1_No3_F",
	"Land_Cargo_Tower_V1_No4_F",
	"Land_Cargo_Tower_V1_No5_F",
	"Land_Cargo_Tower_V1_No6_F",
	"Land_Cargo_Tower_V1_No7_F",
	"Land_Bunker_01_blocks_1_F",
 	"Land_Bunker_01_blocks_3_F",
	"Land_Bunker_01_small_F",
	"Land_Bunker_01_HQ_F",
	"Land_Cargo20_military_green_F",
	"Land_MetalBarrel_F",
	"Land_Scaffolding_F",
	"Land_Pod_Heli_Transport_04_box_F",
	"Land_Pod_Heli_Transport_04_ammo_F",
	"Land_Pod_Heli_Transport_04_fuel_F",
	"Land_Pod_Heli_Transport_04_repair_F",
	"Land_ConcreteWall_01_l_4m_F",
	"Land_ConcreteWall_01_l_gate_F",
	"CargoNet_01_box_F",
	"B_CargoNet_01_ammo_F"
];

_build = [];

if (vehicle _player != _player) exitWith { 	["You can not autoload from inside a vehicle.............", 5] call mf_notify_client; };

for [{_i = 0},{_i < (count _baseObjects)},{_i =_i + 1}] do
{
   _build = getPos _vehicle nearObjects [_baseObjects select _i, _radius];
   for [{_n = 0},{_n < (count _build)},{_n =_n + 1}] do
	{

		if (_vehicle distance2D GenStore1 < _radius || _vehicle distance2D GenStore2 < _radius || _vehicle distance2D GenStore3 < _radius || _vehicle distance2D GenStore4 < _radius || _vehicle distance2D GenStore5 < _radius || _vehicle distance2D GenStore5_1 < _radius || _vehicle distance2D GenStore5_2 < _radius) then {
			//[_vehicle, [[_build select _n,1]] ] execVM "addons\R3F_LOG\auto_load_in_vehicle.sqf";
			nul = [[_vehicle, [[_build select _n,1]]], "addons\R3F_LOG\auto_load_in_vehicle.sqf"] remoteExec ["execVM", 0, true];
			//nul = [[_vehicle, [[_build select _n,1]]], "addons\R3F_LOG\transporteur\charger_auto.sqf"] remoteExec ["execVM", 0, true];			
		};
	};
};

if (_vehicle distance2D GenStore1 < _radius || _vehicle distance2D GenStore2 < _radius || _vehicle distance2D GenStore3 < _radius || _vehicle distance2D GenStore4 < _radius || _vehicle distance2D GenStore5 < _radius || _vehicle distance2D GenStore5_1 < _radius || _vehicle distance2D GenStore5_2 < _radius) then
{
	if !(isnil "_build") then {
		["Loading Complete................", 5] call mf_notify_client;	
		//_player groupChat "Loading Complete................";
	} else
	{
		["No items found to load.............", 5] call mf_notify_client;	
		//_player groupChat "No items found to load.............";	
	};
} else
{
	["Autoload not permitted or you are to far from a General Store!", 5] call mf_notify_client;
	//_player groupChat "Autoload not permitted or you are to far from a General Store!";
};

for "_i" from 0 to (count _build - 1) do {
	_build set [_i, "null"];
	_build = _build - ["null"];
};
	