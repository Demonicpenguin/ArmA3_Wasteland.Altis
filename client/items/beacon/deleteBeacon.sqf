// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//@file Version: 1.0
//@file Name: deleteBeacon.sqf
//@file Author: LouD/Apoc
//@file Description: Delete a Spawn Beacon

_MaxSpawnbeacons = ceil (["A3W_maxSpawnBeacons", 3] call getPublicVar);
#define MAX_BEACONS format ["You cannot deploy more then %1 spawnbeacons.", [_MaxSpawnbeacons]]

_confirmMsg = MAX_BEACONS + format ["<br/>Press delete to remove a random spawnbeacon."];

_beacons = [];
{
	if (_x getVariable ["ownerUID",""] == getPlayerUID player) then
	{
		_beacons pushBack _x;
	};
} forEach pvar_spawn_beacons;

// Display confirm message
if ([parseText _confirmMsg, "DELETE BEACON", "Delete", true] call BIS_fnc_guiMessage) then {

	private _beacon = nil;

	{

		if( !(_x getVariable ["pinned", false]) ) exitWith { _beacon = _x; };

	} forEach _beacons;

	if( !(isNil "_beacon")) then {

		pvar_spawn_beacons = pvar_spawn_beacons - [_beacon];
		publicVariable "pvar_spawn_beacons";
		pvar_manualObjectDelete = [netId _beacon, _beacon getVariable "A3W_objectID"];
		publicVariableServer "pvar_manualObjectDelete";
		deleteVehicle _beacon;

		hint "One random beacon has been removed";

	} else {

		hint "Unable to delete an old spawn beacon, no unpinned beacon was found";

	};

	playSound 'FD_Finish_F';

};
