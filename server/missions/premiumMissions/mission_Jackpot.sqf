// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_geoCache.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev, edit by CRE4MPIE & LouD;
//	@file Created: 08/12/2012 15:19
//	@file Edit: 27/04/2018 by [509th] Coyote Rogue

//if ((count allPlayers) <= 6) then exitWith {};

if (!isServer) exitwith {};
#include "premiumMissionDefines.sqf";

private ["_geoPos", "_geoCache", "_cash", "_moneyAmount", "_marker1", "_minesToDelete", "_boxes1", "_box1", "_para", "_smoke"];

_moneyAmount = Tier_1_Reward; //Reward amount for completing mission

_setupVars =
{
	_missionType = "$10,000,000 Jackpot Bonanza";
	_locationsArray = SniperMissionMarkers;	
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	
	//delete existing base parts and vehicles at location
	_baseToDelete = nearestObjects [_missionPos, ["All"], 100];
	{ deleteVehicle _x } forEach _baseToDelete;	
	
	_geoPos = _missionPos vectorAdd ([[50 + random 750, 0, 0], random 360] call BIS_fnc_rotateVector2D);
	_geoCache = createVehicle ["Land_Trophy_01_gold_F",[(_geoPos select 0), (_geoPos select 1),0],[], 0, "NONE"]; //Land_SatellitePhone_F
	
		_marker1 = createMarker ["Jackpot", _missionPos];
		_marker1 setMarkerShape "ELLIPSE";
		_marker1 setMarkerSize [1600,1600];	
		_marker1 setMarkerBrush "FDiagonal";
		_marker1 setMarkerColor "colorOPFOR";
		
	_missionPicture = "media\jackpot.jpg";		
	
	_missionHintText = format ["There is a Valuable Golden Trophy hidden within an 800 metre radius of the marker. Find it and you hit a JACKPOT of <br/><br/><t color='%1'>$10 MILLION DOLLARS!</t>", premiumMissionColor];
};

_ignoreAiDeaths = true;
_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;
_waitUntilSuccessCondition = {{isPlayer _x && _x distance _geoPos < 5} count playableUnits > 0};

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach [_GeoCache];

	// Delete Jackpot Marker
	deleteMarker "Jackpot"; 	
};

// Mission completed

_successExec =
{
	{ deleteVehicle _x } forEach [_GeoCache];

	// Delete Jackpot Marker

	deleteMarker "Jackpot"; 		
	
	_boxes1 = selectRandom ["I_supplyCrate_F", "B_CargoNet_01_ammo_F", "c_IDAP_supplyCrate_F", "c_supplyCrate_F"];
	_box1 = createVehicle [_boxes1,[(_geoPos select 0), (_geoPos select 1),200],[], 0, "NONE"];
	_box1 setDir random 360;
	[_box1, "special_mass"] call fn_refillbox; //Special large box	
	_box1 allowDamage false;
	_box1 setVariable ["cmoney", 10000000, true];	
	
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1];
	
	playSound3D [call currMissionDir + "media\money.ogg", _box1, false, _box1, 3, 1, 1500];

	_para = createVehicle [format ["I_parachute_02_F"], [0,0,999999], [], 0, "NONE"];

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

	detach _box1;
	
	// Land safely
	WaitUntil {((((position _box1) select 2) < 0.6) || (isNil "_para"))};
	detach _box1;
	_box1 SetVelocity [0,0,-5];           
	sleep 0.3;
	_box1 setPos [(position _box1) select 0, (position _box1) select 1, 1];
	_box1 SetVelocity [0,0,0];		
	
	//_smoke = "SmokeShellBlue" createVehicle getPos _para;

	_successHintMessage = "You're in the MONEY! The Jackpot is being delivered by parachute!";
};

_this call premiumMissionProcessor;
