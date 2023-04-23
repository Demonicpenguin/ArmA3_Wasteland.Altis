/*
Filename: LockDoors.sqf
Author: GMG_Monkey
Purpose: Lock exterior doors of base objects within radius of base manager
*/

private _nearestManagers = nearestObjects [player, ["Land_SatellitePhone_F"], 100];
private _manager = _nearestManagers select 0;

private _ManagerPosition = getpos _manager;
private _lockdown = false;
//Get manager level
private _ManagerLevel = _manager getVariable ["ManagerLevel", 1];
//set default base radius for level 1 manager
private _BaseRadius = 25;
//set base radius based on manager level
switch (_ManagerLevel) do
{
	case (2):
	{
		_BaseRadius = 30;
	};
	case (3):
	{
		_BaseRadius = 45;
	};
	case (4):
	{
		_BaseRadius = 70;
	};
	case (5):
	{
		_BaseRadius = 100;
	};
};



private _managers = nearestObjects [ _manager, ["Land_SatellitePhone_F"], (_BaseRadius * 2), true];
if ( count _managers > 1) then 
{
	private _getmanagerstatus = [{_x getVariable ["Baselockenabled", false]} foreach _managers];
	private _checker = [true];
	private _findlockedmanager = _checker arrayIntersect _getmanagerstatus;
	if (count _findlockedmanager > 0) then 
	{
		_lockdown = true;
	};
} else 
{
	_lockdown = false;
};

if (_lockdown) then 
{
	hint "Base Underlockdown. Action Aborted";
} else
{
	//Objects with Two Doors
		{
			if (!local _x) then
			{
				_setOwner_time = time;
				[_x, "setOwnerTo", player] call R3F_LOG_FNCT_exec_commande_MP; // Requires R3F 3.1
				waitUntil {local _x || time > _setOwner_time + 1.5};
			};
			_x setVariable ['bis_disabled_Door_1',1,true];
			_x setVariable ['bis_disabled_Door_2',1,true];
		} forEach nearestObjects [_ManagerPosition,
			[
				"Land_i_House_Small_03_V1_F",
				"Land_i_House_Big_01_V3_F",
				"Land_i_House_Big_01_V2_F",
				"Land_i_House_Big_01_V1_F",
				"Land_Dome_Small_F",
				"Land_Cargo_HQ_V3_F",
				"Land_Cargo_HQ_V1_F",
				"Land_Medevac_HQ_V1_F",
				"Land_Cargo_HQ_V2_F",
				"Land_Research_HQ_F",
				"Land_FuelStation_Build_F",
				"Land_GH_House_2_F",
				"Land_i_House_Small_02_V3_F",
				"Land_i_House_Small_02_V1_F",
				"Land_i_House_Small_02_V2_F",
				"Land_i_House_Small_01_V3_F",
				"Land_i_House_Small_01_V1_F",
				"Land_i_House_Small_01_V2_F",
				"Land_i_Stone_HouseSmall_V3_F",
				"Land_i_Stone_HouseSmall_V1_F",
				"Land_i_Stone_HouseSmall_V2_F",
				"Wall"
			], _BaseRadius];

		//Objects with Three Doors
		{
			if (!local _x) then
			{
				private ["_setOwner_time"];
				_setOwner_time = time;
				[_x, "setOwnerTo", player] call R3F_LOG_FNCT_exec_commande_MP; // Requires R3F 3.1
				waitUntil {local _x || time > _setOwner_time + 1.5};
			};
			_x setVariable ['bis_disabled_Door_1',1,true];
			_x setVariable ['bis_disabled_Door_2',1,true];
			_x setVariable ['bis_disabled_Door_3',1,true];
		} forEach nearestObjects [_ManagerPosition,
			[
				"Land_Offices_01_V1_F",
				"Land_i_Shop_02_V3_F",
				"Land_i_Shop_02_V2_F",
				"Land_Dome_Big_F",
				"Land_Cargo_Tower_V1_No1_F",
				"Land_Cargo_Tower_V1_No2_F",
				"Land_Cargo_Tower_V1_No3_F",
				"Land_Cargo_Tower_V1_No4_F",
				"Land_Cargo_Tower_V1_No5_F",
				"Land_Cargo_Tower_V1_No6_F",
				"Land_Cargo_Tower_V1_No7_F",
				"Land_Cargo_Tower_V1_F",
				"Land_Cargo_Tower_V3_F",
				"Land_Cargo_Tower_V2_F",
				"Land_MilOffices_V1_F",
				"Land_CarService_F"
			], _BaseRadius];

	//Objects with 4 doors
		{
			if (!local _x) then
			{
				_setOwner_time = time;
				[_x, "setOwnerTo", player] call R3F_LOG_FNCT_exec_commande_MP; // Requires R3F 3.1
				waitUntil {local _x || time > _setOwner_time + 1.5};
			};
			_x setVariable ['bis_disabled_Door_1',1,true];
			_x setVariable ['bis_disabled_Door_2',1,true];
			_x setVariable ['bis_disabled_Door_3',1,true];
			_x setVariable ['bis_disabled_Door_4',1,true];
		} forEach nearestObjects [_ManagerPosition,
			[
				"Land_i_House_Big_02_V3_F",
				"Land_i_House_Big_02_V1_F",
				"Land_i_House_Big_02_V2_F",
				"Land_i_Shop_01_V3_F",
				"Land_i_Shop_01_V1_F",
				"Land_i_Shop_01_V2_F"
				
			], _BaseRadius];

	//Objects with only one Door
		{
			if (!local _x) then
			{
				_setOwner_time = time;
				[_x, "setOwnerTo", player] call R3F_LOG_FNCT_exec_commande_MP; // Requires R3F 3.1
				waitUntil {local _x || time > _setOwner_time + 1.5};
			};
			_x setVariable ['bis_disabled_Door_1',1,true];
		} forEach nearestObjects [_ManagerPosition,
			[
				"Land_Cargo_House_V3_F",
				"Land_Cargo_House_V1_F",
				"Land_Medevac_house_V1_F",
				"Land_Cargo_House_V2_F",
				"Land_Research_house_V1_F",
				"Land_Kiosk_blueking_F",
				"Land_Kiosk_gyros_F",
				"Land_Kiosk_papers_F",
				"Land_Kiosk_redburger_F",
				"Land_spp_Tower_F",
				"Land_i_Garage_V1_F",
				"Land_i_Garage_V2_F",
				"Land_i_Addon_02_V1_F",
				"Land_Slum_House02_F",
				"Land_Slum_House03_F",
				"Land_Slum_House01_F",
				"Land_i_Stone_Shed_V2_F",
				"Land_i_Stone_Shed_V1_F",
				"Land_i_Stone_Shed_V3_F",
				"Wall"
		], _BaseRadius];

	//Industrial Sheds; because BIS is bad and lazy and it's the only building that doesn't conform to convention
		{
			if (!local _x) then
			{
				_setOwner_time = time;
				[_x, "setOwnerTo", player] call R3F_LOG_FNCT_exec_commande_MP; // Requires R3F 3.1
				waitUntil {local _x || time > _setOwner_time + 1.5};
			};
			_x setVariable ['bis_disabled_Door_1',1,true];
			_x setVariable ['bis_disabled_Door_2',1,true];
			_x setVariable ['bis_disabled_Door_3',1,true];
			_x setVariable ['bis_disabled_Door_4',1,true];
			_x setVariable ['bis_disabled_Door_5',1,true];
			_x setVariable ['bis_disabled_Door_6',1,true];
			_x setVariable ['bis_disabled_Door_7',1,true];
			_x setVariable ['bis_disabled_Door_8',1,true];
		} forEach nearestObjects [_ManagerPosition,
			["Land_i_Shed_Ind_F"], _BaseRadius];

	//Objects with 8 Doors
		{
			if (!local _x) then
			{
				_setOwner_time = time;
				[_x, "setOwnerTo", player] call R3F_LOG_FNCT_exec_commande_MP; // Requires R3F 3.1
				waitUntil {local _x || time > _setOwner_time + 1.5};
			};
			_x setVariable ['bis_disabled_Door_1',1,true];
			_x setVariable ['bis_disabled_Door_2',1,true];
			_x setVariable ['bis_disabled_Door_3',1,true];
			_x setVariable ['bis_disabled_Door_4',1,true];
			_x setVariable ['bis_disabled_Door_5',1,true];
			_x setVariable ['bis_disabled_Door_6',1,true];
			_x setVariable ['bis_disabled_Door_7',1,true];
			_x setVariable ['bis_disabled_Door_8',1,true];

		} forEach nearestObjects [_ManagerPosition,
			[
				"Land_i_Barracks_V1_F",
				"Land_i_Barracks_V2_F",
				"Land_u_Barracks_V2_F"
			], _BaseRadius];
	hint "Doors Locked";
};