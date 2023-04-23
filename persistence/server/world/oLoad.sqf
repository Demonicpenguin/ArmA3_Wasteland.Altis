// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: oLoad.sqf
//	@file Author: AgentRev, JoSchaap, Austerror



#include "functions.sqf"
#define STR_TO_SIDE(VAL) ([sideUnknown,BLUFOR,OPFOR,INDEPENDENT,CIVILIAN,sideLogic] select ((["WEST","EAST","GUER","CIV","LOGIC"] find toUpper (VAL)) + 1))

//private ["_strToSide", "_maxLifetime", "_isWarchestEntry", "_isBeaconEntry", "_worldDir", "_methodDir", "_objCount", "_objects", "_exclObjectIDs", "_isCameraEntry"];
private ["_maxLifetime", "_isWarchestEntry", "_isBeaconEntry", "_worldDir", "_methodDir", "_objCount", "_objects", "_exclObjectIDs"];

_maxLifetime = ["A3W_objectLifetime", 0] call getPublicVar;

_isWarchestEntry = { [_variables, "a3w_warchest", false] call fn_getFromPairs };
_isBeaconEntry = { [_variables, "a3w_spawnBeacon", false] call fn_getFromPairs };
_isCameraEntry = { [_variables, "a3w_cctv_camera", false] call fn_getFromPairs };

_worldDir = "persistence\server\world";
_methodDir = format ["%1\%2", _worldDir, call A3W_savingMethodDir];

_objCount = 0;
_objects = call compile preprocessFileLineNumbers format ["%1\getObjects.sqf", _methodDir];

_exclObjectIDs = [];
_objectsArray = [];



{
	private ["_allowed", "_obj", "_objectID", "_class", "_pos", "_dir", "_locked", "_damage", "_allowDamage", "_owner", "_variables", "_weapons", "_magazines", "_items", "_backpacks", "_turretMags", "_ammoCargo", "_fuelCargo", "_repairCargo", "_hoursAlive", "_valid"];

	//{ (_x select 1) call compile format ["%1 = _this", _x select 0] } forEach _x;
	[] params _x; // automagic assignation

	if (isNil "_locked") then { _locked = 1 };
	if (isNil "_hoursAlive") then { _hoursAlive = 0 };
	_valid = false;

	if (!isNil "_class" && !isNil "_pos" && {_maxLifetime <= 0 || _hoursAlive < _maxLifetime}) then
	{
		if (isNil "_variables") then { _variables = [] };

		_allowed = switch (true) do
		{
			case (call _isWarchestEntry):       { _warchestSavingOn };
			case (call _isBeaconEntry):         { _beaconSavingOn };
			case (call _isCameraEntry):         { _cameraSavingOn };
			case (_class call _isBox):          { _boxSavingOn };
			case (_class call _isStaticWeapon): { _staticWeaponSavingOn };
			default                             { _baseSavingOn };
		};

		if (!_allowed) exitWith {};

		_objCount = _objCount + 1;
		_valid = true;

		{ if (typeName _x == "STRING") then { _pos set [_forEachIndex, parseNumber _x] } } forEach _pos;

		_obj = createVehicle [_class, _pos, [], 0, "None"];
		_objectsArray pushBack _obj;


		_obj allowDamage false;
		_obj hideObjectGlobal true;
		_obj enableSimulation false;


		_obj setPosWorld ATLtoASL _pos;

		if (!isNil "_dir") then
		{
			_obj setVectorDirAndUp _dir;
		};
        


		[_obj, false] call vehicleSetup;
		[_obj] call basePartSetup;

		if (!isNil "_objectID") then
		{
			_obj setVariable ["A3W_objectID", _objectID, true];
			_obj setVariable ["A3W_objectSaved", true, true];
			A3W_objectIDs pushBack _objectID;
		};

		_obj setVariable ["baseSaving_hoursAlive", _hoursAlive];
		_obj setVariable ["baseSaving_spawningTime", diag_tickTime];
		_obj setVariable ["objectLocked", true, true]; // force lock

		//_obj setVariable ["R3F_LOG_Disabled", false, true];

        if (_allowDamage > 0) then
		{
			_obj allowDamage true;
			_obj setDamage _damage;
			_obj setVariable ["allowDamage", true, true];
		}
		else
		{
			_obj setVariable ["allowDamage", false, true];
		};
		

		if (!isNil "_owner") then
		{
			_obj setVariable ["ownerUID", _owner, true];
		};

		private _uavSide = if (isNil "_playerSide") then { sideUnknown } else { _playerSide };
		private _uavAuto = true;

		{
			_var = _x select 0;
			_value = _x select 1;

			switch (_var) do
			{
				case "side": { _value = _value call _strToSide };
				case "cmoney": { if (_value isEqualType "") then { _value = parseNumber _value } };
				case "R3F_Side": { _value = _value call _strToSide };
				case "lockDown": { _value }; // BASE LOCKER
				case "Lights": { _value }; // BASE LOCKER
				case "password": { _value }; // BASE LOCKER - SAFE - DOOR
				case "password_door_1": { _value }; 
				case "password_door_2": { _value }; 
				case "password_door_3": { _value }; 
				case "password_door_4": { _value }; 
				case "password_door_5": { _value }; 
				case "password_door_6": { _value }; 
				case "password_door_7": { _value }; 
				case "password_door_8": { _value }; 
				case "password_door_9": { _value }; 
				case "password_door_10": { _value }; 
				case "password_door_11": { _value }; 
				case "password_door_12": { _value }; 
				case "password_door_13": { _value }; 
				case "password_door_14": { _value }; 
				case "password_door_15": { _value }; 
				case "password_door_16": { _value }; 
				case "password_door_17": { _value }; 
				case "password_door_18": { _value }; 
				case "password_door_19": { _value }; 
				case "password_door_20": { _value }; 
				case "password_door_21": { _value }; 
				case "password_door_22": { _value }; 
				case "ManagerLevel" : {_value};
				case "moveable": {_value};
				case "bis_disabled_Door_1": {_value};
				case "bis_disabled_Door_2": {_value};
				case "bis_disabled_Door_3": {_value};
				case "bis_disabled_Door_4": {_value};
				case "bis_disabled_Door_5": {_value};
				case "bis_disabled_Door_6": {_value};
				case "bis_disabled_Door_7": {_value};
				case "bis_disabled_Door_8": {_value};
				case "GOM_fnc_fuelCargo": {_value};
				case "GOM_fnc_ammoCargo": {_value};
				case "GOM_fnc_repairCargo": {_value};
				case "lockedSafe": { _value }; // SAFE
				case "A3W_inventoryLockR3F": { _value }; // SAFE
				case "R3F_LOG_disabled": { _value }; // SAFE
				case "ownerName":
				{
					switch (typeName _value) do
					{
						case "ARRAY": { _value = toString _value };
						case "STRING":
						{
							if (_savingMethod == "iniDB") then
							{
								_value = _value call iniDB_Base64Decode;
							};
						};
						default { _value = "[Beacon]" };
					};
				};
				case "uavSide":
				{
					if (_uavSide isEqualTo sideUnknown) then { _uavSide = STR_TO_SIDE(_value) };
				};
				case "uavAuto":
				{
					if (_value isEqualType true) then
					{
						_uavAuto = _value;
					};
				};
			};

			_obj setVariable [_var, _value, true];
		} forEach _variables;
		
		switch(true) do {
			case( _obj isKindof "Land_SatellitePhone_F" ): {
				_obj setvariable ["Baselockenabled", true, true];
				_satOwnerUID = _obj getVariable "ownerUID";
				satOnServer pushBack _satOwnerUID;
			}; 
			case( _obj isKindOf "ContainmentArea_01_forest_F" ): { _obj setVectorUp [0,0,-1]; };
			case( _obj isKindOf "Flag_White_F" ): { _obj setFlagTexture "client\images\flagTextures\canada.jpg"; };
			case( _obj isKindOf "Flag_Green_F" ): { _obj setFlagTexture "client\images\flagTextures\scotland.jpg"; };
			case( _obj isKindOf "Flag_Blue_F" ): { _obj setFlagTexture "client\images\flagTextures\pride.jpg"; };
			case( _obj isKindOf "Flag_Red_F" ): { _obj setFlagTexture "client\images\flagTextures\canada.jpg"; };	
			case( _obj isKindOf "Flag_UNO_F" ): { _obj setFlagTexture "client\images\flagTextures\swiss.jpg"; };
			case( _obj isKindOf "Flag_Fuel_F" ): { _obj setFlagTexture "client\images\flagTextures\germany.jpg"; };			
			case( _obj isKindOf "Land_CargoBox_V1_F" ): {

				[_obj, ["<img image='client\icons\arsenal.paa'/> Virtual Arsenal", "addons\scripts\vaforall.sqf", nil, 2, true, true, "", "true", 3.5, false]] remoteExec ["addAction",0, true];
				_vaOwnerUID = _obj getVariable "ownerUID";
				vasOnServer pushBack _vaOwnerUID;
			};
			case( _obj isKindOf "Land_PhoneBooth_01_malden_F" ): {

				[_obj, ["<img image='client\icons\whitesquare.paa'/> Repaint Vehicle", "addons\VehiclePainter\VehiclePainter_Check.sqf", nil, 2, true, true, "", "true", 3.5, false]] remoteExec ["addAction",0, true];
				[_obj, ["<img image='client\icons\Paradrop.paa'/> Halo Jump", "addons\scripts\halo.sqf", nil, 2, true, true, "alive _target", "true", 3.5, false]] remoteExec ["addAction",0, true];			
				_haloOwnerUID = _obj getVariable "ownerUID";
				haloOnServer pushBack _haloOwnerUID;
			};			
			case( _obj isKindOf "Land_Pier_Box_F" && _obj getVariable ["helipad", false] ): {

				[_obj] execVM "addons\helipad\decorate.sqf";

				//Is Resupply Installed?
				if( _obj getVariable ["A3W_resupplyTruck", false] ) then { [_obj] remoteExecCall ["A3W_fnc_setupResupplyTruck", 0, _obj]; };
					
			};
			case( _obj getVariable ["lights", "off"] == "off" && typeOf _obj in [BASE_LOCKER, "Lamps_base_F", "Land_PortableLight_single_F", "Land_PortableLight_double_F", ""] ): {

				_obj setHit ["light_1_hitpoint", 0.97];
				_obj setHit ["light_2_hitpoint", 0.97];
				_obj setHit ["light_3_hitpoint", 0.97];
				_obj setHit ["light_4_hitpoint", 0.97];
				_obj setHit ["light_1_hit", 0.97];
				_obj setHit ["light_2_hit", 0.97];
				_obj setHit ["light_3_hit", 0.97];
				_obj setHit ["light_4_hit", 0.97];
				_obj switchLight "OFF";

			};
			case ( typeOf _obj in ["rhsusf_mags_crate", "Land_RepairDepot_01_green_F"] ): {

				_obj setVariable ["A3W_purchasedVehicle", true, true];
				_obj setVariable ["A3W_resupplyTruck", true, true];

				[_obj] remoteExecCall ["A3W_fnc_setupResupplyTruck", 0, _obj];

			};
		};
		
		// Base locker lights
		/*if (_obj getVariable ["lights",""] == "off") then
		{

			_obj setHit ["light_1_hit", 0.97];
		};*/
		
		if ({_obj isKindOf _x} count ["Land_Cargo_Tower_V1_F", "Land_Cargo_Tower_V1_No1_F", "Land_Cargo_Tower_V1_No2_F", "Land_Cargo_Tower_V1_No3_F", "Land_Cargo_Tower_V1_No4_F", "Land_Cargo_Tower_V1_No5_F", "Land_Cargo_Tower_V1_No6_F", "Land_Cargo_Tower_V1_No7_F"] > 0) then
		{
			_obj addEventHandler ["HandleDamage", {0}];
			_obj enableSimulation false;
			_obj allowDamage false;
			_obj setVariable ["allowDamage", false, true];
		};		
		

		if (unitIsUAV _obj) then
		{
			[_obj, _uavSide, false, _uavAuto] spawn fn_createCrewUAV;
		};
		
		// CCTV Camera
		if (isNil "cctv_cameras" || {typeName cctv_cameras != typeName []}) then {
			cctv_cameras = [];
			};
			
			 if (_obj getVariable ["a3w_cctv_camera",false]) then {
				cctv_cameras pushBack _obj;
				publicVariable "cctv_cameras";
		};		


		clearWeaponCargoGlobal _obj;
		clearMagazineCargoGlobal _obj;
		clearItemCargoGlobal _obj;
		clearBackpackCargoGlobal _obj;

		_unlock = switch (true) do
		{
			case (_obj call _isWarchest): { true };
			case (_obj call _isBeacon):
			{
				pvar_spawn_beacons pushBack _obj;
				publicVariable "pvar_spawn_beacons";
				true
			};
			case (_locked < 1): { true };
			default { false };
		};

		if (_unlock) then
		{
			_obj setVariable ["objectLocked", false, true];
		}
		else
		{
			if (_boxSavingOn && {_class call _isBox}) then
			{
				if (!isNil "_weapons") then
				{
					{ _obj addWeaponCargoGlobal _x } forEach _weapons;
				};
				if (!isNil "_magazines") then
				{
					[_obj, _magazines] call processMagazineCargo;
				};
				if (!isNil "_items") then
				{
					{ _obj addItemCargoGlobal _x } forEach _items;
				};
				if (!isNil "_backpacks") then
				{
					{
						_bpack = _x select 0;

						if (!(_bpack isKindOf "Weapon_Bag_Base") || {[["_UAV_","_Designator_"], _bpack] call fn_findString != -1}) then
						{
							_obj addBackpackCargoGlobal _x;
						};
					} forEach _backpacks;
				};
			};

			if (!isNil "_turretMags" && _staticWeaponSavingOn && {_class call _isStaticWeapon}) then
			{
				_obj setVehicleAmmo 0;
				{ _obj removeMagazineTurret [_x select 0, _x select 1] } forEach magazinesAllTurrets _obj;
				{ _obj addMagazine _x } forEach _turretMags;
			};




			if (!isNil "_ammoCargo") then { _obj setAmmoCargo _ammoCargo };
			if (!isNil "_fuelCargo") then { _obj setFuelCargo _fuelCargo };
			if (!isNil "_repairCargo") then { _obj setRepairCargo _repairCargo };


			reload _obj;
		};


		_obj hideObjectGlobal false;
		
	//Restore Service Objects
	if ({_obj iskindof _x} count [
			"Box_NATO_AmmoVeh_F",
			"Box_EAST_AmmoVeh_F",
			"Box_IND_AmmoVeh_F",
			"B_Slingload_01_Ammo_F",
			"B_Slingload_01_Fuel_F",
			"B_Slingload_01_Medevac_F",
			"B_Slingload_01_Repair_F",
			"StorageBladder_01_fuel_forest_F",
			"StorageBladder_01_fuel_sand_F",
			"Land_fs_feed_F",
			"Land_FuelStation_01_pump_malevil_F",
			"Land_FuelStation_Feed_F",
			"Land_Pod_Heli_Transport_04_fuel_F",
			"Land_Pod_Heli_Transport_04_repair_F"
		] > 0) then	
		{
			_obj spawn GOM_fnc_addAircraftLoadoutToObject;
		};		
	};

	if (!_valid && !isNil "_objectID") then
	{
		if (!isNil "_obj") then
		{
			_obj setVariable ["A3W_objectID", nil, true];
		};

		_exclVehicleIDs pushBack _vehicleID;
		_exclObjectIDs pushBack _objectID;
	};
	
} forEach _objects;

//Restore building, towers, etc first
{ 
	if (_x iskindof "NonStrategic") then 
	{ 
		_x hideObjectGlobal false; 
		_x enableSimulation true; 
	}; 
} foreach _objectsArray;
{ 
	//Restore things that go in those buildings 
	if (_x iskindof "Thing") then 
	{ 
		_x hideObjectGlobal false; 
		_x enableSimulation true; 
	}; 
} foreach _objectsArray;
{ 
	//Restore eerything else 
	if (_x iskindof "All") then 
	{ 
		_x hideObjectGlobal false; 
		_x enableSimulation true; 
	}; 
} foreach _objectsArray;

if (_warchestMoneySavingOn) then
{
	_amounts = call compile preprocessFileLineNumbers format ["%1\getWarchestMoney.sqf", _methodDir];

	pvar_warchest_funds_west = (_amounts select 0) max 0;
	publicVariable "pvar_warchest_funds_west";
	pvar_warchest_funds_east = (_amounts select 1) max 0;
	publicVariable "pvar_warchest_funds_east";
};

diag_log format ["A3Wasteland - world persistence loaded %1 objects from %2", _objCount, call A3W_savingMethodName];

_exclObjectIDs call fn_deleteObjects;
