// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1
//	@file Name: missionNavalConvoy.sqf
//	@file Author: The Scotsman
//	@file Created: 09/27/2018
//	@file Args: none

#include "marineMissionDefines.sqf"

if (!isServer) exitwith {};

private ["_boats", "_ships", "_helos", "_count", "_boxes", "_container", "_reward", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints"];

_setupVars = {
	_missionType = "Naval Cargo Convoy";
	_locationsArray = navalConvoyPaths;
};

_setupObjects = {

  private ["_starts", "_startDirs", "_waypoints"];
	call compile preprocessFileLineNumbers format ["mapConfig\convoys\%1.sqf", _missionLocation];

	_helos = [
				ST_BLACKFOOT,
				ST_KAJMAN,
				ST_APACHE,
				ST_APACHE_NORADAR,
				ST_APACHE_GREY
			];

  _boats = [
				"HAFM_CB90_BLU",
				"HAFM_CB90_BLU",
				"HAFM_CB90_BLU",
				"HAFM_CB90_BLU"
			];

  _ships = [
				"HAFM_ABurke",
				"HAFM_FREMM",
				"HAFM_Russen",
				"HAFM_Admiral",
				"HAFM_BUYAN"
			];

	_aiGroup = createGroup CIVILIAN;

  _vehicles = [];
  _vehicles set [0, ([ST_SHIP_SUPPLY, _starts select 0, _startDirs select 0, _aiGroup] call STCreateVehicle)];
  _vehicles set [1, ([(_boats call BIS_fnc_selectRandom), (getPos (_vehicles select 0)) vectorAdd ([[random 150, 0, 0], random 360] call BIS_fnc_rotateVector2D), _startDirs select 0, _aiGroup] call STCreateVehicle)];
  _vehicles set [2, ([(_helos call BIS_fnc_selectRandom), (getPos (_vehicles select 1)) vectorAdd ([[random 50, 0, 0], random 360] call BIS_fnc_rotateVector2D), _startDirs select 0, _aiGroup] call STCreateVehicle)];

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;

	_aiGroup setCombatMode "RED"; // units will defend themselves
	_aiGroup setBehaviour "COMBAT"; // units feel safe until they spot an enemy or get into contact
	_aiGroup setFormation "STAG COLUMN";

	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };

	_aiGroup setSpeedMode _speedMode;

	// behaviour on waypoints
	{
		_waypoint = _aiGroup addWaypoint [_x, 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 50;
		_waypoint setWaypointCombatMode "RED";
		_waypoint setWaypointBehaviour "COMBAT";
		_waypoint setWaypointFormation "STAG COLUMN";
		_waypoint setWaypointSpeed _speedMode;
	} forEach _waypoints;

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> (ST_SHIP_SUPPLY param [0,""]) >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> (ST_SHIP_SUPPLY param [0,""]) >> "displayName");

	_missionHintText = "A Naval convoy escorting a supply ship is making it's way along the coast. Intercept, sink them and recover the cargo!";

	_numWaypoints = count waypoints _aiGroup;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

//_vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome
_successExec = {

	["Naval Cargo Convoy Destroyed!!! You have 5 - 10 seconds to check the Map for the Cargo's Position.", 5] call mf_notify_client;
	
	//Random Reward
	_reward = [ST_ATCONVENIENCEKIT, ST_T140_ANGARA, ST_APACHE_GREY, ST_STATIC_AA, ST_STATIC_AT, ST_KAMYSH, ST_HUNTER_GMG, ST_COBRA, ST_LITTLE_BIRD, ST_PAWNEE, ST_T140_ANGARA, ST_KUMA, ST_TIGRIS, ST_AACONVENIENCEKIT, ST_MGS_RHINO_UP] call BIS_fnc_selectRandom;

	_helopos = _lastPos;
	
	_drypos = [];

	// Distance loop to find dry land position
	
	For "_i" from 0 to 3000 step 100 do
	{
		   // direction loop
	For "_y" from 0 to 360 step 40 do
	{
				_postest = [(_helopos select 0) + (sin _y) * _i, (_helopos  select 1) + (cos _y) * _i, 0];
				If !(surfaceIsWater _postest) exitwith
				{
					_drypos = _postest;
				};
		   };
		  If (!(_drypos isequalto [])) exitwith {};
	};

	//Random Crates
	_boxes = [_drypos, [2, 10]] call STRandomCratesReward;	
	
	// Mission completed
	_container = createVehicle ["Land_Cargo40_yellow_F", _drypos, [], 2, "NONE"];
	_container setDir random 360;
	_container setVariable ["moveable", true, true];
	_container allowDamage false;
	_container setVariable ["R3F_LOG_disabled", false, true];

	//Load reward crates into container
	nul = [_container, _boxes] execVM "addons\R3F_LOG\auto_load_in_vehicle.sqf";

	_container call STParaDropObject;

	[_container] spawn STPopCrateSmoke;
	
	_cargoPos = [getPos _container, 1, 50, 3, 0, 20, 0] call BIS_fnc_findSafePos;
	
	playSound3D [call currMissionDir + "media\alert.ogg", _container, false, getPosATL_container, 5, 1, 1000];	

	switch(true) do {
		case (_reward in [ST_ATCONVENIENCEKIT, ST_AACONVENIENCEKIT]): { //AA/AT Convenience Kit

			_box = [_drypos, _reward] call STCreateSpecialCrate;

	 	};
		default { //Vehicle

			_box = [_reward, _drypos] call createMissionVehicle;
			[_box, 1] call A3W_fnc_setLockState; // Unlock

		};
	};

	_box setPos _cargoPos;
	_box setVariable ["R3F_LOG_disabled", false, true];

	_box call STParaDropObject;

	//_m = createMarkerLocal ["Marker1", getPosATL _container];	
	_m = createMarkerLocal [format ["Cargo Position : %1",random 1000],getPosATL _container];
	_m setMarkerShapeLocal "ICON"; 
	_m setMarkerTypeLocal "mil_dot";
	_m setMarkerTextLocal "<<<<<< Cargo here";
	_m setMarkerColorLocal "ColorRed";

	uiSleep 2;

	for "_i" from 2 to 0 step -0.1 do
	{
	_m setMarkerAlphaLocal _i;
	uiSleep 1;
	};

	deleteMarkerLocal _m;	

	_successHintMessage = "The convoy has been stopped! Well done... That couldn't have been easy. Cargo has been placed along shore line close to your position, marked by purple smoke";
};

_this call marineMissionProcessor;
