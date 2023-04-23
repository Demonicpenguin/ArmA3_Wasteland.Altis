// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2018 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: recycleObject.sqf
//  @file Description: Recycle useless objects

if !(["Are you sure you want to recycle this object?", "Confirm", true, true] call BIS_fnc_guiMessage) exitWith {};

private ["_amount", "_success", "_time", "_checks"];

_time = 3;
_amount = 5000;

if( cursorTarget isKindOf "ReammoBox_F" ) then { _amount = selectRandom [7000, 9500, 9750, 11000, 11250, 11500, 11750, 22000, 22250, 22500, 22750, 33000, 33500, 34000, 34500, 34750, 35000, 35500]; };

_checks = {

	private ["_progress", "_object", "_failed", "_text"];

	_progress = _this select 0;
	_object = _this select 1;
	_failed = true;

	switch (true) do {
		case (!alive player): { _text = "" };
		case (vehicle player != player): { _text = "Action failed! You can't do this in a vehicle" };
		case (isNull _object): { _text = "The object no longer exists" };
		case (!isNull (_object getVariable ["R3F_LOG_est_deplace_par", objNull])): { _text = "Action failed! Somebody moved the object" };
		case (!isNull (_object getVariable ["R3F_LOG_est_transporte_par", objNull])): { _text = "Action failed! Somebody loaded or towed the object" };
		case (doCancelAction): { doCancelAction = false; _text = "Recycling has been cancelled" };
		default {
			_failed = false;
			_text = format ["Recycling %1%2 complete", floor (_progress * 100), "%"];
		};

  };

	[_failed, _text];
};

_firstCheck = [0, cursorObject] call _checks;

if (_firstCheck select 0) exitWith { [_firstCheck select 1, 5] call mf_notify_client; };

mutexScriptInProgress = true;

_success = [_time, format ["AinvPknlMstpSlayW%1Dnon_medic", [player, true] call getMoveWeapon], _checks, [cursorTarget]] call a3w_actions_start;

mutexScriptInProgress = false;

if( _success ) then {

	//Payout
	deleteVehicle cursorTarget;
	player setVariable ["cmoney", (player getVariable ["cmoney", 0]) + _amount, true];
	[format ["You have obtained $%1 from recycling", [_amount] call fn_numbersText], 5] call mf_notify_client;

};
