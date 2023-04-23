#define RESPAWN_PRICE 50000
#define REGULAR_PRICE 100000
#define TEN_MINUTES 600

private _time = serverTime;
private _spawn = player getVariable ["respawn", _time];
private _money = player getVariable ["cmoney", 0];


//hint format ["Server Time : %1 Spawn Time : %2",_time,_spawn];

_host = _this select 0;
_caller = _this select 1;
_id = _this select 2;
_althalo = 1000; //altitude of halo jump
_timeout = 1800;	//change to 30 minutes.

_boothOwnerID = _host getVariable "ownerUID";

_elapsedTime = 86400; //24 hours

if (not alive _host) exitwith {hint "Halo Not Available"; _host removeaction _id;};


//special case: first time halo
if !(isNil {_caller getVariable "HALO_last_time"}) then 
{
	_lastTime 		= _caller getVariable "HALO_last_time";
	_elapsedTime 	= time - _lasttime;	
};

if (_host getVariable "ownerUID" == getplayerUID _caller) then {_elapsedTime = time + _timeout};

if (_elapsedTime < _timeout) exitWith {_caller groupchat format["Next HALO flight will be ready in  %1  minutes:seconds", [(round(_timeout - _elapsedTime)), "MM:SS"] call BIS_fnc_secondsToString];};

if (_host getVariable "ownerUID" == getplayerUID _caller) then
{
	_message = format ["Welcome %1, Confirm you want to Jump?", name _caller];

	if !([_message, "Confirm", true, true] call BIS_fnc_guiMessage) exitWith {hint "Halo Dropped Canceled";	playSound 'FD_CP_Not_Clear_F';};

	openMap true;
	onMapSingleClick {
	onMapSingleClick {};
	player setposATL [_pos select 0, _pos select 1, (_pos select 2) + 500];
	_height = 500;
	[player,_height] spawn BIS_fnc_halo;
	hint '';
	openMap false;
	true
	};

	sleep 5;

	_caller groupchat "Dont forget to open your chute!";	
	
	_caller setVariable ["HALO_last_time", time];
};


if (isNil {_host getVariable "ownerUID"}) then
{
	private _cost = if( _time - _spawn > TEN_MINUTES ) then { REGULAR_PRICE } else { RESPAWN_PRICE };

	_message = format [(["halo cost within ten minutes of respawn is $%1, confirm?", "You respawned more than ten minutes ago, halo cost is $%1, confirm?"] select (_cost == REGULAR_PRICE)), _cost call fn_numbersText];

	if !([_message, "Confirm", true, true] call BIS_fnc_guiMessage) exitWith {hint "Halo Dropped Canceled";	playSound 'FD_CP_Not_Clear_F';};

	_showInsufficientFundsError = {
	hint "Not enough money";
	playSound 'FD_CP_Not_Clear_F';
	};

	// Ensure the player has enough money
	if (_cost > _money) exitWith { call _showInsufficientFundsError; };

	//Deduct
	player setVariable ["cmoney", _money - _cost, true];
	playSound 'defaultNotification';
	
	openMap true;
	onMapSingleClick {
	onMapSingleClick {};
	player setposATL [_pos select 0, _pos select 1, (_pos select 2) + 500];
	_height = 500;
	[player,_height] spawn BIS_fnc_halo;
	hint '';
	openMap false;
	true
	};
	
	sleep 5;

	_caller groupchat "Dont forget to open your chute!";

	_caller setVariable ["HALO_last_time", time];	
};

if (!(_host getVariable "ownerUID" == getplayerUID _caller) && !(isNil {_host getVariable "ownerUID"})) exitWith
{
	hint "This Halo Booth belongs to another player, jump access denied!!";
	playSound 'FD_CP_Not_Clear_F';
};








