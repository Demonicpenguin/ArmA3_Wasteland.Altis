// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//@file Version: 1.0
//@file Name: init.sqf
//@file Author: MercyfulFate
//@file Created: 21/7/2013 16:00
//@file Description: Initialize Miscellaneous Items
//@file Argument: the path of the directory holding this file
#include "..\..\..\STConstants.h"
_path = _this;

MF_ITEMS_REPAIR_KIT_RANGE = 5;

// MF_ITEMS_MEDKIT = "medkit";
// _heal = [_path, "heal.sqf"] call mf_compile;
// [MF_ITEMS_MEDKIT, "Medkit", _heal, "Land_SuitCase_F","client\icons\medkit.paa",2] call mf_inventory_create;

MF_ITEMS_REPAIR_KIT = "repairkit";
_repair = [_path, "repair.sqf"] call mf_compile;
_icon = "client\icons\repair.paa";
[MF_ITEMS_REPAIR_KIT, "Repair Kit", _repair, "Land_SuitCase_F",_icon,2] call mf_inventory_create;

mf_nearest_vehicle = {
	private ["_types", "_obj", "_dist"];
	_types = _this;
	_obj = cursorTarget;
	if (!isNull _obj && {{_obj isKindOf _x} count _types == 0}) then { _obj = objNull };
	_obj
} call mf_compile;

mf_repair_nearest_vehicle = {
	["LandVehicle", "Air", "Ship"] call mf_nearest_vehicle
} call mf_compile;

// Setting up repairing action.
mf_repair_can_repair = [_path, "can_repair.sqf"] call mf_compile;
private ["_label1", "_execute1", "_condition1", "_action1"];
_label1 = format["<img image='%1'/> Repair Vehicle", _icon];
_execute1 = {MF_ITEMS_REPAIR_KIT call mf_inventory_use};
_condition1 = "[] call mf_repair_can_repair == ''";
_action1 = [_label1, _execute1, [], 1, false, false, "", _condition1];
["repairkit-use", _action1] call mf_player_actions_set;

mf_verify_money_input = [_path, "verify_money_input.sqf"] call mf_compile;

//Fire Extinguisher
MF_ITEMS_EXTINGUISHER = "extinguisher";
_extinguish = [_path, "extinguish.sqf"] call mf_compile;
_icon = "client\icons\extinguisher.paa";
_maxExtinguishers = ceil(["A3W_maxFireExtinguishers", 2] call getPublicVar);

[MF_ITEMS_EXTINGUISHER, "Fire Extinguisher", _extinguish, "Land_FireExtinguisher_F",_icon, _maxExtinguishers] call mf_inventory_create;

mf_extinguish_can_extinguish = [_path, "can_extinguish.sqf"] call mf_compile;

private ["_label1", "_execute1", "_condition1", "_action1"];
_label1 = format["<img image='%1' color='#ee0000'/> Extinguish Fire", _icon];
_execute1 = {MF_ITEMS_EXTINGUISHER call mf_inventory_use};
_condition1 = "[] call mf_extinguish_can_extinguish == ''";
_action1 = [_label1, _execute1, [], 1, false, false, "", _condition1];
["extinguisher-use", _action1] call mf_player_actions_set;

//Repair Depot
_label2 = "<img image='client\icons\repair.paa'/> Get Repair Kit";
_condition2 = "{_x getVariable ['kits', 0] >= 1} count nearestObjects [player, ['Land_RepairDepot_01_green_F'], 5] > 0 && !(MF_ITEMS_REPAIR_KIT call mf_inventory_is_full)";
_action2 = {

	_objs = nearestObjects [player, [ST_REPAIR_DEPOT], 5];

	if (count _objs > 0) then {

		player playActionNow "PutDown";

		_obj = _objs select 0;

		_obj setVariable ["kits", (_obj getVariable ["kits", 0]) - 1, true];
		[MF_ITEMS_REPAIR_KIT, 1] call mf_inventory_add;

		[format ["Repair Kits left: %1", _obj getVariable "kits"], 5] call mf_notify_client;

	};
};

["repair-kit-get", [_label2, _action2, [], 0, true, true, "", _condition2]] call mf_player_actions_set;
//ST: Stand on guard for thee
_label = "<img image='media\SKJ.paa'/> Stand On Guard";
_condition = "player distance cursorObject <= 5 && cursorObject iskindof 'Flag_US_F'";
_code = { nul = [] execVM "client\actions\USANA.sqf"; };
["stand-on-guard", [_label, _code, [], 0, true, true, "", _condition]] call mf_player_actions_set;

//ST: Scotland the Brave
_label = "<img image='media\SKJ.paa'/> Freedom Salute";
_condition = "player distance cursorObject <= 5 && cursorObject iskindof 'Flag_Green_F'";
_code = { nul = [] execVM "client\actions\Scottish.sqf"; };
["Freedom Salute", [_label, _code, [], 0, true, true, "", _condition]] call mf_player_actions_set;

//ST: God save the Queen
_label = "<img image='media\SKJ.paa'/> God Save the Queen";
_condition = "player distance cursorObject <= 5 && cursorObject iskindof 'Flag_UK_F'";
_code = { nul = [] execVM "client\actions\EnglishNA.sqf"; };
["God Save the Queen", [_label, _code, [], 0, true, true, "", _condition]] call mf_player_actions_set;

//ST: Over the Rainbow
_label = "<img image='media\SKJ.paa'/> Over the Rainbow";
_condition = "player distance cursorObject <= 5 && cursorObject iskindof 'Flag_Blue_F'";
_code = { nul = [] execVM "client\actions\OvertheRainbow.sqf"; };
["Over the Rainbow", [_label, _code, [], 0, true, true, "", _condition]] call mf_player_actions_set;

//ST: Oh Canada
_label = "<img image='media\SKJ.paa'/> Oh Canada";
_condition = "player distance cursorObject <= 5 && cursorObject iskindof 'Flag_Red_F'";
_code = { nul = [] execVM "client\actions\ohcanada.sqf"; };
["Oh Canada", [_label, _code, [], 0, true, true, "", _condition]] call mf_player_actions_set;

//ST: Swiss
_label = "<img image='media\SKJ.paa'/> Swiss Psalm";
_condition = "player distance cursorObject <= 5 && cursorObject iskindof 'Flag_UNO_F'";
_code = { nul = [] execVM "client\actions\swiss.sqf"; };
["Swiss Psalm", [_label, _code, [], 0, true, true, "", _condition]] call mf_player_actions_set;

//ST: Germany
_label = "<img image='media\SKJ.paa'/> Deutschlandlied";
_condition = "player distance cursorObject <= 5 && cursorObject iskindof 'Flag_Fuel_F'";
_code = { nul = [] execVM "client\actions\germany.sqf"; };
["Deutschlandlied", [_label, _code, [], 0, true, true, "", _condition]] call mf_player_actions_set;

//Recycle Objects
_label = format ["<img image='client\icons\recycle.paa' color='#007f00' /> <t color='#007f00'> Recycle</t>", [], -6, false];
_condition = "player distance cursorTarget <= 4 && !(cursorTarget getVariable ['objectLocked', false]) && !(cursorTarget getVariable ['R3F_LOG_disabled', false]) && {cursorTarget isKindOf _x} count ['ReammoBox_F','B_Ejection_Seat_Plane_Fighter_01_F', 'I_Ejection_Seat_Plane_Fighter_03_F', 'I_Ejection_Seat_Plane_Fighter_04_F', 'Land_Cargo10_yellow_F'] > 0";

["recycle", [_label, a3w_recycle, [], 0, true, true, "", _condition]] call mf_player_actions_set;

//Merge Crates
_label = format ["<img image='client\icons\merge.paa' color='#C280E5' /> <t color='#C280E5'> Merge Crates</t>", [], -7, false];
_condition = "player distance cursorTarget <= 6 && !(cursorTarget getVariable ['objectLocked', false]) && !(cursorTarget getVariable ['R3F_LOG_disabled', false]) && {cursorTarget isKindOf _x} count ['ReammoBox_F','I_CargoNet_01_ammo_F', 'O_CargoNet_01_ammo_F', 'B_CargoNet_01_ammo_F'] > 0";

["merge-crates", [_label, a3w_mergeCrates, [], 0, true, true, "", _condition]] call mf_player_actions_set;

//Mission markers
_label = "Reveal Mission Markers";
_condition = "player getVariable['STMissionMarkers', ''] == ''";

["reveal-missions", [_label, STRevealMissions, [], 0, true, true, "", _condition]] call mf_player_actions_set;


//Mission markers
_label = "Hide Mission Markers";
_condition = "player getVariable['STMissionMarkers', ''] != ''";
_code = {

	_id = player getVariable["STMissionMarkers", ""];

	if( _id != "" ) then {

		[_id, "onEachFrame"] call BIS_fnc_removeStackedEventHandler;

		player setVariable ["STMissionMarkers", nil];

	};

};																

["hide-missions", [_label, _code, [], 0, true, true, "", _condition]] call mf_player_actions_set;

//TODO: Can put stuff in here
//Land_ToolTrolley_02_F

