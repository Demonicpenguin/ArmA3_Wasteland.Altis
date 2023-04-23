// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: drawBuildingGuides.sqf
//	@file Author: The Scotsman
//	@file Description: Draws a line between two builder objects

#include "defines.h"

private ["_object", "_objects", "_id"];

_object = cursorTarget;
_id = format ["sss%1", (time + random 1000)];

//Look for a companion
_objects = nearestObjects [_object, ["Land_NetFence_01_m_pole_F"], 4, true];

if( count _objects <= 1 ) exitWith { hint "No companion object found with 4 meters"; };

_object setVariable [DRAW3DLINE, _id];
_object setVariable [DRAW3DNODE, _objects select 1];

[_id, "onEachFrame", {

  params["_object" ];
  private ["_box", "_height", "_distance", "_base", "_posn", "_label", "_node"];

  //Calculate the height of the object
  _box = boundingBoxReal _object;
  _height = abs (((_box select 1) select 2) - ((_box select 0) select 2));

  _node = _object getVariable [DRAW3DNODE, ""];

  _base = ASLToAGL getPosWorld _object;
  _posn = ASLToAGL getPosWorld _node;

  //Vertical Line on base cone
  drawLine3D [[_base select 0, _base select 1, ((_base select 2) - (_height))], [_base select 0, _base select 1, ((_base select 2) + (_height))], DRAW3DCOLOR];

  //Vertical Line on target node
  drawLine3D [[_posn select 0, _posn select 1, ((_posn select 2) - (_height))], [_posn select 0, _posn select 1, ((_posn select 2) + (_height))], DRAW3DCOLOR];

  //Draw the line at the tip of the bounding box
  _base set [2, ((_base select 2) + (_height / 2))];
  _posn set [2, ((_posn select 2) + (_height / 2))];

  //Distance between objects
  _distance = _base distance2D _posn;

  //Line to each cone
  drawLine3D [_base, _posn, DRAW3DCOLOR];
  drawIcon3D ["", [1,1,1,1], _base, 0, 0, 0, format ["%1 M", _distance], 1, 0.04, "PuristaMedium"];

},[_object]] call BIS_fnc_addStackedEventHandler;
