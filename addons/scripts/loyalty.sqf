// ******************************************************************************************
// * Copyright © 2019 Nurdism                                                               *
// ******************************************************************************************
// @file Author: Nurdism
// @file Name: loyalty.sqf
// @file description: Rewards players for their loyalty (continued play without reconnecting) the reward multiplies!

if (!hasInterface) exitWith {};

private ["_i", "_reward", "_base"];

waitUntil {sleep 0.1; !isNull player && ["playerSetupComplete", false] call getPublicVar};

_base = 5000; // Amopunt of money to dish out

_i = 0;
while {_i < 7} do {
	if ( _i == 1) then {
		_reward = (_base * (_i +1));
		[player, _reward] call A3W_fnc_setCMoney;
		hint parseText ([
			"<t color='#00DE00' shadow='2' size='1.75'>Loyalty Reward</t>",
			"<t color='#00DE00'>------------------------------</t>",
			format ["<t color='#FFFFFF' size='1.0'>%1 thank you for playing on the our Server! You've been rewarded with $%2</t>", name player, _reward]
		] joinString "<br/>");
		_i = 0;
	};
	uiSleep 1800;
	_i = _i + 1;
};