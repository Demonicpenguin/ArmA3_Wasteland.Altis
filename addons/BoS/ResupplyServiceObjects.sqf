/*
Filename: ResupplyServiceObjects.sqf
Author: GMG_Monkey
Purpose: Allow player to resupply service objects through base management system
*/

//Config Defines
	#define Fuel_Cost 0.5 //Price per liter of fuel
	#define Repair_Cost 1 //Price per Kg of repair cargo
	#define Ammo_Cost 5 //Price Per Kg of Ammo Cargo
//Define Variables
	//Find closest base manager
	private _Manager = nearestObject [player, "Land_SatellitePhone_F"];
	//Get position of the closest base manager
	private _ManagerPOS = getpos _manager;
	//Get manager level
	private _ManagerLevel = _manager getVariable ["ManagerLevel", 1];
	//set default base radius for level 1 manager
	private _BaseRadius = 25;
	//set base radius based on manager level
	switch (_ManagerLevel) do
{
	case (2):
	{
		_BaseRadius = 30;
	};
	case (3):
	{
		_BaseRadius = 45;
	};
	case (4):
	{
		_BaseRadius = 70;
	};
	case (5):
	{
		_BaseRadius = 100;
	};
};

	//Array of Service Objects
	private _ServiceObjectslist = 
	[
		"Box_NATO_AmmoVeh_F",
		"Box_EAST_AmmoVeh_F",
		"Box_IND_AmmoVeh_F",
		"B_Slingload_01_Ammo_F",
		"B_Slingload_01_Fuel_F",
		"B_Slingload_01_Medevac_F",
		"B_Slingload_01_Repair_F",
		"Land_Pod_Heli_Transport_04_fuel_F",
		"Land_Pod_Heli_Transport_04_repair_F"
	];
	//Maximum amount of Ammo each object can hold
	private _AmmoResourcesMax =
	[
		["Box_NATO_AmmoVeh_F",						5000],
		["Box_EAST_AmmoVeh_F",						5000],
		["Box_IND_AmmoVeh_F",						5000],
		["B_Slingload_01_Ammo_F",					30000]

	];
	//Maximum amount of Fuel each object can hold
	private _FuelResourcesMax =
	[
		["B_Slingload_01_Fuel_F",					20000],
		["Land_Pod_Heli_Transport_04_fuel_F",		22000]
	];
	//Maximum amount of Repair each object can hold
	private _RepairResourcesMax =
	[
		["B_Slingload_01_Repair_F",					25000],
		["Land_Pod_Heli_Transport_04_repair_F",		22000]
	];
	//Find all service objects within range
	private _ServiceObjects = nearestObjects [_ManagerPOS, _ServiceObjectslist, _BaseRadius, true];
	//Define Player Money
	private _money = player getvariable ["bmoney", 0];
//Resupply stuff Below
{
	//Current object
	private _Object = _x;
	//Get Object Config Name
	private _ObjectClass = typeof _object;
	private _ObjectName = getText (configFile >> "CfgVehicles" >> _ObjectClass >> "displayName");
	//Remaining resources
	private	_ObjectAmmoResource = _Object getvariable ["GOM_fnc_ammoCargo", 0];
	private _Objectfuelresource = _Object getvariable ["GOM_fnc_fuelCargo", 0];
	private _ObjectRepairResource = _Object getvariable ["GOM_fnc_repairCargo", 0];
	//Calculate Cost of Resupply
		//calcuate Ammo Resource costs
			//initialize Cost variable
				private _AmmoResourceCost = 0;
			//Calculate price based on expended resouces
				{
					private _Cost = 0;
					private _Check = _x select 0;
					if (_Object iskindof _Check) then
					{
						private _ResourceMax = _x select 1;
						_Cost = ((_ResourceMax - _ObjectAmmoResource) * Ammo_Cost);
						//player globalchat format ["Vehicle remianing resources: %1 Maximum resources: %2 Cost to resupply: %3", _ObjectAmmoResource, _ResourceMax, _Cost];
						if (_Cost >= 0) then
						{
							_AmmoResourceCost = _Cost;
						};
					};
				} foreach _AmmoResourcesMax;
				// player globalchat format ["Vehicle remianing resources: %1 Cost to resupply: %2", _ObjectAmmoResource, _AmmoResourceCost];
		//Calculate Fuel Resource Cost
			//Initialize cost Variable
				private _FuelResourceCost = 0;
			//Calculate price based on expended resouces
				{
					private _Cost = 0;
					private _Check = _x select 0;
					if (_Object iskindof _Check) then
					{
						private _ResourceMax = _x select 1;
						_Cost = ((_ResourceMax - _ObjectFuelResource) * Fuel_Cost);
						// player globalchat format ["Vehicle remianing resources: %1 Maximum resources: %2 Cost to resupply: %3", _ObjectFuelResource, _ResourceMax, _Cost];
						if (_Cost >= 0) then
						{
							_FuelResourceCost = _Cost;
						};
					};
					
				} foreach _FuelResourcesMax;
		//Calculate Repair Resource Cost
			//Initialize cost variable
				private _RepairResourceCost = 0;
			//Calculate price based on expended resouces
				{
					private _Cost = 0;
					private _Check = _x select 0;
					if (_Object iskindof _Check) then
					{
						private _ResourceMax = _x select 1;
						_Cost = ((_ResourceMax - _ObjectRepairResource) * Repair_Cost);
						// player globalchat format ["Vehicle remianing resources: %1 Maximum resources: %2 Cost to resupply: %3", _ObjectRepairResource, _ResourceMax, _Cost];
						if (_Cost >= 0) then
						{
							_RepairResourceCost = _Cost;
						};
					};
				} foreach _RepairResourcesMax;
		//Calculate Total cost of resupply
		private _TotalPrice = (_AmmoResourceCost + _FuelResourceCost + _RepairResourceCost);
	//Start Resupply
		// Check player has enough money
			if (_money >= _totalprice) then
			{
				//Prompt player to confirm cost
				_msg = format ["%1<br/><br/>%2", format ["It will cost you $%1 to resupply %2.", _totalprice, _ObjectName], "Do you want to proceed?"];
				if ([_msg, "Resupply Vehicle", true, true] call BIS_fnc_guiMessage) then
				{
					//Subtract cost from player money
					player setVariable ["bmoney", (player getVariable ["bmoney",0]) - _totalprice, true];
					//Resupply Start
						//Ammo Resource Section
						if (_AmmoResourceCost > 0) then
						{
							{
								if (_Object iskindof (_x select 0)) then
								{
									titleText ["Resupplying Ammunition Cargo...", "PLAIN DOWN"];
									sleep 15;
									_Object setVariable ["GOM_fnc_ammoCargo", _x select 1, true];
								};
							} foreach _AmmoResourcesMax;
						};
					// Fuel resource Section
						if (_FuelResourceCost > 0) then
						{
							{
								If (_Object iskindof (_x select 0)) then
								{
									titleText ["Resupplying Fuel Cargo...", "PLAIN DOWN"];
									sleep 15;
									_Object setVariable ["GOM_fnc_fuelCargo", _x select 1, true];
								};
							} foreach _FuelResourcesMax;
						};
					//Repair Resource Section
						if (_RepairResourceCost > 0) then
						{
							{
								if (_Object iskindof (_x select 0)) then
								{
									titleText ["Resupplying Repair Cargo...", "PLAIN DOWN"];
									sleep 15;
									_Object setVariable ["GOM_fnc_repairCargo", _x select 1, true];
								};
							} foreach _RepairResourcesMax;
						};
						//Inform Player Object has been Resupplied
						titleText ["Object Resupplied", "PLAIN DOWN"];
				};
			// Exit text if player doesn't have enough money		
			} else
			{
				titleText [format ["You don't have enough money, %1 costs %2 to resupply", _ObjectName, _totalprice], "PLAIN DOWN"];
			};
} foreach _ServiceObjects;

