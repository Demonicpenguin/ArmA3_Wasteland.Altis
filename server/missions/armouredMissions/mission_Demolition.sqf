// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//  @file Name: mission_Roulette.sqf
//  @file Author: JoSchaap, AgentRev, GriffinZS, RickB, soulkobk, SoulStalker
 
if (!isServer) exitwith {};
#include "armouredMissionDefines.sqf";
 
private ["_positions", "_camonet", "_hostage", "_hostage2", "_vehicleName", "_randomBox", "_randomCase", "_box1", "_para", "_geoPos", "_radSource", "_obj1", "_obj2", "_mortar1", "_mortar2", "_aaSupport1", "_aaSupport2", "_armyPos", "_scientist"];
 
_setupVars =
{
    _missionType = "Radioactive Tower Demolition";
    _locationsArray = DemolitionMissionMarkers;
};
 
_setupObjects =
{
    _missionPos = markerPos _missionLocation;
	_armyPos = _missionPos vectorAdd ([[25 + random 20, 0, 0], random 360] call BIS_fnc_rotateVector2D);
    _aaPos = _armyPos vectorAdd ([[50 + random 25, 0, 0], random 360] call BIS_fnc_rotateVector2D);	
	_geoPos = _missionPos vectorAdd ([[25 + random 20, 0, 0], random 360] call BIS_fnc_rotateVector2D);
	

	//[[[_missionPos], "addons\scripts\Radiation_Zone.sqf"], "BIS_fnc_execVM", true, true] call BIS_fnc_MP;	// works locally and on clients but has a performance hit	

	[[_missionPos], "addons\scripts\Radiation_Zone.sqf"] remoteExec ["execVM", 0, true];					// Have not tested this version of command	
	
	//[[[_missionPos],"addons\scripts\Radiation_Zone.sqf"],BIS_fnc_execVM] remoteExec ["call",-2,false];	// works locally but does not work on clients and has a performance hit
	//_radPos = [_missionPos] call compile preprocessFileLineNumbers "addons\scripts\Radiation_Zone.sqf";	// works with very little performance hit but doesn't work on clients
	
   
    //delete existing base parts and vehicles at location
    _baseToDelete = nearestObjects [_missionPos, ["All"], 25];
    { deleteVehicle _x } forEach _baseToDelete;
   
    _camonet = createVehicle ["Land_IRMaskingCover_02_F", [_missionPos select 0, _missionPos select 1], [], 0, "CAN COLLIDE"];
    _camonet allowdamage false;
    _camonet setDir random 360;
    _camonet setVariable ["R3F_LOG_disabled", false];
 
    _missionPos = getPosATL _camonet;
	
    _scientistGroup = createGroup CIVILIAN;
    _scientist = _scientistGroup createUnit ["C_man_polo_1_F", _missionPos, [], 5, "None"];
    _scientist addRating 9000;
    _scientist setPosATL _missionPos;
    _scientist addUniform "U_C_Scientist";
    _scientist addVest "V_PlateCarrierIAGL_oli";
	_scientist additem "G_AirPurifyingRespirator_02_black_F";
	_scientist assignItem "G_AirPurifyingRespirator_02_black_F";	
    _scientist playMove "Stand";
    _scientist disableAI "PATH";
	
    _aaSupport1 = createVehicle ["O_APC_Tracked_02_AA_F", _aaPos, [], 5, "None"];
	_aaSupport1 setPosATL [(_missionPos select 0) - 15, (_missionPos select 1) + 15, _missionPos select 2];	

    _aaSupport2 = createVehicle ["I_MBT_03_cannon_F", _aaPos, [], 5, "None"];
	_aaSupport2 setPosATL [(_missionPos select 0) + 15, (_missionPos select 1) - 15, _missionPos select 2];	

	_aiGroup = createGroup CIVILIAN;
	[_aiGroup,_missionPos,24,50] spawn createCustomGroup8;

	
	_radSource = [_missionPos] call compile preprocessFileLineNumbers "addons\scripts\CreateRadSource.sqf";
	smoke = "test_EmptyObjectForSmoke" createVehicle position _radSource; smoke attachTo[_radSource,[0,1.5,-1]];    
      
    _aiGroup setCombatMode "RED";
    _aiGroup setBehaviour "COMBAT";

	_missionPicture = "media\demolition.jpg";	
    _missionHintText = format ["<br/>A Damaged Radio Tower is leaking radiation across<t color='%2'> ALTIS. </t>Don the correct protective gear. Head over there and blow up the Radio Tower on the advice of the Radiation Expert. Kill the Specialist Security Unit and eliminate the radiation source from our beloved<t color='%2'> ALTIS </t>! Make sure the Scientist survives!!!", armouredMissionColor];
};

 
_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_ignoreAiDeaths = true;
_waitUntilCondition = {!alive _scientist}; // radiation expert died - fail
_waitUntilSuccessCondition = {alive _scientist && getDammage _radSource >= 1}; // radiation expert survived and tower destroyed - win


 
_failedExec = 
{
    // Mission failed
   
    { deleteVehicle _x } forEach [_camonet, _radSource, _aaSupport1, _aaSupport2, smoke, _scientist];
    _failedHintMessage = format ["Excellent work. You ASSHOLES! You let the Expert Die. Our little Rabbits and Snakes have all died."];
	deleteMarker "Warning_Marker_1";
	deleteMarker "Kavala";
	deletevehicle Rad_Zone_1;
};
 
_successExec =
{
    // Mission completed
   
    { deleteVehicle _x } forEach [_camonet, _aaSupport1, _aaSupport2, smoke, _scientist];
	deleteMarker "Warning_Marker_1";
	deleteMarker "Kavala";
	deletevehicle Rad_Zone_1;	
	
	{
		deleteVehicle _x;
	}forEach units _aiGroup;
	deleteGroup _aiGroup;
    
	_randomBox = ["mission_USLaunchers","mission_USSpecial","mission_Main_A3snipers"] call BIS_fnc_selectRandom;
	_randomCase = ["Box_FIA_Support_F","Box_FIA_Wps_F","Box_FIA_Ammo_F","Box_NATO_WpsSpecial_F","Box_East_WpsSpecial_F","Box_NATO_Ammo_F","Box_East_Ammo_F"] call BIS_fnc_selectRandom;
	
	_box1 = createVehicle [_randomCase,[(_missionPos select 0), (_missionPos select 1),0],[], 0, "NONE"];
	_box1 setDir random 360;
	_box1 addItemCargoGlobal ["H_RacingHelmet_1_black_F",1];
	_box1 allowdamage false;
	_box1 setVariable ["cmoney", 1500000, true];	
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _radSource];

	playSound3D ["A3\data_f_curator\sound\cfgsounds\air_raid.wss", _box1, false, _box1, 15, 1, 1500];
   
       
    _successHintMessage = format ["Great job Soldier. Altis wildlife is safe once more. Enjoy your reward, pick it up at mission marker location."];
};
 
_this call armouredMissionProcessor;