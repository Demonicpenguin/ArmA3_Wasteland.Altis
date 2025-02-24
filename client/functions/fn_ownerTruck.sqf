// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: fn_ownerTruck.sqf
//	@file Author: Gigatek, Wiking, Lodac, Cael817, LouD

#define ChangeOwner_Distance (["ChangeOwner_Distance", 30] call getPublicVar)
#define ChangeOwner_Price (["ChangeOwner_Price", 2] call getPublicVar)

// Check if mutex lock is active.
if (mutexScriptInProgress) exitWith
{
	["You are already performing another action.", 5] call mf_notify_client;
};

mutexScriptInProgress = true;

_truck = _this select 0;
_unit = _this select 1;
_vehicle = vehicle _unit;

//check if caller is the driver
if (_unit != driver _vehicle) exitWith
{
	["You must be in the driver seat to change ownership.", 5] call mf_notify_client;
	mutexScriptInProgress = false;
};

// check if player already owns vehicle

_vehicleUIDCheck = _vehicle getVariable ["ownerUID", ""];

if (_vehicleUIDCheck == getPlayerUID player) exitWith
{
	["You already own this vehicle, change ownership canceled.", 5] call mf_notify_client;
	mutexScriptInProgress = false;
};

//set up prices
_vehClass = typeOf _vehicle;
_playerMoney = player getVariable "cmoney";
_price = 10000; // price = 10000 for vehicles not found in vehicle store.

{
	if (_vehClass == _x select 1) exitWith
	{
		_price = (ceil (((_x select 2) / ChangeOwner_Price) / 5)) * 5;
	};
} forEach (call allVehStoreVehicles);

_text = format ["Stop engine within 10 seconds to change ownership. Price is 1/2 of vehicle store price, stay in the vehicle until the next message appears.", _price];
[_text, 5] call mf_notify_client;

uiSleep 10;

// Ensure the player has enough money
if (_price > _playerMoney) exitWith
{
	_text = format ["You need $%2 to change ownership on %1", _vehClass, _price];
	[_text, 5] call mf_notify_client;
	playSound "FD_CP_Not_Clear_F";
	mutexScriptInProgress = false;
};

if (isEngineOn _vehicle) exitWith
{
	["Engine still running. Deal CANCELLED!", 5] call mf_notify_client;
	mutexScriptInProgress = false;
};

if (!local _vehicle) then
{
	_crew = crew _vehicle;
	_text = format ["Change ownership aborted by %1", if (count _crew > 0 && !isStreamFriendlyUIEnabled) then { name (_crew select 0) } else { "another player" }];
	[_text, 5] call mf_notify_client;
	mutexScriptInProgress = false;
};

_started = true;
if (_vehicle distance _truck > ChangeOwner_Distance || vehicle _unit != _vehicle) then
{
	if (_started) then { ["Change ownership aborted", 5] call mf_notify_client };
	mutexScriptInProgress = false;
};

if (!isNil "_price") then 
{
	// Add total sell value to confirm message
	_confirmMsg = format ["Changing ownership on %1 will cost you $%2 for:<br/>", _vehClass, _price];
	_confirmMsg = _confirmMsg + format ["<br/><t font='EtelkaMonospaceProBold'>1</t> x %1", _vehClass];

	// Display confirm message
	if ([parseText _confirmMsg, "Confirm", "OK", true] call BIS_fnc_guiMessage) then
	{
		if !(objectParent player isKindOf "ship") then {
			// get everyone out of the vehicle
			_vehicleCrewArr = crew _vehicle;
			{
				_x action ["Eject", vehicle _x];
			} foreach _vehicleCrewArr;
		};
		
		_vehicle lock true;
	
		player setVariable["cmoney",(player getVariable "cmoney")-_price,true];
		player setVariable["timesync",(player getVariable "timesync")+(_price * 3),true];
		[] spawn fn_savePlayerData; // Changed call to spawn
		["Changing ownership will take about 1 minute", 10] call mf_notify_client;
		playSound "FD_Finish_F";
		_vehicle setVelocity [0,0,0];
		_vehicle setFuel 0;
		_text = format ["Changing owner for %1 for $%2. Removing VIN, tags and other items.", _vehClass, _price];
		[_text, 5] call mf_notify_client;

		sleep 5;
		["Submitting application to district office.", 5] call mf_notify_client;
		sleep 5;
		["Waiting for background check to clear. You didn't steal this, did you?", 5] call mf_notify_client;
		sleep 5;
		["Application approved!.", 5] call mf_notify_client;
		sleep 5;
		["Adding new VIN.", 5] call mf_notify_client;
		sleep 5;		
		["Typing new pink slip.", 5] call mf_notify_client;
		sleep 5;
		["Installing new locks", 5] call mf_notify_client;
		playSound3d ["a3\sounds_f\air\Heli_Attack_01\close.wss",  _vehicle, false, getPosASL _vehicle, 10, 1, 20 max sizeOf _vehClass];		
		sleep 5;
		["Repairing.", 5] call mf_notify_client;
		_vehicle setDamage 0;
		sleep 5;
		["Rearming.", 5] call mf_notify_client;
		playSound3D ["A3\Sounds_F\arsenal\weapons_static\Static_HMG\reload_static_HMG.wss", _vehicle, false, getPosASL _vehicle, 10, 1, 20 max sizeOf _vehClass];		
		_vehicle setVehicleAmmo 1;
		sleep 5;
		["Finishing up and refuelling.", 5] call mf_notify_client;

		_vehicle setVelocity [0,0,0];
		_vehicle setFuel 1;
		_vehicle setVariable ["A3W_purchasedVehicle", true, true];
		_vehicle setVariable ["ownerUID", getPlayerUID player, true];
		//_vehicle setVariable ["vehOwnerName", name player, true];	//un remmed to see if it fixes owner name issue
		_vehicle setVariable ["ownedVehicle", true, true];
		_vehicle setVariable ["ownerName", name player, true];		
		[_vehicle, 1] call A3W_fnc_setLockState; // Unlock

		if (_vehicle getVariable ["A3W_skipAutoSave", false]) then
		{
			_vehicle setVariable ["A3W_skipAutoSave", nil, true];
		};

		if (!isNil "fn_manualVehicleSave") then
		{
			_vehicle call fn_manualVehicleSave;
		};
		playSound "FD_Finish_F";
		_text = format ["%1 Is now yours to lock (and it saves too)! It is also fully repaired, rearmed and refuelled.", _vehClass];
		[_text, 10] call mf_notify_client;
		mutexScriptInProgress = false;
	} else {
	mutexScriptInProgress = false;
	};
} else {
	hint parseText "<t color='#ffff00'>An unknown error occurred.</t><br/>Cancelled.";
	playSound "FD_CP_Not_Clear_F";
	mutexScriptInProgress = false;
};
