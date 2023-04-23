scriptName "fn_aj_s_refreshTime";
// @file Name: fn_aj_s_refreshTime.sqf
// @file Author:  wiking.at
// @file Author: www.armajunkies.de
// Based on ideas in serverRestartMessages by soulkobk
// Refresh current server time and broadcast to clients if hh:mm changes.

if !(isServer) exitWith {};

_doubleDigits = {
    if (_this < 10) exitWith {"0"+str _this};
    str _this
};

_outputservertime = "";
_checkServerTime = 
	{
		_currServerTime = call compile ("real_date" callExtension "+");
		_currServerTimeHour = _currServerTime select 3;
		_currServerTimeMin = _currServerTime select 4;
		_currServerTimeSec = _currServerTime select 5;
		
		if (_this == "HHMM") then {
			_outputServerTime =  format ["%1:%2", _currServerTimeHour call _doubleDigits, _currServerTimeMin call _doubleDigits];
		}
		else
		{
			
			_outputServerTime = [_currServerTimeHour, _currServerTimeMin, _currServerTimeSec];
		};
	 _outputServerTime
	};
	
	
	AJ_SERVERTIME_PUBVAR = "";
	_lasttimestamp = "";

	while {true} do
	{ 	
		AJ_SERVERTIME_PUBVAR = "HHMM" call _checkServerTime;
		
		if !(AJ_SERVERTIME_PUBVAR isequalto _lasttimestamp ) then
		{
			publicVariable "AJ_SERVERTIME_PUBVAR";
		};
		
		_lastimestamp = AJ_SERVERTIME_PUBVAR;
		uiSleep 1;
	};
