// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: pickupEverything.sqf
//	@file Author: The Scotsman
//	@file Created: 11/23/2018
//  Picks up all wasteland items

private ["_crate", "_crates", "_target", "_cargo", "_count", "_time", "_skip", "_firstCheck", "_mags", "_packs", "_weapons", "_index"];

// Check if mutex lock is active.
if (mutexScriptInProgress) exitWith { player globalChat "You are already performing another action."; };
if (vehicle player != player) exitWith { titleText ["You can't pick stuff up while in a vehicle", "PLAIN DOWN", 0.5]; };

_count = 0;
_money = 0;
_supplies = nearestObjects[player, ["Land_Money_F","Land_BakedBeans_F","Land_Tablet_02_F","Land_Suitcase_F","Land_CanisterFuel_F","Land_BottlePlastic_V2_F","Land_Sleeping_bag_folded_F","Land_FireExtinguisher_F","Land_SatellitePhone_F","Land_Ground_sheet_folded_OPFOR_F"], 5];

player playActionNow "PutDown";
sleep 0.25;

{

	if( _x isKindOf "Land_Money_F" ) then {

		_money = _money + (_x getVariable["cmoney", 0]);

		pvar_processMoneyPickup = [player, netId _x];
		publicVariableServer "pvar_processMoneyPickup";

	} else {

		private _type = (_x getVariable ["mf_item_id", ""]);

		if( _type != "" ) then {

			//For each found item, fetch it's inventory name
			private _max = switch (_type) do {
				case MF_ITEMS_CANNED_FOOD: {MF_ITEMS_FOOD_MAX};
				case MF_ITEMS_WATER: {MF_ITEMS_WATER_MAX};
				case MF_ITEMS_ARTILLERY: {MF_ITEMS_MAX_ARTILLERY};
				case MF_ITEMS_REPAIR_KIT: {MF_ITEMS_REPAIR_KIT_MAX};
				case MF_ITEMS_JERRYCAN_EMPTY: {1};
				case MF_ITEMS_JERRYCAN_FULL: {1};
				case MF_ITEMS_SPAWN_BEACON: {MF_ITEMS_SPAWN_BEACON_MAX};
				case MF_ITEMS_EXTINGUISHER: {MF_ITEMS_EXTINGUISHER_MAX};
				case MF_ITEMS_PINLOCK: {MF_ITEMS_PINLOCK_MAX};
				case MF_ITEMS_CAMO_NET: {MF_ITEMS_CAMO_NET_MAX};
        //case MF_ITEMS_SYPHON_HOSE: { 1 };
				default {0};
			};

			if( (_type call mf_inventory_count) < _max ) then {

				[_type, 1] call mf_inventory_add;

				//Delete the object
				deleteVehicle _x;

				_count = _count + 1;

			};
		};
	};

} forEach _supplies;

private _message = switch(true) do {
  case (_money == 0 && _count == 0): { "There was nothing to pick up that would fit in your inventory"; };
  case (_count == 0): { format["You have picked up $%1 dollars", _money]; };
  case (_money == 0): { format["You have picked up %1 items", _count]; };
  default { format["You have picked up $%1 dollars and %2 other items", _money, _count]; };
};

hint _message;
