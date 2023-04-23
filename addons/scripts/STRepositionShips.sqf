// ***************************************************  ***************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: STRepositionShips.sqf
//	@file Author: The Scotsman
//	@file Description:

#include "..\..\STConstants.h"

#define SHIPS [ST_CARRIER, ST_DESTROYER, ST_SUBMARINE]
#define ICONS ["media\carrier.paa", "media\destroyer.paa", "media\submarine.paa"]
#define INTERVALS [30,40,45,55,60,90,120]
#define MARKERS ["TERRITORY_CARRIER", "TERRITORY_DESTROYER", "TERRITORY_SUBMARINE"]

if( !isServer ) exitWith {};

private ["_ship", "_time", "_vehicle", "_index", "_icon", "_name", "_grid", "_positions", "_trigger"];

if (isNil "ST_ShipMarkers") then {

  _count = 0;

  ST_ShipMarkers = [];

	{

		if (["ship_", _x] call fn_startsWith) then {

			ST_ShipMarkers pushBack markerPos _x;
	    _count = _count + 1;

    };

  } forEach allMapMarkers;

  diag_log format["[1ST]: Loaded %1 ship locations", _count];

};

_positions = [];

{

  _position = selectRandom ST_ShipMarkers;

  while{ _position in _positions} do { _position = (selectRandom ST_ShipMarkers); };

  _vehicle = createVehicle [_x, _position, [], 0, "NONE"];

  _vehicle setPosWorld _position;
  _vehicle setDir 90;
  _vehicle enableSimulationGlobal true;

  [_vehicle] call BIS_fnc_Carrier01PosUpdate;

  // Broadcast Carrier ID over network
  missionNamespace setVariable [_x, _vehicle]; publicVariable _x;

  _positions set [_forEachIndex, _position];

  //Move the marker
  _mark = (MARKERS select _forEachIndex);
  _mark setMarkerPos _position;
  _mark setMarkerDir 90;

  diag_log format["[1ST]: Setting Initial Position of:%1 to %2", _x, _position];

  private _triggers = allMissionObjects "EmptyDetector";

  _trigger = {

    if( (_x getVariable ["captureTriggerMarker", ""]) == _mark ) exitWith{ _x; };

  } forEach _triggers;

  diag_log format["Moving Trigger:%1 for Marker:%2", _trigger, _mark];

  //Reposition the trigger
  _trigger setPos _position;

} forEach SHIPS;

//Initial interval 90 minutes from now
_time = time + (selectRandom INTERVALS) * 60;
//_time = 60;

while {true} do {

  if( time >= _time ) then {

    //Select at random a new position
    _position = selectRandom ST_ShipMarkers;

    //Make sure the position isn't occupied
    while{ _position in _positions} do { _position = selectRandom ST_ShipMarkers; };

    //The ship that's going to move
    _ship = selectRandom SHIPS;

    //Entry location in the positions array
    _index = switch (_ship) do {
      case (ST_CARRIER): { 0 };
      case (ST_DESTROYER): { 1 };
      case (ST_SUBMARINE): { 2 };
    };

    _icon = ICONS select _index;
    _name = getText (configFile >> "CfgVehicles" >> _ship >> "displayName");
    _grid = (mapGridPosition _position);
    _mark = (MARKERS select _index);

    //Give a warning the the ship is moving
    [format [
    		"<t color='%5' shadow='2' size='1.75'>%1</t><br/>" +
    		"<t color='%5'>--------------------------------</t><br/>" +
    		"<t size='1.1'>%2</t><br/>" +
        "<t size='.15'> </t><br/>" +
    		"<img size='3' image='%3'/><br/>" +
        "<t size='.15'> </t><br/>" +
    		"%4",
    		"Warning",
    		"A ship is repositioning in 5 minutes",
    		_icon,
    		_name,
    		"#BA150D"
    	]] call hintBroadcast;

    //Sleep for 5 minutes
    uiSleep 300;
    //uiSleep 5;

    _vehicle = missionNamespace getVariable [_ship, objNull];
    _vehicle setPosWorld _position;
    _vehicle setDir 90; // North

    [_vehicle] call BIS_fnc_Carrier01PosUpdate;

    //Broadcast new Position
    missionNamespace setVariable [_ship, _vehicle]; publicVariable _ship;

    diag_log format["[1ST]: Moving %1 to %2", _name, _position];

    //Update the position data
    _positions set [_index, _position];

    //Move the marker
    _mark setMarkerPos _position;
    _mark setMarkerDir 90;

    _entry = {

      if( _x select 0 == _mark ) exitWith { _x; };

    } forEach currentTerritoryDetails;

    //Flag the zone as uncapped
    _entry set [1, []];
    _entry set [2, sideUnknown];
    _entry set [3, 0];
    _entry set [4, 0];

    _owner = {

      if( _x select 0 == _mark ) exitWith { _x; };

    } forEach A3W_currentTerritoryOwners;

    _owner set [1, sideUnknown];

    private _triggers = allMissionObjects "EmptyDetector";

    _trigger = {

      if( (_x getVariable ["captureTriggerMarker", ""]) == _mark ) exitWith{ _x; };

    } forEach _triggers;

    diag_log format["Moving Trigger:%1 for Marker:%2", _trigger, _mark];

    //Reposition the trigger
    _trigger setPos _position;

    publicVariable "A3W_currentTerritoryOwners";

    //TODO: Anything I need to do to the ship (like static guns);

    //Notify that the ship has moved
    [format [
    		"<t color='%5' shadow='2' size='1.75'>%1</t><br/>" +
    		"<t color='%5'>--------------------------------</t><br/>" +
    		"<t size='1.1'>The %2 has repositioned to %4</t><br/>" +
        "<t size='.15'> </t><br/>" +
    		"<img size='3' image='%3'/><br/>" +
        "<t size='.15'> </t><br/>" +
        "Territory is now available to be captured",
    		"Repositioning Complete",
    		_name,
    		_icon,
    		_grid,
    		"#31AD08"
    	]] call hintBroadcast;

    playSound 'FD_Finish_F';

      //TODO: Lookup BIS_fnc_infoText
      _time = time + (selectRandom INTERVALS) * 60;
      //_time = 30;

  };

  uiSleep 120;

};
