// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: filterExecAttempt.sqf
//	@file Author: AgentRev
//	@file Created: 14/07/2013 13:10

private "_packetName";
_packetName = param [0, "", [""]];

if (_packetName == "BIS_fnc_MP_packet") then
{
	private ["_values", "_args", "_function", "_whitelisted", "_filePath", "_argsType", "_argsStr", "_buffer"];

	_values = param [1, [], [[]]];

	if (count _values < 3) exitWith {};

	_args = _values param [1, []];
	_function = _values param [2, "", [""]];
	_whitelisted = false;

	if (_function == "BIS_fnc_execVM") then
	{
		_filePath = if (typeName _args == "STRING") then { _args } else { _args param [1, "", [""]] };

		{
			if (_filePath == _x) exitWith
			{
				_whitelisted = true;
			};
		}
		forEach
		[
			"client\functions\defineServerRules.sqf",
			"territory\client\updateTerritoryMarkers.sqf",
			"initPlayerServer.sqf",
			"addons\gom\functions\GOM_fnc_aircraftLoadout.sqf",
			"addons\gom\functions\GOM_fnc_aircraftLoadoutParameters.sqf"
		];
	}
	else
	{
		{
			if (_function == _x) exitWith
			{
				_whitelisted = true;
			};
		}
		forEach
		[
			"BIS_fnc_effectKilledAirDestruction",
			"BIS_fnc_effectKilledAirDestructionStage2",
			"BIS_fnc_effectKilledSecondaries",
			"BIS_fnc_objectVar"/*,
			"JTS_FNC_SENT"*/ // PM Compact by JTS

			// NOTE: You also need to whitelist individual functions in client\CfgRemoteExec_fnc.hpp
		];
		
	//allow zeus functions	
	if (!_whitelisted) then
	{
		scopeName "zeusFunc";
		private ["_zeusFuncCfg", "_zeusFuncPrefix", "_i", "_catCfg", "_j"];

		_zeusFuncCfg = configfile >> "CfgFunctions" >> "A3_Functions_F_Curator";
		_zeusFuncPrefix = getText (_zeusFuncCfg >> "tag") + "_fnc_";

		for "_i" from 0 to (count _zeusFuncCfg - 1) do
		{
			_catCfg = _zeusFuncCfg select _i;
			for "_j" from 0 to (count _catCfg - 1) do
			{
				if (_function == _zeusFuncPrefix + configName (_catCfg select _j)) then
				{
					_whitelisted = true;
					breakOut "zeusFunc";
				};
			};
		};
	};		
		

		if (!_whitelisted) then
		{
			{
				if (_function select [0, count _x] == _x) exitWith
				{
					_whitelisted = true;
				};
			}
			forEach
			[
				"A3W_fnc_",
				"mf_remote_",
				"BIS_fnc_spawn",
				"BH_fnc_",
				"APOC_srv_",
				//GOM Functions
				"GOM_fnc_",
				"GOM_",
				"GOM_fnc_handleResources",
				"addaction"
			];
		};
	};

	if (_whitelisted) then
	{
		_this call BIS_fnc_MPexec;
	}
	else
	{
		if (isServer) then
		{
			BIS_fnc_MP_packet = [];
			publicVariable "BIS_fnc_MP_packet";

			_argsType = toUpper typeName _args;
			_argsStr = if (_argsType == "STRING") then { "'" + _args + "'" } else { if (_argsType in ["BOOL","SCALAR","ARRAY","SIDE"]) then { str _args } else { "(" + str _args + ")" } };
			_buffer = toArray ("ANTI-HACK - Blocked remote execution: params=" + str (_values select [2, count _values - 2]) + " args=" + _argsStr);

			while {count _buffer > 0} do
			{
				diag_log toString (_buffer select [0, 1021]);
				_buffer deleteRange [0, 1021];
			};
		};
	};
};
