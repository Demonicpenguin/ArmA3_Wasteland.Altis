// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: ohcanada.sqf
//	@file Author: The Scotsman
//	@file Description: Plays O Canada on all speakers

//if( isServer ) exitWith {};

player playActionNow "Salute";

nul = [MISSION_ROOT + "media\ANA.ogg"] execVM "client\actions\playOnAllSpeakers.sqf";

sleep 20;

player playActionNow "saluteOff";
