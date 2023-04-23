/*
	Author: AryX (noaim)
	Description: Weapon System
	Version: 0.1
	Updated: 02.11.2019
*/

if (isDedicated) exitWith {};
waitUntil {!isNull player};

private _wpnSys1 = getMarkerPos "Gunner1";
private _wpnSys2 = getMarkerPos "Gunner2";
private _dis = 35; 
private _inArea = false;

if (isDedicated) exitWith {};
waitUntil {!isNull player};
/*
switch (playerSide) do {
	case west: {
		for "_i" from 0 to 1 step 0 do {
			if (alive player) then {	
				if (((_wpnSys1 distance player < _dis) || (_wpnSys2 distance player < _dis)) && (!_inArea)) then {     
					_inArea = true;
					systemChat "This is a no UAV Zone!";
					player removeItem "B_UAVTerminal";  player unassignItem "B_UAVTerminal";
				};
			};
		};
	};
	case east: {
		for "_i" from 0 to 1 step 0 do {
			if (alive player) then {	
				if (((_wpnSys1 distance player < _dis) || (_wpnSys2 distance player < _dis)) && (!_inArea)) then {     
					_inArea = true;
					systemChat "This is a no UAV Zone!";
					player removeItem "O_UAVTerminal";  player unassignItem "O_UAVTerminal";
				};
			};
		};
	};
	case independent: {
		for "_i" from 0 to 1 step 0 do {
			if (alive player) then {	
				if (((_wpnSys1 distance player < _dis) || (_wpnSys2 distance player < _dis)) && (!_inArea)) then {     
					_inArea = true;
					systemChat "This is a no UAV Zone!";
					player removeItem "I_UAVTerminal";  player unassignItem "I_UAVTerminal";
				};
			};
		};
	};
	uiSleep 3;
};*/

/*
	Author: AryX (noaim)
	Description: Weapon System
	Version: 0.1
	Updated: 02.11.2019
*/

for "_i" from 0 to 1 step 0 do {
	if (alive player) then {	
		if (((_wpnSys1 distance player < _dis) || (_wpnSys2 distance player < _dis)) && (!_inArea)) then {     
			_inArea = true;
			systemChat "This is a no UAV Zone!";
			player removeItem "B_UAVTerminal";  player unassignItem "B_UAVTerminal";
			player removeItem "O_UAVTerminal";  player unassignItem "O_UAVTerminal";
			player removeItem "I_UAVTerminal";  player unassignItem "I_UAVTerminal";
			player removeItem "I_E_UavTerminal";  player unassignItem "I_E_UavTerminal";
		};
	};
};