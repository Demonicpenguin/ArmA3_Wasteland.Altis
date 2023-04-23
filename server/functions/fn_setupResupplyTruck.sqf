// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2016 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: fn_setupResupplyTruck.sqf
//	@file Author: AgentRev

#define RS_ITEM_CONDITION "alive _target"
#define RS_OBJECT_CONDITION "(_target getVariable ['lockedSafe', false]) && _target getVariable ['A3W_resupplyTruck', false] && _target getVariable ['A3W_resupplyCount', 0] > 0"
#define RS_PLAYER_CONDITION "alive objectParent _this && attachedTo _target != vehicle _this && !((vehicle _this) getVariable ['A3W_resupplyTruck', false])"
#define RS_DISTANCE "(_target distance vehicle _this <= (10 max (sizeOf typeOf vehicle _this * 0.75)) || _target isKindOf 'Land_Pier_Box_F')"
//#define RS_VEHICLE_SEAT "currentPilot vehicle _this == _this"
#define RS_VEHICLE_SEAT "(vehicle _this) isKindOf 'Helicopter'"	//vehicle _this) in thislist && 

params [["_veh",objNull,[objNull]], ["_static",false,[false]]];

if (_veh getVariable ["A3W_resupplyTruckSetup", false]) exitWith {};

if (hasInterface) then
{
	_veh addAction ["<img image='client\icons\repair.paa'/> Resupply Vehicle", "client\functions\fn_resupplyTruck.sqf", [], 51, false, true, "", "alive _target && alive objectParent _this && attachedTo _target != vehicle _this && _target distance vehicle _this <= (10 max (sizeOf typeOf vehicle _this * 0.75)) && (isNil 'mutexScriptInProgress' || {!mutexScriptInProgress})"]; // _target = truck, _this = player

	// _target = truck, _this = player
	_veh addAction ["<t color='#31AD08'><img image='client\icons\repair.paa'/> Resupply Vehicle</t>", "client\functions\fn_resupplyTruck.sqf", [], 51, false, true, "", RS_ITEM_CONDITION + " && !" + RS_OBJECT_CONDITION + " && " + RS_PLAYER_CONDITION + " && " + RS_DISTANCE + " && " + RS_VEHICLE_SEAT];
	_veh addAction ["<t color='#BA150D'><img image='client\icons\repair.paa'/> Access Security Settings (Resupply Locked)</t>", "addons\resupply\SecuritySettings.sqf", [cursorTarget], 51, false, true, "", RS_ITEM_CONDITION + " && " + RS_PLAYER_CONDITION + " && " + RS_OBJECT_CONDITION + " && " + RS_DISTANCE];
	
	
};

if (local _veh) then
{
	_veh setAmmoCargo 0;
	_veh setFuelCargo 0;
	_veh setRepairCargo 0;

	clearBackpackCargoGlobal _veh;
	clearMagazineCargoGlobal _veh;
	clearWeaponCargoGlobal _veh;
	clearItemCargoGlobal _veh;

	if (_static) then
	{
		_veh lock 2;
		_veh enableRopeAttach false;
	};
};

if (_static) then
{
	_veh allowDamage false;
	_veh setVariable ["A3W_lockpickDisabled", true];
	_veh setVariable ["R3F_LOG_disabled", true];
	
	_marker = createMarker ["Service_Icon_" + netId _veh, getPosATL _veh];
	_marker setMarkerShape "ICON";
	_marker setMarkerType "o_service";
	_marker setMarkerText "";
	_marker setMarkerColor "ColorBlue";
	_marker setMarkerSize [0.5, 0.5];
	_marker setMarkerDir 270;	

	if (isServer) then
	{
		_veh setDamage 0;
		_veh enableSimulationGlobal false;
	}
	else
	{
		_veh enableSimulation false;
	};
};

_veh setVariable ["A3W_resupplyTruck", true];
_veh setVariable ["A3W_resupplyTruckSetup", true];
