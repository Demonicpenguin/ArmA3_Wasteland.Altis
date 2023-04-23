// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: spawnStoreObject.sqf
//	@file Author: AgentRev
//	@file Created: 11/10/2013 22:17
//	@file Args:

#include "..\..\STConstants.h"
if (!isServer) exitWith {};

scopeName "spawnStoreObject";
private ["_isGenStore", "_isGunStore", "_isVehStore", "_timeoutKey", "_objectID", "_playerSide", "_objectsArray", "_results", "_itemEntry", "_itemPrice", "_safePos", "_object"];

params [["_player",objNull,[objNull]], ["_itemEntrySent",[],[[]]], ["_npcName","",[""]], ["_key","",[""]]];

_itemEntrySent params [["_class","",[""]]];

_isGenStore = ["GenStore", _npcName] call fn_startsWith;
_isGunStore = ["GunStore", _npcName] call fn_startsWith;
_isVehStore = ["VehStore", _npcName] call fn_startsWith;



private _storeNPC = missionNamespace getVariable [_npcName, objNull];
private _marker = _npcName;

if (_key != "" && _player isKindOf "Man" && {_isGenStore || _isGunStore || _isVehStore}) then
{
	_timeoutKey = _key + "_timeout";
	_objectID = "";
	private _seaSpawn = false;
	private _playerGroup = group _player;
	_playerSide = side _playerGroup;

	if (_isGenStore || _isGunStore) then
	{
		_npcName = _npcName + "_objSpawn";

		switch (true) do
		{
			case _isGenStore: { _objectsArray = genObjectsArray };
			case _isGunStore: { _objectsArray = staticGunsArray };
		};

		if (!isNil "_objectsArray") then
		{
			_results = (call _objectsArray) select {_x select [1,999] isEqualTo _itemEntrySent};

			if (count _results > 0) then
			{
				_itemEntry = _results select 0;
				_marker = _marker + "_objSpawn";
			};
		};
	};

	if (_isVehStore) then
	{
		// LAND VEHICLES
		{
			_results = (call _x) select {_x select [1,999] isEqualTo _itemEntrySent};

			if (count _results > 0) then
			{
				_itemEntry = _results select 0;
				_marker = _marker + "_landSpawn";
			};
		} forEach [landArray, armoredArray, tanksArray];

		// SEA VEHICLES BOATS
		if (isNil "_itemEntry") then
		{
			_results = (call boatsArray) select {_x select [1,999] isEqualTo _itemEntrySent};

			if (count _results > 0) then
			{
				_itemEntry = _results select 0;
				_marker = _marker + (["_seaSpawn","_landSpawn"] select (markerType (_marker + "_seaSpawn") isEqualTo "")); // allow boat on landSpawn if no seaSpawn
				_seaSpawn = true;
			};
		};
		
		// SEA VEHICLES SHIPS
		if (isNil "_itemEntry") then
		{
			_results = (call shipsArray) select {_x select [1,999] isEqualTo _itemEntrySent};

			if (count _results > 0) then
			{
				_itemEntry = _results select 0;




				_marker = _marker + (["_subSpawn","_landSpawn"] select (markerType (_marker + "_seaSpawn") isEqualTo "")); // allow boat on landSpawn if no seaSpawn
				_seaSpawn = true;
			};


		};

		// SEA VEHICLES SUBS
		if (isNil "_itemEntry") then
		{
			_results = (call subsArray) select {_x select [1,999] isEqualTo _itemEntrySent};

			if (count _results > 0) then
			{
				_itemEntry = _results select 0;




				_marker = _marker + (["_subSpawn","_landSpawn"] select (markerType (_marker + "_subSpawn") isEqualTo "")); // allow boat on landSpawn if no seaSpawn
				_subSpawn = true;
			};


		};			

		// HELICOPTERS
		if (isNil "_itemEntry") then
		{
			_results = (call helicoptersArray) select {_x select [1,999] isEqualTo _itemEntrySent};

			if (count _results > 0) then
			{
				_itemEntry = _results select 0;
				_marker = _marker + "_heliSpawn";
			};
		};
		
		// DRONES
		if (isNil "_itemEntry") then
		{
			_results = (call uavArray) select {_x select [1,999] isEqualTo _itemEntrySent};

			if (count _results > 0) then
			{
				_itemEntry = _results select 0;
				_marker = _marker + "_planeSpawn";
			};
		};		
		

		// AIRPLANES
		if (isNil "_itemEntry") then
		{
			_results = (call planesArray) select {_x select [1,999] isEqualTo _itemEntrySent};

			if (count _results > 0) then
			{
				_itemEntry = _results select 0;
				_marker = _marker + "_planeSpawn";
			};
		};
	};
	
	if (!isNil "_itemEntry" && markerShape _marker != "") then
	{
		_itemPrice = _itemEntry select 2;
		_skipSave = "SKIPSAVE" in (_itemEntry select [3,999]);

		/*if (_class isKindOf "Box_NATO_Ammo_F") then
		{
			switch (side _player) do
			{
				case OPFOR:       { _class = "Box_East_Ammo_F" };
				case INDEPENDENT: { _class = "Box_IND_Ammo_F" };
			};
		};*/

		if (_player getVariable ["cmoney", 0] >= _itemPrice) then
		{
			private _markerPos = markerPos _marker;
			private _npcPos = getPosASL _storeNPC;
			private _canFloat = (round getNumber (configFile >> "CfgVehicles" >> _class >> "canFloat") > 0);
			private _waterNonBoat = false;
			private "_spawnPosAGL";

			// non-boat spawn over water (e.g. aircraft carrier)
			if (!isNull _storeNPC && surfaceIsWater _npcPos && !_seaSpawn) then
			{
				_markerPos set [2, _npcPos select 2];
				_spawnPosAGL = ASLtoAGL _markerPos;
				_safePos = if (_canFloat) then { _spawnPosAGL } else { ASLtoATL _markerPos };
				_waterNonBoat = true;
			}
			else // normal spawn
			{
				_safePos = _markerPos findEmptyPosition [0, 50, [_class, "B_Truck_01_transport_F"] select (!surfaceIsWater _markerPos && _seaSpawn)]; // use HEMTT in findEmptyPosition for boats on lands 
				if (count _safePos == 0) then { _safePos = _markerPos };
				_spawnPosAGL = _safePos;
				if (_seaSpawn) then { _safePos vectorAdd [0,0,0.05] };
			};

			// delete wrecks near spawn
			{
				if (!alive _x) then
				{
					deleteVehicle _x;
				};
			} forEach nearestObjects [_spawnPosAGL, ["LandVehicle","Air","Ship"], 25 max sizeOf _class];

			if (_player getVariable [_timeoutKey, true]) then { breakOut "spawnStoreObject" }; // Timeout

			_object = createVehicle [_class, _safePos, [], 0, "NONE"];
			//_object setVariable ["moveable", true, true]; 			

			if (_waterNonBoat) then
			{
				private _posSurf = getPos _object;
				private _posASL = getPosASL _object;

				if (_posSurf select 2 < 0) then
				{
					_object setPosASL [_posSurf select 0, _posSurf select 1, (_posASL select 2) - (_posSurf select 2) + 0.05];
				};
			};




			if (_player getVariable [_timeoutKey, true]) then // Timeout
			{
				deleteVehicle _object;
				breakOut "spawnStoreObject";
			};

			_objectID = netId _object;
			_object setVariable ["A3W_purchasedStoreObject", true];
			_object setVariable ["ownerUID", getPlayerUID _player, true];
			//_object setVariable ["R3F_LOG_Disabled", false, true];
			_object setVariable ["ownerName", name _player, true];

			private _variant = (_itemEntry select {_x isEqualType "" && {_x select [0,8] == "variant_"}}) param [0,""];

			if (_variant != "") then
			{
				_object setVariable ["A3W_vehicleVariant", _variant select [8], true];
			};

			private _isUAV = (round getNumber (configFile >> "CfgVehicles" >> _class >> "isUav") > 0);

			if (_isUAV) then
			{
				createVehicleCrew _object;

				//assign AI to the vehicle so it can actually be used
				[_object, _playerSide, _playerGroup] spawn
				{
					params ["_uav", "_playerSide", "_playerGroup"];

					_grp = [_uav, _playerSide, true] call fn_createCrewUAV;

					if (isNull (_uav getVariable ["ownerGroupUAV", grpNull])) then
					{
						_uav setVariable ["ownerGroupUAV", _playerGroup, true]; // not currently used
					};
				};
				0 = [_object,0.0016] execVM "addons\scripts\Fuel_Consumption.sqf";
			};


			if !(_player getVariable [_timeoutKey, true]) then
			{
				[_player, -_itemPrice] call A3W_fnc_setCMoney;
				_player setVariable [_key, _objectID, true];
			}
			else // Timeout
			{
				if (!isNil "_object") then { deleteVehicle _object };
				breakOut "spawnStoreObject";
			};

			if (_object isKindOf "AllVehicles" && !(_object isKindOf "StaticWeapon")) then
			{
				if (!surfaceIsWater _safePos) then
				{
					_object setPosATL [_safePos select 0, _safePos select 1, 0.05];
				};

				_object setVelocity [0,0,0.01];
				// _object spawn cleanVehicleWreck;
				_object setVariable ["A3W_purchasedVehicle", true, true];
				_object engineOn true; // Lets already turn the engine one to see if it fixes exploding vehicles.

				if (["A3W_vehicleLocking"] call isConfigOn && !_isUAV && !(_object isKindOf "ship")) then
				{
					[_object, 2] call A3W_fnc_setLockState; // Lock
				};
				if (["A3W_vehicleLocking"] call isConfigOn && !_isUAV && (_object isKindOf "ship")) then
				{
					[_object, 1] call A3W_fnc_setLockState; // unLock
				};				
			
				//25% chance of a fun bobblehead in the little bird
				if( _object isKindOf ST_LITTLE_BIRD && 25 > random 100 ) then { _object setVariable ["AddBobhead", true, true]; };
			};

			_object setDir (if (_object isKindOf "Plane") then { markerDir _marker } else { random 360 });

			_isDamageable = !(_object isKindOf "ReammoBox_F");

			[_object] call vehicleSetup;
			_object allowDamage _isDamageable;
			_object setVariable ["allowDamage", _isDamageable, true];

			clearBackpackCargoGlobal _object;
			if ({_object iskindof _x} count 
			[
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
				"Land_Pod_Heli_Transport_04_repair_F",
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
					["Box_NATO_AmmoVeh_F",						5000],
					["Box_EAST_AmmoVeh_F",						5000],
					["Box_IND_AmmoVeh_F",						5000],
					["B_Slingload_01_Ammo_F",					30000],
					["B_Truck_01_ammo_F",						25000],
					["O_Truck_03_ammo_F", 						15000],
					["I_Truck_02_ammo_F",						10000],
					["B_APC_Tracked_01_CRV_F",					500],
					["O_Heli_Transport_04_ammo_F",				20000]

				];
				private _FuelResourcesMax =
				[
					["B_Slingload_01_Fuel_F",					20000],
					["StorageBladder_01_fuel_forest_F",			15000],
					["StorageBladder_01_fuel_sand_F",			15000],
					["Land_fs_feed_F",							100000],
					["Land_FuelStation_01_pump_malevil_F",		100000],
					["Land_FuelStation_Feed_F",					100000],
					["Land_Pod_Heli_Transport_04_fuel_F",		22000],
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
					["B_Slingload_01_Repair_F",					25000],
					["Land_Pod_Heli_Transport_04_repair_F",		22000],
					["C_Offroad_01_repair_F",					500],
					["C_Van_02_service_F",						1000],
					["B_Truck_01_Repair_F",						25000],
					["O_Truck_03_repair_F",						20000],
					["I_Truck_02_box_F",						15000],
					["B_APC_Tracked_01_CRV_F",					500],
					["O_Heli_Transport_04_repair_F",			22000]
				];
				_object setAmmoCargo 0;
				_object setFuelCargo 0;
				_object setRepairCargo 0;
				_object spawn GOM_fnc_addAircraftLoadoutToObject;
				{
					private _check = _x select 0;
					private _value = _x select 1;
					if (_object iskindof _check) then

					{
						_object setVariable ["GOM_fnc_ammoCargo", _value, true];
					};
				} foreach _AmmoResourcesMax;
				{
					private _check = _x select 0;
					private _value = _x select 1;
					if (_object iskindof _check) then

					{
						_object setVariable ["GOM_fnc_fuelCargo", _value, true];
					};
				} foreach _FuelResourcesMax;
				{
					private _check = _x select 0;
					private _value = _x select 1;
					if (_object iskindof _check) then

					{
						_object setVariable ["GOM_fnc_repairCargo", _value, true];
					};
				} foreach _RepairResourcesMax;
			};
			
			// give diving gear to RHIB, Speedboat, and SDV
			if ({_object isKindOf _x} count ["Boat_Transport_02_base_F","Boat_Armed_01_base_F","SDV_01_base_F"] > 0) then
			{
				switch (side _player) do
				{
					case BLUFOR:
					{
						_object addItemCargoGlobal ["U_B_Wetsuit", 1];
						_object addItemCargoGlobal ["V_RebreatherB", 1];
					};
					case OPFOR:
					{
						_object addItemCargoGlobal ["U_O_Wetsuit", 1];
						_object addItemCargoGlobal ["V_RebreatherIR", 1];
					};
					default
					{
						_object addItemCargoGlobal ["U_I_Wetsuit", 1];
						_object addItemCargoGlobal ["V_RebreatherIA", 1];
					};
				};

				_object addItemCargoGlobal ["G_Diving", 1];
				_object addWeaponCargoGlobal ["arifle_SDAR_F", 1];
				_object addMagazineCargoGlobal ["20Rnd_556x45_UW_mag", 4];
				_object addMagazineCargoGlobal ["30Rnd_556x45_Stanag", 2];
			};
			
			if ({_object isKindOf _x} count ["Land_Cargo_Tower_V1_F", "Land_Cargo_Tower_V1_No1_F", "Land_Cargo_Tower_V1_No2_F", "Land_Cargo_Tower_V1_No3_F", "Land_Cargo_Tower_V1_No4_F", "Land_Cargo_Tower_V1_No5_F", "Land_Cargo_Tower_V1_No6_F", "Land_Cargo_Tower_V1_No7_F"] > 0) then
			{
				_object addEventHandler ["HandleDamage", {0}];
				_object enableSimulation false;
				_object allowDamage false;
				_object setVariable ["allowDamage", false, true];
			};

			switch (true) do
			{
				// Add default password to baselocker, safe and doorlocks.
		
				case ({_object isKindOf _x} count ["Land_MapBoard_01_Wall_Altis_F", "Land_InfoStand_V2_F", "Land_SatellitePhone_F", "Box_NATO_AmmoVeh_F"] > 0):
				{
					_object setVariable ["password", "0000", true];
				};
				case ({_object isKindOf _x} count ["Land_Cargo20_yellow_F"] > 0):
				{
						[_object, [["Land_Cargo_Tower_V1_No2_F", 1], ["Land_Canal_Wall_Stairs_F", 4],["Land_BarGate_F", 4],["Land_Cargo_Patrol_V2_F", 2],["Land_HBarrierWall6_F", 10],["Land_Canal_WallSmall_10m_F", 30],["Land_LampShabby_F", 4], ["Land_RampConcreteHigh_F",6], ["Land_Canal_Wall_10m_F", 2], ["Land_RampConcrete_F", 6], ["BlockConcrete_F",16], ["Land_Crash_barrier_F",6],  ["Land_GH_Stairs_F", 8], ["B_HMG_01_high_F",4]] ] execVM "addons\R3F_LOG\auto_load_in_vehicle.sqf";
				};
				case ({_object isKindOf _x} count ["Land_Cargo20_sand_F"] > 0):
				{
						[_object, [["Land_Fortress_01_10m_F", 8], ["Land_Fortress_01_5m_F", 2],["Land_Fortress_01_outterCorner_90_F", 4],["Land_Canal_Dutch_01_plate_F", 20]] ] execVM "addons\R3F_LOG\auto_load_in_vehicle.sqf";
				};				
				
				case ({_object isKindOf _x} count ["Land_Cargo40_white_F"] > 0):
				{
						[_object, [["Land_Cargo_Tower_V1_No7_F",2],["Land_GH_Platform_F",10],["Land_Canal_Wall_Stairs_F", 6],["Land_BarGate_F", 6],["Land_Cargo_Patrol_V2_F", 4],["Land_HBarrierWall6_F", 20],["Land_Canal_WallSmall_10m_F", 40],["Land_LampHalogen_F", 4], ["Land_RampConcreteHigh_F",8], ["Land_RampConcrete_F", 8], ["Land_Canal_Wall_10m_F", 4], ["Land_Crash_barrier_F",8],["B_GMG_01_F",2],["B_static_AA_F",2],["B_static_AT_F",2],["B_Quadbike_01_F",4],["C_Heli_light_01_digital_F",1]] ] execVM "addons\R3F_LOG\auto_load_in_vehicle.sqf";
				};
				case ({_object isKindOf _x} count ["ContainmentArea_01_forest_F"] > 0):
				{
					_object setVectorUp [0,0,-1];
				};
				case ({_object isKindOf _x} count ["ContainmentArea_01_sand_F"] > 0):
				{
					_object setVectorUp [0,-1,0];
				};
				case ({_object isKindOf _x} count ["Flag_White_F"] > 0):
				{
					_object setFlagTexture "client\images\flagTextures\canada.jpg";
				};
				case ({_object isKindOf _x} count ["Flag_Green_F"] > 0):
				{
					_object setFlagTexture "client\images\flagTextures\scotland.jpg";
				};
				case ({_object isKindOf _x} count ["Flag_Blue_F"] > 0):
				{
					_object setFlagTexture "client\images\flagTextures\pride.jpg";
				};
				case ({_object isKindOf _x} count ["Flag_Red_F"] > 0):
				{
					_object setFlagTexture "client\images\flagTextures\canada.jpg";
				};
				case ({_object isKindOf _x} count ["Flag_UNO_F"] > 0):
				{
					_object setFlagTexture "client\images\flagTextures\swiss.jpg";
				};
				case ({_object isKindOf _x} count ["Flag_Fuel_F"] > 0):
				{
					_object setFlagTexture "client\images\flagTextures\germany.jpg";
				};
				case ({_object isKindOf _x} count [ST_ATCONVENIENCEKIT, ST_AACONVENIENCEKIT] > 0):
				{
					0 = [_object] execVM "server\missions\factoryMethods\STCreateConvenienceKit.sqf";
				};
				case ({_object isKindOf _x} count ["B_Truck_01_box_F"] > 0):
				{
					[[_object, [ "<t color='#FF0000'> Autoload Store Items</t>", {nul = [_player] call Soul_AutoLoad}, "_this distance cursortarget < 3"]],"addAction",true,true] call BIS_fnc_MP;				
					//[_object, ["<img image='client\icons\arrow.paa'/><t color='#FF0000'> Autoload Store Items", "addons\scripts\Soul_AutoLoad.sqf", nil, 2, true, true, "", "true", 3.5, false]] remoteExec ["addAction",0, true];
				};
				
				case ({_object isKindOf _x} count ["Land_CargoBox_V1_F"] > 0):
				{
					[_object, ["<img image='client\icons\arsenal.paa'/> Virtual Arsenal", "addons\scripts\vaforall.sqf", nil, 2, true, true, "", "true", 3.5, false]] remoteExec ["addAction",0, true];
				};
				case ({_object isKindOf _x} count ["Land_PhoneBooth_01_malden_F"] > 0):
				{
					[_object, ["<img image='client\icons\whitesquare.paa'/> Repaint Vehicle", "addons\VehiclePainter\VehiclePainter_Check.sqf", nil, 2, true, true, "", "true", 3.5, false]] remoteExec ["addAction",0, true];
					[_object, ["<img image='client\icons\Paradrop.paa'/> Halo Jump", "addons\scripts\halo.sqf", nil, 2, true, true, "alive _target", "true", 3.5, false]] remoteExec ["addAction",0, true];
					
					// old man [_object,["<img image='client\icons\Paradrop.paa'/> Halo Jump","addons\scripts\halo.sqf",[],1,false,true,"","_this distance _target < 2"]] remoteExec ["addAction",2];
				};
				case ({_object isKindOf _x} count ["Lamps_base_F", "Land_PortableLight_single_F", "Land_PortableLight_double_F"] > 0):
				{
					_object switchLight "OFF";
					_object setHit ["light_1_hitpoint", 0.97];
					_object setHit ["light_2_hitpoint", 0.97];
				};
				case ({_object isKindOf _x} count [ST_REPAIR_DEPOT, ST_RESUPPLY_KIT] > 0):
				{

					if( _object isKindOf ST_REPAIR_DEPOT ) then {
						_object setVariable ["kits", 100, true];
					} else {

						_object allowDamage false; //Prevents destruction of crates
						_object setVariable ["allowDamage", false, true];
						_object setVariable ["A3W_inventoryLockR3F", true, true];
						_object setAmmoCargo 10;
					};

					/* private _magsCargo = magazinesAmmoCargo _container;
					private _items = (getItemCargo _container) call cargoToPairs;
					private _backpacks = (getBackpackCargo _container) call cargoToPairs; */

					_object setVariable ["password", "0000", true];
					_object setVariable ["A3W_resupplyCount", 100, true];

					[_object] remoteExecCall ["A3W_fnc_setupResupplyTruck", 0, _object];

				};				
			};

			switch (true) do
			{
				case (_object isKindOf "HAFM_MisBoat"):
				{
					_object setDir 206;			
					_object setPosASL [2546.161,21788.33,13.737];
				};
				case (_object isKindOf "HAFM_PBoat"):
				{

					_object setDir 206;			
					_object setPosASL [2546.161,21788.33,13.737];
				};
				case (_object isKindOf "HAFM_CB90"):
				{
					_object setDir 206;			
					_object setPosASL [2603.25,21755.762,18.478];
				};
				case (_object isKindOf "HAFM_GunBoat"):
				{
					_object setDir 206;			
					_object setPosASL [2546.161,21788.33,13.737];
				};
				case (_object isKindOf "HAFM_GunBoat_BLU"):
				{
					_object setDir 206;			
					_object setPosASL [2546.161,21788.33,13.737];
				};
				case (_object isKindOf "HAFM_CB90_BLU"):
				{
					_object setDir 206;			
					_object setPosASL [2546.161,21788.33,13.737];
				};
				case (_object isKindOf "HAFM_PBoat_BLU"):
				{
					_object setDir 206;			
					_object setPosASL [2546.161,21788.33,13.737];
				};
				case (_object isKindOf "HAFM_Replenishment"):
				{
					_object setDir 206;			
					_object setPosASL [2536.96,21768.2,14.158];
				};
				case (_object isKindOf "HAFM_Russen"):
				{
					_object setDir 206;			
					_object setPosASL [2546.161,21788.33,13.737];
				};
				case (_object isKindOf "HAFM_Admiral"):
				{
					_object setDir 206;			
					_object setPosASL [2546.161,21788.33,13.737];
				};
				case (_object isKindOf "HAFM_MEKO_TN"):
				{
					_object setDir 206;			
					_object setPosASL [2546.161,21788.33,13.737];
				};
				case (_object isKindOf "HAFM_MEKO_HN"):
				{
					_object setDir 206;			
					_object setPosASL [2546.161,21788.33,13.737];
				};
				case (_object isKindOf "HAFM_FREMM"):
				{
					_object setDir 206;			
					_object setPosASL [2536.96,21768.2,14.158];
				};
				case (_object isKindOf "HAFM_ABurke"):
				{
					_object setDir 206;			
					_object setPosASL [2536.96,21768.2,14.158];
					_object enableDynamicSimulation true;					
				};	
				case (_object isKindOf "HAFM_052C"):
				{
					_object setDir 206;			
					_object setPosASL [2536.96,21768.2,14.158];
				};
				case (_object isKindOf "HAFM_052D"):
				{
					_object setDir 206;			
					_object setPosASL [2536.96,21768.2,14.158];
				};					
				case (_object isKindOf "HAFM_Virginia"):
				{
					[_object, 3] call HAFM_fnc_SubAttachment;
					_object setDir 206;			
					_object setPosASL [2603.25,21755.762,18.478];
					_object addEventHandler
						[
							"HandleDamage",
							{
								_unit = _this select 0;
								_selections = _unit getVariable ["selections", []];
								_gethit = _unit getVariable ["gethit", []];
								_selection = _this select 1;
								if !(_selection in _selections) then
								{
									_selections set [count _selections, _selection];
									_gethit set [count _gethit, 0];
								};
								_i = _selections find _selection;
								_olddamage = _gethit select _i;
								_damage = _olddamage + ((_this select 2) - _olddamage) * 0.20; // The lower the number, the higher the armor
								_gethit set [_i, _damage];
								_damage;
							}
						];					
				};
				case (_object isKindOf "HAFM_Yasen"):
				{
					[_object, 3] call HAFM_fnc_SubAttachment;				
					_object setDir 206;			
					_object setPosASL [2603.25,21755.762,18.478];
					_object addEventHandler
						[
							"HandleDamage",
							{
								_unit = _this select 0;
								_selections = _unit getVariable ["selections", []];
								_gethit = _unit getVariable ["gethit", []];
								_selection = _this select 1;
								if !(_selection in _selections) then
								{
									_selections set [count _selections, _selection];
									_gethit set [count _gethit, 0];
								};
								_i = _selections find _selection;
								_olddamage = _gethit select _i;
								_damage = _olddamage + ((_this select 2) - _olddamage) * 0.20; // The lower the number, the higher the armor
								_gethit set [_i, _damage];
								_damage;
							}
						];					
				};
				case (_object isKindOf "HAFM_214"):
				{
					[_object, 3] call HAFM_fnc_SubAttachment;				
					_object setDir 206;			
					_object setPosASL [2616.109,21748.385,16.743];
					_object addEventHandler
						[
							"HandleDamage",
							{
								_unit = _this select 0;
								_selections = _unit getVariable ["selections", []];
								_gethit = _unit getVariable ["gethit", []];
								_selection = _this select 1;
								if !(_selection in _selections) then
								{
									_selections set [count _selections, _selection];
									_gethit set [count _gethit, 0];
								};
								_i = _selections find _selection;
								_olddamage = _gethit select _i;
								_damage = _olddamage + ((_this select 2) - _olddamage) * 0.30; // The lower the number, the higher the armor
								_gethit set [_i, _damage];
								_damage;
							}
						];					
				};
				case (_object isKindOf "HAFM_209"):
				{
					[_object, 3] call HAFM_fnc_SubAttachment;				
					_object setDir 206;			
					_object setPosASL [2616.109,21748.385,16.743];
					_object addEventHandler
						[
							"HandleDamage",
							{
								_unit = _this select 0;
								_selections = _unit getVariable ["selections", []];
								_gethit = _unit getVariable ["gethit", []];
								_selection = _this select 1;
								if !(_selection in _selections) then
								{
									_selections set [count _selections, _selection];
									_gethit set [count _gethit, 0];
								};
								_i = _selections find _selection;
								_olddamage = _gethit select _i;
								_damage = _olddamage + ((_this select 2) - _olddamage) * 0.30; // The lower the number, the higher the armor
								_gethit set [_i, _damage];
								_damage;
							}
						];					
				};
				case (_object isKindOf "HAFM_BUYAN"):
				{
					_object setDir 206;			
					_object setPosASL [2546.161,21788.33,13.737];
				};
				case (_object isKindOf "HAFM_MisBoat_BLU"):
				{
					_object setDir 206;			
					_object setPosASL [2546.161,21788.33,13.737];
				};
				case (_object isKindOf "HAFM_Corvette"):
				{
					_object setDir 206;			
					_object setPosASL [2546.161,21788.33,13.737];
				};
				case (_object isKindOf "HAFM_Frigate"):
				{
					_object setDir 206;			
					_object setPosASL [2546.161,21788.33,13.737];
				};
				case (_object isKindOf "A2_Fregata"):
				{
					_object setDir 206;			
					_object setPosASL [2546.161,21788.33,13.737];
				};
				case (_object isKindOf "HAFM_Frigate_OPF"):
				{
					_object setDir 206;			
					_object setPosASL [2546.161,21788.33,13.737];
				};
				case (_object isKindOf "HAFM_Corvette_OPF"):
				{
					_object setDir 206;			
					_object setPosASL [2546.161,21788.33,13.737];
				};
				case (_object isKindOf "HAFM_PBoat_OPF"):
				{
					_object setDir 206;			
					_object setPosASL [2546.161,21788.33,13.737];
				};					
				case (_object isKindOf "SDV_01_base_F" || _object isKindOf "Boat_Civil_01_base_F" || _object isKindOf "Boat_Armed_01_base_F"):
				{
					switch (side _player) do
					{
						case BLUFOR:
						{
							_object addItemCargoGlobal ["U_B_Wetsuit", 1];
							_object addItemCargoGlobal ["V_RebreatherB", 1];
						};
						case OPFOR:
						{
							_object addItemCargoGlobal ["U_O_Wetsuit", 1];
							_object addItemCargoGlobal ["V_RebreatherIR", 1];
						};
						default
						{
							_object addItemCargoGlobal ["U_I_Wetsuit", 1];
							_object addItemCargoGlobal ["V_RebreatherIA", 1];
						};
					};

					_object addItemCargoGlobal ["G_Diving", 1];
					_object addWeaponCargoGlobal ["arifle_SDAR_F", 1];
					_object addMagazineCargoGlobal ["20Rnd_556x45_UW_mag", 4];
					_object addMagazineCargoGlobal ["30Rnd_556x45_Stanag", 2];			

				};
				case (_object isKindOf "RHS_AH64D" || _object isKindOf "fza_ah64d_b2e_nr"):
				{
					_object addItemCargoGlobal ["rhsusf_ihadss", 2];
				};
				case (_object isKindOf "Land_CargoBox_V1_F"):
				{
					private _VA = nearestObject [_player, "Land_CargoBox_V1_F"];
					private _uid = getPlayerUID _player;
					if (count vasOnServer > 0) then
					{
						if (vasOnServer findIf {_x == _uid} > -1) then
						{
							playSound3D [call currMissionDir + "media\klaxon.ogg", _player, true, getPos _player, 2];
							
							//hint format ["Virtual Arsenal denied! ONLY one Virtual Arsenal Box allowed. Virtual Arsenal Box has been Deleted and bank refunded."];
							_player groupChat format ["Virtual Arsenal denied! ONLY one Virtual Arsenal Box allowed. Virtual Arsenal Box has been Deleted and bank refunded."];							

							_balance = _player getVariable ["bmoney", 0];
							_newBalance = _balance + 15000000;
							_player setVariable ["bmoney", _newBalance, true];
							[_uid, [["BankMoney", _newBalance]], []] call fn_saveAccount;
							deleteVehicle _VA;
							_moreThanOneVA = false;
							_ownedCount = 0;		
						} else
						{
							vasOnServer pushBack _uid;
						};
					} else	// array empty add first element
					{
						vasOnServer pushBack _uid;	
					};
				};
				case (_object isKindOf "Land_PhoneBooth_01_malden_F"):
				{
					private _HALO = nearestObject [_player, "Land_PhoneBooth_01_malden_F"];
					private _uid = getPlayerUID _player;
					if (count haloOnServer > 0) then
					{
						if (haloOnServer findIf {_x == _uid} > -1) then
						{
							playSound3D [call currMissionDir + "media\klaxon.ogg", _player, true, getPos _player, 2];
							
							//hint format ["Virtual Arsenal denied! ONLY one Virtual Arsenal Box allowed. Virtual Arsenal Box has been Deleted and bank refunded."];
							_player groupChat format ["Halo Phone Booth denied! ONLY one Halo Jump Purchase allowed. Halo Phone Booth has been Deleted and bank refunded."];							

							_balance = _player getVariable ["bmoney", 0];
							_newBalance = _balance + 5000000;
							_player setVariable ["bmoney", _newBalance, true];
							[_uid, [["BankMoney", _newBalance]], []] call fn_saveAccount;
							deleteVehicle _HALO;
							_moreThanOneHALO = false;
							_ownedCount = 0;		
						} else
						{
							haloOnServer pushBack _uid;
						};
					} else	// array empty add first element
					{
						haloOnServer pushBack _uid;	
					};
				};
				case (_object isKindOf "Land_SatellitePhone_F"):
				{
					private _BMS = nearestObject [_player, "Land_SatellitePhone_F"];				
					private _uid = getPlayerUID _player;
					if (count satOnServer > 0) then
					{
						if (satOnServer findIf {_x == _uid} > -1) then
						{
							playSound3D [call currMissionDir + "media\klaxon.ogg", _player, true, getPos _player, 2];
							
							//hint format ["Virtual Arsenal denied! ONLY one Virtual Arsenal Box allowed. Virtual Arsenal Box has been Deleted and bank refunded."];
							_player groupChat format ["Base Management System denied! ONLY one Base Management Purchase allowed. Base Management System has been Deleted and bank refunded."];							

							_balance = _player getVariable ["bmoney", 0];
							_newBalance = _balance + 300000;
							_player setVariable ["bmoney", _newBalance, true];
							[_uid, [["BankMoney", _newBalance]], []] call fn_saveAccount;
							deleteVehicle _BMS;
							_moreThanOneSAT = false;
							_ownedCount = 0;		
						} else
						{
							satOnServer pushBack _uid;
						};
					} else	// array empty add first element
					{
						satOnServer pushBack _uid;	
					};
				};				
			};

			
			if (_skipSave) then
			{
				_object setVariable ["A3W_skipAutoSave", true, true];
			}
			else
			{
				if (_object getVariable ["A3W_purchasedVehicle", false] && !isNil "fn_manualVehicleSave") then
				{
					_object call fn_manualVehicleSave;
				};
			};

			if (_object isKindOf "AllVehicles") then
			{
				if (isNull group _object) then
				{
					_object setOwner owner _player; // tentative workaround for exploding vehicles
				}
				else
				{
					(group _object) setGroupOwner owner _player;
				};
			};
		
		};
	};
};
