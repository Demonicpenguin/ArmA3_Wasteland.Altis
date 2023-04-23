GOM_fnc_scan = {
params [["_scanObject",objNull],["_scanRadius",500],["_duration",5],["_debug",true]];

	_scanObject setVariable ["GOM_fnc_scanActive",true,true];
	if (_debug) then {systemChat "Starting to scan!"};
	hint "Starting to scan!";
	sleep 1;
	_stopTime = time + _duration;
	waitUntil {

		_nearPlayers = (_scanObject nearEntities _scanRadius) - [player] select {getConnectedUAV _x}; //isPlayer
		hintsilent format ["Scan duration: %1\nPlayers detected: %2",[-(time - _stopTime),"HH:MM"] call BIS_fnc_timeToString,count _nearPlayers];
		time > _stopTime
	};
	if (_debug) then {systemChat "Stopped scanning!"};
	_scanObject setVariable ["GOM_fnc_scanActive",false,true];

	hint "Stopped scanning!";

};

//add scan action to object
player addAction ["Scan for Players Connected to UAV",{
	params ["_object","_caller","_ID"];

	_scan = [_object,500,5] spawn GOM_fnc_scan;

},[],0,true,true,"","_this isEqualTo vehicle _this AND !(_this getVariable ['GOM_fnc_scanActive',false])",5];