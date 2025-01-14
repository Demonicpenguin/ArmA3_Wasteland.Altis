/*/
File: fn_clientInteractCamoNet.sqf
Author:

	Quiksilver
	
Last Modified:

	3/03/2018 A3 1.80 by Quiksilver
	
Description:

	Vehicle Camo Nets
_____________________________________________________________/*/

params ['_actionTarget','_actionCaller','_actionID','_actionArguments'];
_fn_inString = {
	params ['_find','_string',['_matchcase',FALSE]]; 
	if (_matchcase) exitWith {((_string find _find) > -1)}; 
	(((toLower _string) find (toLower _find)) > -1)
};
_actionArguments params ['_vehicle','_newPhase','_animationSources'];
private _exitArmor = FALSE;
_armor_anims = ['showslathull','showslatturret'];
private _armor_vAnims = _vehicle getVariable ['QS_vehicle_slatarmorAnims',[]];
if (_armor_vAnims isEqualTo []) then {
	private _array = [];
	private _armorAnimationSources = configFile >> 'CfgVehicles' >> (typeOf _vehicle) >> 'animationSources';
	private _animationSource = configNull;
	private _i = 0;
	for '_i' from 0 to ((count _armorAnimationSources) - 1) step 1 do {
		_animationSource = _armorAnimationSources select _i;
		if (((toLower (configName _animationSource)) in _armor_anims) || {(['showslat',(configName _animationSource),FALSE] call _fn_inString)}) then {
			0 = _array pushBack (toLower (configName _animationSource));
		};
	};
	{
		if (_x isEqualType '') then {
			if (!((toLower _x) in _array)) then {
				if (((toLower _x) in _armor_anims) || {(['showslat',_x,FALSE] call _fn_inString)}) then {
					_array pushBack (toLower _x);
				};
			};
		};
	} forEach (getArray (configFile >> 'CfgVehicles' >> (typeOf _vehicle) >> 'animationList'));
	_vehicle setVariable ['QS_vehicle_slatarmorAnims',_array,FALSE];
	_armor_vAnims = _array;
};
if (!(_armor_vAnims isEqualTo [])) then {
	if (!((_armor_vAnims findIf {((_vehicle animationSourcePhase _x) isEqualTo 1)}) isEqualTo -1)) then {
		_exitArmor = TRUE;
	};
};
if (_exitArmor) exitWith {
	50 cutText ['Remove slat armor to deploy camo net','PLAIN DOWN',0.5];
};
_onCancelled = {
	params ['_t','_position'];
	private _c = FALSE;
	if (!alive player) then {_c = TRUE;};
	if (!(player isEqualTo (vehicle player))) then {_c = TRUE;};
	if (!(player isEqualTo player)) then {_c = TRUE;};
	if (!alive _t) then {_c = TRUE;};
	if (!((vehicle player) isKindOf 'Man')) then {_c = TRUE;};
	if (!(_t in [cursorObject,cursorTarget])) then {_c = TRUE;};
	if (((getPosATL player) distance2D _position) > 5) then {_c = TRUE;};
	if (_c) then {
		missionNamespace setVariable ['QS_repairing_vehicle',FALSE,FALSE];
	};
	_c;
};
_onCompleted = {
	params ['_actionTarget','_actionCaller','_actionID','_actionArguments'];
	_fn_inString = {
		params ['_find','_string',['_matchcase',FALSE]]; 
		if (_matchcase) exitWith {((_string find _find) > -1)}; 
		(((toLower _string) find (toLower _find)) > -1)
	};
	_actionArguments params ['_vehicle','_newPhase','_animationSources'];
	private _exitArmor = FALSE;
	_armor_anims = ['showslathull','showslatturret'];
	private _armor_vAnims = _vehicle getVariable ['QS_vehicle_slatarmorAnims',[]];
	if (_armor_vAnims isEqualTo []) then {
		private _array = [];
		private _armorAnimationSources = configFile >> 'CfgVehicles' >> (typeOf _vehicle) >> 'animationSources';
		private _animationSource = configNull;
		private _i = 0;
		for '_i' from 0 to ((count _armorAnimationSources) - 1) step 1 do {
			_animationSource = _armorAnimationSources select _i;
			if (((toLower (configName _animationSource)) in _armor_anims) || {(['showslat',(configName _animationSource),FALSE] call _fn_inString)}) then {
				0 = _array pushBack (toLower (configName _animationSource));
			};
		};
		{
			if (_x isEqualType '') then {
				if (!((toLower _x) in _array)) then {
					if (((toLower _x) in _armor_anims) || {(['showslat',_x,FALSE] call _fn_inString)}) then {
						_array pushBack (toLower _x);
					};
				};
			};
		} forEach (getArray (configFile >> 'CfgVehicles' >> (typeOf _vehicle) >> 'animationList'));
		_vehicle setVariable ['QS_vehicle_slatarmorAnims',_array,FALSE];
		_armor_vAnims = _array;
	};
	if (!(_armor_vAnims isEqualTo [])) then {
		if (!((_armor_vAnims findIf {((_vehicle animationSourcePhase _x) isEqualTo 1)}) isEqualTo -1)) then {
			_exitArmor = TRUE;
		};
	};
	if (_exitArmor) exitWith {
		50 cutText ['Remove slat armor to deploy camo net','PLAIN DOWN',0.5];
	};
	{
		_vehicle animateSource [_x,_newPhase,TRUE];
	} forEach _animationSources;
	if (_newPhase isEqualTo 1) then {
		50 cutText ['Camo net deployed','PLAIN DOWN',0.333];
	} else {
		50 cutText ['Camo net removed','PLAIN DOWN',0.333];
	};
	missionNamespace setVariable ['QS_repairing_vehicle',FALSE,FALSE];
};
missionNamespace setVariable ['QS_repairing_vehicle',TRUE,FALSE];
private _text = '';
if (_newPhase isEqualTo 1) then {
	_text = 'Deploying camo net';
} else {
	_text = 'Removing camo net';
};
private _duration = 5;
[
	_text,
	_duration,
	0,
	[[_vehicle],{FALSE}],
	[[_vehicle,(getPosATL _vehicle)],_onCancelled],
	[_this,_onCompleted],
	[[],{FALSE}]
] spawn (missionNamespace getVariable 'QS_fnc_clientProgressVisualization');