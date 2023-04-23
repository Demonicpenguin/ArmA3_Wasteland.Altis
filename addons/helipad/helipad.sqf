// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: Init.sqf
//	@file Author: The Scotsman
//	@file Description: Creates a helipad from a Pierbox

#include "..\..\STConstants.h"

#define PLAYER_CONDITION "(vehicle player == player && {!isNull cursorTarget})"
#define ITEM_CONDITION "{cursortarget iskindof 'Land_Pier_Box_F' && !(cursorTarget getVariable ['objectLocked', false]) } && {(player distance2D (getPosATL cursortarget)) < 5}" //Land_Pier_Box_F
#define OBJECT_CONDITION "{cursorTarget getVariable ['helipad', false]}"
#define OBJECT_CONDITION_UNSET "{!(cursorTarget getVariable ['helipad', false])}"
#define ITEM_CONDITION_REARM "{cursortarget iskindof 'Land_PortableGenerator_01_F' && count (nearestObjects [cursortarget, ['Land_Pier_Box_F'], 20, true]) > 0 }"

helipad_show = {

  private ["_helipad"];

  //Cleanup
  [] call helipad_hide;

  _helipad = cursorTarget;
  _helipad setVariable ["helipad", true, true];

  [_helipad] execVM "addons\helipad\decorate.sqf";

};

helipad_install_resupply = {

  private ["_helipad", "_helipads", "_resupply", "_position"];

  _helipads = nearestObjects [cursorObject, ["Land_Pier_Box_F"], 30, true]; //Land_Canal_Dutch_01_plate_F

  //No Helipads?
  if( count _helipads == 0 ) exitWith { hint "No Helipads are nearby"; };

  //Closest
  _helipad = _helipads select 0;

  //Not Decorated?
  if( !(_helipad getVariable ["helipad", false]) ) exitWith{ hint "No Helipads are nearby"; };

  //Already Installed?
  if( _helipad getVariable ["A3W_resupplyTruck", false] ) exitWith { hint "Closest helipad already has resupply installed"; };

  //Install Resupply
  _helipad setVariable ["password", "0000", true];
  _helipad setVariable ["lockedSafe", false, true];
  _helipad setVariable ["A3W_resupplyTruck", true, true];
  _helipad setVariable ["A3W_resupplyCount", 50, true];

  //Get Position & Size of Helipad
  _position = getPosASL _helipad;
  _box = boundingBoxReal _helipad;

  _height = abs (((_box select 1) select 2) - ((_box select 0) select 2));
  _length = abs (((_box select 1) select 1) - ((_box select 0) select 1));
  _width = abs (((_box select 1) select 0) - ((_box select 0) select 0));

  //Create resupply asset
  _resupply = createVehicle [ST_HELIPAD_REARM_INSTALLED, _position, [], 1, "NONE"];

  //Attach it to the helipad
  _resupply attachTo [_helipad, [(_width /2 - 1.5), -(_length / 2 - 1.5), _height / 2 - 1.2]];

  //Remove the module
  deleteVehicle cursorTarget;

  hint "Resupply has been installed in nearest helipad";

};

helipad_install_number = {

  private ["_number", "_box", "_texture", "_position", "_helipad", "_height"];

  _number = _this select 3 select 0;

  _helipad = cursorTarget;
  _helipad setVariable ["pad-number", _number, true];

  //If this helipad already has a pad number remove it
  {

    if( _x isKindOf "UserTexture_1x2_F" ) then {
      detach _x;
      deleteVehicle _x;
    };

  } forEach attachedObjects _helipad;

  _box = boundingBox _helipad;
  _height = abs (((_box select 1) select 2) - ((_box select 0) select 2));

  //Create the texture
  _position = getPosASL _helipad;
  _texture = createVehicle ["UserTexture_1x2_F", _position, [], 1, "NONE"];

  _texture attachTo [_helipad, [-6.7, -.68, _height/2 -1.19]];
  _texture setVectorDirAndUp [[ sin 0 * cos -90,cos -90 * cos -90,sin -90],[[ sin 0,-sin -90,cos 0 * cos -90],-90] call BIS_fnc_rotateVector2D];

  //Load it's Image
  _texture setObjectTextureGlobal [0, format["media\stencil%1.paa", _number]];

  _texture = createVehicle ["UserTexture_1x2_F", _position, [], 1, "NONE"];

  _texture attachTo [_helipad, [-6.7, .68, _height/2 -1.19]];
  _texture setVectorDirAndUp [[ sin 0 * cos -90,cos -90 * cos -90,sin -90],[[ sin 0,-sin -90,cos 0 * cos -90],-90] call BIS_fnc_rotateVector2D];

  //Load it's Image
  _texture setObjectTextureGlobal [0, "media\stencil0.paa"];

};

helipad_hide = {

  private _helipad = cursorTarget;

  {

    detach _x;
    deleteVehicle _x;

  } forEach attachedObjects _helipad;

  _helipad setVariable ["helipad", nil, true];
  _helipad setVariable ["pad-number", nil, true];

};

helipad_actions = {
	{ [player, _x] call fn_addManagedAction } forEach
	[
		["<t color='#FFFFFF'><img image='media\helipad.paa'/>Hide Helipad</t>", helipad_hide, [], -97, false, false, "", PLAYER_CONDITION + " && " + ITEM_CONDITION + " && " + OBJECT_CONDITION],
		["<t color='#FFFFFF'><img image='media\helipad.paa'/>Show Helipad</t>", helipad_show, [], -97, false, false, "", PLAYER_CONDITION + " && " + ITEM_CONDITION + " && " + OBJECT_CONDITION_UNSET],
    ["<t color='#FFE496'><img image='client\icons\keypad.paa'/>Install Helipad Resupply</t>", helipad_install_resupply, [], -97, false, false, "", PLAYER_CONDITION + " && " + ITEM_CONDITION_REARM],
    ["<t color='#FFFFFF'>Pad One</t>", helipad_install_number, [1], -97, false, false, "", PLAYER_CONDITION + " && " + ITEM_CONDITION + " && " + OBJECT_CONDITION],
    ["<t color='#FFFFFF'>Pad Two</t>", helipad_install_number, [2], -97, false, false, "", PLAYER_CONDITION + " && " + ITEM_CONDITION + " && " + OBJECT_CONDITION],
    ["<t color='#FFFFFF'>Pad Three</t>", helipad_install_number, [3], -97, false, false, "", PLAYER_CONDITION + " && " + ITEM_CONDITION + " && " + OBJECT_CONDITION],
    ["<t color='#FFFFFF'>Pad Four</t>", helipad_install_number, [4], -97, false, false, "", PLAYER_CONDITION + " && " + ITEM_CONDITION + " && " + OBJECT_CONDITION],
    ["<t color='#FFFFFF'>Pad Five</t>", helipad_install_number, [5], -97, false, false, "", PLAYER_CONDITION + " && " + ITEM_CONDITION + " && " + OBJECT_CONDITION],
    ["<t color='#FFFFFF'>Pad Six</t>", helipad_install_number, [6], -97, false, false, "", PLAYER_CONDITION + " && " + ITEM_CONDITION + " && " + OBJECT_CONDITION]
	];
};

HelipadInitialized = true;
