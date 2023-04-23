// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: drawGrid.sqf
//	@file Author: The Scotsman
//	@file Description: Draws a 1M X 1M Grid for 25 meters

#include "defines.h"

private ["_object", "_id"];

//The target object
_object = cursorTarget;
_id = format ["sss%1", (time + random 1000)];

_object setVariable [DRAW3DGRID, _id];

[_id, "onEachFrame", {

  params["_object" ];
  private ["_box", "_height", "_base", "_dir", "_size", "_range", "_color", "_pos1", "_pos2", "_zpos"];

  //Calculate the height of the cone
  _dir = getDir _object;
  _box = boundingBoxReal _object;
  _height = abs (((_box select 1) select 2) - ((_box select 0) select 2));
  _range = _object getVariable[DRAW3DRANGE, DRAW3DRANGE_DEFAULT];
  _size = _object getVariable[DRAW3DSIZE, DRAW3DSIZE_DEFAULT];
  _color = DRAW3DCOLOR;

  _base = ASLToAGL getPosWorld _object;
  _zpos = (_base select 2) + getTerrainHeightASL(_base);

  _pos1 = [_base select 0, _base select 1, ((_base select 2) - _height * 4)];
  _pos2 = [_base select 0, _base select 1, ((_base select 2) + _height * 4)];

  //Vertical Line on base cone - Do this just to find the cone
  drawLine3D [_pos1, _pos2, _color];

   _pos1 = + _base;

  //Set "y" position offset
  _pos2 = _pos1 getPos[_range, _dir];
  _pos2 set[2, _zpos - getTerrainHeightASL(_pos2)];

  _dir = _dir - 90;

  for "_x" from 0 to _range step _size do {

    //Line to each cone
    drawLine3D [_pos1, _pos2, _color];

    _pos1 = _pos1 getPos [_size, _dir];
    _pos2 = _pos2 getPos [_size, _dir];

    _pos1 set [2, _zpos - getTerrainHeightASL(_pos1)];
    _pos2 set [2, _zpos - getTerrainHeightASL(_pos2)];

  };

  _pos1 = + _base;
  _pos2 = _base getPos [_range, _dir];
  _pos2 set [2, _zpos - getTerrainHeightASL(_pos2)];

  _dir = _dir + 90;

  for "_y" from 0 to _range step _size do {

    //Line to each cone
    drawLine3D [_pos1, _pos2, _color];

    _pos1 = _pos1 getPos [_size, _dir];
    _pos2 = _pos2 getPos [_size, _dir];

    _pos1 set [2, _zpos - getTerrainHeightASL(_pos1)];
    _pos2 set [2, _zpos - getTerrainHeightASL(_pos2)];

  };

  drawIcon3D ["", [1,1,1,1], _base, 0, 0, 0, format ["Grid %1M (X %2)", _range,_size], 1, 0.04, "PuristaMedium"];

},[_object]] call BIS_fnc_addStackedEventHandler;
