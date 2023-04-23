// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: playOnAllSpeakers.sqf
//	@file Author: The Scotsman
//	@file Description: Plays a sound file on all speakers within a radius

//if( isServer ) exitWith {};

params ["_source", ["_target", cursorTarget], ["_radius", 100], ["_repeats", 0]];

private _speakers = nearestObjects [_target, ["Land_Loudspeakers_F"], _radius];

if( count _speakers == 0 ) then { _speakers pushBack _target; };

for "_x" from 0 to _repeats do {

  {
	If (cursortarget iskindof 'Flag_US_F') then
	{
		playSound3D [call currMissionDir + "media\ANA.ogg", _x, false, _x, 3];
	};
	If (cursortarget iskindof 'Flag_Green_F') then
	{
		playSound3D [call currMissionDir + "media\STB.ogg", _x, false, _x, 3];
	};
	If (cursortarget iskindof 'Flag_UK_F') then
	{
		playSound3D [call currMissionDir + "media\GsoQ.ogg", _x, false, _x, 3];
	};
	If (cursortarget iskindof 'Flag_Blue_F') then
	{
		playSound3D [call currMissionDir + "media\rainbow.ogg", _x, false, _x, 3];
	};
	If (cursortarget iskindof 'Flag_Red_F') then
	{
		playSound3D [call currMissionDir + "media\ohcanada.ogg", _x, false, _x, 3];
	};
	If (cursortarget iskindof 'Flag_UNO_F') then
	{
		playSound3D [call currMissionDir + "media\swiss.ogg", _x, false, _x, 3];
	};		
	If (cursortarget iskindof 'Flag_Fuel_F') then
	{
		playSound3D [call currMissionDir + "media\germany.ogg", _x, false, _x, 3];
	};	
    //playSound3D [_source, _x, false, _x, 3];
  } forEach _speakers;

  sleep 5;

};