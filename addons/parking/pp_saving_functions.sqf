if (!isNil "parking_saving_functions_defined") exitWith {};
diag_log format["Loading parking saving functions ..."];

#include "macro.h"

if (isServer) then {
  pp_notify = {
    //diag_log format["%1 call pp_notify", _this];
    ARGVX3(0,_player,objNull);
    ARGVX3(1,_msg,"");
    ARGV3(2,_dialog,"");


    pp_notify_request = [_msg,OR(_dialog,nil)];
    (owner _player) publicVariableClient "pp_notify_request";
  };

  pp_mark_vehicle = {
    //diag_log format["%1 call pp_create_mark_vehicle", _this];
    ARGVX3(0,_player,objNull);
    ARGVX3(1,_vehicle,objNull);

    pp_mark_vehicle_request = [_vehicle];
    (owner _player) publicVariableClient "pp_mark_vehicle_request";
  };

  pp_is_safe_position = {
    ARGVX3(0,_player,objNull);
    ARGVX3(1,_class,"");
    ARGVX3(2,_position,[]);

    def(_classes);
    _classes = ["Helicopter", "Plane", "Ship_F", "Car", "Motorcycle", "Tank"];

    def(_size);
    _size = sizeof _class;

    ((_position distance _player) < 150 && {
     (count(nearestObjects [_position, _classes , _size]) == 0)})
  };

  if (call A3W_savingMethod == "extDB") then
  {
    v_addSaveVehicle =
    {
      params ["_parked_vehicles", "_vehicle"];

      private _vehID = [_vehicle, 0, true] call fn_saveVehicle;
      private _vehProps = _vehicle getVariable "A3W_parkedProperties";

      if (isNil "_vehProps") exitWith {nil};
      _vehicle setVariable ["A3W_parkedProperties", nil];
      if (isNil "_vehID") exitWith {nil};

      [_parked_vehicles, _vehID, _vehProps] call fn_setToPairs;
      true
    };

    v_restoreVehicle =
    {
      params ["_data_pair", ["_ignore_expiration",false,[false]], ["_create_array",[],[[]]]];

      _data_pair params ["_vehicleID", "_vehData"];
      private _pos = _create_array select 1;
      private _safeDistance = _create_array select 3;

      [_vehData, "Position", _pos] call fn_setToPairs;
      [_vehData, "Direction"] call fn_removeFromPairs;
      [_vehData, "Velocity"] call fn_removeFromPairs;

      private _varNames = call fn_getVehicleVars;
      private _varVals = [_vehData, _varNames] call fn_preprocessSavedData;

      private ["_veh", "_hoursAlive", "_hoursUnused"];
      //private (_varVals apply {_x select 0});
      //{ (_x select 1) call compile format ["%1 = _this", _x select 0] } forEach _varVals;
      [] params _varVals; // automagic assignation

      private _lockState = [1,2] select (["A3W_vehicleLocking"] call isConfigOn && round getNumber (configFile >> "CfgVehicles" >> _class >> "isUav") < 1);

      // delete wrecks near spawn
      {
        if (!alive _x) then
        {
          deleteVehicle _x;
        };
      } forEach nearestObjects [_markerPos, ["LandVehicle","Air","Ship"], 25 max sizeOf _class];

      call fn_restoreSavedVehicle;

      _veh call fn_manualVehicleSave;
      _veh
    };
  };

  pp_park_vehicle_request_handler = {
    ARGVX3(1,_this,[]);
    ARGVX3(0,_player,objNull);
    ARGVX3(1,_vehicle,objNull);

    if (not(alive _vehicle)) exitWith {};

    def(_uid);
    _uid = getPlayerUID _player;

    private _vehOwner = _vehicle getVariable ["ownerUID",""];

    if !(_vehOwner in ["",_uid]) exitWith {
      [_player, format ["Someone else has the ownership of the %1, you cannot park it.", ([typeOf _vehicle] call generic_display_name)], "Parking Error"] call pp_notify;
    };

/*********************************************************************************************************/
	
	switch (true) do
	{
		case (_vehicle isKindOf "HAFM_Virginia"):				// Test to remove DDS and SDV from subs before parking
		{
			[_vehicle, 0] call HAFM_fnc_SubAttachment;			
		};
		case (_vehicle isKindOf "HAFM_Yasen"):
		{
			[_vehicle, 0] call HAFM_fnc_SubAttachment;			
		};							
		case (_vehicle isKindOf "HAFM_214"):
		{
			[_vehicle, 0] call HAFM_fnc_SubAttachment;			
		};							
		case (_vehicle isKindOf "HAFM_209"):
		{
			[_vehicle, 0] call HAFM_fnc_SubAttachment;			
		};
	};

/*********************************************************************************************************/	
	
    diag_log format["Parking vehicle %1(%2) for player %3(%4)", typeOf _vehicle, netId _vehicle,  (name _player), _uid];

    def(_parked_vehicles);
    _parked_vehicles = _player getVariable "parked_vehicles";
    _parked_vehicles = OR(_parked_vehicles,[]);

    if (_vehOwner isEqualTo "") then {
      _vehicle setVariable ["ownerUID", _uid];
    };

    private _saveFlag = (_vehicle getVariable ["A3W_purchasedVehicle", false] || _vehicle getVariable ["A3W_missionVehicle", false]);

    if !(_saveFlag) then {
      _vehicle setVariable ["A3W_purchasedVehicle", true];
    };

    [_this, _player, _vehicle, _uid, _vehOwner, _parked_vehicles, _saveFlag] spawn
    {
      params ["_this", "_player", "_vehicle", "_uid", "_vehOwner", "_parked_vehicles", "_saveFlag"];

      def(_added);
      _added = [_parked_vehicles, _vehicle, false] call v_addSaveVehicle;

      if (isNil "_added") exitWith {
        if (_vehOwner isEqualTo "") then {
          _vehicle setVariable ["ownerUID", nil];
        };

        if !(_saveFlag) then {
          _vehicle setVariable ["A3W_purchasedVehicle", nil];
        };

        diag_log format["ERROR: Could not park vehicle %1(%2) for player %3(%4)", typeOf _vehicle, netId _vehicle,  (name _player), _uid];
        [_player, format["An unknown error happened while trying to park the %1", ([typeOf _vehicle] call generic_display_name)], "Parking Error"] call pp_notify;
      };

      def(_display_name);
      _display_name = [typeOf _vehicle] call generic_display_name;

      private _attachedObjs = attachedObjects _vehicle;
      if (!isNil "fn_untrackSavedVehicle") then { _vehicle call fn_untrackSavedVehicle };
      deleteVehicle _vehicle;

      { ["detach", _x] call A3W_fnc_towingHelper } forEach _attachedObjs;

      _player setVariable ["parked_vehicles", _parked_vehicles]; //, true];
      ["parked_vehicles", _parked_vehicles] remoteExecCall ["A3W_fnc_setVarPlayer", _player];
      //[_player] call fn_saveAccount;
      [_player, format["%1, your %2 has been parked.", (name _player), _display_name]] call pp_notify;
    };
  };

  pp_retrieve_vehicle_request_handler = {
    ARGVX3(1,_this,[]);
    ARGVX3(0,_player,objNull);
    ARGVX3(1,_vehicle_id, "");

    def(_uid);
    _uid = getPlayerUID _player;

    diag_log format["Retrieving parked vehicle %1 for player %2(%3)", _vehicle_id,  (name _player), _uid];

    def(_parked_vehicles);
    _parked_vehicles = _player getVariable "parked_vehicles";
    _parked_vehicles = OR(_parked_vehicles,[]);

    def(_vehicle_data);
    _vehicle_data = [_parked_vehicles, _vehicle_id] call fn_getFromPairs;

    if (!isARRAY(_vehicle_data)) exitWith {
      diag_log format["ERROR: Could not retrieve vehicle %1 for player %2(%3)", _vehicle_id,  (name _player), _uid];
      [_player, format["An error occurred, your vehicle (%2) could not be retrieved. Please report this error to A3Armory.com.", _vehicle_id], "Retrieval Error"] call pp_notify;
    };

    //def(_position);
    //_position = [_vehicle_data, "Position"] call fn_getFromPairs;

    //def(_class);
    _class = [_vehicle_data, "Class"] call fn_getFromPairs;

    private ["_marker", "_markerPos", "_dirAngle", "_pos", "_posAGL"];
    private _nearbySpawns = allMapMarkers select {_x select [0,7] == "Parking" && {_x select [count _x - 6, 6] == "_spawn" && _player distance markerPos _x < 300}};

    if !(_nearbySpawns isEqualTo []) then
    {
      _marker = _nearbySpawns select 0;
      _markerPos = markerPos _marker;
      _dirAngle = markerDir _marker;

      if (surfaceIsWater _markerPos) then
      {
        _markerPos set [2, (getPosASL _player) select 2];
        _posAGL = ASLtoAGL _markerPos;
        _pos = if (round getNumber (configFile >> "CfgVehicles" >> _class >> "canFloat") > 0) then { _posAGL } else { ASLtoATL _markerPos };
      }
      else
      {
        _pos = _markerPos;
        _posAGL = _pos;
      };

      _pos set [2, (_pos select 2) + 0.1];
    };

    def(_create_array);
    //if (not([_player,_class,_position] call pp_is_safe_position)) then {
      //we don't have an exact safe position, let the game figure one out
      _create_array = [_class, if (isNil "_pos") then { getPos _player } else { _pos }, [], [0,50] select (isNil "_pos"), ""];
    //};

    def(_vehicle);
    _vehicle = [[_vehicle_id, _vehicle_data], true,OR(_create_array,nil)] call v_restoreVehicle;

	if (_vehicle isKindOf "ship") then {[_vehicle, 1] call A3W_fnc_setLockState;};	 // unLock
/***********************************************BOMOS****************************************************/
	
		if (count (_player nearObjects ["Land_Statue_02_F", 10]) > 0) then // Bomos
		{
			switch (true) do
			{
				case (_vehicle isKindOf "HAFM_Virginia"):				// Test to reposition ships/subs for easy player access
				{
					[_vehicle, 3] call HAFM_fnc_SubAttachment;			
					_vehicle setDir 206;			
					_vehicle setPosASL [2603.25,21755.762,13.737];
				};	
				case (_vehicle isKindOf "HAFM_MisBoat"):
				{
					_vehicle setDir 206;			
					_vehicle setPosASL [2546.161,21788.33,13.737];
				};							
				case (_vehicle isKindOf "HAFM_PBoat"):
				{
					_vehicle setDir 206;			
					_vehicle setPosASL [2546.161,21788.33,13.737];
				};	
				case (_vehicle isKindOf "HAFM_CB90"):
				{
					_vehicle setDir 206;			
					_vehicle setPosASL [2603.25,21755.762,18.478];
				};
				case (_vehicle isKindOf "HAFM_GunBoat"):
				{
					_vehicle setDir 206;			
					_vehicle setPosASL [2546.161,21788.33,13.737];
				};	
				case (_vehicle isKindOf "HAFM_GunBoat_BLU"):
				{
					_vehicle setDir 206;			
					_vehicle setPosASL [2546.161,21788.33,13.737];
				};							
				case (_vehicle isKindOf "HAFM_CB90_BLU"):
				{
					_vehicle setDir 206;			
					_vehicle setPosASL [2546.161,21788.33,13.737];
				};							
				case (_vehicle isKindOf "HAFM_PBoat_BLU"):
				{
					_vehicle setDir 206;			
					_vehicle setPosASL [2546.161,21788.33,13.737];
				};							
				case (_vehicle isKindOf "HAFM_Replenishment"):
				{
					_vehicle setDir 206;			
					_vehicle setPosASL [2536.96,21768.2,14.158];
				};							
				case (_vehicle isKindOf "HAFM_Russen"):
				{				
					_vehicle setDir 206;			
					_vehicle setPosASL [2546.161,21788.33,13.737];
				};							
				case (_vehicle isKindOf "HAFM_Admiral"):
				{
					_vehicle setDir 206;			
					_vehicle setPosASL [2546.161,21788.33,13.737];
				};							
				case (_vehicle isKindOf "HAFM_MEKO_TN"):
				{
					_vehicle setDir 206;			
					_vehicle setPosASL [2546.161,21788.33,13.737];
				};							
				case (_vehicle isKindOf "HAFM_MEKO_HN"):
				{
					_vehicle setDir 206;			
					_vehicle setPosASL [2546.161,21788.33,13.737];
				};							
				case (_vehicle isKindOf "HAFM_FREMM"):
				{
					_vehicle setDir 206;			
					_vehicle setPosASL [2536.96,21768.2,14.158];
				};							
				case (_vehicle isKindOf "HAFM_ABurke"):
				{
					_vehicle setDir 206;			
					_vehicle setPosASL [2536.96,21768.2,14.158];
				};							
				case (_vehicle isKindOf "HAFM_052C"):
				{
					_vehicle setDir 206;			
					_vehicle setPosASL [2536.96,21768.2,14.158];
				};							
				case (_vehicle isKindOf "HAFM_052D"):
				{
					_vehicle setDir 206;			
					_vehicle setPosASL [2536.96,21768.2,14.158];
				};							
				case (_vehicle isKindOf "HAFM_Yasen"):
				{
					[_vehicle, 3] call HAFM_fnc_SubAttachment;			
					_vehicle setDir 206;			
					_vehicle setPosASL [2603.25,21755.762,13.737];
				};							
				case (_vehicle isKindOf "HAFM_214"):
				{
					[_vehicle, 3] call HAFM_fnc_SubAttachment;			
					_vehicle setDir 206;			
					_vehicle setPosASL [2616.109,21748.385,13.737];
				};							
				case (_vehicle isKindOf "HAFM_209"):
				{
					[_vehicle, 3] call HAFM_fnc_SubAttachment;			
					_vehicle setDir 206;			
					_vehicle setPosASL [2616.109,21748.385,13.737];
				};							
				case (_vehicle isKindOf "HAFM_BUYAN"):
				{
					_vehicle setDir 206;			
					_vehicle setPosASL [2546.161,21788.33,13.737];
				};							
				case (_vehicle isKindOf "HAFM_MisBoat_BLU"):
				{
					_vehicle setDir 206;			
					_vehicle setPosASL [2546.161,21788.33,13.737];
				};							
				case (_vehicle isKindOf "HAFM_Corvette"):
				{
					_vehicle setDir 206;			
					_vehicle setPosASL [2546.161,21788.33,13.737];
				};							
				case (_vehicle isKindOf "HAFM_Frigate"):
				{
					_vehicle setDir 206;			
					_vehicle setPosASL [2546.161,21788.33,13.737];
				};							
				case (_vehicle isKindOf "A2_Fregata"):
				{
					_vehicle setDir 206;			
					_vehicle setPosASL [2546.161,21788.33,13.737];
				};							
				case (_vehicle isKindOf "HAFM_Frigate_OPF"):
				{
					_vehicle setDir 206;			
					_vehicle setPosASL [2546.161,21788.33,13.737];
				};							
				case (_vehicle isKindOf "HAFM_Corvette_OPF"):
				{
					_vehicle setDir 206;			
					_vehicle setPosASL [2546.161,21788.33,13.737];
				};							
				case (_vehicle isKindOf "HAFM_PBoat_OPF"):
				{
					_vehicle setDir 206;			
					_vehicle setPosASL [2546.161,21788.33,13.737];
				};
				default	// for all other watercraft
				{
					_vehicle setDir 114.976;			
					_vehicle setPosASL [2552.91,21707.5,10];				
				};			
			};	
		};

	
/*******************************************ISLAND*******************************************************/	

		if (count (_player nearObjects ["Land_Statue_01_F", 10]) > 0) then // Island Positions
		{
			switch (true) do
			{
				case (_vehicle isKindOf "HAFM_Virginia"):				// Test to reposition ships/subs for easy player access
				{
					[_vehicle, 3] call HAFM_fnc_SubAttachment;			
					_vehicle setDir 355;			
					_vehicle setPosASL [14217.053,13165.772,13.737];
				};	
				case (_vehicle isKindOf "HAFM_MisBoat"):
				{
					_vehicle setDir 84;
					_vehicle setPosASL [14234.105,13216.237,15.391];
				};							
				case (_vehicle isKindOf "HAFM_PBoat"):
				{
					_vehicle setDir 84;			
					_vehicle setPosASL [14234.105,13216.237,15.391];
				};	
				case (_vehicle isKindOf "HAFM_CB90"):
				{
					_vehicle setDir 84;			
					_vehicle setPosASL [14234.105,13216.237,15.391];
				};
				case (_vehicle isKindOf "HAFM_GunBoat"):
				{
					_vehicle setDir 84;			
					_vehicle setPosASL [14234.105,13216.237,15.391];
				};	
				case (_vehicle isKindOf "HAFM_GunBoat_BLU"):
				{
					_vehicle setDir 84;			
					_vehicle setPosASL [14234.105,13216.237,15.391];
				};							
				case (_vehicle isKindOf "HAFM_CB90_BLU"):
				{
					_vehicle setDir 84;			
					_vehicle setPosASL [14234.105,13216.237,15.391];
				};							
				case (_vehicle isKindOf "HAFM_PBoat_BLU"):
				{
					_vehicle setDir 84;			
					_vehicle setPosASL [14234.105,13216.237,15.391];
				};							
				case (_vehicle isKindOf "HAFM_Replenishment"):
				{
					_vehicle setDir 84;			
					_vehicle setPosASL [14234.105,13216.237,15.391];
				};							
				case (_vehicle isKindOf "HAFM_Russen"):
				{				
					_vehicle setDir 84;			
					_vehicle setPosASL [14234.105,13216.237,15.391];
				};							
				case (_vehicle isKindOf "HAFM_Admiral"):
				{
					_vehicle setDir 84;			
					_vehicle setPosASL [14234.105,13216.237,15.391];
				};							
				case (_vehicle isKindOf "HAFM_MEKO_TN"):
				{
					_vehicle setDir 84;			
					_vehicle setPosASL [14234.105,13216.237,15.391];
				};							
				case (_vehicle isKindOf "HAFM_MEKO_HN"):
				{
					_vehicle setDir 84;			
					_vehicle setPosASL [14234.105,13216.237,15.391];
				};							
				case (_vehicle isKindOf "HAFM_FREMM"):
				{
					_vehicle setDir 84;			
					_vehicle setPosASL [14234.105,13216.237,15.391];
				};							
				case (_vehicle isKindOf "HAFM_ABurke"):
				{
					_vehicle setDir 84;			
					_vehicle setPosASL [14234.105,13216.237,15.391];
				};							
				case (_vehicle isKindOf "HAFM_052C"):
				{
					_vehicle setDir 84;			
					_vehicle setPosASL [14234.105,13216.237,15.391];
				};							
				case (_vehicle isKindOf "HAFM_052D"):
				{
					_vehicle setDir 84;			
					_vehicle setPosASL [14234.105,13216.237,15.391];
				};							
				case (_vehicle isKindOf "HAFM_Yasen"):
				{
					[_vehicle, 3] call HAFM_fnc_SubAttachment;			
					_vehicle setDir 355;			
					_vehicle setPosASL [14217.053,13165.772,13.737];
				};							
				case (_vehicle isKindOf "HAFM_214"):
				{
					[_vehicle, 3] call HAFM_fnc_SubAttachment;			
					_vehicle setDir 355;			
					_vehicle setPosASL [14217.053,13165.772,13.737];
				};							
				case (_vehicle isKindOf "HAFM_209"):
				{
					[_vehicle, 3] call HAFM_fnc_SubAttachment;			
					_vehicle setDir 355;		
					_vehicle setPosASL [14217.053,13165.772,13.737];
				};							
				case (_vehicle isKindOf "HAFM_BUYAN"):
				{
					_vehicle setDir 84;			
					_vehicle setPosASL [14234.105,13216.237,15.391];
				};							
				case (_vehicle isKindOf "HAFM_MisBoat_BLU"):
				{
					_vehicle setDir 84;			
					_vehicle setPosASL [14234.105,13216.237,15.391];
				};							
				case (_vehicle isKindOf "HAFM_Corvette"):
				{
					_vehicle setDir 84;			
					_vehicle setPosASL [14234.105,13216.237,15.391];
				};							
				case (_vehicle isKindOf "HAFM_Frigate"):
				{
					_vehicle setDir 84;			
					_vehicle setPosASL [14234.105,13216.237,15.391];
				};							
				case (_vehicle isKindOf "A2_Fregata"):
				{
					_vehicle setDir 84;			
					_vehicle setPosASL [14234.105,13216.237,15.391];
				};							
				case (_vehicle isKindOf "HAFM_Frigate_OPF"):
				{
					_vehicle setDir 84;			
					_vehicle setPosASL [14234.105,13216.237,15.391];
				};							
				case (_vehicle isKindOf "HAFM_Corvette_OPF"):
				{
					_vehicle setDir 84;			
					_vehicle setPosASL [14234.105,13216.237,15.391];
				};							
				case (_vehicle isKindOf "HAFM_PBoat_OPF"):
				{
					_vehicle setDir 84;			
					_vehicle setPosASL [14234.105,13216.237,15.391];
				};
				default	// for all other watercraft
				{
					_vehicle setDir 84;			
					_vehicle setPosASL [14234.105,13216.237,15.391];			
				};			
			};	
		};

/*******************************************NORTH*******************************************************/	

		if (count (_player nearObjects ["Land_PalmTotem_01_F", 10]) > 0) then // North Resupply Platform Positions
		{
			switch (true) do
			{
				case (_vehicle isKindOf "HAFM_Virginia"):				// Test to reposition ships/subs for easy player access
				{
					[_vehicle, 3] call HAFM_fnc_SubAttachment;			
					_vehicle setDir 44.727;			
					_vehicle setPosASL [21341.266,24020.637,13.737];
				};	
				case (_vehicle isKindOf "HAFM_MisBoat"):
				{
					_vehicle setDir 43.305;			
					_vehicle setPosASL [21359,24049.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_PBoat"):
				{
					_vehicle setDir 43.305;			
					_vehicle setPosASL [21359,24049.7,15.391];
				};	
				case (_vehicle isKindOf "HAFM_CB90"):
				{
					_vehicle setDir 43.305;			
					_vehicle setPosASL [21359,24049.7,15.391];
				};
				case (_vehicle isKindOf "HAFM_GunBoat"):
				{
					_vehicle setDir 43.305;			
					_vehicle setPosASL [21359,24049.7,15.391];
				};	
				case (_vehicle isKindOf "HAFM_GunBoat_BLU"):
				{
					_vehicle setDir 43.305;			
					_vehicle setPosASL [21359,24049.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_CB90_BLU"):
				{
					_vehicle setDir 43.305;			
					_vehicle setPosASL [21359,24049.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_PBoat_BLU"):
				{
					_vehicle setDir 43.305;			
					_vehicle setPosASL [21359,24049.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_Replenishment"):
				{
					_vehicle setDir 43.305;			
					_vehicle setPosASL [21359,24049.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_Russen"):
				{				
					_vehicle setDir 43.305;			
					_vehicle setPosASL [21359,24049.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_Admiral"):
				{
					_vehicle setDir 43.305;			
					_vehicle setPosASL [21359,24049.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_MEKO_TN"):
				{
					_vehicle setDir 43.305;			
					_vehicle setPosASL [21359,24049.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_MEKO_HN"):
				{
					_vehicle setDir 43.305;			
					_vehicle setPosASL [21359,24049.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_FREMM"):
				{
					_vehicle setDir 43.305;			
					_vehicle setPosASL [21359,24049.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_ABurke"):
				{
					_vehicle setDir 43.305;			
					_vehicle setPosASL [21359,24049.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_052C"):
				{
					_vehicle setDir 43.305;			
					_vehicle setPosASL [21359,24049.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_052D"):
				{
					_vehicle setDir 43.305;			
					_vehicle setPosASL [21359,24049.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_Yasen"):
				{
					[_vehicle, 3] call HAFM_fnc_SubAttachment;			
					_vehicle setDir 44.727;			
					_vehicle setPosASL [21341.266,24020.637,13.737];
				};							
				case (_vehicle isKindOf "HAFM_214"):
				{
					[_vehicle, 3] call HAFM_fnc_SubAttachment;			
					_vehicle setDir 44.727;			
					_vehicle setPosASL [21341.266,24020.637,13.737];
				};							
				case (_vehicle isKindOf "HAFM_209"):
				{
					[_vehicle, 3] call HAFM_fnc_SubAttachment;			
					_vehicle setDir 44.727;			
					_vehicle setPosASL [21341.266,24020.637,13.737];
				};							
				case (_vehicle isKindOf "HAFM_BUYAN"):
				{
					_vehicle setDir 43.305;			
					_vehicle setPosASL [21359,24049.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_MisBoat_BLU"):
				{
					_vehicle setDir 43.305;			
					_vehicle setPosASL [21359,24049.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_Corvette"):
				{
					_vehicle setDir 43.305;			
					_vehicle setPosASL [21359,24049.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_Frigate"):
				{
					_vehicle setDir 43.305;			
					_vehicle setPosASL [21359,24049.7,15.391];
				};							
				case (_vehicle isKindOf "A2_Fregata"):
				{
					_vehicle setDir 43.305;			
					_vehicle setPosASL [21359,24049.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_Frigate_OPF"):
				{
					_vehicle setDir 43.305;			
					_vehicle setPosASL [21359,24049.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_Corvette_OPF"):
				{
					_vehicle setDir 43.305;			
					_vehicle setPosASL [21359,24049.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_PBoat_OPF"):
				{
					_vehicle setDir 43.305;			
					_vehicle setPosASL [21359,24049.7,15.391];
				};
				default	// for all other watercraft
				{
					_vehicle setDir 131.371;			
					_vehicle setPosASL [21282.2,23931.5,184.187];				
				};			
			};	
		};

/*******************************************SOUTH*******************************************************/	

		if (count (_player nearObjects ["Land_Monument_01_F", 10]) > 0) then // South Resupply Platform Positions
		{
			switch (true) do
			{
				case (_vehicle isKindOf "HAFM_Virginia"):				// Test to reposition ships/subs for easy player access
				{
					[_vehicle, 3] call HAFM_fnc_SubAttachment;			
					_vehicle setDir 106.723;			
					_vehicle setPosASL [12574.771,5411.977,13.737];
				};	
				case (_vehicle isKindOf "HAFM_MisBoat"):
				{
					_vehicle setDir 105.074;			
					_vehicle setPosASL [12606.4,5411.44,15.391];
				};							
				case (_vehicle isKindOf "HAFM_PBoat"):
				{
					_vehicle setDir 105.074;			
					_vehicle setPosASL [12606.4,5411.44,15.391];
				};	
				case (_vehicle isKindOf "HAFM_CB90"):
				{
					_vehicle setDir 105.074;			
					_vehicle setPosASL [12606.4,5411.44,15.391];
				};
				case (_vehicle isKindOf "HAFM_GunBoat"):
				{
					_vehicle setDir 105.074;			
					_vehicle setPosASL [12606.4,5411.44,15.391];
				};	
				case (_vehicle isKindOf "HAFM_GunBoat_BLU"):
				{
					_vehicle setDir 105.074;			
					_vehicle setPosASL [12606.4,5411.44,15.391];
				};							
				case (_vehicle isKindOf "HAFM_CB90_BLU"):
				{
					_vehicle setDir 105.074;			
					_vehicle setPosASL [12606.4,5411.44,15.391];
				};							
				case (_vehicle isKindOf "HAFM_PBoat_BLU"):
				{
					_vehicle setDir 105.074;			
					_vehicle setPosASL [12606.4,5411.44,15.391];
				};							
				case (_vehicle isKindOf "HAFM_Replenishment"):
				{
					_vehicle setDir 105.074;			
					_vehicle setPosASL [12606.4,5411.44,15.391];
				};							
				case (_vehicle isKindOf "HAFM_Russen"):
				{				
					_vehicle setDir 105.074;			
					_vehicle setPosASL [12606.4,5411.44,15.391];
				};							
				case (_vehicle isKindOf "HAFM_Admiral"):
				{
					_vehicle setDir 105.074;			
					_vehicle setPosASL [12606.4,5411.44,15.391];
				};							
				case (_vehicle isKindOf "HAFM_MEKO_TN"):
				{
					_vehicle setDir 105.074;			
					_vehicle setPosASL [12606.4,5411.44,15.391];
				};							
				case (_vehicle isKindOf "HAFM_MEKO_HN"):
				{
					_vehicle setDir 105.074;			
					_vehicle setPosASL [12606.4,5411.44,15.391];
				};							
				case (_vehicle isKindOf "HAFM_FREMM"):
				{
					_vehicle setDir 105.074;			
					_vehicle setPosASL [12606.4,5411.44,15.391];
				};							
				case (_vehicle isKindOf "HAFM_ABurke"):
				{
					_vehicle setDir 105.074;			
					_vehicle setPosASL [12606.4,5411.44,15.391];
				};							
				case (_vehicle isKindOf "HAFM_052C"):
				{
					_vehicle setDir 105.074;			
					_vehicle setPosASL [12606.4,5411.44,15.391];
				};							
				case (_vehicle isKindOf "HAFM_052D"):
				{
					_vehicle setDir 105.074;			
					_vehicle setPosASL [12606.4,5411.44,15.391];
				};							
				case (_vehicle isKindOf "HAFM_Yasen"):
				{
					[_vehicle, 3] call HAFM_fnc_SubAttachment;			
					_vehicle setDir 106.723;			
					_vehicle setPosASL [12574.771,5411.977,13.737];
				};							
				case (_vehicle isKindOf "HAFM_214"):
				{
					[_vehicle, 3] call HAFM_fnc_SubAttachment;			
					_vehicle setDir 106.723;			
					_vehicle setPosASL [12574.771,5411.977,13.737];
				};							
				case (_vehicle isKindOf "HAFM_209"):
				{
					[_vehicle, 3] call HAFM_fnc_SubAttachment;			
					_vehicle setDir 106.723;			
					_vehicle setPosASL [12574.771,5411.977,1];
				};							
				case (_vehicle isKindOf "HAFM_BUYAN"):
				{
					_vehicle setDir 105.074;			
					_vehicle setPosASL [12606.4,5411.44,15.391];
				};							
				case (_vehicle isKindOf "HAFM_MisBoat_BLU"):
				{
					_vehicle setDir 105.074;			
					_vehicle setPosASL [12606.4,5411.44,15.391];
				};							
				case (_vehicle isKindOf "HAFM_Corvette"):
				{
					_vehicle setDir 105.074;			
					_vehicle setPosASL [12606.4,5411.44,15.391];
				};							
				case (_vehicle isKindOf "HAFM_Frigate"):
				{
					_vehicle setDir 105.074;			
					_vehicle setPosASL [12606.4,5411.44,15.391];
				};							
				case (_vehicle isKindOf "A2_Fregata"):
				{
					_vehicle setDir 105.074;			
					_vehicle setPosASL [12606.4,5411.44,15.391];
				};							
				case (_vehicle isKindOf "HAFM_Frigate_OPF"):
				{
					_vehicle setDir 105.074;			
					_vehicle setPosASL [12606.4,5411.44,15.391];
				};							
				case (_vehicle isKindOf "HAFM_Corvette_OPF"):
				{
					_vehicle setDir 105.074;			
					_vehicle setPosASL [12606.4,5411.44,15.391];
				};							
				case (_vehicle isKindOf "HAFM_PBoat_OPF"):
				{
					_vehicle setDir 105.074;			
					_vehicle setPosASL [12606.4,5411.44,15.391];
				};
				default	// for all other watercraft
				{
					_vehicle setDir 197.675;			
					_vehicle setPosASL [12473.1,5436.39,105.116];				
				};			
			};	
		};

/*******************************************EAST*******************************************************/	

		if (count (_player nearObjects ["Land_Pedestal_02_F", 10]) > 0) then // East Resupply Platform Positions
		{
			switch (true) do
			{
				case (_vehicle isKindOf "HAFM_Virginia"):				// Test to reposition ships/subs for easy player access
				{
					[_vehicle, 3] call HAFM_fnc_SubAttachment;			
					_vehicle setDir 28;			
					_vehicle setPosASL [25408.574,17812.633,13.737];
				};	
				case (_vehicle isKindOf "HAFM_MisBoat"):
				{
					_vehicle setDir 28.966;			
					_vehicle setPosASL [25420.5,17844.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_PBoat"):
				{
					_vehicle setDir 28.966;			
					_vehicle setPosASL [25420.5,17844.7,15.391];
				};	
				case (_vehicle isKindOf "HAFM_CB90"):
				{
					_vehicle setDir 28.966;			
					_vehicle setPosASL [25420.5,17844.7,15.391];
				};
				case (_vehicle isKindOf "HAFM_GunBoat"):
				{
					_vehicle setDir 28.966;			
					_vehicle setPosASL [25420.5,17844.7,15.391];
				};	
				case (_vehicle isKindOf "HAFM_GunBoat_BLU"):
				{
					_vehicle setDir 28.966;			
					_vehicle setPosASL [25420.5,17844.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_CB90_BLU"):
				{
					_vehicle setDir 28.966;			
					_vehicle setPosASL [25420.5,17844.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_PBoat_BLU"):
				{
					_vehicle setDir 28.966;			
					_vehicle setPosASL [25420.5,17844.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_Replenishment"):
				{
					_vehicle setDir 28.966;			
					_vehicle setPosASL [25420.5,17844.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_Russen"):
				{				
					_vehicle setDir 28.966;			
					_vehicle setPosASL [25420.5,17844.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_Admiral"):
				{
					_vehicle setDir 28.966;			
					_vehicle setPosASL [25420.5,17844.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_MEKO_TN"):
				{
					_vehicle setDir 28.966;			
					_vehicle setPosASL [25420.5,17844.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_MEKO_HN"):
				{
					_vehicle setDir 28.966;			
					_vehicle setPosASL [25420.5,17844.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_FREMM"):
				{
					_vehicle setDir 28.966;			
					_vehicle setPosASL [25420.5,17844.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_ABurke"):
				{
					_vehicle setDir 28.966;			
					_vehicle setPosASL [25420.5,17844.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_052C"):
				{
					_vehicle setDir 28.966;			
					_vehicle setPosASL [25420.5,17844.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_052D"):
				{
					_vehicle setDir 28.966;			
					_vehicle setPosASL [25420.5,17844.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_Yasen"):
				{
					[_vehicle, 3] call HAFM_fnc_SubAttachment;			
					_vehicle setDir 28;			
					_vehicle setPosASL [25408.574,17812.633,13.737];
				};							
				case (_vehicle isKindOf "HAFM_214"):
				{
					[_vehicle, 3] call HAFM_fnc_SubAttachment;			
					_vehicle setDir 28;			
					_vehicle setPosASL [25408.574,17812.633,13.737];
				};							
				case (_vehicle isKindOf "HAFM_209"):
				{
					[_vehicle, 3] call HAFM_fnc_SubAttachment;			
					_vehicle setDir 28;			
					_vehicle setPosASL [25408.574,17812.633,13.737];
				};							
				case (_vehicle isKindOf "HAFM_BUYAN"):
				{
					_vehicle setDir 28.966;			
					_vehicle setPosASL [25420.5,17844.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_MisBoat_BLU"):
				{
					_vehicle setDir 28.966;			
					_vehicle setPosASL [25420.5,17844.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_Corvette"):
				{
					_vehicle setDir 28.966;			
					_vehicle setPosASL [25420.5,17844.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_Frigate"):
				{
					_vehicle setDir 28.966;			
					_vehicle setPosASL [25420.5,17844.7,15.391];
				};							
				case (_vehicle isKindOf "A2_Fregata"):
				{
					_vehicle setDir 28.966;			
					_vehicle setPosASL [25420.5,17844.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_Frigate_OPF"):
				{
					_vehicle setDir 28.966;			
					_vehicle setPosASL [25420.5,17844.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_Corvette_OPF"):
				{
					_vehicle setDir 28.966;			
					_vehicle setPosASL [25420.5,17844.7,15.391];
				};							
				case (_vehicle isKindOf "HAFM_PBoat_OPF"):
				{
					_vehicle setDir 28.966;			
					_vehicle setPosASL [25420.5,17844.7,15.391];
				};
				default	// for all other watercraft
				{
					_vehicle setDir 119.246;			
					_vehicle setPosASL [25371.8,17702.5,15.391];				
				};			
			};	
		};

/*******************************************KAVALA*******************************************************/	

		if (count (_player nearObjects ["Land_Maroula_F", 10]) > 0) then // Kavala Parking Positions
		{
			switch (true) do
			{
				case (_vehicle isKindOf "HAFM_Virginia"):				// Test to reposition ships/subs for easy player access
				{
					[_vehicle, 3] call HAFM_fnc_SubAttachment;			
					_vehicle setDir 326.266;			
					_vehicle setPosASL [3083.24,12643.6,3.85283];
				};	
				case (_vehicle isKindOf "HAFM_MisBoat"):
				{
					_vehicle setDir 326.266;			
					_vehicle setPosASL [3083.24,12643.6,3.85283];
				};							
				case (_vehicle isKindOf "HAFM_PBoat"):
				{
					_vehicle setDir 326.266;			
					_vehicle setPosASL [3083.24,12643.6,3.85283];
				};	
				case (_vehicle isKindOf "HAFM_CB90"):
				{
					_vehicle setDir 326.266;			
					_vehicle setPosASL [3083.24,12643.6,3.85283];
				};
				case (_vehicle isKindOf "HAFM_GunBoat"):
				{
					_vehicle setDir 326.266;			
					_vehicle setPosASL [3083.24,12643.6,3.85283];
				};	
				case (_vehicle isKindOf "HAFM_GunBoat_BLU"):
				{
					_vehicle setDir 326.266;			
					_vehicle setPosASL [3083.24,12643.6,3.85283];
				};							
				case (_vehicle isKindOf "HAFM_CB90_BLU"):
				{
					_vehicle setDir 326.266;			
					_vehicle setPosASL [3083.24,12643.6,3.85283];
				};							
				case (_vehicle isKindOf "HAFM_PBoat_BLU"):
				{
					_vehicle setDir 326.266;			
					_vehicle setPosASL [3083.24,12643.6,3.85283];
				};							
				case (_vehicle isKindOf "HAFM_Replenishment"):
				{
					_vehicle setDir 326.266;			
					_vehicle setPosASL [3083.24,12643.6,3.85283];
				};							
				case (_vehicle isKindOf "HAFM_Russen"):
				{				
					_vehicle setDir 326.266;			
					_vehicle setPosASL [3083.24,12643.6,3.85283];
				};							
				case (_vehicle isKindOf "HAFM_Admiral"):
				{
					_vehicle setDir 326.266;			
					_vehicle setPosASL [3083.24,12643.6,3.85283];
				};							
				case (_vehicle isKindOf "HAFM_MEKO_TN"):
				{
					_vehicle setDir 326.266;			
					_vehicle setPosASL [3083.24,12643.6,3.85283];
				};							
				case (_vehicle isKindOf "HAFM_MEKO_HN"):
				{
					_vehicle setDir 326.266;			
					_vehicle setPosASL [3083.24,12643.6,3.85283];
				};							
				case (_vehicle isKindOf "HAFM_FREMM"):
				{
					_vehicle setDir 326.266;			
					_vehicle setPosASL [3083.24,12643.6,3.85283];
				};							
				case (_vehicle isKindOf "HAFM_ABurke"):
				{
					_vehicle setDir 326.266;			
					_vehicle setPosASL [3083.24,12643.6,3.85283];
				};							
				case (_vehicle isKindOf "HAFM_052C"):
				{
					_vehicle setDir 326.266;			
					_vehicle setPosASL [3083.24,12643.6,3.85283];
				};							
				case (_vehicle isKindOf "HAFM_052D"):
				{
					_vehicle setDir 326.266;			
					_vehicle setPosASL [3083.24,12643.6,3.85283];
				};							
				case (_vehicle isKindOf "HAFM_Yasen"):
				{
					[_vehicle, 3] call HAFM_fnc_SubAttachment;			
					_vehicle setDir 326.266;			
					_vehicle setPosASL [3083.24,12643.6,3.85283];
				};							
				case (_vehicle isKindOf "HAFM_214"):
				{
					[_vehicle, 3] call HAFM_fnc_SubAttachment;			
					_vehicle setDir 326.266;			
					_vehicle setPosASL [3083.24,12643.6,3.85283];
				};							
				case (_vehicle isKindOf "HAFM_209"):
				{
					[_vehicle, 3] call HAFM_fnc_SubAttachment;			
					_vehicle setDir 326.266;			
					_vehicle setPosASL [3083.24,12643.6,3.85283];
				};							
				case (_vehicle isKindOf "HAFM_BUYAN"):
				{
					_vehicle setDir 326.266;			
					_vehicle setPosASL [3083.24,12643.6,3.85283];
				};							
				case (_vehicle isKindOf "HAFM_MisBoat_BLU"):
				{
					_vehicle setDir 326.266;			
					_vehicle setPosASL [3083.24,12643.6,3.85283];
				};							
				case (_vehicle isKindOf "HAFM_Corvette"):
				{
					_vehicle setDir 326.266;			
					_vehicle setPosASL [3083.24,12643.6,3.85283];
				};							
				case (_vehicle isKindOf "HAFM_Frigate"):
				{
					_vehicle setDir 326.266;			
					_vehicle setPosASL [3083.24,12643.6,3.85283];
				};							
				case (_vehicle isKindOf "A2_Fregata"):
				{
					_vehicle setDir 326.266;			
					_vehicle setPosASL [3083.24,12643.6,3.85283];
				};							
				case (_vehicle isKindOf "HAFM_Frigate_OPF"):
				{
					_vehicle setDir 326.266;			
					_vehicle setPosASL [3083.24,12643.6,3.85283];
				};							
				case (_vehicle isKindOf "HAFM_Corvette_OPF"):
				{
					_vehicle setDir 326.266;			
					_vehicle setPosASL [3083.24,12643.6,3.85283];
				};							
				case (_vehicle isKindOf "HAFM_PBoat_OPF"):
				{
					_vehicle setDir 326.266;			
					_vehicle setPosASL [3083.24,12643.6,3.85283];
				};
				default	// for all other watercraft
				{
					_vehicle setDir 231.518;			
					_vehicle setPosASL [3032.3,12657.3,6.53332];				
				};			
			};	
		};

/*********************************************************************************************************/

    if (isNil "_vehicle") exitWith {
      diag_log format["ERROR: Could not restore vehicle %1 for player %2(%3)", _vehicle_id,  (name _player), _uid];
      [_player, format["An error occurred, your vehicle (%1) could not be restored. Please report this error to A3Armory.com.", _vehicle_id], "Restoring Error"] call pp_notify;
    };

    [_parked_vehicles, _vehicle_id] call fn_removeFromPairs;
    _player setVariable ["parked_vehicles", _parked_vehicles]; //, true];
    ["parked_vehicles", _parked_vehicles] remoteExecCall ["A3W_fnc_setVarPlayer", _player];
    //[_player] call fn_saveAccount;

    def(_display_name);
    _display_name = [typeOf _vehicle] call generic_display_name;
    [_player, _vehicle] call pp_mark_vehicle;
    [_player, format["%1, your %2 has been retrieved (marked on map)", (name _player), _display_name]] call pp_notify;
  };

  "pp_park_vehicle_request" addPublicVariableEventHandler pp_park_vehicle_request_handler;
  "pp_retrieve_vehicle_request" addPublicVariableEventHandler pp_retrieve_vehicle_request_handler;

};

if (isClient) then {
  pp_notify_request_handler = {_this spawn {
    //diag_log format["%1 call pp_notify_request_handler", _this];
    ARGVX3(1,_this,[]);
    ARGVX3(0,_msg,"");
    ARGV3(1,_dialog,"");

    if (isSTRING(_dialog)) exitWith {
      [_msg, _dialog, "OK", false] call BIS_fnc_guiMessage;
    };

    player groupChat _msg;
  };};

  "pp_notify_request" addPublicVariableEventHandler {_this call pp_notify_request_handler};

  pp_mark_vehicle_request_handler = {_this spawn {
    //diag_log format["%1 call pp_mark_vehicle_request_handler", _this];
    ARGVX3(1,_this,[]);
    ARGVX3(0,_vehicle,objNull);

    sleep 1; //give enough time for the vehicle to be move to the correct location (before marking)
    def(_class);
    _class = typeOf _vehicle;

    def(_name);
    _name = [_class] call generic_display_name;

    def(_pos);
    _pos = getPos _vehicle;

    def(_marker);
    _marker = format["pp_vehicle_marker_%1", ceil(random 1000)];
    _marker = createMarkerLocal [_marker, _pos];
    _marker setMarkerTypeLocal "waypoint";
    _marker setMarkerPosLocal _pos;
    _marker setMarkerColorLocal "ColorBlue";
    //_marker setMarkerTextLocal _name;

    _vehicle setVariable ["was_parked", true];

    if (!alive getConnectedUAV player) then {
      player connectTerminalToUAV _vehicle; // attempt uav connect
    };

    [_marker] spawn {
      ARGVX3(0,_marker,"");
      sleep 60;
      deleteMarkerLocal _marker;
    };
  };};

  "pp_mark_vehicle_request" addPublicVariableEventHandler {_this call pp_mark_vehicle_request_handler};

  pp_park_vehicle = {
    pp_park_vehicle_request = _this;
    publicVariableServer "pp_park_vehicle_request";
  };

  pp_retrieve_vehicle = {
    pp_retrieve_vehicle_request = _this;
    publicVariableServer "pp_retrieve_vehicle_request";
  };
};


diag_log format["Loading parking saving functions complete"];
parking_saving_functions_defined = true;