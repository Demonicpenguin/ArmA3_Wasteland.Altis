// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: Door_closeRoof.sqf
//	@file Description: Close Roof Panels

private ["_roofs", "_roof"];

_roofs = (nearestObjects [player, ["ContainmentArea_01_forest_F"], 40]);
_roof = nearestObject [player, "ContainmentArea_01_forest_F"];

if (!isNil "_roofs") then
{
	{
		//[netId _x, false] call fn_hideObjectGlobal
		//[[_x, false], "A3W_fnc_hideObjectGlobal"] call A3W_fnc_MP;
		[_x, false] call fn_hideObjectGlobal;
	} forEach _roofs;
	playSound3D [call currMissionDir + "media\hiss.ogg", _roof, true, getPosASL _roof, 2,1,60];	
	hint "Your roof is now closed";
}
else 
{
	hint "No locked roof found";
};