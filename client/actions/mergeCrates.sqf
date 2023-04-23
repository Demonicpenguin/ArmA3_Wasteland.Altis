// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2018 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mergeCrates.sqf
//  @file Description: Merges the contents crates

private ["_crate", "_crates", "_target", "_cargo", "_count", "_time", "_skip", "_firstCheck", "_mags", "_packs", "_weapons", "_index"];

// Check if mutex lock is active.
if (mutexScriptInProgress) exitWith { player globalChat "You are already performing another action."; };

//Find Nearest Crates
_crate = cursorTarget;
_crates = nearestObjects [_crate, ["ReammoBox_F","I_CargoNet_01_ammo_F", "O_CargoNet_01_ammo_F", "B_CargoNet_01_ammo_F"], 4];

if( count _crates == 1) exitWith { hint "No nearby crate to merge with"; };

//Nearest crate, not the source
_target = _crates select 1;
_time = 4;

_checks = {

  private ["_progress", "_object", "_failed", "_text"];

  _progress = _this select 0;
  _object = _this select 1;
  _failed = true;

  switch (true) do
  {
    case (!alive player): { _text = "" };
    case (vehicle player != player): { _text = "Action failed! You can't do this in a vehicle" };
    case (isNull _object): { _text = "The object no longer exists" };
    case (!isNull (_object getVariable ["R3F_LOG_est_deplace_par", objNull])): { _text = "Action failed! Somebody moved the object" };
    case (!isNull (_object getVariable ["R3F_LOG_est_transporte_par", objNull])): { _text = "Action failed! Somebody loaded or towed the object" };
    case (doCancelAction): { doCancelAction = false; _text = "Merging has been cancelled" };
    default
    {
      _failed = false;
      _text = format ["Merging %1%2 complete", floor (_progress * 100), "%"];
    };
  };

  [_failed, _text];
};

_firstCheck = [0, _crate] call _checks;

if (_firstCheck select 0) exitWith { [_firstCheck select 1, 5] call mf_notify_client; };

mutexScriptInProgress = true;

_success = [_time, format ["AinvPknlMstpSlayW%1Dnon_medic", [player, true] call getMoveWeapon], _checks, [_crate]] call a3w_actions_start;

mutexScriptInProgress = false;

if( _success ) then {

  //Get items from target crate in array [item, quantity]
  _count = 0;
  _skip = 0;
  _cargo = (getItemCargo _target) call cargoToPairs;
  _mags = (getMagazineCargo _target) call cargoToPairs;
  _weapons = (getWeaponCargo _target) call cargoToPairs;
  _packs = (getBackpackCargo _target) call cargoToPairs;

  clearItemCargoGlobal _target;
  clearBackpackCargoGlobal _target;
  clearMagazineCargoGlobal _target;
  clearWeaponCargoGlobal _target;

  {

    _index = _forEachIndex;

    {

      _item = _x select 0;
      _size = _x select 1;

      while { _size > 0 && (_crate canAdd [_item, 1]) } do {

        diag_log format["Adding Item:%1", _item];

        //Move to source crate
        switch(_index)do {
        case (0): {_crate addItemCargoGlobal [_item, 1];};
        case (1): {_crate addMagazineCargoGlobal [_item, 1];};
        case (2): {_crate addWeaponCargoGlobal [_item, 1];};
        case (3): {_crate addBackpackCargoGlobal [_item, 1];};
        };

        _count = _count + 1;
        _size = _size - 1;

      };

      _skip = _skip + _size;

      //Leave in original crate
      switch(_index)do {
      case (0): {_target addItemCargoGlobal [_item, _size];};
      case (1): {_target addMagazineCargoGlobal [_item, _size];};
      case (2): {_target addWeaponCargoGlobal [_item, _size];};
      case (3): {_target addBackpackCargoGlobal [_item, _size];};
      };

    } forEach _x;

  } forEach [_cargo, _mags, _weapons, _packs];

  private _picture = getText(configfile >> "CfgVehicles" >> typeOf _crate >> "editorPreview");

  if( _count == 0 ) then {

    hint parseText format [
    		"<t shadow='2' color='#BA150D' size='1.75'>Merge Failed</t><br/>" +
    		"<t color='#BA150D'>--------------------------------</t><br/>" +
    		"<t color='#BA150D' size='1.05'>Could not merge anything into this crate, it is already full</t><br/>" +
        "<t size='.15'> </t><br/>" +
        "<img size='5' image='%1'/><br/>",
        _picture];

    //Buzzer
    playMusic "ErrorSound";

  } else {

    hint parseText format [
    		"<t shadow='2' color='#31AD08' size='1.75'>Merge Successful</t><br/>" +
    		"<t color='#31AD08'>--------------------------------</t><br/>" +
    		"<t size='1.05'>%1 of %2 items were merged into this crate. The remaining %3 would not fit.</t><br/>" +
        "<t size='.15'> </t><br/>" +
        "<img size='5' image='%4'/><br/>",
        _count,
    		_count + _skip,
    		_skip,
        _picture];

    playSound "defaultNotification";

  };

};
