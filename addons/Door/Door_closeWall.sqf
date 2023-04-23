// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: Door_closeWall.sqf
//	@file Description: Close Wall Portal Panels

private ["_walls", "_wall"];

_walls = (nearestObjects [player, ["ContainmentArea_01_sand_F"], 40]);
_wall = nearestObject [player, "ContainmentArea_01_sand_F"];

if (!isNil "_walls") then
{
	{
		//[netId _x, true] call fn_hideObjectGlobal
		//[[_x, true], "A3W_fnc_hideObjectGlobal"] call A3W_fnc_MP;
		[_x, false] call fn_hideObjectGlobal;
	} forEach _walls;
	playSound3D [call currMissionDir + "media\hiss.ogg", _wall, true, getPosASL _wall, 2,1,60];	
	hint "Your Wall Portal is now closed";
} 
else 
{
	hint "No locked Wall Portal found";
};