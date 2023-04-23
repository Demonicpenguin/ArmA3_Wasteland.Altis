// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: Door_unlockDoor.sqf
//	@file Author: LouD / Cael817 for original script
//	@file Description: Door script

private ["_doors"];
_doors = (nearestObjects [player, ["Land_Canal_Wall_10m_F"], 10]);

if (!isNil "_doors") then
{
	{
		//[netId _x, true] call fn_hideObjectGlobal
		//[[_x, true], "A3W_fnc_hideObjectGlobal"] call A3W_fnc_MP;
		[_x, true] call fn_hideObjectGlobal;
	} forEach _doors;
	hint "Your door is opened";
} 
else 
{
	hint "No locked door found";
};