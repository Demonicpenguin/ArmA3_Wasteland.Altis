//Client Function for Airdrop Assistance (not really a function, as it is called via ExecVM from command menu)
//This takes values from command menu, and some passed variables, and interacts with client and sends commands to server
//Author: Apoc, GMG_Monkey
//Credits: Some methods taken from Cre4mpie's airdrop scripts, props for the idea!
#define Monkey_AirSupport_coolDownTime (["Monkey_AirSupport_coolDownTime", 3600] call getPublicVar)

scriptName "Monkey_cli_startAirSupport";
private ["_type","_selection","_player","_coolDownTimer"]; //Variables coming from command menu
_type 				= _this select 0;
_selectionNumber 	= _this select 1;
_player 			= _this select 2;



_selectionArray = [];
switch (_type) do
{
	case "Interceptors"  : {_selectionArray = Monkey_AirSupport_Options};
	case "Ground Support": {_selectionArray = Monkey_AirSupport_Options};

	default 		{_selectionArray = Monkey_AirSupport_Options; diag_log "AAA - Default Array Selected - Something broke";};
};
_selectionName =(_selectionArray select _selectionNumber) select 0;
_price =(_selectionArray select _selectionNumber) select 1;
_coolDownTimer =(_selectionArray select _selectionNumber)select 4;

/////////////  Cooldown Timer ////////////////////////
if (!isNil "Monkey_Airdrop_LastUsedTime") then
{
	if (isNil {_coolDownTimer}) then
	{
		_coolDownTimer = Monkey_AirSupport_coolDownTime;
	};

	_timeRemainingReuse = _coolDownTimer - (diag_tickTime - Monkey_Airdrop_LastUsedTime); //time is still in s
	if ((_timeRemainingReuse) > 0) then
	{
		hint format["Negative. Air Support Offline. Online ETA: %1", _timeRemainingReuse call fn_formatTimer];
		playSound "FD_CP_Not_Clear_F";
		player groupChat format ["Negative. Air Support Offline. Online ETA: %1",_timeRemainingReuse call fn_formatTimer];
		breakOut "Monkey_cli_startAirSupport";
	};
};
////////////////////////////////////////////////////////

_playerMoney = _player getVariable ["bmoney", 0];
if (_price > _playerMoney) exitWith
{
	hint format["You don't have enough money in the bank to request this support!"];
	playSound "FD_CP_Not_Clear_F";
};

_confirmMsg = format ["This support will deduct $%1 from your bank account upon dispatch<br/>",_price call fn_numbersText];
_confirmMsg = _confirmMsg + format ["<br/><t font='EtelkaMonospaceProBold'>1</t> x %1",_selectionName];

// Display confirm message
if ([parseText _confirmMsg, "Confirm", "CALL!", true] call BIS_fnc_guiMessage) then
{
	[[_type,_selectionNumber,_player],"Monkey_srv_StartAirSupport",false,false,false] call BIS_fnc_MP;
	Monkey_Airdrop_LastUsedTime = diag_tickTime;
	playSound3D ["a3\sounds_f\sfx\radio\ambient_radio17.wss",player,false,getPosASL player,1,1,25];
	hint format ["Inbound %1",_selectionName];
};
