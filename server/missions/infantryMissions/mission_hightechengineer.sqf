// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_hightechengineer.sqf
//	@file Author: JoSchaap, AgentRev, GriffinZS, RickB, soulkobk

if (!isServer) exitwith {};
#include "infantryMissionDefines.sqf";

private ["_positions", "_camonet", "_hostage", "_obj1", "_obj3", "_obj4", "_vehicleName", "_chair", "_randomBox", "_randomCase", "_box1", "_para", "_geoPos","_boxContents"];

_setupVars =
{
	_missionType = "Captured Engineer";
	_locationsArray = MissionSpawnMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_geoPos = _missionPos vectorAdd ([[25 + random 20, 0, 0], random 360] call BIS_fnc_rotateVector2D);
	
	//delete existing base parts and vehicles at location
	_baseToDelete = nearestObjects [_missionPos, ["All"], 25];
	{ deleteVehicle _x } forEach _baseToDelete; 
	
	_camonet = createVehicle ["Land_Shed_06_F", [_missionPos select 0, _missionPos select 1], [], 0, "CAN COLLIDE"];
	_camonet allowdamage false;
	_camonet setDir random 360;
	_camonet setVariable ["R3F_LOG_disabled", false];

	_missionPos = getPosATL _camonet;

	_chair = createVehicle ["Land_Slums02_pole", _missionPos, [], 0, "CAN COLLIDE"];
	_chair setPosATL [_missionPos select 0, _missionPos select 1, _missionPos select 2];
	
	_hostage = createVehicle ["C_scientist_F", _missionPos, [], 0, "CAN COLLIDE"];
	_hostage setPosATL [_missionPos select 0, _missionPos select 1, _missionPos select 2];
	waitUntil {alive _hostage};
	[_hostage, "Acts_AidlPsitMstpSsurWnonDnon_loop"] call switchMoveGlobal;
	_hostage disableAI "anim";
	  	

	_obj1 = createVehicle ["I_GMG_01_high_F", _missionPos,[], 10,"None"]; 
	_obj1 setPosATL [(_missionPos select 0) - 2, (_missionPos select 1) + 2, _missionPos select 2];
	
	_obj3 = createVehicle ["I_HMG_01_high_F", _missionPos,[], 10,"None"]; 
	_obj3 setPosATL [(_missionPos select 0) - 2, (_missionPos select 1) - 2, _missionPos select 2];
	
	_obj4 = createVehicle ["I_HMG_01_high_F", _missionPos,[], 10,"None"]; 
	_obj4 setPosATL [(_missionPos select 0) + 2, (_missionPos select 1) - 2, _missionPos select 2];

	
	_aiGroup = createGroup CIVILIAN;
	[_aiGroup,_missionPos,13,30] spawn createcustomGroup;

	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "COMBAT";	
	
	
	_missionHintText = format ["<br/>An technology engineer has been kidnapped by terrorists!<br/> Free the engineer and get retrieve his intel!", infantryMissionColor];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = {!alive _hostage};

_failedExec =
{
	// Mission failed
	
	{ deleteVehicle _x } forEach [_camonet, _obj1, _obj3, _obj4, _hostage, _chair];
	_failedHintMessage = format ["<br/>The engineer was killed. Debrief!"];
};

_successExec =
{
	// Mission completed
	
	
	{ deleteVehicle _x } forEach [_camonet, _obj1, _obj3, _obj4, _hostage, _chair];
	_randomBox = ["mission_USLaunchers2"] call BIS_fnc_selectRandom;
	_randomCase = ["Box_FIA_Support_F","Box_FIA_Wps_F","Box_FIA_Ammo_F","Box_NATO_WpsSpecial_F","Box_East_WpsSpecial_F","Box_NATO_Ammo_F","Box_East_Ammo_F"] call BIS_fnc_selectRandom;
	
	_box1 = createVehicle [_randomCase,[(_geoPos select 0), (_geoPos select 1),200],[], 0, "NONE"];
	_box1 setDir random 360;
	_box1 addItemCargoGlobal ["NVGogglesB_grn_F",1];
	_box1 addItemCargoGlobal ["NVGogglesB_gry_F",1];
	_box1 allowdamage false;
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1];

	playSound3D ["A3\data_f_curator\sound\cfgsounds\air_raid.wss", _box1, false, _box1, 15, 1, 1500];
	
	_para = createVehicle [format ["I_parachute_02_F"], [0,0,999999], [], 0, ""];

	_para setDir getDir _box1;
	_para setPosATL getPosATL _box1;

	_para attachTo [_box1, [0, 0, 0]];
	uiSleep 2;

	detach _para;
	_box1 attachTo [_para, [0, 0, 0]];

	while {(getPos _box1) select 2 > 3 && attachedTo _box1 == _para} do
	{
		_para setVectorUp [0,0,1];
		_para setVelocity [0, 0, (velocity _para) select 2];
		uiSleep 0.1;
	};
	
	// Land safely
    WaitUntil {((((position _box1) select 2) < 0.6) || (isNil "_para"))};
    detach _box1;
    _box1 SetVelocity [0,0,-5]; 
    sleep 0.3;
    _box1 setPos [(position _box1) select 0, (position _box1) select 1, 1];
    _box1 SetVelocity [0,0,0];	
	
	_successHintMessage = format ["<br/>Well done! You managed to rescue the engineer."];
};

_this call infantryMissionProcessor;