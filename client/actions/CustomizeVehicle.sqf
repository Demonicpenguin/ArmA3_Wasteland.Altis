/*
Filename: DeployCamo.sqf
Author: GMG_Monkey
Purpose: Allow players to deploy or Stow Cammo nets on supported vehicles
*/

/*player addaction ["Deploy Camo Nets", "CustomizeVehicle.sqf",["DeployCamo"], -99, false, true, "", "{cursorObject isKindOf _x} count ['Tank_F', 'Wheeled_APC_F']>0 && !(cursorObject getvariable ['CamoDeployed', false])"]; 
player addaction ["Stow Camo Nets", "CustomizeVehicle.sqf",["StowCamo"], -99, false, true, "", "{cursorObject isKindOf _x} count ['Tank_F', 'Wheeled_APC_F']>0 && (cursorObject getvariable ['CamoDeployed', false])"];
*/


private _vehicle = cursorObject;
player globalChat str _vehicle;
private _action = _this select 3 select 0;
player globalChat str _action;


switch (_action) do
{
	case "DeployCamo":
	{
		if ({_vehicle isKindOf _x} count 
		[
			"B_APC_Tracked_01_CRV_F",
			"B_APC_Tracked_01_rcws_F",
			"O_APC_Tracked_02_cannon_F",
			"O_APC_Wheeled_02_rcws_v2_F",
			"I_APC_Wheeled_03_cannon_F",
			"I_LT_01_AA_F",
			"I_LT_01_AT_F",
			"I_LT_01_scout_F",
			"I_LT_01_cannon_F"
		]>0) then 
		{
			_vehicle animate ["showCamonetHull",1];
			_vehicle setVariable ["CamoDeployed", true, true];
		};
		if ({_vehicle isKindOf _x} count 
		[
			"B_APC_Tracked_01_AA_F",
			"B_APC_Wheeled_01_cannon_F",
			"B_AFV_Wheeled_01_cannon_F",
			"B_AFV_Wheeled_01_up_cannon_F",
			"B_MBT_01_arty_F",
			"B_MBT_01_mlrs_F",
			"B_MBT_01_cannon_F",
			"B_MBT_01_TUSK_F",
			"O_APC_Tracked_02_AA_F",
			"O_MBT_02_arty_F",
			"O_MBT_02_cannon_F",
			"O_MBT_04_cannon_F",
			"O_MBT_04_command_F",
			"I_APC_tracked_03_cannon_F",
			"I_MBT_03_cannon_F"
		]>0) then
		{
			_vehicle animate ["showCamonetHull",1];
			_vehicle animate ["showCamonetTurret",1];
			_vehicle setVariable ["CamoDeployed", true, true];
		};
	};
	case "StowCamo":
	{
		if ({_vehicle isKindOf _x} count 
		[
			"B_APC_Tracked_01_CRV_F",
			"B_APC_Tracked_01_rcws_F",
			"O_APC_Tracked_02_cannon_F",
			"O_APC_Wheeled_02_rcws_v2_F",
			"I_APC_Wheeled_03_cannon_F",
			"I_LT_01_AA_F",
			"I_LT_01_AT_F",
			"I_LT_01_scout_F",
			"I_LT_01_cannon_F"

		]>0) then 
		{
			_vehicle animate ["showCamonetHull",0];
			_vehicle setVariable ["CamoDeployed", false, true];
		};
		if ({_vehicle isKindOf _x} count 
		[
			"B_APC_Tracked_01_AA_F",
			"B_APC_Wheeled_01_cannon_F",
			"B_AFV_Wheeled_01_cannon_F",
			"B_AFV_Wheeled_01_up_cannon_F",
			"B_MBT_01_arty_F",
			"B_MBT_01_mlrs_F",
			"B_MBT_01_cannon_F",
			"B_MBT_01_TUSK_F",
			"O_APC_Tracked_02_AA_F",
			"O_MBT_02_arty_F",
			"O_MBT_02_cannon_F",
			"O_MBT_04_cannon_F",
			"O_MBT_04_command_F",
			"I_APC_tracked_03_cannon_F",
			"I_MBT_03_cannon_F"
		]>0) then
		{
			_vehicle animate ["showCamonetHull",0];
			_vehicle animate ["showCamonetTurret",0];
			_vehicle setVariable ["CamoDeployed", false, true];
		};
	};
};