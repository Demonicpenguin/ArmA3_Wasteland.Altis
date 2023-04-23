scriptName "fn_aj_s_hideObjectGlobal";
// @file Name: fn_aj_s_hideObjectGlobal.sqf
// @file Author:  wiking.at
// @file Author: www.armajunkies.de

if (isServer) then 
	{
		FNC_HIDE = { (_this select 0) hideObject (_this select 1); };
	
	};