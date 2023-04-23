// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: Door_unlockDoor.sqf
//	@file Author: SoulStalker / Cael817 for original script
//	@file Description: Door script

private _Hanger = nearestObject [player, "Land_Airport_01_hangar_F"];

if (!isNil "_Hanger") then
{

	_Hanger animateSource ["Door_3_sound_source", 1]; 
	_Hanger animateSource ["Door_2_sound_source", 1];

	hint "Your Hangar door is opening";
} 
else 
{
	hint "No Hangar door found";
};	