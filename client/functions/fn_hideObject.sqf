scriptName "fn_aj_s_hideObjectGlobal";
// @file Name: fn_aj_s_hideObjectGlobal.sqf
// @file Author:  wiking.at
// @file Author: www.armajunkies.de

if (isServer) then 
	{
		fncDisable = {
		_unit = _this select 0;
		_unit enableSimulationGlobal false; 
		_unit hideObjectGlobal true;
		};

		fncEnable = {
		_unit = _this select 0;
		_unit enableSimulationGlobal true; 
		_unit hideObjectGlobal false;
		};
	
	};