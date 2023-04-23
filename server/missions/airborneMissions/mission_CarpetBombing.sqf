// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_HostileJet.sqf
//	@file Author: JoSchaap, AgentRev, LouD

if (!isServer) exitwith {};
#include "airborneMissionDefines.sqf";

private ["_plane", "_vehicle", "_cities", "_leader", "_speedMode", "_city", "_waypoint", "_vehicleName", "_numWaypoints", "_target", "_targetPos", "_marker", "_box1", "_box2", "_boxes1", "_boxes2", "_currBox1", "_currBox2"];

_setupVars = {
	_missionType = "Carpet Bombing";
	_locationsArray = nil; // locations are generated on the fly from towns
};

_setupObjects = {

	_city = ((call cityList) call BIS_fnc_selectRandom);
	_target = _city select 2;
  _targetPos = markerPos (_city select 0);
  _missionPos = markerPos (((call cityList) call BIS_fnc_selectRandom) select 0);

  //TODO: Draw Target Icon
  _marker = createMarker ["CarpetBomb", _targetPos]; // create 'drop off' marker on _dropOffPos
  _marker setMarkerType "mil_end";
  _marker setMarkerShape "ICON";
  _marker setMarkerSize [1, 1];
  _marker setMarkerText "Carpet Bombing Target";
  _marker setMarkerColor "colorCivilian";
  
  _plane = selectRandom [
		ST_BLACK_WASP,
		//ST_WIPEOUT,
		ST_NEOPHRON,
		ST_SHIKRA,
		//ST_BUZZARD,
		ST_GRYPHON];

	_aiGroup = createGroup CIVILIAN;
	
	_createVehicle = 
	{
		private ["_type","_position","_direction","_vehicle","_soldier"];
		
		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;
		

		_vehicle = createVehicle [_type, _position, [], 0, "FLY"]; // Added to make it fly
		
		_vehicle setVehicleReportRemoteTargets true;
		_vehicle setVehicleReceiveRemoteTargets true;
		_vehicle setVehicleRadar 1;
		_vehicle confirmSensorTarget [west, true];
		_vehicle confirmSensorTarget [east, true];
		_vehicle confirmSensorTarget [resistance, true];	
		
		_vehicle setVariable ["R3F_LOG_disabled", true, true];
		_vel = [velocity _vehicle, -(_direction)] call BIS_fnc_rotateVector2D; // Added to make it fly
		_vehicle setDir _direction;
		_vehicle setVelocity _vel; // Added to make it fly
		_vehicle setVariable [call vChecksum, true, false];
		_aiGroup addVehicle _vehicle;

		// add pilot
		_soldier = [_aiGroup, _position] call createRandomSoldier; 
		_soldier moveInDriver _vehicle;
		// lock the vehicle untill the mission is finished and initialize cleanup on it
		
		
		[_vehicle, _aiGroup] spawn checkMissionVehicleLock;
		_vehicle
	};	

  //_vehicle = [_plane, _missionPos, 0, _aiGroup] call STCreateVehicle;
  
	_vehicles = [];
	_vehicles set [0, [_plane,[14321.6,15857.7,0], 14, _aiGroup] call _createVehicle]; // static value update when porting to different maps  

	_leader = effectiveCommander _vehicle;
	_aiGroup selectLeader _leader;
	_leader setRank "LIEUTENANT";

	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "COMBAT";
	_aiGroup setFormation "STAG COLUMN";

	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };

	_cities = ((call cityList) call BIS_fnc_arrayShuffle);

	//Trim the array by half(2 returns 24) quarter(4 returns 12) eigth(8 returns 6)
	for "_x" from 0 to ((count _cities) / 8) do {
		_cities deleteAt 0;
	};

	// behaviour on waypoints
	{

		//Skip Destination city
		if( _x select 0 != (_city select 0) ) then {

	    _waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
			_waypoint setWaypointType "MOVE";
			_waypoint setWaypointCompletionRadius 55;
			_waypoint setWaypointCombatMode "RED";
			_waypoint setWaypointBehaviour "COMBAT";
			_waypoint setWaypointFormation "STAG COLUMN";
			_waypoint setWaypointSpeed _speedMode;

		};

	} forEach _cities;

	//Last city in list triggers air raid sirens
	_waypoint setWaypointStatements ["true", "[(waypointPosition (waypoints (group this) select (currentWaypoint (group this) + 1)))] spawn GOM_fnc_airRaidSirens;"];

	_waypoint = _aiGroup addWaypoint [_targetPos, 0];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointCompletionRadius 10;
	_waypoint setWaypointCombatMode "RED";
	_waypoint setWaypointBehaviour "COMBAT";
	_waypoint setWaypointFormation "STAG COLUMN";
	_waypoint setWaypointSpeed _speedMode;
	_waypoint setWaypointStatements ["true", "["""", getPosASL this, (getDir this) , 20, 150] spawn GOM_fnc_carpetBombing;"];

	_numWaypoints = count waypoints _aiGroup;
	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _plane >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _plane >> "displayName");
	_missionHintText = format ["An armed <t color='%2'>%1</t> is on it's way to carpet bomb <t color='%2'>%3</t>. Shoot it down and kill the pilot to prevent the devastation", _vehicleName, airborneMissionColor, _target];

};

//this will drop a carpet of 20 bombs of a random type, beginning at the screen center position, moving ~100m from east to west
_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = {};
_waitUntilCondition = { currentWaypoint _aiGroup >= _numWaypoints };

_failedExec = {

	deleteMarker "CarpetBomb";

};

_successExec =
{
	// Mission completed

	//Money
	for "_i" from 1 to 5 do
	{
		_cash = createVehicle ["Land_Money_F", _lastPos, [], 5, "None"];
		_cash setPos ([_lastPos, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
		_cash setDir random 360;
		_cash setVariable ["cmoney", 100000, true];
		_cash setVariable ["owner", "world", true];
	};

	_Boxes1 = ["Box_IND_Wps_F","Box_East_Wps_F","Box_NATO_Wps_F","Box_NATO_AmmoOrd_F","Box_NATO_Grenades_F","Box_East_WpsLaunch_F","Box_NATO_WpsLaunch_F","Box_East_WpsSpecial_F","Box_NATO_WpsSpecial_F"];    
	_currBox1 = _Boxes1 call BIS_fnc_selectRandom;
	_box1 = createVehicle [_currBox1, _lastPos, [], 2, "None"];
	_box1 setDir random 360;
	_box1 allowDamage false;

	_Boxes2 = ["Box_IND_Wps_F","Box_East_Wps_F","Box_NATO_Wps_F","Box_NATO_AmmoOrd_F","Box_NATO_Grenades_F","Box_East_WpsLaunch_F","Box_NATO_WpsLaunch_F","Box_East_WpsSpecial_F","Box_NATO_WpsSpecial_F"];    
	_currBox2 = _Boxes2 call BIS_fnc_selectRandom;
	_box2 = createVehicle [_currBox2, _lastPos, [], 2, "None"];
	_box2 setDir random 360;
	_box2 allowDamage false;
	
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2];
	
	//Smoke to mark the crates
	_smokemarker = createMarker ["SMMarker1", _lastPos];
	[_smokemarker] spawn CrateSmoke; //Calls repeating green smoke grenade
	uiSleep 2;		
	deleteMarker "SMMarker1";
	deleteMarker "CarpetBomb";	

	_successHintMessage = format["Well done!  The residents of %1 thank you and have organized a reward in the centre of town for your bravery.", _target];
};

_this call airborneMissionProcessor;
