// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: drawAngleGuide.sqf
//	@file Author: The Scotsman
//	@file Description: Draws a right angle reference

#include "defines.h"


private ["_object", "_id"];

_object = cursorTarget;
_id = format ["sss%1", (time + random 1000)];

//The Given Cone
_object setVariable [DRAW3DANGLE, _id];

[_id, "onEachFrame", {

  params["_object" ];
  private ["_box", "_height", "_color", "_range", "_zpos", "_dir", "_pos1", "_pos2"];

  //Calculate the height of the cone
  _dir = getDir _object;
  _box = boundingBoxReal _object;
  _height = abs (((_box select 1) select 2) - ((_box select 0) select 2));
  _color = DRAW3DCOLOR;
  _range = 8;

  _base = ASLToAGL getPosWorld _object;
  _zpos = (_base select 2) + getTerrainHeightASL(_base);

  _pos1 = [_base select 0, _base select 1, ((_base select 2) - _height * 4)];
  _pos2 = [_base select 0, _base select 1, ((_base select 2) + _height * 4)];

  drawLine3D [_pos1, _pos2, _color];

  _pos1 = _base getPos[_range, _dir];
  _pos2 = _base getPos[_range, _dir - 180];
  _pos1 set [2, _zpos - getTerrainHeightASL(_pos1)];
  _pos2 set [2, _zpos - getTerrainHeightASL(_pos2)];

  drawLine3D [_pos1, _pos2, _color];

  _pos1 = _base getPos[_range, _dir + 90];
  _pos2 = _base getPos[_range, _dir - 90];
  _pos1 set [2, _zpos - getTerrainHeightASL(_pos1)];
  _pos2 set [2, _zpos - getTerrainHeightASL(_pos2)];

  //Connect two offsets
  drawLine3D [_pos1, _pos2, DRAW3DCOLOR];

},[_object]] call BIS_fnc_addStackedEventHandler;
