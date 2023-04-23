private ["_player", "_playerPos"];

_player = _this select 0;
_playerPos = getPosATL _player;

private _closesttown = (nearestLocations [_player,["NameCityCapital","NameCity"],10000]) select 0;
private _pos = getPos _closesttown;
ATMmarker1 = createMarker ["atmHackLoc1", _pos];

ATMmarker1 setMarkerType "mil_objective";
ATMmarker1 setMarkerShape "ICON";
ATMmarker1 setMarkerSize [0.75, 0.75];
ATMmarker1 setMarkerText "Possible ATM Hacking Location";
ATMmarker1 setMarkerColor "ColorRed";

private _closesttown2 = (nearestLocations [_player,["NameCityCapital","NameCity"],10000]) select 1;
private _pos2 = getPos _closesttown2;
ATMmarker2 = createMarker ["atmHackLoc2", _pos2];

ATMmarker2 setMarkerType "mil_objective";
ATMmarker2 setMarkerShape "ICON";
ATMmarker2 setMarkerSize [0.75, 0.75];
ATMmarker2 setMarkerText "Possible ATM Hacking Location";
ATMmarker2 setMarkerColor "ColorRed";

["Hacking Started at an ATM near you!!! Approximate location is being uploaded to your map now.....","hint",true,true] call BIS_fnc_MP;