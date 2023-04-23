
params ["_position", ["_range", 400]];
private ["_road", "_roads", "_direction"];

_road = [_position, _range] call BIS_fnc_nearestRoad;
_roads = roadsConnectedTo _road;
_direction = [_road, (_roads select 0)] call BIS_fnc_DirTo;

[getPos _road, _direction]
