// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: fn_restoreSavedVehicle.sqf
//	@file Author: AgentRev

#define STR_TO_SIDE(VAL) ([sideUnknown,BLUFOR,OPFOR,INDEPENDENT,CIVILIAN,sideLogic] select ((["WEST","EAST","GUER","CIV","LOGIC"] find toUpper (VAL)) + 1))

_pos = _pos apply { if (_x isEqualType "") then { parseNumber _x } else { _x } };

private _isUAV = (round getNumber (configFile >> "CfgVehicles" >> _class >> "isUav") > 0);

private ([["_flying"],[]] select isNil "_flying");
_flying = (!isNil "_flying" && {_flying > 0});

private _special = ["NONE","FLY"] select (_isUAV && _flying);
private _tempPos = +_pos;

if (isNil "_safeDistance" && _special in ["","NONE"]) then
{
	_tempPos set [2, 9000000 + random 999999];
};

_veh = createVehicle [_class, _tempPos, [], if (isNil "_safeDistance") then { 0 } else { _safeDistance }, _special];
_veh allowDamage false;
_veh hideObjectGlobal true;

//Make sure Blackwasp wings are folded
if (_veh iskindof "Plane_Fighter_01_Base_F") then 
{ 
	_veh animate ['wing_fold_l',1];	
	_veh animate ['wing_fold_r',1];	
	_veh animate ['wing_fold_cover_l',1];	
	_veh animate ['wing_fold_cover_r',1]; 
}; 
//Make sure Sentinal wings are folded
if (_veh iskindof "B_UAV_05_F") then
{
	_veh animate ["wing_fold_l_arm",1];
	_veh animate ["wing_fold_l",1];
	_veh animate ["wing_fold_cover_l_arm",1];
	_veh animate ["wing_fold_cover_l",1];
	_veh animate ["wing_fold_r_arm",1];
	_veh animate ["wing_fold_r",1];
	_veh animate ["wing_fold_cover_r_arm",1];
	_veh animate ["wing_fold_cover_r",1];
};

//Reload Service system
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
	] >0)
then
{
	_veh spawn GOM_fnc_addAircraftLoadoutToObject;
};
private _velMag = vectorMagnitude velocity _veh;

if (isNil "_safeDistance") then
{
	if (!isNil "_dir") then
	{
		_veh setVelocity [0,0,0];
		_veh setVectorDirAndUp _dir;
	};

	_veh setPosWorld ATLtoASL _pos;
};

if (!isNil "_dirAngle") then
{
	_veh setDir _dirAngle;
};

if (!isNil "_dir") then
{
	_veh setVectorDirAndUp _dir;
};

private _uavSide = if (isNil "_playerSide") then { sideUnknown } else { _playerSide };
private _uavAuto = true;

{
	_x params ["_var", "_val"];

	switch (_var) do
	{
		case "ownerName":
		{
			if (_val isEqualType []) then { _val = toString _val };
		};
		case "uavSide":
		{
			if (_uavSide isEqualTo sideUnknown) then { _uavSide = STR_TO_SIDE(_val) };
		};
		case "uavAuto":
		{
			if (_val isEqualType true) then
			{
				_uavAuto = _val;
			};
		};
	};

	_veh setVariable [_var, _val, true];
} forEach _variables;

// UAV AI
if (_isUAV) then
{
	createVehicleCrew _veh;

	if (_flying) then
	{
		if (isNil "_vel" || {count _vel < 3}) then
		{
			_vel = (vectorDir _veh) vectorMultiply _velMag;
		};

		_veh setVelocity _vel;
		_veh flyInHeight (((_veh call fn_getPos3D) select 2) max 500);
	};

	//assign AI to the vehicle so it can actually be used
	[_veh, _flying, _uavSide, _uavAuto] spawn
	{
		params ["_uav", "_flying", "_uavSide", "_uavAuto"];

		_grp = [_uav, _uavSide, true, _uavAuto] call fn_createCrewUAV;

		if (_flying) then
		{
			_wp = (group _uav) addWaypoint [getPosATL _uav, 0];
			_wp setWaypointType "MOVE";
		};
	};
};

[_veh, false] call vehicleSetup;

if (!isNil "_vehicleID") then
{
	_veh setVariable ["A3W_vehicleID", _vehicleID, true];
	_veh setVariable ["A3W_vehicleSaved", true, true];
	A3W_vehicleIDs pushBack _vehicleID;
};

_veh setVariable ["vehSaving_hoursUnused", _hoursUnused];
_veh setVariable ["vehSaving_lastUse", diag_tickTime];
_veh setVariable ["vehSaving_hoursAlive", _hoursAlive];
_veh setVariable ["vehSaving_spawningTime", diag_tickTime];

_veh allowDamage true;
_veh setDamage _damage;
{ _veh setHitPointDamage _x } forEach _hitPoints;

_veh setFuel _fuel;

if (!isNil "_textures") then
{
	_veh setVariable ["BIS_enableRandomization", false, true];

	if (_textures isEqualType "") then { _textures = [_textures] }; // assume TextureSource
	if (_textures isEqualTypeArray [""]) then // TextureSource

	{
		[_veh, _textures] call applyVehicleTexture;
	}
	else // texture paths
	{
		private _objTextures = [];


		{
			_texture = _x select 0;

			// fix for double backslashes in parking data
			if (_texture find "\\" != -1) then
			{
				_texture = (["","\"] select (_texture select [0,1] == "\")) + (_texture splitString "\" joinString "\");
			};

			{
				_veh setObjectTextureGlobal [_x, _texture];
				_objTextures set [_x, _texture];				
				//[_objTextures, _x, _texture] call fn_setToPairs;
			} forEach (_x select 1);
		} forEach _textures;

		_veh setVariable ["A3W_objectTextures", _objTextures, true];
	};
};

if (!isNil "_animPhases") then
{
	private _animList = [];
	{ _animList append [_x select 0, [0,1] select (_x select 1 >= 1)] } forEach _animPhases;
	[_veh, false, _animList, true] call BIS_fnc_initVehicle;
};

if (!isNil "_owner") then
{
	_veh setVariable ["ownerUID", _owner, true];

	if (!isNil "_lockState" && ["A3W_vehicleLocking"] call isConfigOn) then
	{
		[_veh, _lockState] call A3W_fnc_setLockState;
	};
};

//AJ - Possible Fix for AJWL-122 - if no missonvehicle or purchased vehicle variable is set on the restored vehicle - set it now.
if  !(_veh getVariable ["A3W_purchasedVehicle", false] || _veh getVariable ["A3W_missionVehicle", false]) then
{
	_veh setVariable ["A3W_purchasedVehicle", true, true];
};
clearWeaponCargoGlobal _veh;
clearMagazineCargoGlobal _veh;
clearItemCargoGlobal _veh;
clearBackpackCargoGlobal _veh;

if (!isNil "_weapons") then
{
	{ _veh addWeaponCargoGlobal _x } forEach _weapons;
};
if (!isNil "_magazines") then
{
	[_veh, _magazines] call processMagazineCargo;
};
if (!isNil "_items") then
{
	{ _veh addItemCargoGlobal _x } forEach _items;
};
if (!isNil "_backpacks") then
{
	{
		_x params ["_bpack"];

		if (!(_bpack isKindOf "Weapon_Bag_Base") || {[["_UAV_","_Designator_"], _bpack] call fn_findString != -1}) then
		{
			_veh addBackpackCargoGlobal _x;
		};
	} forEach _backpacks;
};

if (!isNil "_turretMags" && {_turretMags isEqualTo []}) then
{
	// for vehicles saved from A3 v1.56 and onwards, remove all default mags because empty ones are saved
	{ _veh removeMagazineTurret (_x select [0,2]) } forEach magazinesAllTurrets _veh;
}
else
{
	// for older vehicle saves, mark all default mags as empty so it can still be resupplied to its default ammo capacity
	_veh setVehicleAmmo 0;
};

// Remove all turret weapons to ensure they are reloaded properly
private _turretWeapons = _veh call fn_removeTurretWeapons;
private _pylons = [];

if (!isNil "_turretMags3") then
{
	private _magsAdded = [];
	private "_magPathStr";

	{
		_x params ["_mag", "_path", "_ammoCoef"];

		if (_mag == "" || isText (configFile >> "CfgMagazines" >> _mag >> "pylonWeapon")) then // pylon stuff
		{
			_pylons pushBack _x;
		}
		else // legacy stuff
		{
			_magPathStr = toLower (_mag + str _path);

			if (_magPathStr in _magsAdded) then
			{
				_veh addMagazineTurret [_mag, _path];
			}
			else
			{
				_magsAdded pushBack _magPathStr;
			};

			_veh setMagazineTurretAmmo [_mag, _ammoCoef * getNumber (configFile >> "CfgMagazines" >> _mag >> "count"), _path];
		};
	} forEach _turretMags3;
};
if (!isNil "_turretMags") then
{
	{ _veh addMagazine _x } forEach _turretMags;
};
if (!isNil "_turretMags2") then
{
	{ _veh addMagazineTurret _x } forEach _turretMags2;
};

// Re-add all turret weapons to ensure they are reloaded properly
{ _veh addWeaponTurret _x } forEach _turretWeapons;

// Restore pylons
{
	_x params ["_mag", "_path", "_ammo"];
	_veh setPylonLoadOut [_forEachIndex + 1, _mag, true, _path];
	_veh setAmmoOnPylon [_forEachIndex + 1, _ammo];
} forEach _pylons;

if (!isNil "_ammoCargo") then { _veh setAmmoCargo _ammoCargo };
if (!isNil "_fuelCargo") then { _veh setFuelCargo _fuelCargo };
if (!isNil "_repairCargo") then { _veh setRepairCargo _repairCargo };
//Restore Vehicle Camo nets
if (_veh getvariable ["CamoDeployed", false]) then
{
	if ({_veh isKindOf _x} count 
	[
		"B_APC_Tracked_01_CRV_F",
		"B_APC_Tracked_01_rcws_F",
		"O_APC_Tracked_02_cannon_F",
		"O_APC_Wheeled_02_rcws_v2_F",
		"I_APC_Wheeled_03_cannon_F",
		"I_LT_01_AA_F",
		"I_LT_01_AT_F",
		"I_LT_01_scout_F",
		"I_LT_01_cannon_F"
	]>0) then 
	{
		_veh animate ["showCamonetHull",1];
	};
	if ({_veh isKindOf _x} count 
	[
		"B_APC_Tracked_01_AA_F",
		"B_APC_Wheeled_01_cannon_F",
		"B_AFV_Wheeled_01_cannon_F",
		"B_AFV_Wheeled_01_up_cannon_F",
		"B_MBT_01_arty_F",
		"B_MBT_01_mlrs_F",
		"B_MBT_01_cannon_F",
		"B_MBT_01_TUSK_F",
		"O_APC_Tracked_02_AA_F",
		"O_MBT_02_arty_F",
		"O_MBT_02_cannon_F",
		"O_MBT_04_cannon_F",
		"O_MBT_04_command_F",
		"I_APC_tracked_03_cannon_F",
		"I_MBT_03_cannon_F"
	]>0) then
	{
		_veh animate ["showCamonetHull",1];
		_veh animate ["showCamonetTurret",1];
	};
};


reload _veh;
_veh hideObjectGlobal false;
