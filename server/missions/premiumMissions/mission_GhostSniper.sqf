// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_Sniper.sqf
//	@file Author: JoSchaap, AgentRev, LouD
//	@file Edit: 27/04/2018 by [509th] Coyote Rogue
// 	@file Edit: 06/04/2020 by [Raw Gaming] SoulStalker

if (!isServer) exitwith {};
#include "premiumMissionDefines.sqf";

private ["_boxes1", "_box1", "_box2", "_box3","_geoPos","_sniper","_marker1","_sniper1","_sniper2","_currBox1","_currBox2","_currBox3","_smokemarker"];

_setupVars =
{
	_missionType = "Ghost Sniper";
	_locationsArray = SniperMissionMarkers;
};

_setupObjects =
{

	_missionPos = markerPos _missionLocation;

	_geoPos = _missionPos vectorAdd ([[500 + random 500, 0, 0], random 360] call BIS_fnc_rotateVector2D);	

	// Sniper One
	_aiGroup = createGroup CIVILIAN;
    _sniper = [_aiGroup, _missionPos] call createRandomSoldier;
    _sniper setPosATL [_geoPos select 0, _geoPos select 1, 0];

	_sniper addUniform "U_I_FullGhillie_sard";
	_sniper addVest "V_PlateCarrierIA1_dgtl";
	_sniper addItem "NVGoggles";
	_sniper assignItem "NVGoggles";
	_sniper addMagazine "5Rnd_127x108_APDS_Mag";
	_sniper addWeapon "srifle_GM6_camo_F";
	_sniper addPrimaryWeaponItem "optic_LRPS_ghex_F";
	_sniper addMagazine "5Rnd_127x108_APDS_Mag";
	_sniper addMagazine "5Rnd_127x108_APDS_Mag";
	_sniper addMagazine "5Rnd_127x108_APDS_Mag";
	_sniper addMagazine "5Rnd_127x108_APDS_Mag";	

	_sniper addRating 9999999;
	_sniper setUnitPos "DOWN";
	_sniper = leader _aiGroup;

	_geoPos = _missionPos vectorAdd ([[500 + random 500, 0, 0], random 360] call BIS_fnc_rotateVector2D);	
	// Sniper Two
	_aiGroup = createGroup CIVILIAN;
    _sniper1 = [_aiGroup, _missionPos] call createRandomSoldier;
    _sniper1 setPosATL [_geoPos select 0, _geoPos select 1, 0];

	_sniper1 addUniform "U_I_FullGhillie_sard";
	_sniper1 addVest "V_PlateCarrierIA1_dgtl";
	_sniper1 addItem "NVGoggles";
	_sniper1 assignItem "NVGoggles";
	_sniper1 addMagazine "5Rnd_127x108_APDS_Mag";
	_sniper1 addWeapon "srifle_GM6_camo_F";
	_sniper1 addPrimaryWeaponItem "optic_LRPS_ghex_F";
	_sniper1 addMagazine "5Rnd_127x108_APDS_Mag";
	_sniper1 addMagazine "5Rnd_127x108_APDS_Mag";
	_sniper1 addMagazine "5Rnd_127x108_APDS_Mag";
	_sniper1 addMagazine "5Rnd_127x108_APDS_Mag";	

	_sniper1 addRating 9999999;
	_sniper1 setUnitPos "DOWN";
	
	_geoPos = _missionPos vectorAdd ([[500 + random 500, 0, 0], random 360] call BIS_fnc_rotateVector2D);	
	// Sniper Third
	_aiGroup = createGroup CIVILIAN;
    _sniper2 = [_aiGroup, _missionPos] call createRandomSoldier;
    _sniper2 setPosATL [_geoPos select 0, _geoPos select 1, 0];

	_sniper2 addUniform "U_I_FullGhillie_sard";
	_sniper2 addVest "V_PlateCarrierIA1_dgtl";
	_sniper2 addItem "NVGoggles";
	_sniper2 assignItem "NVGoggles";
	_sniper2 addMagazine "5Rnd_127x108_APDS_Mag";
	_sniper2 addWeapon "srifle_GM6_camo_F";
	_sniper2 addPrimaryWeaponItem "optic_LRPS_ghex_F";
	_sniper2 addMagazine "5Rnd_127x108_APDS_Mag";
	_sniper2 addMagazine "5Rnd_127x108_APDS_Mag";
	_sniper2 addMagazine "5Rnd_127x108_APDS_Mag";
	_sniper2 addMagazine "5Rnd_127x108_APDS_Mag";	

	_sniper2 addRating 9999999;
	_sniper2 setUnitPos "DOWN";	
	
	[_sniper,_sniper1,_sniper2] joinSilent _aiGroup;
	

    _aiGroup setCombatMode "RED";
    _aiGroup setBehaviour "COMBAT";	
 
	_marker1 = createMarker ["SniperArea", _missionPos];
	_marker1 setMarkerShape "ELLIPSE";
	_marker1 setMarkerSize [1000,1000];	
	_marker1 setMarkerBrush "FDiagonal";
	_marker1 setMarkerColor "colorOPFOR";
	
	_missionPicture = "media\ghost.jpg";		
	_missionHintText = format ["<br/>Three <t color='%1'>Ghost Snipers</t> are targeting players randomly. They seem to be changing position supernaturally and very frequently! <br/>Try and track their positions and take him out!", premiumMissionColor];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	deleteMarker "SniperArea";
};

_successExec =
{
	// Mission completed

	deleteMarker "SniperArea";

	// Mission completed

	_Boxes1 = ["Box_IND_Wps_F","Box_East_Wps_F","Box_NATO_Wps_F","Box_NATO_AmmoOrd_F","Box_NATO_Grenades_F","Box_East_WpsLaunch_F","Box_NATO_WpsLaunch_F","Box_East_WpsSpecial_F","Box_NATO_WpsSpecial_F"];    
	_currBox1 = _Boxes1 call BIS_fnc_selectRandom;
	_box1 = createVehicle [_currBox1, _lastPos, [], 2, "None"];
	_box1 setDir random 360;
	_box1 setVariable ["cmoney", 1000000, true];	
	_box1 allowDamage false;

	_currBox2 = _Boxes1 call BIS_fnc_selectRandom;
	_box2 = createVehicle [_currBox2, _lastPos, [], 2, "None"];
	_box2 setDir random 360;
	_box2 setVariable ["cmoney", 1000000, true];	
	_box2 allowDamage false;
	
	_currBox3 = _Boxes1 call BIS_fnc_selectRandom;
	_box3 = createVehicle [_currBox2, _lastPos, [], 2, "None"];
	_box3 setDir random 360;
	_box3 setVariable ["cmoney", 1000000, true];	
	_box3 allowDamage false;	
	
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2, _box3];
	
	//Smoke to mark the crates
	_smokemarker = createMarker ["SMMarker1", _lastPos];
	[_smokemarker] spawn CrateSmoke; //Calls repeating green smoke grenade
	uiSleep 2;		
	deleteMarker "SMMarker1";		

	_successHintMessage = "The Ghost Snipers were successfully located and assasinated. Job Really Well Done! Now collect $1 million dollars for each Sniper Dispatched.";
};

_this call premiumMissionProcessor;
