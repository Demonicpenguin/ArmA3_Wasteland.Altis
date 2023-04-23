/*
	Function: TAG_fnc_BUBBLES
	Author: BIS Bubble module, HallyG
	SPAWNS BLOOMIN BUBBBBBBBBBBLES
	
	Arguments(s):
	0: Emitter Position <OBJECT, POSITION>
	1: Bubble size  (default: 1) <NUMBER>
	2: Bubble drop interval (rate at which particles are emitted, smaller = MORE BUBBLES)  (default: 1) <NUMBER>
	2: Bubble velocity (from source) [X speed, Y speed, Z speed]  (default: [0,0,1]) <ARRAY>
	3: Bubble lifetime (default: 5) <NUMBER>
	
	Return Value:
	Emitter <OBJECT>
		
	Example:
	[
		getPos player,
		1,
		0.01,
		[0,0,-1],
		10
	] call TAG_fnc_BUBBLES;
__________________________________________________________________*/
params [ 
	["_position", [0,0,0], [[]]], 
	["_size", 1, [0]], 
	["_dropInterval", 0.1, [0]], 
	["_speed", [0, 0, 1], [[]], [3]], 
	["_lifeTime", 5, [0]] 
]; 
_speed params ["_speedX", "_speedY", "_speedZ"]; 

_position = _position call {
	if (_this isEqualType objNull) exitWith {getPosATL _this};
	_this
};
	
if ((_position select 2 > -0.01) && (surfaceIsWater _position)) then {
	_position = _position vectorAdd [0,0,-0.1];
};

_source = "#particlesource" createVehicleLocal _position; 
_source setParticleParams [ 
	["\A3\data_f\ParticleEffects\Universal\Universal",16,13,7,0], 
	"", "Billboard", 1, 50, [0, 0, 0],
	[_speedX, _speedY, _speedZ],
	0, 1, 1, 15, 
	[0.05 * _size], 
	[[1,1,1,-2]], 
	[1000], 0.12, 0.045, "", "", "" 
]; 
	 
// CHANGE THESE TO IMPROVE YOUR BUBBLES
// Sets randomization of particle source parameters
_source setParticleRandom [ 
	20,  					// lifeTimeVar
	[0,0,0], 				// positionVar
	[2,2,0], 				// moveVelocityVar --> BIS module default ([0.02,0.02,0]) 
	0,						// rotationVelocityVar
	(0.005 * _size), 		// sizeVar
	[0,0,0,1], 				// colorVar
	0.003,					// randomDirectionPeriodVar --> BIS module default (0) 
	0 						// randomDirectionIntensityVar --> BIS module default (0)
];
	 
_source setDropInterval _dropInterval; 
_source