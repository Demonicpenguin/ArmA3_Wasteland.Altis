// ******************************************************************************************
// * Copyright © 2019 Nurdism                                                               *
// ******************************************************************************************
// @file Author: Nurdism
// @file Name: init.sqf

MF_ITEMS_BUSHKIT = "bushkit";

mf_bushkit_use = [_this, "use.sqf"] call mf_compile;
mf_bushkit_equip = [_this, "equip.sqf"] call mf_compile;

[MF_ITEMS_BUSHKIT, "Bushkit", mf_bushkit_use, "Land_PaperBox_01_small_closed_brown_F", "client\icons\bushkit.paa", 1, true] call mf_inventory_create;

[
  "bushkit-remove", 
  [ "Remove Bushkit", { player setVariable ["bushkitOn", 0, true]; }, nil, 1, true, false, "", "player getVariable ['bushkitOn', 0] == 1" ]
] call mf_player_actions_set;

