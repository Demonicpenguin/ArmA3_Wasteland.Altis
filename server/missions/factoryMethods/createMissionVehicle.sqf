// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: createMissionVehicle.sqf
//	@file Author: [404] Deadbeat, AgentRev, GMG_Monkey
//	@file Created: 26/1/2013 15:19

// if (!isServer && hasinterface) exitWith {};

private ["_class", "_pos", "_fuel", "_ammo", "_damage", "_variant", "_veh"];

private _class = _this select 0;
private _pos = _this select 1;
private _fuel = param [2, 1, [0]];
private _ammo = param [3, 1, [0]];
private _damage = param [4, 0, [0]];
private _SpawnHeight = param [5, 0.5, [0]];
private _water = param [6 ,1, [0]];
private _MaxGradient = param [7, 0,[0]];
private _ShoreMode = param [8, 0, [0]];
private _caller = param [9, "Caller Unkown", [""]];
private _vehPos = [_pos, 0, 50, 5,_water,_MaxGradient,_ShoreMode, _caller] call findSafePos;
_vehPos set [2, _SpawnHeight];

_variant = _class param [1,"",[""]];

if (_class isEqualType []) then
{
	_class = _class select 0;
};

_veh = createVehicle [_class, _vehPos, [], 0, "NONE"];
if (_SpawnHeight >= 500) then
{
	_veh setVelocity [500,0,0];
};
if (_variant != "") then
{
	_veh setVariable ["A3W_vehVariant", _variant, true];
};
[_veh] call vehicleSetup;

_veh setVehicleReportRemoteTargets true;
_veh setVehicleReceiveRemoteTargets true;
_veh setVehicleRadar 1;
_veh confirmSensorTarget [west, true];
_veh confirmSensorTarget [east, true];
_veh confirmSensorTarget [resistance, true];

_veh setVelocity [0,0,0.01];
_veh setdir (random 360);
if (_fuel != 1) then { _veh setFuel _fuel };
if (_ammo != 1) then { _veh setVehicleAmmo _ammo };
_veh setDamage _damage;
if ({_veh iskindof _x} count
[
	"C_Offroad_01_repair_F",
	"C_Van_02_service_F",
	"C_Van_01_fuel_F",
	"B_G_Van_01_fuel_F",
	"B_Truck_01_fuel_F",
	"B_Truck_01_Repair_F",
	"B_Truck_01_ammo_F",
	"O_Truck_03_fuel_F",
	"O_Truck_03_repair_F",
	"O_Truck_03_ammo_F",
	"I_Truck_02_fuel_F",
	"I_Truck_02_ammo_F",
	"I_Truck_02_box_F",
	"B_APC_Tracked_01_CRV_F",
	"O_Heli_Transport_04_ammo_F",
	"O_Heli_Transport_04_repair_F",
	"O_Heli_Transport_04_fuel_F"
] > 0) then
{
	private _AmmoResourcesMax =
	[
		["B_Truck_01_ammo_F",						25000],
		["O_Truck_03_ammo_F", 						15000],
		["I_Truck_02_ammo_F",						10000],
		["B_APC_Tracked_01_CRV_F",					500],
		["O_Heli_Transport_04_ammo_F",				20000]

	];
	private _FuelResourcesMax =
	[
		["C_Van_01_fuel_F",							1000],
		["B_G_Van_01_fuel_F",						1000],
		["B_Truck_01_fuel_F",						25000],
		["O_Truck_03_fuel_F",						20000],
		["I_Truck_02_fuel_F",						15000],
		["B_APC_Tracked_01_CRV_F",					500],
		["O_Heli_Transport_04_fuel_F",				22000]
	];
	private _RepairResourcesMax =
	[
		["C_Offroad_01_repair_F",					500],
		["C_Van_02_service_F",						1000],
		["B_Truck_01_Repair_F",						25000],
		["O_Truck_03_repair_F",						20000],
		["I_Truck_02_box_F",						15000],
		["B_APC_Tracked_01_CRV_F",					500],
		["O_Heli_Transport_04_repair_F",			22000]
	];
	_veh setAmmoCargo 0;
	_veh setFuelCargo 0;
	_veh setRepairCargo 0;
	_veh spawn GOM_fnc_addAircraftLoadoutToObject;
	{
		private _check = _x select 0;
		private _value = _x select 1;
		if (_veh iskindof _check) then
		{
			_veh setVariable ["GOM_fnc_ammoCargo", _value, true];
		};
	} foreach _AmmoResourcesMax;
	{
		private _check = _x select 0;
		private _value = _x select 1;
		if (_veh iskindof _check) then
		{
			_veh setVariable ["GOM_fnc_fuelCargo", _value, true];
		};
	} foreach _FuelResourcesMax;
	{
		private _check = _x select 0;
		private _value = _x select 1;
		if (_veh iskindof _check) then
		{
			_veh setVariable ["GOM_fnc_repairCargo", _value, true];
		};
	} foreach _RepairResourcesMax;
};
_veh
