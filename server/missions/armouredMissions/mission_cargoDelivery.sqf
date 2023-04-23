// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_cargoDelivery.sqf
//	@file Author: The Scotsman

if (!isServer) exitwith {};

#include "armouredMissionDefines.sqf";

#define REWARD 850000

private ["_stealCar", "_dropPos"];

_setupVars = {
	_missionType = "Breaking Bad";
};

_setupObjects = {
    _missionLocation = ["Race_1", "Race_2", "Race_3", "Race_4", "Race_5", "Race_6", "Race_7", "Race_8", "Race_9", "Race_10", "Race_11", "Race_12"] call bis_fnc_selectRandom;
    _dropLoc1 = ["dropOff_1","dropOff_2","dropOff_3","dropOff_4","dropOff_5","dropOff_6", "dropOff_7", "dropOff_8", "dropOff_9", "dropOff_10", "dropOff_11", "dropOff_12"] call bis_fnc_selectRandom;

	_missionPos = markerPos _missionLocation;
	_dropPos = markerPos _dropLoc1;
    _stealCar = createVehicle ["RHS_MELB_AH6M", _missionPos, [], 5, "None"];

	// added by soulkobk
	[_stealCar,_dropPos] spawn { // spawn new thread for activation of _dropPos marker once player is in _stealCar
		params ["_stealCar","_dropPos"];
		waitUntil { (!isNull (driver _stealCar)) || (!alive _stealCar)}; // this line waits until a unit is in the _stealCar or the _stealCar is dead/destroyed
		if (alive _stealCar) then // if _stealCar is still alive then create marker, else do nothing (exit thread).
		{
			_dropMarker = createMarker ["DropOff", _dropPos]; // create 'drop off' marker on _dropPos
			_dropMarker setMarkerType "hd_end";
			_dropMarker setMarkerShape "ICON";
			_dropMarker setMarkerSize [0.5, 0.5];
			_dropMarker setMarkerText "Destination for Cocaine";
			_dropMarker setMarkerColor "ColorRed";
		};
	};

	_missionPicture = "media\breakingBad.jpg";
	_missionHintText = format ["<br/>Walter White is expecting a 600 kg 'cargo', to be transported! <br/>Head to the <t color='%1'>Little Bird</t>, get in and fly the cargo to the marked location!", armouredMissionColor];
	playSound3D [call currMissionDir + "SFX\bb.ogg", player, false, getPosASL player, 1, 1, 50000];
};

_ignoreAiDeaths = true;
_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = {!alive _stealCar}; // changed by soulkobk - if vehicle is no longer alive (destroyed) then mission fail
_waitUntilSuccessCondition = {(_stealCar distance _dropPos) <5}; // if vehicle is less than 5 meters from the drop off position then mission successful

_failedExec = {

	{ deleteVehicle _x } forEach [_stealCar];
	deleteMarker "DropOff";

};

_successExec = {

	deleteMarker "DropOff";

	//Cash
	[_dropPos, REWARD] call STFixedCashReward;

  { deleteVehicle _x } forEach [_stealCar];

	_successHintMessage = "Well done! The cocaine has been delivered. Walter is proud of you!";
};

_this call armouredMissionProcessor;
