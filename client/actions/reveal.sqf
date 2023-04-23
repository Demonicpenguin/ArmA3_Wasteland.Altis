/*******************************************************************************************
* This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com
********************************************************************************************
* @file Name: revealMissions.sqf
* @author: The Scotsman
*
* Shows mission positions in the 3D world
*
*/

private ["_id"];

_id = format ["sss%1", (time + random 1000)];

player setVariable ["STMissionMarkers", _id];

[_id, "onEachFrame", {

  {
    _player = _this select 0;

    if (side _x == CIVILIAN) then {

      _marker = _x getVariable ["A3W_missionMarkerName", ""];
      _picture = _x getVariable["A3W_missionPicture", ""];
      _base = markerPos (_marker);
      _width = 1;

      if (["media\", _picture] call fn_startsWith) then {

        _picture = (call currMissionDir) + _picture;
        _width = 0.5;

      };

      _dist = _player distance2D _base;
      _text = format ["%1 (%2M)", (markerText _marker), [_dist] call fn_numbersText];
      _base set[2, 0];

      _top = + _base;
      _top set[2, 2000];

      drawLine3D [_base, _top, [0,0,0,1]];
      drawIcon3D [_picture, [0,0,0,1], _top, _width, 0.5, 0, (markerText _marker), 1, 0.035, "PuristaMedium"];

    };
  } forEach allGroups;

},[player]] call BIS_fnc_addStackedEventHandler;
