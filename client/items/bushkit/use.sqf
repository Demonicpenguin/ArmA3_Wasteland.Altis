// ******************************************************************************************
// * Copyright © 2019 Nurdism                                                               *
// ******************************************************************************************
// @file Author: Nurdism
// @file Name: use.sqf

#define DURATION 3
#define ANIMATION "AinvPknlMstpSlayWrflDnon_medic"
#define ERR_NO_PLAYER "You are not close enough to a player."
#define ERR_IN_VEHICLE "You can't do this while in a vehicle."
#define ERR_NO_BUSHKIT "You don't have a bushkit!"
#define ERR_CANCELLED "Creating Bushkit cancelled!"
#define ERR_EQUIPED "You already have a bushkit equiped!"
#define HACK_COMPLETE "Creating Bushkit complete!"
#define ITEM_COUNT(ITEMID) ITEMID call mf_inventory_count

_checks = {
	private ["_progress", "_failed", "_text"];
	_progress = _this select 0;
	_text = "";
	_failed = true;
	switch (true) do {
		case (!alive player): {};
    case (vehicle player != player):{_text = ERR_IN_VEHICLE};
    case (player getVariable ['bushkitOn', 0] == 1): {_text = ERR_EQUIPED; };
    case (ITEM_COUNT(MF_ITEMS_BUSHKIT) <= 0): { _text = ERR_NO_BUSHKIT; };
    case (doCancelAction): {_text = ERR_CANCELLED; doCancelAction = false;};
		default {
			_text = format["Creating Bushkit %1%2 Complete", round(100 * _progress), "%"];
			_failed = false;
		};
	};
	[_failed, _text];
};

_success = [DURATION, ANIMATION, _checks, []] call a3w_actions_start;

if (_success) then {
	player spawn mf_bushkit_equip;
};

_success;