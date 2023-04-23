// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_militaryTownIncursion.sqf
//	@file Author: The Scotsman
//  @file Information: A more difficult town invasion

#include "occupationMissionDefines.sqf";

if (!isServer) exitwith {};

private ["_maxUnits", "_moneyText", "_pos", "_objects", "_reward", "_type", "_mrap", "_helo", "_boxes", "_townName", "_vehicles", "_missionPos", "_buildingRadius", "_putOnRoof", "_fillEvenly"];

_setupVars = {

	_missionType = "Miltary Incursion";
	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };

	// settings for this mission
	_locArray = ((call cityList) call BIS_fnc_selectRandom);
	_missionPos = markerPos (_locArray select 0);
	_buildingRadius = _locArray select 1;
	_townName = _locArray select 2;

	//randomize amount of units
	_maxUnits = AI_GROUP_LARGE + round(random ((AI_GROUP_LARGE) * 1));
	_reward = 50000 * _maxUnits;

	// reduce radius for larger towns. for example to avoid endless hide and seek in kavala ;)
	_buildingRadius = if (_buildingRadius > 201) then {(_buildingRadius*0.5)} else {_buildingRadius};

	// 25% change on AI not going on rooftops
	if (random 1 < 0.75) then { _putOnRoof = true } else { _putOnRoof = false };

	// 25% chance on AI trying to fit into a single building instead of spreading out
	if (random 1 < 0.75) then { _fillEvenly = true } else { _fillEvenly = false };

};

_setupObjects = {

	_type = [ST_HUMVEE_ARMED1, ST_HUMVEE_ARMED2] call BIS_fnc_selectRandom;
	_mrap = [ST_BRADLEY, ST_BRADLEY0, ST_BRADLEY1, ST_BRADLEY2, ST_LINEBACKER] call BIS_fnc_selectRandom;
	_helo = ST_APACHE;

	//calculate a safe position for the enclosure
	_pos = [_missionPos,5,300,50,0,0,0] call findSafePos;

	//Some Random Crates (disabled)
	_boxes = [_pos, [2,5], false, true] call STRandomCratesReward;

	//Shelter
	_objects = ["compositions\NetBlue01", _pos, 0] call createOutpost;

	// spawn some rebels/enemies :)
  _aiGroup = [_missionPos, ST_SEAL, _maxUnits] call STCreateRandomGroup;

	//move them into buildings
	[_aiGroup, _missionPos, _buildingRadius, _fillEvenly, _putOnRoof] call moveIntoBuildings;

	//TODO: Maybe make vehicle counts random
	_vehicles = [
		[_type, [(_missionPos vectorAdd ([[random 100, 0, 0], random 360] call BIS_fnc_rotateVector2D)),1,50,50,0,0,0] call findSafePos, 0, _aiGroup, ST_SEAL] call STCreateVehicle,
		[_type, [(_missionPos vectorAdd ([[random 100, 0, 0], random 360] call BIS_fnc_rotateVector2D)),1,50,50,0,0,0] call findSafePos, 0, _aiGroup, ST_SEAL] call STCreateVehicle,
		[_mrap, [(_missionPos vectorAdd ([[random 100, 0, 0], random 360] call BIS_fnc_rotateVector2D)),1,50,50,0,0,0] call findSafePos, 0, _aiGroup, ST_SEAL] call STCreateVehicle,
		[_helo, [(_missionPos vectorAdd ([[random 100, 0, 0], random 360] call BIS_fnc_rotateVector2D)),1,50,50,0,0,0] call findSafePos, 0, _aiGroup, ST_SEAL] call STCreateVehicle
	];

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;
	_leader setRank ST_COLONEL;

	_moneyText = format ["$%1", [_reward] call fn_numbersText];
	_missionPicture = getText (configFile >> "CfgVehicles" >> _mrap >> "picture");
	_vehicleName1 = getText (configFile >> "CfgVehicles" >> _mrap >> "displayName");
	_vehicleName2 = getText (configFile >> "CfgVehicles" >> _helo >> "displayName");
	_missionHintText = format ["Military incursion into the town of <t size='1.25' color='%1'>%2</t>.<br/>An entire company of highly trained troops supported by at least a <t color='%1'>%3</t> and a <t color='%1'>%4</t> have been spotted. Liberate the town, and collect their supplies and <t color='%1'>%5</t> in cash!<br/>", occupationMissionColor, _townName, _vehicleName1, _vehicleName2, _moneyText];

};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec = {

	//Delete Boxes
	{ deleteVehicle _x } forEach _boxes;
	{ deleteVehicle _x } forEach _objects;

};

_successExec = {

	//Dispose of props
	{ deleteVehicle _x } forEach _objects;

	//Enable Reward Boxes
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach _boxes;

	//Add some cash
	[(markerPos _marker), _reward] call STFixedCashReward;

	_successHintMessage = format ["Congratulations. <br/><br/><t color='%1'>%2</t><br/>has been effectively liberated.<br/>The remaining supplies and <t color='%1'>%3</t> in cash are now yours to take!", townMissionColor, _townName, _moneyText];

};

_this call occupationMissionProcessor;