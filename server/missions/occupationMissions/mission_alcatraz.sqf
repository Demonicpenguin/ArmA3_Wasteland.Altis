// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_hightechengineer.sqf
//	@file Author: JoSchaap, AgentRev, GriffinZS, RickB, soulkobk

if (!isServer) exitwith {};
#include "occupationMissionDefines.sqf";

private ["_positions", "_camonet", "_hostage", "_obj1", "_obj2", "_obj3", "_obj4", "_obj5", "_obj6", "_obj7", "_obj8", "_obj9", "_vehicleName", "_chair", "_randomBox", "_randomCase", "_box1", "_para", "_geoPos","_boxContents", "_marker1", "_marker2", "_marker3", "_marker4"];

_setupVars =
{
	_missionType = "Alcatraz Jail Break";
	_locationsArray = AlcatrazSpawnMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_geoPos = _missionPos vectorAdd ([[25 + random 20, 0, 0], random 360] call BIS_fnc_rotateVector2D);
	_mfW = [8310.64,25033.7,0.000221252];
	_mfE = [8608.62,25142.4,0.000740051];
	_mfN = [8403.05,25225.1,0.000991821];
	_mfS = [8516.47,24934,0.000450134];
	//_mfS = [8463.15,24864.8,0.00224686];	
	
	// Create minefield	
		for "_i" from 1 to 100 do
		{
			_mine = createMine ["APERSMine", _mfW, [], 50];		
		};
		for "_i" from 1 to 100 do
		{
			_mine = createMine ["APERSMine", _mfE, [], 50];		
		};
		for "_i" from 1 to 100 do
		{
			_mine = createMine ["APERSMine", _mfN, [], 50];		
		};
		for "_i" from 1 to 100 do
		{
			_mine = createMine ["APERSMine", _mfS, [], 50];		
		};		

		/*for "_i" from 1 to 25 do
		{
			_mineAT = createMine ["ATMine", _mfS, [], 50];		
		};*/

		_marker1 = createMarker ["Minefield", _mfW];
		_marker1 setMarkerShape "ELLIPSE";
		_marker1 setMarkerSize [120,120];	
		_marker1 setMarkerBrush "FDiagonal";
		_marker1 setMarkerColor "colorOPFOR";
		
		_marker2 = createMarker ["Minefield2", _mfE];
		_marker2 setMarkerShape "ELLIPSE";
		_marker2 setMarkerSize [120,120];	
		_marker2 setMarkerBrush "FDiagonal";
		_marker2 setMarkerColor "colorOPFOR";
		
		_marker3 = createMarker ["Minefield3", _mfN];
		_marker3 setMarkerShape "ELLIPSE";
		_marker3 setMarkerSize [120,120];	
		_marker3 setMarkerBrush "FDiagonal";
		_marker3 setMarkerColor "colorOPFOR";
		
		_marker4 = createMarker ["Minefield4", _mfS];
		_marker4 setMarkerShape "ELLIPSE";
		_marker4 setMarkerSize [120,120];	
		_marker4 setMarkerBrush "FDiagonal";
		_marker4 setMarkerColor "colorOPFOR";		
	
	_camonet = createVehicle ["Land_Shed_06_F", [_missionPos select 0, _missionPos select 1], [], 0, "CAN COLLIDE"];
	_camonet allowdamage false;
	_camonet setDir random 360;
	_camonet setVariable ["R3F_LOG_disabled", false];

	_missionPos = getPosATL _camonet;

	_chair = createVehicle ["Land_Slums02_pole", _missionPos, [], 0, "CAN COLLIDE"];
	_chair setPosATL [_missionPos select 0, _missionPos select 1, _missionPos select 2];
	
	_hostage = createVehicle ["C_scientist_F", _missionPos, [], 0, "CAN COLLIDE"];
	//_hostage setPosATL [_missionPos select 0, _missionPos select 1, _missionPos select 2];	
	_hostage setPosATL [8536.45,25013.1,7.2];
	waitUntil {alive _hostage};
	[_hostage, "Acts_AidlPsitMstpSsurWnonDnon_loop"] call switchMoveGlobal;
	_hostage disableAI "anim";	
	
	_obj1 = createVehicle ["I_GMG_01_high_F", _missionPos,[], 10,"None"]; 
	_obj1 setPosATL [8804.96, 25196.6, 18.0387];
	_obj1 setDir 226.755;
	
	_obj2 = createVehicle ["I_GMG_01_high_F", _missionPos,[], 10,"None"]; 
	_obj2 setPosATL [8207.32,24943.5,17.8453];
	_obj2 setDir 226.755;	
	
	_obj3 = createVehicle ["I_HMG_01_high_F", _missionPos,[], 10,"None"]; 
	_obj3 setPosATL [8477.34, 25249.4, 17.6111];
	_obj3 setDir 164.678;
	
	_obj4 = createVehicle ["I_HMG_01_high_F", _missionPos,[], 10,"None"]; 
	_obj4 setPosATL [8679.91,24815.8,19.0472];
	_obj4 setDir 5.423;

	_obj5 = createVehicle ["I_HMG_01_high_F", _missionPos,[], 10,"None"]; 
	_obj5 setPosATL [8503.11,24994.6,14.7049];
	_obj5 setDir 260.809;
	
	_obj6 = createVehicle ["I_GMG_01_high_F", _missionPos,[], 10,"None"]; 
	_obj6 setPosATL [8532.01,25024.2,5.53651];
	_obj6 setDir 260.809;	
	
	_obj7 = createVehicle ["I_GMG_01_high_F", _missionPos,[], 10,"None"]; 
	_obj7 setPosATL [8533.73,25004.6,5.75833];
	_obj7 setDir 260.809;

	_obj8 = createVehicle ["I_HMG_01_high_F", _missionPos,[], 10,"None"]; 
	_obj8 setPosATL [8536.3,25011.3,13.8053];
	_obj8 setDir 260.809;

	_obj9 = createVehicle ["I_GMG_01_high_F", _missionPos,[], 10,"None"]; 
	_obj9 setPosATL [8541.98,25021.7,13.7944];
	_obj9 setDir 354.471;	
	
	_aiGroup = createGroup CIVILIAN;
	
	[_aiGroup,_missionPos,17,30] spawn createalcatrazGroup;
	
	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "COMBAT";	
	
	_missionPicture = "media\alcatraz.jpg";	
	_missionHintText = format ["<br/>An Cyber Security Expert has been kidnapped and held hostage on Alcatraz by an unknown Terrorist Cell!<br/> Free the Security Expert for a substantial reward!!<br/>Mind the Minefield!!!", occupationMissionColor];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = {!alive _hostage};

_failedExec =
{
	// Mission failed
	// Delete minefield
	_minesToDelete = (_geoPos nearObjects ["MineBase", 600]);	
	{ deleteVehicle _x } forEach _minesToDelete;
	deleteMarker "Minefield";
	deleteMarker "Minefield2";
	deleteMarker "Minefield3";
	deleteMarker "Minefield4";
	
	{ deleteVehicle _x } forEach [_camonet, _obj1, _obj2, _obj3, _obj4, _obj5, _obj6, _obj7, _obj8, _obj9, _hostage, _chair];
	_failedHintMessage = format ["<br/>The engineer was killed. Debrief!"];
};

_successExec =
{
	// Mission completed

	// Delete minefield
	_minesToDelete = (_geoPos nearObjects ["MineBase", 600]);	
	{ deleteVehicle _x } forEach _minesToDelete;
	deleteMarker "Minefield";
	deleteMarker "Minefield2";
	deleteMarker "Minefield3";
	deleteMarker "Minefield4";	
	
	{ deleteVehicle _x } forEach [_camonet,  _obj1, _obj2, _obj3, _obj4, _obj5, _obj6, _obj7, _obj8, _obj9, _hostage, _chair];
	_randomBox = ["mission_USLaunchers2"] call BIS_fnc_selectRandom;
	_randomCase = ["Box_FIA_Support_F","Box_FIA_Wps_F","Box_FIA_Ammo_F","Box_NATO_WpsSpecial_F","Box_East_WpsSpecial_F","Box_NATO_Ammo_F","Box_East_Ammo_F"] call BIS_fnc_selectRandom;
	
	_box1 = createVehicle [_randomCase,[(_geoPos select 0), (_geoPos select 1),200],[], 0, "NONE"];
	_box1 setDir random 360;
	_box1 addItemCargoGlobal ["Laserdesignator_02",1];
	_box1 addItemCargoGlobal ["NVGogglesB_gry_F",1];
	_Box1 setVariable ["cmoney", 1500000, true];	
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
	
	_successHintMessage = format ["<br/>Well done! You managed to rescue the Cyber Geek. Look to the skies for your reward. Check the cash inside"];
};

_this call occupationMissionProcessor;