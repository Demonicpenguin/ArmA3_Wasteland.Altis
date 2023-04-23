// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_AirWreck.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev
//	@file Created: 08/12/2012 15:19

if (!isServer) exitwith {};
#include "armouredMissionDefines.sqf";

private ["_nbUnits", "_armyPos", "_box1", "_box2", "_box3", "_scientist", "_aaSupport"];

_setupVars =
{
	_missionType = "Mad Scientist";
	_locationsArray = MissionSpawnMarkers;
	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_armyPos = _missionPos vectorAdd ([[25 + random 20, 0, 0], random 360] call BIS_fnc_rotateVector2D);
    _aaPos = _armyPos vectorAdd ([[50 + random 25, 0, 0], random 360] call BIS_fnc_rotateVector2D);

	_box1 = createVehicle ["Box_NATO_WpsSpecial_F", _missionPos, [], 5, "None"];
	_box1 setDir random 360;
	[_box1, "mission_USSpecial"] call fn_refillbox;

	_box2 = createVehicle ["Box_East_WpsSpecial_F", _missionPos, [], 5, "None"];
	_box2 setDir random 360;
	[_box2, "mission_USLaunchers"] call fn_refillbox;

    _box3 = createVehicle ["Box_IND_Grenades_F", _missionPos, [], 5, "None"];
    _box3 setDir random 360;
    [_box3, "mission_ScientistSpecial"] call fn_refillbox;

	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach [_box1, _box2, _box3];

	_aiGroup = createGroup CIVILIAN;

	[_aiGroup, _armyPos, _nbUnits] call createCustomGroup;

    _scientistGroup = createGroup CIVILIAN;
    _scientist = _scientistGroup createUnit ["C_man_polo_1_F", _missionPos, [], 5, "None"];
    _scientist addRating 9000;
    _scientist setPosATL _missionPos;
    _scientist addUniform "U_C_Scientist";
    _scientist addVest "V_PlateCarrierIAGL_oli";
    _scientist playMove "Stand";
    _scientist disableAI "PATH";

    _aaSupport = createVehicle ["O_APC_Tracked_02_AA_F", _aaPos, [], 5, "None"];
    _soldier = [_aiGroup, _aaPos] call createRandomSoldier;
    _soldier moveInDriver _aaSupport;

    _soldier = [_aiGroup, _aaPos] call createRandomSoldier;
    _soldier moveInGunner _aaSupport;

	_missionPicture = "media\mads.jpg";	
	_missionHintText = "A mad scientist has found a treatment for enternal youth. The Altis Management don't want this secret revealed. He is being held under guard. Go free him so we can all enjoy Arma forever";
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = {!alive _scientist};

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach [_box1, _box2, _box3, _aaSupport];
};

_successExec =
{
	// Mission completed
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2, _box3];

	deleteVehicle _scientist;

	_successHintMessage = "Enternal Youth is ours to share, well done. Enjoy your reward";
};

_this call armouredMissionProcessor;
