scriptName _fnc_scriptName;
if (!isServer) exitWith {};

private _objPos = param [0,[0,0,0],[[]]];

// Eventhandler to only allow satchel damage
private _scriptEH = {
	params ["_target","_selection","_damage","_source","_proj"];
	if  (_proj isKindOf ["PipeBombBase",configFile >> "CfgAmmo"]) then {
		if (_damage >= 1) then {
			_target removeAllEventHandlers "HandleDamage";
		};
		_damage
	} else {0};
};

// Create the radiactive spurce
private _objRT = createVehicle ["Land_TTowerBig_2_F", _objPos,[], 10,"None"];
_objRT setVectorUp [0,0,1];
_objRT addEventHandler ["HandleDamage",_scriptEH];
_objRT setPosATL [(_objPos select 0) + 30, (_objPos select 1) + 30, _objPos select 2];

_objRT;