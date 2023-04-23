// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: Main.sqf
//	@file Author: The Scotsman
//	@file Description:

#include "defines.h"

#define PLAYER_CONDITION "((vehicle player == player || vehicle player != player) && {!isNull cursorTarget}) && player distance cursorTarget <= 5"
#define ITEM_CONDITION "typeOf cursortarget in ['Land_NetFence_01_m_pole_F']"

#define OBJECT_CONDITION_NODES "count (nearestObjects [cursorTarget, ['Land_NetFence_01_m_pole_F'], 4, true]) > 1"
#define OBJECT_CONDITION_LINE "((cursorTarget getVariable ['Draw3DID', '']) == '')"
#define OBJECT_CONDITION_GRID "((cursorTarget getVariable ['Draw3DGrid', '']) == '')"
#define OBJECT_CONDITION_RTANGLE "((cursorTarget getVariable ['Draw3DRTAngle', '']) == '')"
#define OBJECT_CONDITION_BOX "((cursorTarget getVariable ['Draw3DBox', '']) == '')"

builder_drawLine = { nul = execVM "addons\builder\drawLine.sqf"; };
builder_drawGrid = { nul = [] execVM "addons\builder\drawGrid.sqf"; };
builder_drawAngleGuide = { nul = [] execVM "addons\builder\drawAngleGuide.sqf"; };
builder_drawBoundingBox = { nul = [cursorTarget] execVM "addons\builder\drawBoundingBox.sqf"; };

builder_adjustRange = {

  params [["_increasing", false]];
  private ["_object", "_objects", "_range", "_index"];

  //Find Nearest Pole
  _objects = nearestObjects [player, [ST_BASE_BUILDER_TOOL], 50, true];

  _object = objNull;
  _object = { if( _x getVariable[DRAW3DGRID, ""] != "" || _x getVariable[DRAW3DBOX,""] != "" ) exitWith { _x }; } forEach _objects;

  if( !isNull _object ) then {

      _range = _object getVariable[DRAW3DRANGE, DRAW3DRANGE_DEFAULT];

      //Find Current Range Index
      _index = DRAW3DRANGES find _range;

      _index = [_index - 1, _index + 1] select (_increasing);

      _index = switch (true) do {
        case (_index < 0): { 0 };
        case (_index > (count DRAW3DRANGES) - 1): { _index - 1 };
        default { _index };
      };

      _object setVariable[DRAW3DRANGE, (DRAW3DRANGES select _index)];

  };

}call mf_compile;

builder_adjustSize = {

  params [["_increasing", false]];
  private ["_object", "_objects", "_size", "_index"];

  //Find Nearest Pole
  _objects = nearestObjects [player, [ST_BASE_BUILDER_TOOL], 50, true];

  _object = objNull;
  _object = { if( _x getVariable[DRAW3DGRID, ""] != "" ) exitWith { _x }; } forEach _objects;

  if( !isNull _object ) then {

      _size = _object getVariable[DRAW3DSIZE, DRAW3DSIZE_DEFAULT];

      //Find Current Size Index
      _index = DRAW3DSIZES find _size;

      _index = [_index - 1, _index + 1] select (_increasing);

      _index = switch (true) do {
        case (_index < 0): { 0 };
        case (_index > (count DRAW3DSIZES) - 1): { _index - 1 };
        default { _index };
      };

      _object setVariable[DRAW3DSIZE, (DRAW3DSIZES select _index)];

  };

} call mf_compile;

 builder_adjustColor = {



} call mf_compile;

builder_resolveBoundingBox = {

    private ["_object","_bb", "_bbx","_bby","_bbz", "_arr", "_y", "_z", "_array"];

    _object = _this;
    _array = (boundingBoxReal _object);

    _bbx = [_array select 0 select 0, _array select 1 select 0];
    _bby = [_array select 0 select 1, _array select 1 select 1];
    _bbz = [_array select 0 select 2, _array select 1 select 2];
    _arr = [];
    0 = {
        _y = _x;
        0 = {
            _z = _x;
            0 = {
                0 = _arr pushBack (_object modelToWorld [_x,_y,_z]);
            } count _bbx;
        } count _bbz;
        reverse _bbz;
    } count _bby;
    _arr pushBack (_arr select 0);
    _arr pushBack (_arr select 1);
    _arr
};

builder_setColor = {

  //WHITE [1,1,1,1]
  //BLACK  [0,0,0,1]
  //GREEN [0,0.8,0,1]
  //BLUE  [0,0,1,1]
  //RED [0.9,0,0,1]


  params ["_color"];
  private ["_cone"];

  _cone = cursorTarget;
  _cone setVariable ["Draw3DColor", _color];

} call mf_compile;

builder_hideTool = {

  private ["_object", "_tool", "_id"];

  _object = cursorTarget;
  _tool = _this select 3 select 0;
  _id = _object getVariable[_tool, ""];

  diag_log format ["[1ST:Hiding Drawing Tool:%1 ID:%2]", _tool, _id];

  if( _id != "" ) then { [_id, "onEachFrame"] call BIS_fnc_removeStackedEventHandler; };

  _object setVariable [_tool, nil];

  //Associated Object
  if( _tool == DRAW3DLINE ) then { _object setVariable [DRAW3DNODE, nil]; };

};

builder_Actions = {
	{ [player, _x] call fn_addManagedAction } forEach
	[
		["<t color='#31AD08'>Draw Line</t>", builder_drawLine, [], -97, false, false, "", PLAYER_CONDITION + " && " + ITEM_CONDITION + " && " + OBJECT_CONDITION_LINE + "&&" + OBJECT_CONDITION_NODES],
		["<t color='#BA150D'>Hide Line</t>", builder_hideTool, [DRAW3DLINE], -97, false, false, "", PLAYER_CONDITION + " && " + ITEM_CONDITION + " && !" + OBJECT_CONDITION_LINE],
    ["<t color='#31AD08'>Draw Grid</t>", builder_drawGrid, [], -97, false, false, "", PLAYER_CONDITION + " && " + ITEM_CONDITION + " && " + OBJECT_CONDITION_GRID],
    ["<t color='#BA150D'>Hide Grid</t>", builder_hideTool, [DRAW3DGRID], -97, false, false, "", PLAYER_CONDITION + " && " + ITEM_CONDITION + " && !" + OBJECT_CONDITION_GRID],
    ["<t color='#31AD08'>Draw Angle Guide</t>", builder_drawAngleGuide, [], -97, false, false, "", PLAYER_CONDITION + " && " + ITEM_CONDITION + " && " + OBJECT_CONDITION_RTANGLE],
    ["<t color='#BA150D'>Hide Angle Guide</t>", builder_hideTool, [DRAW3DANGLE], -97, false, false, "", PLAYER_CONDITION + " && " + ITEM_CONDITION + " && !" + OBJECT_CONDITION_RTANGLE],
    ["<t color='#31AD08'>Draw Bounding Box</t>", builder_drawBoundingBox, [], -97, false, false, "", PLAYER_CONDITION + " && " + ITEM_CONDITION + " && " + OBJECT_CONDITION_BOX],
    ["<t color='#BA150D'>Hide Bounding Box</t>", builder_hideTool, [DRAW3DBOX], -97, false, false, "", PLAYER_CONDITION + " && " + ITEM_CONDITION + " && !" + OBJECT_CONDITION_BOX]
	];
};

BuilderInitialized = true;
