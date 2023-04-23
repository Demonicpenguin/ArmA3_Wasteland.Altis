// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: decorate.sqf
//	@file Author: The Scotsman
//	@file Description: Decorates a PierBox as a helipad

#include "..\..\STConstants.h"

#define HELIPAD_EDGE_LIGHT "Land_runway_edgelight_blue_F"
#define HELIPAD_FLUSH_LIGHT "Land_Flush_Light_green_F"
#define HELIPAD_TEXTURE "UserTexture10m_F"
#define HELIPAD_WINDSOCK "Windsock_01_F"

params ["_helipad"];

private ["_box", "_position", "_texture", "_length", "_width", "_height", "_light", "_distance", "_resupply"];

//Helipad Bounding Box
_box = boundingBoxReal _helipad;

_height = abs (((_box select 1) select 2) - ((_box select 0) select 2));
_length = abs (((_box select 1) select 1) - ((_box select 0) select 1));
_width = abs (((_box select 1) select 0) - ((_box select 0) select 0));

//Helipad Location
_position = getPosASL _helipad;

//Create the texture
_texture = createVehicle [HELIPAD_TEXTURE, _position, [], 1, "NONE"];

_texture setObjectTextureGlobal [0, "A3\Structures_F\Mil\Helipads\Data\HelipadCircle_CA.paa"];

//Landng Circle
_texture attachTo [_helipad, [0,0, _height / 2 - 1.19]];

//Pitch the texture 90 degrees
//[_texture, -90, 0] call BIS_fnc_setPitchBank;
_texture setVectorDirAndUp [[ sin 0 * cos -90,cos -90 * cos -90,sin -90], [[ sin 0,-sin -90,cos 0 * cos -90],-90] call BIS_fnc_rotateVector2D];

if( _helipad getVariable ["A3W_resupplyTruck", false] ) then {

  //Create resupply asset
  _resupply = createVehicle [ST_HELIPAD_REARM_INSTALLED, _position, [], 1, "NONE"];

  //Attach it to the helipad
  _resupply attachTo [_helipad, [(_width /2 - 1.5), -(_length / 2 - 1.5), _height / 2 - 1.2]];

};

if( _helipad getVariable["pad-number", 0] > 0 ) then {

  //Create the texture
  _texture = createVehicle ["UserTexture_1x2_F", _position, [], 1, "NONE"];

  _texture attachTo [_helipad, [-6.7, -.68, _height/2 -1.19]];
  _texture setVectorDirAndUp [[ sin 0 * cos -90,cos -90 * cos -90,sin -90],[[ sin 0,-sin -90,cos 0 * cos -90],-90] call BIS_fnc_rotateVector2D];

  //Load it's Image
  _texture setObjectTextureGlobal [0, format["media\stencil%1.paa", (_helipad getVariable["pad-number", 0])]];

  _texture = createVehicle ["UserTexture_1x2_F", _position, [], 1, "NONE"];

  _texture attachTo [_helipad, [-6.7, .68, _height/2 -1.19]];
  _texture setVectorDirAndUp [[ sin 0 * cos -90,cos -90 * cos -90,sin -90],[[ sin 0,-sin -90,cos 0 * cos -90],-90] call BIS_fnc_rotateVector2D];

  //Load it's Image
  _texture setObjectTextureGlobal [0, "media\stencil0.paa"];

};

_height = _height / 2 - 1.125;

_light = createVehicle [HELIPAD_EDGE_LIGHT, _position, [], 1, "NONE"];
_light attachTo [_helipad, [-(_width /2 - .7),-(_length / 2 - 1.5), _height]];

_light = createVehicle [HELIPAD_EDGE_LIGHT, _position, [], 1, "NONE"];
_light attachTo [_helipad, [_width /2 - .7,-(_length / 2 - 1.5), _height]];

_light = createVehicle [HELIPAD_EDGE_LIGHT, _position, [], 1, "NONE"];
_light attachTo [_helipad, [-(_width / 2 - .7),_length / 2 - .7, _height]];

_light = createVehicle [HELIPAD_EDGE_LIGHT, _position, [], 1, "NONE"];
_light attachTo [_helipad, [_width /2 - .7,_length / 2 - .7, _height]];

_width = _width / 2.5;

for "_x" from 0 to 3 do {

  _light = createVehicle [HELIPAD_FLUSH_LIGHT, _position, [], 1, "NONE"];

  _offsetx = [0, 0, _width, -_width] select (_x / 1);
  _offsety = [_width, -_width, 0, 0] select (_x / 1);

  _light attachTo [_helipad, [_offsetx, _offsety, _height - .07]];

};

//Axis Lights
_width = sqrt ((_width * _width) / 2);

for "_x" from 0 to 3 do {

  _light = createVehicle [HELIPAD_FLUSH_LIGHT, _position, [], 1, "NONE"];

  _offsetx = [_width, -_width, -_width, _width] select (_x / 1);
  _offsety = [_width, -_width, _width, -_width] select (_x / 1);

  _light attachTo [_helipad, [_offsetx, _offsety, _height - .07]];

};
