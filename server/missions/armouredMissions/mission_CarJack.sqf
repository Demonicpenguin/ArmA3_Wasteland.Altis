// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 2
//	@file Name: mission_Escobar.sqf
//	@file Author: Spectryx
//	@file Tanoa Edit: GriffinZS, soulkobk
//	@file Created: Sep 2016

#include "armouredMissionDefines.sqf";

if (!isServer) exitwith {};

private ["_missionVehicle", "_dropOffPos", "_vehicles", "_waypoint", "_leader", "_vehicleName", "_type", "_vehicle", "_count"];

_setupVars = {
		_missionType = "Car Jacking";
};

_setupObjects = {

	_missionLocation = selectRandom ["Race_1", "Race_2", "Race_3", "Race_4", "Race_5", "Race_6", "Race_7", "Race_8", "Race_9", "Race_10", "Race_11", "Race_12"];
  _dropOffLocation = selectRandom ["dropOff_1", "dropOff_2", "dropOff_3", "dropOff_4", "dropOff_5", "dropOff_6", "dropOff_7", "dropOff_8", "dropOff_9", "dropOff_10", "dropOff_11", "dropOff_12"];

	_missionPos = markerPos _missionLocation;
	_dropOffPos = markerPos _dropOffLocation;

	_vehicles = [];

	_aiGroup = createGroup CIVILIAN;

	_missionVehicle = [ST_VAN_CARGO, _missionPos, 0, _aiGroup] call STCreateVehicle;

	_vehicles pushBack _missionVehicle;
	_type = selectRandom [ST_QLIN_MINI, ST_PROWLER_MG, ST_QLIN_AT, ST_PROWLER_AT];

	_count = [1,3] call BIS_fnc_randomInt;

	for "_x" from 1 to _count do {

		diag_log format["[1ST] CarJack type:%1", _type];

		_vehicle = [_type, _missionPos, 0, _aiGroup, ST_DELTA] call STCreateVehicle;

		_vehicles pushBack _vehicle;

	};

	{

		//Color
		[_x, "Black", nil] call bis_fnc_initVehicle;

	} forEach _vehicles;

	//Add Some Extra Dudes
	while { _missionVehicle emptyPositions "cargo" > 0 } do { ([_missionPos, _aiGroup, ST_DELTA] call STCreateUnit) moveInCargo _missionVehicle; };

	_leader = effectiveCommander _missionVehicle;

	_aiGroup setCombatMode "YELLOW";
	_aiGroup setBehaviour "AWARE";
	_aiGroup setFormation "COLUMN";
	_aiGroup selectLeader _leader;

	_waypoint = _aiGroup addWaypoint [_dropOffPos, 0];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointCompletionRadius 10;
	_waypoint setWaypointCombatMode "YELLOW";
	_waypoint setWaypointBehaviour "AWARE";
	_waypoint setWaypointFormation "COLUMN";
	_waypoint setWaypointSpeed "NORMAL";

	_missionPicture = getText (configFile >> "CfgVehicles" >> ST_VAN_CARGO >> "picture");

	// added by soulkobk
	[_missionVehicle, _dropOffPos] spawn { // spawn new thread for activation of _dropOffPos marker once player is in _missionVehicle

		params ["_missionVehicle","_dropOffPos"];

		waitUntil {(!isNull (driver _missionVehicle)) || (!alive _missionVehicle)}; // this line waits until a unit is in the driver seat of _missionVehicle or the _missionVehicle is dead/destroyed

		_vehName = gettext (configFile >> "CfgVehicles" >> (typeOf vehicle _missionVehicle) >> "displayName"); // get vehicle display name eg, 'MB 4WD'

		if (alive _missionVehicle) then {

			_dropMarker = createMarker ["DropOff", _dropOffPos]; // create 'drop off' marker on _dropOffPos
			_dropMarker setMarkerType "mil_objective";
			_dropMarker setMarkerShape "ICON";
			_dropMarker setMarkerSize [0.75, 0.75];
			_dropMarker setMarkerText "Car Jacking - Destination";
			_dropMarker setMarkerColor "ColorGreen";

			//hint format ["THE STEALCAR %1\nHAS A DRIVER %2, CHECK MAP!",_vehName, name (driver _missionVehicle)]; // you don't really need this line, delete it.

		} else {

			hint format ["THE STEALCAR %1\nWAS DESTROYED!\nMISSION FAILED!",_vehName];

		};

		waitUntil {(!alive _missionVehicle)}; // waits for the vehicle to not exist anymore (destroyed or successful mission)
		deleteMarker "DropOff"; // deletes the "DropOff" _dropMarker (see above line)

	};

	_missionHintText = format ["A cargo van is transporting an unknown amount of cash, hijack the vehicle and deliver it to it's destination marker.", armouredMissionColor];

};

_ignoreAiDeaths = true;
_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = {!alive _missionVehicle || (_leader distance _dropOffPos) < 15 }; // changed by soulkobk - if vehicle is no longer alive (destroyed) then mission fail
_waitUntilSuccessCondition = {(_missionVehicle distance _dropOffPos) < 8}; // if vehicle is less than 5 meters from the drop off position then mission successful

_failedExec = {
	{ deleteVehicle _x } forEach [_missionVehicle];
	deleteMarker "DropOff";
};

_successExec = {

	[_dropOffPos, [100000, 200000, 300000, 400000]] call STRandomCashReward;

	deleteMarker "DropOff";

	_successHintMessage = "Well done, You have delivered as promised! Take your reward.";

};

_this call armouredMissionProcessor;
