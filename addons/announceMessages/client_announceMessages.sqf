// ******************************************************************************************
// * Copyright © 2019 Nurdism                                                               *
// ******************************************************************************************
// @file Author: Nurdism
// @file Name: announcements.sqf

if (!hasInterface) exitWith {};

private ["_announcements", "_i", "_l", "_announcement"];

waitUntil {sleep 0.1; !isNull player && ["playerSetupComplete", false] call getPublicVar};

_announcements = [
  "Hey %1, need an admin? Join the discord server at %2",
  "REMEMBER!!! to pay for the upkeep of your Base EVERY 29 days through BMS Menu or it will disappear", 
  "This server auto restarts every 6 hours to ensure optimal performance!",
  "If you are experiencing FPS drops (Hold Left shift and minus(-) On your NUMPAD and type FLUSH)",
  "We do NOT accept applications to become staff it is EARNED by playing on our servers!",
  "Hey %1, have a suggestion? Join the discord server at %2"
];

_i = 0; 
_l = (count _announcements) -1;

if (_l <= 0) exitWith {
  diag_log "[Announcements] No announcements, quiting...";
};

while {(true)} do {
  sleep 900; // Change to add more time in between messages
  
  _announcement = format [
    (_announcements select _i),   // text
    (name player),                // %1
    "https://discord.gg/XBJrA68"          // %2
  ];

  [_announcement, 5] call mf_notify_client;
  diag_log format [ "[Announcements] %1", _announcement];

  _i = _i + 1;
  if (_i > _l) then { _i = 0; };
}