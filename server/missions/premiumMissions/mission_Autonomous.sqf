// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_geoCache.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev, edit by CRE4MPIE & LouD;
//	@file Created: 08/12/2012 15:19
//	@file Edit: 27/04/2018 by [509th] Coyote Rogue


if (!isServer) exitwith {};

#include "premiumMissionDefines.sqf";

private ["_smoke", "_gunType", "_geoPos", "_geoCache", "_marker1", "_para", "_veh", "_veh2", "_container"];

_setupVars =
{
	_missionType = "Black Magic Autonomous Weapons";
	_locationsArray = SniperMissionMarkers;	
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	
	//delete existing base parts and vehicles at location
	_baseToDelete = nearestObjects [_missionPos, ["All"], 100];
	{ deleteVehicle _x } forEach _baseToDelete;	
	
	_geoPos = _missionPos vectorAdd ([[50 + random 350, 0, 0], random 360] call BIS_fnc_rotateVector2D);
	_geoCache = createVehicle ["Land_Canteen_F",[(_geoPos select 0), (_geoPos select 1),0],[], 0, "NONE"]; //Land_SatellitePhone_F
	
		_marker1 = createMarker ["AutoGuns", _missionPos];
		_marker1 setMarkerShape "ELLIPSE";
		_marker1 setMarkerSize [800,800];	
		_marker1 setMarkerBrush "FDiagonal";
		_marker1 setMarkerColor "colorOPFOR";
		
	_missionPicture = "media\genie.jpg";		
	
	_missionHintText = format ["There is a Magic Canteen Bottle hidden within an 400 metre radius of the marker. Find it, then Rub it and the Genie will bestow upon you <br/><br/><t color='%1'>TWO AUTONOMOUS GUNS!</t>", "#fcc362"];
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

	// Delete AutoGuns Marker
	deleteMarker "AutoGuns"; 	
};

// Mission completed

_successExec =
{
	{ deleteVehicle _x } forEach [_GeoCache];

	deleteMarker "AutoGuns"; 		

	_container = createVehicle [ST_CARGO_SMALL,[(_geoPos select 0), (_geoPos select 1),200],[], 0, "NONE"];	
	_container setDir random 360;
	_container allowDamage false;
	_container setVariable ["R3F_LOG_disabled", _disabled, true];
	_container setVariable ["moveable", true, true];

	_gunType = selectRandom ["B_HMG_01_A_F", "O_HMG_01_A_F", "I_HMG_01_A_F", "B_GMG_01_A_F", "O_GMG_01_A_F", "I_GMG_01_A_F"];
	_veh = createVehicle [_gunType,[(_geoPos select 0), (_geoPos select 1),210],[], 0, "NONE"];
	_veh2 = createVehicle [_gunType,[(_geoPos select 0), (_geoPos select 1),210],[], 0, "NONE"];
	
	if (_veh isKindOf "B_HMG_01_A_F" || _veh isKindOf "B_GMG_01_A_F") then
	{
		_veh setVariable ["FactionLocked", west, true];
		_veh2 setVariable ["FactionLocked", west, true];		
	} else
	  {
		  if (_veh isKindOf "O_HMG_01_A_F" || _veh isKindOf "O_GMG_01_A_F") then
		  {
			  _veh setVariable ["FactionLocked", east, true];
			  _veh2 setVariable ["FactionLocked", east, true];			  
		  } else
		    {
				_veh setVariable ["FactionLocked", independent, true];
				_veh2 setVariable ["FactionLocked", independent, true];				
			};
	  };

	_veh allowDamage false;
	_veh2 allowDamage false;	
	
	[_veh, 1] call A3W_fnc_setLockState; // Unlock
	[_veh2, 1] call A3W_fnc_setLockState; // Unlock	

	//Load Reward inside crate
	[_container, [[_veh, 1],[_veh2, 1]]] execVM "addons\R3F_LOG\auto_load_in_vehicle.sqf";
	
	_container allowDamage false;
	
	playSound3D [call currMissionDir + "media\genie.ogg", _container, false, _container, 3, 1, 1500];	

	_para = createVehicle [format ["I_parachute_02_F"], [0,0,999999], [], 0, "NONE"];

	_para setDir getDir _container;
	_para setPosATL getPosATL _container;

	_para attachTo [_container, [0, 0, 0]];
	uiSleep 2;

	detach _para;
	_container attachTo [_para, [0, 0, 0]];

	while {(getPos _container) select 2 > 2 && attachedTo _container == _para} do
	{
		_para setVectorUp [0,0,1];
		_para setVelocity [0, 0, (velocity _para) select 2];
		uiSleep 0.1;
	};

	detach _container;
	
	// Land safely
	WaitUntil {((((position _container) select 2) < 0.7) || (isNil "_para"))};
	detach _container;
	_container SetVelocity [0,0,-5];           
	sleep 0.3;
	_container setPos [(position _container) select 0, (position _container) select 1, 1];
	_container SetVelocity [0,0,0];

	//_container allowDamage true;	
	//_veh allowDamage true;
	//_veh2 allowDamage true;	
	
	_smoke = "SmokeShellBlue" createVehicle getPos _para;	
	
	_successHintMessage = "Oh, does that feel good! The Black Magic is being delivered by parachute!";

};

_this call premiumMissionProcessor;
