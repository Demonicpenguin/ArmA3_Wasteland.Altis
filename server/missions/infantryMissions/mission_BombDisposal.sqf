//mission_Bomb.sqf by Samson - only works dedicated server

if (!isServer) exitwith {};

#include "infantryMissionDefines.sqf"

private [ "_townName", "_missionPos","_change","_area","_playerIntel","_wires"];

_setupVars =
{
	_missionType = "Bomb Defusal";

	// settings for this mission
	_locArray = ((call cityList) call BIS_fnc_selectRandom);
	_missionPos = markerPos (_locArray select 0);
	_townName = _locArray select 2;


	_area = _missionPos;

	_wires = 
	[
	"Red",
	"Green",
	"Yellow",
	"Black",
	"Blue"
	];
};

_setupObjects =
{
	
	//intel distributor
	waitUntil {(count playableUnits > 1 )};
	if (isDedicated) then {
	_playerIntel = [];
	{
		if (isPlayer _x) then 
		{
		_playerIntel pushBack _x;
		};
	
	} foreach (playableUnits);

	playerIntel = _playerIntel call BIS_fnc_selectRandom;
	playerName = name playerIntel;
	_missionHintText = format ["A bomb has been armed at <br/><t size='1.25' color='%1'>%2</t><br/><br/> Negotiate with <t color='%1'> %3 </t> for defusal intel, reward is <t color='%1'>1,000,000 Dollars</t> ", infantryMissionColor, _townName, playerName];
	
	//intel & Wires
	wire = _wires call BIS_fnc_selectRandom;
	
	
	[[wire],"BIS_fnc_guiMessage",playerIntel,true ] call BIS_fnc_MP;

	
	
	// boomla boomla
	bombModel = createVehicle ["Land_Device_assembled_F", _missionPos, [], 5, "None"];
	bombModel setDir random 360;
	bombModel setVariable ["wire",wire,true];
	bombModel setVariable ["cut","Nope",true];
	
	

	 //this if condition is ganked local player must not be the player intel player to get defuse menu.
	 //[[player], "name", true, true] call BIS_fnc_MP
	[[bombModel, [ "<t color='#FF0000'>Cut Red</t>", {bombModel setVariable ["cut", "Red",true]}, "_this distance cursortarget < 3"]],"addAction",true,true] call BIS_fnc_MP;
	[[bombModel, [ "<t color='#186a3b'>Cut Green</t>",{bombModel setVariable ["cut", "Green",true]}, "_this distance cursortarget < 3"]],"addAction",true,true] call BIS_fnc_MP;
	[[bombModel, [ "<t color='#f4d03f'>Cut Yellow</t>", {bombModel setVariable ["cut", "Yellow",true]}, "_this distance cursortarget < 3"]],"addAction",true,true] call BIS_fnc_MP;
	[[bombModel, [ "<t color='#17202a'>Cut Black</t>", {bombModel setVariable ["cut", "Black",true]}, "_this distance cursortarget < 3"]],"addAction",true,true] call BIS_fnc_MP;
	[[bombModel, [ "<t color='#3498db'>Cut Blue</t>", {bombModel setVariable ["cut", "Blue",true]}, "_this distance cursortarget < 3"]],"addAction",true,true] call BIS_fnc_MP;
	};
		

		publicVariable "cut";
		publicVariable "wire";
		publicVariable "bombModel";
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;

_ignoreAiDeaths = true;
_waitUntilCondition = {((bombModel getVariable "cut") !=  "Nope") && ((bombModel getVariable "cut") != (bombModel getVariable "wire"))};
_waitUntilSuccessCondition = {((bombModel getVariable "cut") == (bombModel getVariable "wire"))};

_failedExec ={
//bombcode
_count = 0;
for "_i" from 0 to (8) do {
for "_j" from 0 to 1 do {
switch (_j) do
{ case 0: {if (random 1 == 1) then {_xVel = -1*_xVel }};
case 1: {if (random 1 == 1) then {_yVel = -1*_yVel }};
};
}; 
	_xVel = random 10;
	_yVel = random 10;
	_zVel = random 20;
	_xCoord = random 15;
	_yCoord = random 15;
	_zCoord = random 5;

	_bomb = "Bo_GBU12_LGB_MI10" createVehicle (getPos bombModel);
	_bomb setVelocity [_xVel,_yVel,_zVel-50];
	_bomb = "Cluster_120mm_AMOS" createVehicle (getPos bombModel);
	_bomb setVelocity [_xVel,_yVel,_zVel-50];
	_bomb = "HelicopterExploBig" createVehicle (getPos bombModel);
	_bomb setVelocity [_xVel,_yVel,_zVel-50];
};

//destroying target
{_x setdamage 1; } foreach nearestObjects [getPos  bombModel, [],100];
//addCamShake [1+random 5,1+random 3, 5+random 15];
deleteVehicle bombModel;	
};
_successExec =
{
	// Mission completed
	
		for "_i" from 1 to 10 do
	{
		_cash = createVehicle ["Land_Money_F", _missionPos, [], 5, "None"];
		_cash setPos ([_lastPos, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
		_cash setDir random 360;
		_cash setVariable ["cmoney", 100000, true];
		_cash setVariable ["owner", "world", true];
	};
	deleteVehicle bombModel;
	_successHintMessage = "Bomb Defused, well done.";

};

_this call infantryMissionProcessor;