//	@file Version: 1.0
//	@file Name: createSquadAssault.sqf
//	@file Author: [509th] Coyote Rogue
//	@file Created: 20/02/2019 21:27

if (!isServer) exitWith {};

private ["_group", "_pos", "_nbUnits", "_unitTypes", "_uPos", "_unit"];

_group = _this select 0;
_pos = _this select 1;
_nbUnits = param [2, 7, [0]];
_radius = param [3, 10, [0]];

_unitTypes =
[
	"RyanZombieC_man_1Slow","RyanZombieC_man_polo_1_FSlow","RyanZombieC_man_pilot_FSlow",
	"RyanZombieC_journalist_FSlow","RyanZombieC_OrestesSlow","RyanZombieC_NikosSlow",
	"RyanZombieC_man_polo_2_FSlow","RyanZombieC_man_polo_4_FSlow","RyanZombieC_man_polo_5_FSlow",
	"RyanZombieC_man_polo_6_FSlow","RyanZombieC_man_p_fugitive_FSlow","RyanZombieC_man_w_worker_FSlow",
	"RyanZombieC_scientist_FSlow","RyanZombieC_man_hunter_1_FSlow","RyanZombieC_man_1Medium",
	"RyanZombieC_man_polo_1_FMedium","RyanZombieC_man_pilot_FMedium","RyanZombieC_journalist_FMedium",
	"RyanZombieC_OrestesMedium","RyanZombieC_NikosMedium","RyanZombieC_man_polo_2_FMedium",
	"RyanZombieC_man_polo_4_FMedium","RyanZombieC_man_polo_5_FMedium","RyanZombieC_man_polo_6_FMedium",
	"RyanZombieC_man_1","RyanZombieC_man_hunter_1_F","RyanZombieC_man_pilot_F","RyanZombieC_scientist_F",
	"RyanZombieC_journalist_F","RyanZombieC_Orestes","RyanZombieC_Nikos","RyanZombieC_man_polo_1_F",
	"RyanZombieC_man_polo_2_F","RyanZombieC_man_polo_4_F","RyanZombieC_man_polo_6_F",
	"RyanZombieC_man_p_fugitive_F","RyanZombieC_man_w_worker_F","RyanZombieC_man_polo_5_F",	
	"RyanZombieC_man_p_fugitive_FMedium","RyanZombieC_man_w_worker_FMedium","RyanZombieC_scientist_FMedium",
	"RyanZombieC_man_hunter_1_FMedium"
];

for "_i" from 1 to _nbUnits do
{
	_uPos = _pos vectorAdd ([[random _radius, 0, 0], random 360] call BIS_fnc_rotateVector2D);
	_unit = _group createUnit [(selectRandom _unitTypes), _uPos, [], 0, "Form"];
	_unit setPosATL _uPos;
	//_unit addRating 9999999;
	_unit spawn addMilCap;
	_unit addEventHandler ["Killed", server_playerDied];
};

//[_group, _pos] call defendArea;
