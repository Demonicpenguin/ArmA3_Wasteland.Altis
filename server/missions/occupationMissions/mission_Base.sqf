// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_MilitaryBase.sqf
//	@file Author: Nurdism
//	@file Created: 09/09/2018 

if (!isServer) exitwith {};

#include "occupationMissionDefines.sqf";

private ["_nbUnits", "_MilitaryVehicles", "_putOnRoof", "_fillEvenly", "_createVehicle", "_box1", "_box2", "_box3"];

_setupVars = {
	_missionType = "Military Base";
	_locationsArray = MilitaryMissionMarkers;
	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
	_nbUnits = (_nbUnits * (random 3));

  // 25% change on AI not going on rooftops
	if (random 1 < 0.75) then { _putOnRoof = true } else { _putOnRoof = false };
	// 25% chance on AI trying to fit into a single building instead of spreading out
	if (random 1 < 0.75) then { _fillEvenly = true } else { _fillEvenly = false };

  _MilitaryVehicles = [
    [ // NATO convoy
      ["B_MRAP_01_hmg_F", "B_MRAP_01_gmg_F"], // Veh 1
      ["B_APC_Wheeled_01_cannon_F", "B_APC_Tracked_01_rcws_F", "B_APC_Tracked_01_AA_F"], // Veh 2
      ["B_MRAP_01_hmg_F", "B_MRAP_01_gmg_F"] // Veh 3
    ],
    [ // CSAT convoy
      ["O_MRAP_02_hmg_F", "O_MRAP_02_gmg_F"], // Veh 1
      ["O_APC_Wheeled_02_rcws_v2_F", "O_APC_Tracked_02_cannon_F", "O_APC_Tracked_02_AA_F"], // Veh 2
      ["O_MRAP_02_hmg_F", "O_MRAP_02_gmg_F"] // Veh 3
    ],
    [ // AAF convoy
      ["I_MRAP_03_hmg_F", "I_MRAP_03_gmg_F", "I_LT_01_cannon_F"], // Veh 1
      ["I_APC_Wheeled_03_cannon_F", "I_APC_tracked_03_cannon_F"], // Veh 2
      ["I_MRAP_03_hmg_F", "I_MRAP_03_gmg_F", "I_LT_01_AT_F"] // Veh 3
    ]
  ];
};

_setupObjects = {
  _missionPos = markerPos _missionLocation;

  _createVehicle =
	{
		private ["_type", "_position", "_vehicle", "_soldier"];

		_type = _this select 0;
    _position = [(_this select 1), 0, 100, 3, 0, 0.7] call BIS_fnc_findSafePos;
		_aiGroup = _this select 2;

		_vehicle = createVehicle [_type, _position, [], 0, "None"];
		_vehicle setVariable ["R3F_LOG_disabled", true, true];
		[_vehicle] call vehicleSetup;

		_vehicle setDir (random 360);
		_aiGroup addVehicle _vehicle;

		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInDriver _vehicle;

		if !(_type isKindOf "LT_01_base_F") then {
			_soldier = [_aiGroup, _position] call createRandomSoldier;
			_soldier moveInCargo [_vehicle, 0];
		};

		if !(_type isKindOf "Truck_F") then {
			_soldier = [_aiGroup, _position] call createRandomSoldier;
			_soldier moveInGunner _vehicle;
			if (_type isKindOf "LT_01_base_F") exitWith {};

			_soldier = [_aiGroup, _position] call createRandomSoldier;

			if (_vehicle emptyPositions "commander" > 0) then {
				_soldier moveInCommander _vehicle;
			}	else {
				_soldier moveInCargo [_vehicle, 1];
			};
		};

		[_vehicle, _aiGroup] spawn checkMissionVehicleLock;

		_vehicle
	};

	_box1 = createVehicle ["Box_NATO_Wps_F", _missionPos, [], 5, "None"];
	_box1 setDir random 360;
	[_box1, "mission_USSpecial"] call fn_refillbox;

	_box2 = createVehicle ["Box_East_Wps_F", _missionPos, [], 5, "None"];
	_box2 setDir random 360;
	[_box2, "mission_USLaunchers"] call fn_refillbox;

  // spawn some military units
	_aiGroup = createGroup CIVILIAN;
  
  [_aiGroup, _missionPos, _nbUnits, 15] spawn createMilitaryGroup;
	
  _aiGroup setCombatMode "YELLOW";
	_aiGroup setBehaviour "SAFE";

	[_aiGroup, _missionPos, 100, _fillEvenly, _putOnRoof] call moveIntoBuildings;

  _vehicles = [];
	{
		_vehicles pushBack ([(selectRandom _x), _missionPos, _aiGroup] call _createVehicle);
	} forEach (selectRandom _MilitaryVehicles);

  [_aiGroup, _missionPos] call bis_fnc_taskDefend;
  
	_missionHintText = format ["The military have taken over a base!<br/>There seem to be <t color='%1'>%2 soldiers</t> hiding inside or on top of buildings. Get rid of them all, and take their supplies!<br/>Watch out for those windows!", occupationMissionColor, _nbUnits]
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;
_failedExec = {
	{ deleteVehicle _x } forEach [_box1, _box2];
};

_successExec = {

	// Mission completed

	for "_x" from 1 to 10 do
	{
		_cash = "Land_Money_F" createVehicle markerPos _marker;
		_cash setPos ((markerPos _marker) vectorAdd ([[2 + random 2,0,0], random 360] call BIS_fnc_rotateVector2D));
		_cash setDir random 360;
		_cash setVariable["cmoney",40000,true];
		_cash setVariable["owner","world",true];
	};
	
	_box3 = "Box_East_Wps_F" createVehicle getMarkerPos _marker;
	_box3 setVariable ["moveable", true, true];
    [_box3,"mission_USLaunchers"] call fn_refillbox;
	_box3 allowDamage false;

	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2, _box3];
	
	_successHintMessage = format ["Nice work!<br/><t color='%1'>The base is safe again!</t><br/>Their belongings are now yours to take!", occupationMissionColor];
};

_this call occupationMissionProcessor;