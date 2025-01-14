// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 2.1
//	@file Name: mission_ArmedPatrol.sqf
//	@file Author: JoSchaap / routes by Del1te - (original idea by Sanjo), AgentRev
//	@file Created: 31/08/2013 18:19
//	@file Modified: [FRAC] Mokey
//	@file missionSuccessHandler Author: soulkobk

if (!isServer) exitwith {};
#include "armouredMissionDefines.sqf";

private ["_Patrol", "_convoys", "_vehChoices", "_vehClasses", "_createVehicle", "_vehicles", "_veh2", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints", "_box1", "_box2", "_box3", "_Mortar"];

_setupVars =
{
	// _locationsArray = nil;

	// Patrol settings
	// Difficulties : Min = 1, Max = infinite
	// Convoys per difficulty : Min = 1, Max = infinite
	// Vehicles per convoy : Min = 1, Max = infinite
	// Choices per vehicle : Min = 1, Max = infinite
	_Patrol =
	[
		// Medium
		[
			"APC Patrol", // Marker text
			[
				[ // Tracked convoy 1
					["O_APC_Tracked_02_cannon_F", "I_APC_tracked_03_cannon_F"], // Veh 1
					["B_APC_Tracked_01_rcws_F", "I_APC_tracked_03_cannon_F"], // Veh 2
					["O_APC_Tracked_02_cannon_F", "I_APC_tracked_03_cannon_F"] // Veh 3
				],
				[ // Wheeled convoy
					["B_APC_Wheeled_01_cannon_F", "I_APC_Wheeled_03_cannon_F"], // Veh 1
					["B_APC_Wheeled_01_cannon_F", "O_APC_Wheeled_02_rcws_F"], // Veh 2
					["B_APC_Wheeled_01_cannon_F", "I_APC_Wheeled_03_cannon_F"] // Veh 4
				],
				[ // Tracked Convoy 2
					["O_APC_Tracked_02_cannon_F", "I_APC_tracked_03_cannon_F"], // Veh 1
					["O_APC_Tracked_02_cannon_F", "B_APC_Tracked_01_CRV_F"], // Veh 2
					["O_APC_Tracked_02_cannon_F", "I_APC_tracked_03_cannon_F"] // Veh 3
				]
			]
		],
		// Hard
		[
			"Armored Patrol", // Marker text
			[
				[ // Tracked convoy 1
					["O_APC_Tracked_02_cannon_F", "I_APC_tracked_03_cannon_F"], // Veh 1
					["I_MBT_03_cannon_F", "O_MBT_02_cannon_F"], // Veh 2
					["O_APC_Tracked_02_cannon_F", "I_APC_tracked_03_cannon_F"] // Veh 3
				],
				[ // Wheeled convoy
					["B_APC_Wheeled_01_cannon_F", "I_APC_Wheeled_03_cannon_F"], // Veh 1
					["B_APC_Wheeled_01_cannon_F", "O_APC_Wheeled_02_rcws_F"], // Veh 2
					["B_APC_Wheeled_01_cannon_F", "I_APC_Wheeled_03_cannon_F"] // Veh 4
				],
				[ // Tracked Convoy 2
					["O_APC_Tracked_02_cannon_F", "I_APC_tracked_03_cannon_F"], // Veh 1
					["B_MBT_01_cannon_F", "B_MBT_01_TUSK_F" ], // Veh 2
					["O_APC_Tracked_02_cannon_F", "I_APC_tracked_03_cannon_F"] // Veh 3
				]
			]
		],
		// Extreme
		[
			"Anti Air Patrol", // Marker text
			[
				[ // Tracked convoy 1
					["O_APC_Tracked_02_cannon_F", "I_APC_tracked_03_cannon_F"], // Veh 1
					["B_APC_Tracked_01_AA_F", "B_APC_Tracked_01_AA_F"], // Veh 2
					["O_APC_Tracked_02_cannon_F", "I_APC_tracked_03_cannon_F"] // Veh 3
				],
				[ // Wheeled convoy
					["B_APC_Wheeled_01_cannon_F", "I_APC_Wheeled_03_cannon_F"], // Veh 1
					["B_APC_Tracked_01_AA_F", "B_APC_Tracked_01_AA_F"], // Veh 2
					["B_APC_Wheeled_01_cannon_F", "I_APC_Wheeled_03_cannon_F"] // Veh 4
				],
				[ // Tracked Convoy 2
					["O_APC_Tracked_02_cannon_F", "I_APC_tracked_03_cannon_F"], // Veh 1
					["O_APC_Tracked_02_AA_F", "O_APC_Tracked_02_AA_F"], // Veh 2
					["O_APC_Tracked_02_cannon_F", "I_APC_tracked_03_cannon_F"] // Veh 3
				]
			]
		]
	]
	call BIS_fnc_selectRandom;

	_missionType = _Patrol select 0;
	_convoys = _Patrol select 1;
	_vehChoices = _convoys call BIS_fnc_selectRandom;


	_vehClasses = [];
	{ _vehClasses pushBack (_x call BIS_fnc_selectRandom) } forEach _vehChoices;
};

_setupObjects =
{
	private ["_starts", "_startDirs", "_waypoints"];
	// call compile preprocessFileLineNumbers format ["mapConfig\convoys\%1.sqf", _missionLocation];

	_createVehicle =
	{
		private ["_type", "_position", "_direction", "_vehicle", "_soldier"];

		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;

		_vehicle = createVehicle [_type, _position, [], 0, "None"];
		_vehicle setVariable ["R3F_LOG_disabled", true, true];
		[_vehicle] call vehicleSetup;

		if (_vehicle isKindOf "B_APC_Tracked_01_CRV_F") then
		{
			_vehicle setAmmoCargo 0;
			_vehicle setFuelCargo 0;
			_vehicle setRepairCargo 0;
			_vehicle spawn GOM_fnc_addAircraftLoadoutToObject;
			_vehicle setVariable ["GOM_fnc_ammoCargo", 500, true];
			_vehicle setVariable ["GOM_fnc_fuelCargo", 500, true];
			_vehicle setVariable ["GOM_fnc_repairCargo", 500, true];			
		};
		
		_vehicle setDir _direction;
		_aiGroup addVehicle _vehicle;

		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInDriver _vehicle;

		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInCargo [_vehicle, 0];

		if !(_type isKindOf "Truck_F") then
		{
			_soldier = [_aiGroup, _position] call createRandomSoldier;
			_soldier moveInGunner _vehicle;

			_soldier = [_aiGroup, _position] call createRandomSoldier;

			if (_vehicle emptyPositions "commander" > 0) then
			{
				_soldier moveInCommander _vehicle;
			}
			else
			{
				_soldier moveInCargo [_vehicle, 1];
			};
		};

		[_vehicle, _aiGroup] spawn checkMissionVehicleLock;
		_vehicle
	};


    // SKIP TOWN AND PLAYER PROXIMITY CHECK

    _skippedTowns = // get the list from -> \mapConfig\towns.sqf
    [
        "Town_17",
		"Town_14" // Pythos Island Marker Name
    ];

    _town = ""; _missionPos = [0,0,0]; _radius = 0;
    _townOK = false;
    while {!_townOK} do
    {
        _town = selectRandom (call cityList); // initially select a random town for the mission.
        _missionPos = markerPos (_town select 0); // the town position.
        _radius = (_town select 1); // the town radius.
        _anyPlayersAround = (nearestObjects [_missionPos,["MAN"],_radius]) select {isPlayer _x}; // search the area for players only.
        if (((count _anyPlayersAround) isEqualTo 0) && !((_town select 0) in _skippedTowns)) exitWith // if there are no players around and the town marker is not in the skip list, set _townOK to true (exit loop).
        {
            _townOK = true;
        };
        sleep 0.1; // sleep between loops.
    };

	_aiGroup = createGroup CIVILIAN;
	//_town = selectRandom (call cityList);
	//_missionPos = markerPos (_town select 0);
	//_radius = (_town select 1);
	// _vehiclePosArray = [_missionPos,(_radius / 2),_radius,5,0,0,0] call findSafePos;

	// _vehicles = [];
	// {
		// _vehicles pushBack ([_x, _vehiclePosArray, 0, _aiGroup] call _createVehicle);
	_vehicles = [];
	_vehiclePosArray = nil;
	{
		_vehiclePosArray = getPos ((_missionPos nearRoads _radius) select _forEachIndex);
		if (isNil "_vehiclePosArray") then
		{
			_vehiclePosArray = [_missionPos,(_radius / 2),_radius,5,0,0,0] call findSafePos;
		};
		_vehicles pushBack ([_x, _vehiclePosArray, 0, _aiGroup] call _createVehicle);
		_vehiclePosArray = nil;
	} forEach _vehClasses;

	_veh2 = _vehClasses select (1 min (count _vehClasses - 1));

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;

	_aiGroup setCombatMode "GREEN"; // units will defend themselves
	_aiGroup setBehaviour "SAFE"; // units feel safe until they spot an enemy or get into contact
	_aiGroup setFormation "COLUMN";

	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };

	_aiGroup setSpeedMode _speedMode;

	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 100;
		_waypoint setWaypointCombatMode "GREEN";
		_waypoint setWaypointBehaviour "SAFE"; // safe is the best behaviour to make AI follow roads, as soon as they spot an enemy or go into combat they WILL leave the road for cover though!
		_waypoint setWaypointFormation "COLUMN";
		_waypoint setWaypointSpeed _speedMode;
	} forEach ((call cityList) call BIS_fnc_arrayShuffle);

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> (_veh2 param [0,""]) >> "picture");
 	_vehicleName = getText (configFile >> "CfgVehicles" >> (_veh2 param [0,""]) >> "displayName");

	_missionHintText = format ["A Military Patrol containing a <t color='%3'>%1</t> is patrolling the island. Destroy them and recover their cargo!", _vehicleName, armouredMissionColor];

	_numWaypoints = count waypoints _aiGroup;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome

#include "..\missionSuccessHandler.sqf"

_missionCratesSpawn = true;
_missionCrateAmount = 3;
_missionCrateSmoke = true;
_missionCrateSmokeDuration = 120;
_missionCrateChemlight = true;
_missionCrateChemlightDuration = 120;

_missionMoneySpawn = false;
_missionMoneyAmount = 100000;
_missionMoneyBundles = 10;
_missionMoneySmoke = true;
_missionMoneySmokeDuration = 120;
_missionMoneyChemlight = true;
_missionMoneyChemlightDuration = 120;

_missionSuccessMessage = "The Patrol has been stopped! Crates have been dropped nearby!";

_this call armouredMissionProcessor;
