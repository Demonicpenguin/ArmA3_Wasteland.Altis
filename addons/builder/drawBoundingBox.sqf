// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: drawBoundingBox.sqf
//	@file Author: The Scotsman, adapted from Killzone Kid
//	@file Description: Draws the bounding box of an object

#include "defines.h"

private ["_object", "_id"];

_id = format ["sss%1", (time + random 1000)];

_object = cursorTarget;
_object setVariable [DRAW3DBOX, _id];

[_id, "onEachFrame", {

  params["_object"];
  private ["_objects", "_box"];

  _objects = nearestObjects [_object, R3F_LOG_CFG_can_be_moved_by_player, 20, true];

  {

    _box = _x call builder_resolveBoundingBox;

    for "_i" from 0 to 7 step 2 do {
      drawLine3D [
          _box select _i,
          _box select (_i + 2),
          DRAW3DCOLOR
      ];
      drawLine3D [
          _box select (_i + 2),
          _box select (_i + 3),
          DRAW3DCOLOR
      ];
      drawLine3D [
          _box select (_i + 3),
          _box select (_i + 1),
          DRAW3DCOLOR
      ];
    };

  } forEach _objects;

},[_object]] call BIS_fnc_addStackedEventHandler;
