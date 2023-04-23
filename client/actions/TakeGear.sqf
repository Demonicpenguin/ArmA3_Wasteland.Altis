/***************************
File Name: TakeGear.sqf
File Author: BIB_Monkey
File Created: 18 MAR 2017
File Description: Removes Gear from corpse and adds it to player
***************************/

// Check if mutex lock is active.
if (mutexScriptInProgress) exitWith
{
	["You are already performing another action.", 5] call mf_notify_client;
};
//Target Equipment
private _Target = cursorObject;
private _uniform = uniform _Target;
private _uniformItems = uniformItems _target;
private _backpack = backpack _Target;
private _backpackItems = backpackItems _target;
private _vest = vest _Target;
private _vestitems = vestItems _Target;
private _headgear = headgear _Target;
private _goggles = goggles _Target;
private _binoculars = binocular _Target;
private _items = assigneditems _Target;
private _mags = magazines _Target;
private _weapons = weapons _Target;

//Player Equipment
private _playeruniform = uniform player;
private _playerUniformItems = uniformItems player;
private _playervest = vest player;
private _playervestItems = vestItems player;
private _playerheadgear = headgear player;
private _playergoggles = goggles player;
private _playerBinoculars = binocular player;
private _playeritems = assigneditems player;
private _playermags = magazines player;
private _playerweapons = weapons player;

mutexScriptInProgress = true;
_Lootable = _Target getvariable ["TakeGear", true];
if (_Lootable) then
{
	_Target setVariable ["TakeGear", false, true];
	titleText ["Dropping gear", "PLAIN DOWN"];
	player action ["PutBag"];
	sleep 1;
	{
		player action ["dropMagazine", player, _x];
	} foreach _playermags;
	sleep 1;
	{
		private _ground = createVehicle ["GroundWeaponHolder_Scripted", player, [], 0, "NONE"];
		player action ["Dropweapon", _ground, _x];
	} foreach _playerweapons;
	sleep 1;

	titleText ["Stripping Corpse", "PLAIN DOWN"];
	removeUniform _target;
	sleep 1;
	removevest _target;
	sleep 1;
	removeBackpack _target;
	sleep 1;
	removeHeadgear _target;
	sleep 1;
	removeAllItems _target;
	sleep 1;
	removeGoggles _target;
	sleep 1;
	removeAllAssignedItems _target;
	removeAllWeapons _target;
	sleep 1;

	titletext ["Trading clothes with a deadman ", "PLAIN DOWN"];
	player forceAddUniform _uniform;
	sleep 1;
	if (count _items > 0) then
	{
		{player additem _x; Player assignitem _x} foreach _items;
	};
	sleep 1;
	if (count _uniformItems > 0) then
	{
		{player addItemToUniform _x} foreach _uniformItems;
	};
	sleep 1;
	player addVest _vest;
	sleep 1;
	if (count _vestitems > 0) then
	{
		{player addItemToVest _x} foreach _vestitems;
	};
	sleep 1;
	player addBackpack _backpack;
	sleep 1;
	if (count _backpackItems > 0) then
	{
		{player addItemToBackpack _x} foreach _backpackItems;
	};
	sleep 1;
	player addHeadgear _headgear;
	sleep 1;
	player addGoggles _goggles;
	sleep 1;
	{
		player addweapon _x
	} foreach _weapons;
	sleep 1;
	_target forceAddUniform _playeruniform;
	if (count _playeritems > 0) then
	sleep 1;
	if (count _playeruniformItems > 0) then
	{
		{_target addItemToUniform _x} foreach _playeruniformItems;
	};
	sleep 1;
	_target addVest _playervest;
	sleep 1;
	if (count _playervestitems > 0) then
	{
		{_target addItemToVest _x} foreach _playervestitems;
	};
	sleep 1;
	_target addHeadgear _playerheadgear;
	sleep 1;
	_target addGoggles _playergoggles;
	sleep 1;

	titletext ["All done", "PLAIN DOWN"];
}
else
{
	titletext ["Someone else is already taking the gear", "PLAIN DOWN"];
};
mutexScriptInProgress = false;
