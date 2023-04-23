/*
Author: BIB_Monkey
FileName: DetachFromVehicle.sqf
Purpose: Detach Static Objects from attached Vehicle
*/

//Setup Variables
_vehicle = cursorTarget;  
_attached = attachedObjects _vehicle;
_vehLocation = getPosATL _vehicle;

{
	if (_x getVariable ["Towed", false]) then 
	{
		detach _x;
		_detachpos = [_vehLocation,5,15,3,1,0,0] call findSafePos;
		_x setPosATL _detachpos;
		_x setVariable ["Towed", false, true];
		_vehicle setVariable ["Towing", false, true];

	};
} foreach _attached;

{
	private _VehVariables = 
	[
		"Attached",
		"StaticAttached",
		"LocationSLD_Attached",
		"Location1_Attached",
		"Location2_Attached",
		"Location3_Attached",
		"Location4_Attached",
		"Location5_Attached",
		"Location6_Attached",
		"Location7_Attached",
		"Location8_Attached",
		"Location9_Attached",
		"Location10_Attached"	
	];
	if (_x getVariable ["Attached", false]) then 
	{
		detach _x;
		_detachpos = [_vehLocation,5,10,3,1,0,0] call findSafePos;
		_x setPosATL _detachpos;
		_x setVariable ["Attached", false, true];
		_x setVariable ["moveable", true, true];
		{_vehicle setvariable [_x, false, true]} forEach _VehVariables;

	};
} foreach _attached;

