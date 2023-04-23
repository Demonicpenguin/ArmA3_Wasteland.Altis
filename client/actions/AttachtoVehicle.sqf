/*
Authorthen BIB_Monkey
Filenamethen AttachtoVehicle.sqf
Purpose: Attach static weapons and objects to Vehicles
*/

//Define the static weapon
_static = cursortarget;
//Find the nearest vehicle
_vehicle = nearestObject [_static, "Car_F"];
//Get the vehicle className
_class = typeof _vehicle;
//Find the position of the static weapon
_posstatic = getPos _static;
//Find the position of the vehicle
_posvehicle = getPos _vehicle;
//get the distance between the two objects
_distance = _posstatic distance _posvehicle;
//Get the name of the vehicle
_displayname = str configProperties [configFile>>"cfgVehicles">>_class>>"displayName"];
hint _displayname;

//Make sure the vehicle is in range
if (_distance <=10) then
{
	switch (true) do 
	{
		//Offroad Variants
		case (_vehicle iskindof "Offroad_01_base_F"): 
		{
			//determine already attached locations
			//NOTE Attachement points vary by vehicle. 
			_attachedStatic = _vehicle getVariable ["StaticAttached", false];		// Special Spot for Static Weapon (may preclude loading of static objects)
			_attachedSLD = _vehicle getVariable ["LocationSLD_Attached", false];	// Special Spot for Static laser designator
			_Attached1 = _vehicle getVariable ["Location1_Attached", false];		// Used for Vehicle Ammo Crate
			_Attached2 = _vehicle getVariable ["Location2_Attached", false];		// Used for Supply crates
			_Attached3 = _vehicle getVariable ["Location3_Attached", false];		// Used for large crates
			_attached4 = _vehicle getVariable ["Location4_Attached", false];		// Used for speacial weapons crate Right side
			_attached5 = _vehicle getVariable ["Location5_Attached", false];		// Used for speacial weapons crate Left Side
			_attached6 = _vehicle getVariable ["Location6_Attached", false];		
			_attached7 = _vehicle getVariable ["Location7_Attached", false];
			_attached8 = _vehicle getVariable ["Location8_Attached", false];
			_attached9 = _vehicle getVariable ["Location9_Attached", false];
			_attached10 = _vehicle getVariable ["Location10_Attached", false];

			//Define Attachment points
			_attach1 = [1.49012e-008,-1.8,0.3];
			_attach2 = [1.49012e-008,-1.8,0.1];
			_attach3 = [1.49012e-008,-1.8,-0.3];
			_attach4 = [0.3,-1.8,-0.5];
			_attach5 = [-0.4,-1.8,-0.5];
			_attach6 = [0,-1.1,-0.4];
			_atach7 = [0,-1.7,-0.4];
			_attach8 = [0,-2.3,-0.4];

			//make sure theres an empty spot
			_spotarray = [_attachedStatic,_Attached1,_Attached2,_Attached3,_attached4,_attached5,_attached6,_attached7,_attached8,_attached9,_attached10,_attachedSLD];
			_spotcheck = [false];
			_spots = _spotarray arrayIntersect _spotcheck;
			if ((count _spots)>0) then 
			{
				if (_static isKindOf "StaticWeapon") then
				{
					if !(_attachedStatic) then 
					{
					//Offroad (unarmed)
						if (({_vehicle iskindof _x} count ["Offroad_01_base_F", "Offroad_01_military_base_F"]>0) && !(_vehicle iskindof "Offroad_01_armed_base_F")) then
						{
						//high GMG and HMG
							if ({_static iskindof _x} count["GMG_01_high_base_F", "GMG_01_high_base_F"]>0) then
							{
								//let the player know what's going on 
								titleText ["Attaching to Offroad", "PLAIN"];
								
								for "_i" from 0 to 10 do //have to repeat this section so that it takes effect
								{
									//Attach the static to the vehicle
									_static attachTo [_vehicle, [-0.3,-1.9,0.9]];
									//Set the Statics direction
									_static setdir 180;
								};
								//Set the variables
								_static setVariable ["Attached", true, true];
								_static setvariable ["moveable", false, true];
								_vehicle setVariable ["StaticAttached", true, true];
								_vehicle setVariable ["Attached", true, true];

							};
						//Low and autonomous HMG and GMG
							if ({_static iskindof _x} count["B_HMG_01_F","O_HMG_01_F","I_HMG_01_F","B_HMG_01_A_F","O_HMG_01_A_F","I_HMG_01_A_F","B_GMG_01_F","O_GMG_01_F","I_GMG_01_F"]>0) then
							{
								titleText ["Attaching to Offroad", "PLAIN"];
								_vehicle animate ["HideDoor3",1]; // Hide the tailgate so it isn't in the way
								for "_i" from 0 to 10 do 
								{
									_static attachTo [_vehicle, [0,-1.9,0.4]];
									_static setdir 180;
								};
								_static setVariable ["Attached", true, true];
								_static setvariable ["moveable", false, true];
								_vehicle setVariable ["StaticAttached", true, true];
								_vehicle setVariable ["Attached", true, true];
							};
						//Mortor
							if ({_static iskindof _x} count["B_Mortar_01_F","O_Mortar_01_F","I_Mortar_01_F"]>0) then
							{
								titleText ["Attaching to Offroad", "PLAIN"];
								for "_i" from 0 to 10 do 
								{
									_static attachTo [_vehicle, [0.2,-1.8,1.49012e-008]];
									_static setdir 180;
								};
								_static setVariable ["Attached", true, true];
								_static setvariable ["moveable", false, true];
								_vehicle setVariable ["StaticAttached", true, true];
								_vehicle setVariable ["Attached", true, true];
							};
						//AA , AT
							if ({_static iskindof _x} count["AT_01_base_F","AA_01_base_F"]>0) then
							{
								titleText ["Attaching to Offroad", "PLAIN"];
								for "_i" from 0 to 10 do 
								{
									_static attachTo [_vehicle, [1.49012e-008,-1.7,0.3]];
									_static setdir 180;
								};
								_static attachTo [_vehicle, [1.49012e-008,-1.7,0.3]];
								_static setVariable ["Attached", true, true];
								_static setvariable ["moveable", false, true];
								_vehicle setVariable ["StaticAttached", true, true];
								_vehicle setVariable ["Attached", true, true];
							};
						//Spartan
							if (_static iskindof "B_SAM_System_02_F") then
							{
								titleText ["Cannot Attach to this Vehicle", "PLAIN"];
							};
						//Centurion
							if (_static iskindof "B_SAM_System_01_F") then
							{
								titleText ["Cannot Attach to this Vehicle", "PLAIN"];
							};
						//Preatorian
							if (_static iskindof "B_AAA_System_01_F") then
							{
								titleText ["Cannot Attach to this Vehicle", "PLAIN"];
							};
						};
					//Offroad Repair
						if (_vehicle iskindof "Offroad_01_repair_base_F") then
						{
						//high GMG and HMG
							if ({_static iskindof _x} count["GMG_01_high_base_F", "GMG_01_high_base_F"]>0) then
							{
								titleText ["Cannot Attach to this Vehicle", "PLAIN"];
							};
						//Low and autonomous HMG and GMG
							if ({_static iskindof _x} count["B_HMG_01_F","O_HMG_01_F","I_HMG_01_F","B_HMG_01_A_F","O_HMG_01_A_F","I_HMG_01_A_F","B_GMG_01_F","O_GMG_01_F","I_GMG_01_F"]>0) then
							{
								titleText ["Cannot Attach to this Vehicle", "PLAIN"];
							};
						//Mortor
							if ({_static iskindof _x} count["B_Mortar_01_F","O_Mortar_01_F","I_Mortar_01_F"]>0) then
							{
								titleText ["Cannot Attach to this Vehicle", "PLAIN"];
							};
						//AT , AA
							if ({_static iskindof _x} count["AT_01_base_F","AA_01_base_F"]>0) then
							{
								titleText ["Cannot Attach to this Vehicle", "PLAIN"];
							};
						//Spartan
							if (_static iskindof "B_SAM_System_02_F") then
							{
								titleText ["Cannot Attach to this Vehicle", "PLAIN"];
							};
						//Centurion
							if (_static iskindof "B_SAM_System_01_F") then
							{
								titleText ["Cannot Attach to this Vehicle", "PLAIN"];
							};
						//Preatorian
							if (_static iskindof "B_AAA_System_01_F") then
							{
								titleText ["Cannot Attach to this Vehicle", "PLAIN"];
							};
						};
					//Ofroad (Armed)
						if (_vehicle iskindof "Offroad_01_armed_base_F") then
						{
						//high GMG and HMG
							if ({_static iskindof _x} count ["GMG_01_high_base_F", "GMG_01_high_base_F"]>0)then
							{
								titleText ["Cannot Attach to this Vehicle", "PLAIN"];
							};
						//Low and autonomous HMG and GMG
							if ({_static iskindof _x} count["B_HMG_01_F","O_HMG_01_F","I_HMG_01_F","B_HMG_01_A_F","O_HMG_01_A_F","I_HMG_01_A_F","B_GMG_01_F","O_GMG_01_F","I_GMG_01_F"]>0)then
							{
								titleText ["Cannot Attach to this Vehicle", "PLAIN"];
							};
						//Mortor
							if ({_static iskindof _x} count["B_Mortar_01_F","O_Mortar_01_F","I_Mortar_01_F"]>0)then
							{
								titleText ["Cannot Attach to this Vehicle", "PLAIN"];
							};
						//AT , AA
							if ({_static iskindof _x} count["AT_01_base_F","AA_01_base_F"]>0)then
							{
								titleText ["Cannot Attach to this Vehicle", "PLAIN"];
							};
						//Spartan
							if (_static iskindof "B_SAM_System_02_F")then
							{
								titleText ["Cannot Attach to this Vehicle", "PLAIN"];
							};
						//Centurion
							if (_static iskindof "B_SAM_System_01_F")then
							{
								titleText ["Cannot Attach to this Vehicle", "PLAIN"];
							};
						//Preatorian
							if (_static iskindof "B_AAA_System_01_F")then
							{
								titleText ["Cannot Attach to this Vehicle", "PLAIN"];
							};
						} else 
						{
							titleText ["Static Weapon Already Installed", "PLAIN"];
						};
					//Static LD's
					} else
					{
						titletext ["Staticweapon already attached", "PLAIN"]
					};
					if !(_attachedSLD) then
					{
					//Offroad (unarmed)
						if  (_vehicle iskindof "Offroad_01_unarmed_base_F")then
						{
							if ({_static iskindof _x} count["Static_Designator_02_base_F", "Static_Designator_01_base_F"]>0)then
							{
								titleText ["Attaching to Offroad", "PLAIN"];
								_static attachTo [_vehicle, [1.49012e-008,0.0999999,0.9]];
								_static setVariable ["Attached", true, true];
								_vehicle setVariable ["LocationSLD_Attached", true, true];
								_vehicle setVariable ["Attached", true, true];
							};
						};
					//Offroad Repair
						if  (_vehicle iskindof "Offroad_01_repair_base_F")then
						{
								if ({_static iskindof _x} count["Static_Designator_02_base_F", "Static_Designator_01_base_F"]>0)then
								{
									titleText ["Attaching to Offroad", "PLAIN"];
									_static attachTo [_vehicle, [1.49012e-008,0.0999999,0.9]];
									_static setVariable ["Attached", true, true];
									_vehicle setVariable ["LocationSLD_Attached", true, true];
									_vehicle setVariable ["Attached", true, true];
								};
						};
					//Ofroad (Armed)
						if  (_vehicle iskindof "I_G_Offroad_01_armed_F")then
						{
							if ({_static iskindof _x} count["Static_Designator_02_base_F", "Static_Designator_01_base_F"]>0)then
							{
								titleText ["Attaching to Offroad", "PLAIN"];
								_static attachTo [_vehicle, [1.49012e-008,1.9,-0.2]];
								_static setVariable ["Attached", true, true];
								_vehicle setVariable ["LocationSLD_Attached", true, true];
								_vehicle setVariable ["Attached", true, true];
							};
						};
					} else
					{
						titleText ["Remote Laser Designator already installed", "PLAIN"];
					};
				};
				if (_static isKindOf "ReammoBox_F")then
				{
					if (({_vehicle iskindof _x} count ["Offroad_01_base_F", "Offroad_01_military_base_F"]>0) && !(_vehicle iskindof "Offroad_01_armed_base_F")) then
					{
						if !(_attachedStatic) then
						{
							if ((count _spots)>0) then
							{
								if ({_static isKindOf _x} count ["Box_East_AmmoVeh_F", "Box_IND_AmmoVeh_F", "Box_NATO_AmmoVeh_F", "CargoNet_01_ammo_base_F"]>0) then
								{
									if (_Attached1 && _Attached2 && _Attached3 && _attached4 && _attached5 && _attached6 && _attached7 && _attached8 && _attached9 && _attached10) then
									{
										titleText ["No Room", "PLAIN"];
									} else
									{
										_vehicle animateSource ["hideRearStructure",1]; // Hide the rollcage so it isn't in the way
										//let the player know what's going on 
										titleText ["Attaching to Offroad", "PLAIN"];
										//Attach the static to the vehicle
										_static attachTo [_vehicle, _attach1];
										//Set the variables
										_static setVariable ["Attached", true, true];
										_static setVariable ["moveable", false, true];
										_vehicle setvariable ["Attached", true, true];
										_vehicle setVariable ["Location1_Attached", true, true];
									};
								};
								if  ({_static isKindOf _x} count ["B_supplyCrate_F"]>0)then
								{
									if (_Attached1 && _Attached2 && _Attached3 && _attached4 && _attached5 && _attached6 && _attached7 && _attached8 && _attached9 && _attached10) then
									{
										titleText ["No Room", "PLAIN"];
									} else
									{
										_vehicle animateSource ["hideRearStructure",1]; // Hide the rollcage so it isn't in the way
										//let the player know what's going on 
										titleText ["Attaching to Offroad", "PLAIN"];
										//Attach the static to the vehicle
										_static attachTo [_vehicle, _attach2];
										//Set the variables
										_static setVariable ["Attached", true, true];
										_vehicle setVariable ["Location2_Attached", true, true];
									};
								};
								if  ({_static isKindOf _x} count ["Box_NATO_Equip_F","Box_NATO_Uniforms_F"]>0)then
								{
									if (_Attached1 && _Attached2 && _Attached3 && _attached4 && _attached5 && _attached6 && _attached7 && _attached8 && _attached9 && _attached10) then
									{
										titleText ["No Room", "PLAIN"];
									} else
									{
										_vehicle animateSource ["hideRearStructure",1]; // Hide the rollcage so it isn't in the way
										//let the player know what's going on 
										titleText ["Attaching to Offroad", "PLAIN"];
										//Attach the static to the vehicle
										_static attachTo [_vehicle, _attach3];
										//Set the variables
										_static setVariable ["Attached", true, true];
										_vehicle setVariable ["Location3_Attached", true, true];
									};
								};
								if  ({_static isKindOf _x} count ["Box_IND_WpsSpecial_F","Box_T_East_WpsSpecial_F","Box_East_WpsSpecial_F","Box_T_NATO_WpsSpecial_F","Box_NATO_WpsSpecial_F"]>0)then
								{
									if (_Attached1 && _Attached2 && _attached3) then
									{
										titleText ["No Room", "PLAIN"];
									} else
									{
										if (_attached4 == false) then
										{
											//let the player know what's going on 
											titleText ["Attaching to Offroad", "PLAIN"];
											//Attach the static to the vehicle
											_static attachTo [_vehicle, _attach4];
											//Set the variables
											_static setVariable ["Attached", true, true];
											_vehicle setVariable ["Location4_Attached", true, true];
										} else 
										{
											if (_attached5 == false) then
											{
												//let the player know what's going on 
												titleText ["Attaching to Offroad", "PLAIN"];
												//Attach the static to the vehicle
												_static attachTo [_vehicle, _attach5];
												//Set the variables
												_static setVariable ["Attached", true, true];
												_vehicle setVariable ["Location5_Attached", true, true];
											} else
											{
												titleText ["No Room", "PLAIN"]
											};
										};
									};
								};
								if  ({_static isKindOf _x} count ["Box_IND_Wps_F","Box_T_East_Wps_F","Box_East_Wps_F","Box_T_NATO_Wps_F","Box_NATO_Wps_F"]>0)then
								{
									if (_Attached1 && _Attached2 && _attached3 && _attached4 && _attached5) then
									{
										titleText ["No Room", "PLAIN"];
									} else
									{
										if (_attached4 == false) then
										{
											//let the player know what's going on 
											titleText ["Attaching to Offroad", "PLAIN"];
											//Attach the static to the vehicle
											_static attachTo [_vehicle, _attach6];
											//Set the variables
											_static setVariable ["Attached", true, true];
											_vehicle setVariable ["Location6_Attached", true, true];
										} else 
										{
											if (_attached5 == false) then
											{
												//let the player know what's going on 
												titleText ["Attaching to Offroad", "PLAIN"];
												//Attach the static to the vehicle
												_static attachTo [_vehicle, _attached7];
												//Set the variables
												_static setVariable ["Attached", true, true];
												_vehicle setVariable ["Location7_Attached", true, true];
											} else
											{	
												if (_attached7 == false) then
												{
												//let the player know what's going on 
												titleText ["Attaching to Offroad", "PLAIN"];
												//Attach the static to the vehicle
												_static attachTo [_vehicle, _attach8];
												//Set the variables
												_static setVariable ["Attached", true, true];
												_vehicle setVariable ["Location8_Attached", true, true];
												} else
												{
												titleText ["No Room", "PLAIN"]
												};
											};
										};
									};
								};
								if  ({_static isKindOf _x} count ["Box_IND_WpsLaunch_F","Box_East_WpsLaunch_F","Box_NATO_WpsLaunch_F"]>0)then
								{
									TitleText ["Monkey Hasn't Completed This yes"];
								};
								if  ({_static isKindOf _x} count ["Box_Syndicate_Ammo_F","Box_IED_Exp_F"]>0)then
								{
									TitleText ["Monkey Hasn't Completed This yes"];
								};
								if  ({_static isKindOf _x} count ["Box_Syndicate_WpsLaunch_F"]>0)then
								{
									TitleText ["Monkey Hasn't Completed This yes"];
								};
								if  ({_static isKindOf _x} count ["Box_Syndicate_Wps_F"]>0)then
								{
									TitleText ["Monkey Hasn't Completed This yes"];
								};
								if  ({_static isKindOf _x} count ["Box_IND_Ammo_F","Box_T_East_Ammo_F","Box_East_Ammo_F","Box_IND_AmmoOrd_F","Box_East_AmmoOrd_F","Box_IDAP_AmmoOrd_F","Box_NATO_AmmoOrd_F","Box_IND_Grenades_F","Box_East_Grenades_F","Box_NATO_Grenades_F"]>0)then
								{
									TitleText ["Monkey Hasn't Completed This yes"];
								};
							} else
							{
								titleText ["Static Weapon already attached", "PLAIN"]
							};
						} else
						{
							titleText ["No Space", "PLAIN"]
						};
					} else
					{
						titleText ["Only Unarmed Offroad, can transport Crates", "PLAIN"]
					};
				};
			};
		};
		case (_vehicle iskindof "Truck_01_base_F"):
		{
			//HEMMT Trackter
			if (_vehicle iskindof "B_Truck_01_mover_F") then
			{
				_attachedStatic = _vehicle getVariable ["StaticAttached", false];		// Special Spot for Static Weapon (may preclude loading of static objects)
				_attachedSLD = _vehicle getVariable ["LocationSLD_Attached", false];	// Special Spot for Static laser designator
				if (_static isKindOf "StaticWeapon") then
				{
					if !(_attachedStatic) then 
					{
						if ({_static iskindof _x} count["B_HMG_01_high_F","O_HMG_01_high_F","I_HMG_01_high_F","B_GMG_01_high_F","O_GMG_01_high_F","I_GMG_01_high_F", "B_HMG_01_F","O_HMG_01_F","I_HMG_01_F","B_HMG_01_A_F","O_HMG_01_A_F","I_HMG_01_A_F","B_GMG_01_F","O_GMG_01_F","I_GMG_01_F", "B_Mortar_01_F","O_Mortar_01_F","I_Mortar_01_F", "B_static_AT_F","O_static_AT_F","I_static_AT_F","B_static_AA_F","O_static_AA_F","I_static_AA_F"]>0) then
						{
							titleText ["Cannot Attach to this Vehicle", "PLAIN"];
						};
						if (_static iskindof "B_SAM_System_02_F") then
						{
							titleText ["Attaching to Offroad", "PLAIN"];
							_static attachTo [_vehicle, [0,-2.8,1.6]];
							_static setVariable ["Attached", true, true];
							_static setvariable ["moveable", false, true];
							_vehicle setVariable ["StaticAttached", true, true];
							_vehicle setVariable ["Attached", true, true];
						};
						if (_static iskindof "B_SAM_System_01_F") then
						{
							titleText ["Attaching to Offroad", "PLAIN"];
							_static attachTo [_vehicle, [0,-3.2,1.4]];
							_static setVariable ["Attached", true, true];
							_static setvariable ["moveable", false, true];
							_vehicle setVariable ["StaticAttached", true, true];
							_vehicle setVariable ["Attached", true, true];
						};
						if (_static iskindof "B_AAA_System_01_F") then
						{
							titleText ["Attaching to Offroad", "PLAIN"];
							_static attachTo [_vehicle, [0,-2.8,2.1]];
							_static setVariable ["Attached", true, true];
							_static setvariable ["moveable", false, true];
							_vehicle setVariable ["StaticAttached", true, true];
							_vehicle setVariable ["Attached", true, true];
						};
					};
					if !(_attachedSLD) then
					{
						if ({_static iskindof _x} count ["Static_Designator_02_base_F", "Static_Designator_01_base_F"]>0) then
						{
							titleText ["Attaching to Offroad", "PLAIN"];
							_static attachTo [_vehicle, [1.49012e-008,3.2,1.3]];
							_vehicle setVariable ["LocationSLD_Attached", true, true];
							_vehicle setVariable ["Attached", true, true];
						};
					};
				};
			};
		};
		default
		{
			titletext ["Vehicle not Supported...Yet?", "PLAIN"];
		};
	};
} else 
{
	titleText ["Nothing in range", "PLAIN"];
};

