//Client Menu Building for Airdrop Assistance 
//Builds client commanding menus dynamically based on config file arrays
//Author: Apoc
//Credits to Cre4mpie for the command menu approach and static structure of menus

AirdropMenu = 
[
	["Airdrop",true],
			["Vehicles", [2], "#USER:VehicleMenu", -5, [["expression", ""]], "1", "1"],
			["Armoured", [3], "#USER:Vehicle2Menu", -5, [["expression", ""]], "1", "1"],	
			["Tanks", [4], "#USER:TanksMenu", -5, [["expression", ""]], "1", "1"],		
			["Helicoptors", [5], "#USER:HelisMenu", -5, [["expression", ""]], "1", "1"],
			["Boats", [6], "#USER:BoatMenu", -5, [["expression", ""]], "1", "1"],			
			["Supplies", [7], "#USER:SupplyMenu", -5, [["expression", ""]], "1", "1"],
			["BasePacks", [8], "#USER:BaseMenu", -5, [["expression", ""]], "1", "1"],			
			["Cancel Airdrop", [8], "", -3, [["expression", ""]], "1", "1"]
];
//////////////////////////////////////////////////////
//Setting up the Vehicle Menu ///////////////////////
/////////////////////////////////////////////////////
VehicleMenu = [];
_startVehMenu = ["Vehicles",true];
VehicleMenu pushback _startVehMenu;

_i=0;
{
_optionVehMenu = [];
_lineElement1=format ["%1 ($%2)",(APOC_AA_VehOptions select _i) select 0, (APOC_AA_VehOptions select _i) select 2];
_type = (APOC_AA_VehOptions select _i) select 3;
_optionVehMenu pushback _lineElement1;

_optionVehMenu append [[_i+2], "", -5];

_optionVehMenu pushback [["expression", format ['["%1",%2,player] execVM "addons\APOC_Airdrop_Assistance\APOC_cli_startAirdrop.sqf"',_type,_i]]];

_optionVehMenu append ["1","1"];

VehicleMenu pushback _optionVehMenu;
//diag_log format["Here's the menu structure: %1",VehicleMenu];
_i=_i+1;
}forEach APOC_AA_VehOptions;

_endVehMenu = ["Cancel Airdrop", [_i+2], "", -3, [["expression", ""]], "1", "1"];
VehicleMenu pushback _endVehMenu;
///////////////////////////////////////////////////////

//////////////////////////////////////////////////////
//Setting up the Light Vehicle Menu //////////////////
/////////////////////////////////////////////////////
Vehicle2Menu = [];
_startVeh2Menu = ["Armoured",true];
Vehicle2Menu pushback _startVeh2Menu;

_i=0;
{
_optionVeh2Menu = [];
_lineElement1=format ["%1 ($%2)",(APOC_AA_LightOptions select _i) select 0, (APOC_AA_LightOptions select _i) select 2];
_type = (APOC_AA_LightOptions select _i) select 3;
_optionVeh2Menu pushback _lineElement1;

_optionVeh2Menu append [[_i+2], "", -5];

_optionVeh2Menu pushback [["expression", format ['["%1",%2,player] execVM "addons\APOC_Airdrop_Assistance\APOC_cli_startAirdrop.sqf"',_type,_i]]];

_optionVeh2Menu append ["1","1"];

Vehicle2Menu pushback _optionVeh2Menu;
//diag_log format["Here's the menu structure: %1",Vehicle2Menu];
_i=_i+1;
}forEach APOC_AA_LightOptions;

_endVeh2Menu = ["Cancel Airdrop", [_i+2], "", -3, [["expression", ""]], "1", "1"];
Vehicle2Menu pushback _endVeh2Menu;
///////////////////////////////////////////////////////

//////////////////////////////////////////////////////
//Setting up the Tank Menu ///////////////////////////
/////////////////////////////////////////////////////
TanksMenu = [];
_startTankMenu = ["Tanks",true];
TanksMenu pushback _startTankMenu;

_i=0;
{
_optionTankMenu = [];
_lineElement1=format ["%1 ($%2)",(APOC_AA_TankOptions select _i) select 0, (APOC_AA_TankOptions select _i) select 2];
_type = (APOC_AA_TankOptions select _i) select 3;
_optionTankMenu pushback _lineElement1;

_optionTankMenu append [[_i+2], "", -5];

_optionTankMenu pushback [["expression", format ['["%1",%2,player] execVM "addons\APOC_Airdrop_Assistance\APOC_cli_startAirdrop.sqf"',_type,_i]]];

_optionTankMenu append ["1","1"];

TanksMenu pushback _optionTankMenu;
//diag_log format["Here's the menu structure: %1",TanksMenu];
_i=_i+1;
}forEach APOC_AA_TankOptions;

_endTankMenu = ["Cancel Airdrop", [_i+2], "", -3, [["expression", ""]], "1", "1"];
TanksMenu pushback _endTankMenu;
///////////////////////////////////////////////////////

//////////////////////////////////////////////////////
//Setting up the Heli Menu ///////////////////////////
/////////////////////////////////////////////////////
HelisMenu = [];
_startHeliMenu = ["Helicoptors",true];
HelisMenu pushback _startHeliMenu;

_i=0;
{
_optionHeliMenu = [];
_lineElement1=format ["%1 ($%2)",(APOC_AA_HeliOptions select _i) select 0, (APOC_AA_HeliOptions select _i) select 2];
_type = (APOC_AA_HeliOptions select _i) select 3;
_optionHeliMenu pushback _lineElement1;

_optionHeliMenu append [[_i+2], "", -5];

_optionHeliMenu pushback [["expression", format ['["%1",%2,player] execVM "addons\APOC_Airdrop_Assistance\APOC_cli_startAirdrop.sqf"',_type,_i]]];

_optionHeliMenu append ["1","1"];

HelisMenu pushback _optionHeliMenu;
//diag_log format["Here's the menu structure: %1",HelisMenu];
_i=_i+1;
}forEach APOC_AA_HeliOptions;

_endHeliMenu = ["Cancel Airdrop", [_i+2], "", -3, [["expression", ""]], "1", "1"];
HelisMenu pushback _endHeliMenu;
///////////////////////////////////////////////////////

//////////////////////////////////////////////////////
//Setting up the Boat Menu ///////////////////////////
/////////////////////////////////////////////////////
BoatMenu = [];
_startBoatMenu = ["Boats",true];
BoatMenu pushback _startBoatMenu;

_i=0;
{
_optionHeliMenu = [];
_lineElement1=format ["%1 ($%2)",(APOC_AA_BoatOptions select _i) select 0, (APOC_AA_BoatOptions select _i) select 2];
_type = (APOC_AA_BoatOptions select _i) select 3;
_optionHeliMenu pushback _lineElement1;

_optionHeliMenu append [[_i+2], "", -5];

_optionHeliMenu pushback [["expression", format ['["%1",%2,player] execVM "addons\APOC_Airdrop_Assistance\APOC_cli_startAirdrop.sqf"',_type,_i]]];

_optionHeliMenu append ["1","1"];

BoatMenu pushback _optionHeliMenu;
//diag_log format["Here's the menu structure: %1",BoatMenu];
_i=_i+1;
}forEach APOC_AA_BoatOptions;

_endBoatMenu = ["Cancel Airdrop", [_i+2], "", -3, [["expression", ""]], "1", "1"];
BoatMenu pushback _endBoatMenu;
///////////////////////////////////////////////////////

//////////////////////////////////////////////////////
//Setting up the Supply Menu ////////////////////////
/////////////////////////////////////////////////////
SupplyMenu = [];
_startSupMenu = ["Supplies",true];
SupplyMenu pushback _startSupMenu;

_i=0;
{
_optionSupMenu = [];
_lineElement1=format ["%1 ($%2)",(APOC_AA_SupOptions select _i) select 0, (APOC_AA_SupOptions select _i) select 2];
_type = (APOC_AA_SupOptions select _i) select 3;
_optionSupMenu pushback _lineElement1;

_optionSupMenu append [[_i+2], "", -5];

_optionSupMenu pushback [["expression", format ['["%1",%2,player] execVM "addons\APOC_Airdrop_Assistance\APOC_cli_startAirdrop.sqf"',_type,_i]]];

_optionSupMenu append ["1","1"];

SupplyMenu pushback _optionSupMenu;
//diag_log format["Here's the menu structure: %1",SupplyMenu];
_i=_i+1;
}forEach APOC_AA_SupOptions;

_endSupMenu = ["Cancel Airdrop", [_i+2], "", -3, [["expression", ""]], "1", "1"];
SupplyMenu pushback _endSupMenu;
///////////////////////////////////////////////////////


//////////////////////////////////////////////////////
//Setting up the Base Pack Menu ////////////////////////
/////////////////////////////////////////////////////
BaseMenu = [];
_startSupMenu = ["BasePacks",true];
BaseMenu pushback _startSupMenu;

_i=0;
{
_optionBaseMenu = [];
_lineElement1=format ["%1 ($%2)",(APOC_AA_BaseOptions select _i) select 0, (APOC_AA_BaseOptions select _i) select 2];
_type = (APOC_AA_BaseOptions select _i) select 3;
_optionBaseMenu pushback _lineElement1;

_optionBaseMenu append [[_i+2], "", -5];

_optionBaseMenu pushback [["expression", format ['["%1",%2,player] execVM "addons\APOC_Airdrop_Assistance\APOC_cli_startAirdrop.sqf"',_type,_i]]];

_optionBaseMenu append ["1","1"];

BaseMenu pushback _optionBaseMenu;
//diag_log format["Here's the menu structure: %1",BaseMenu];
_i=_i+1;
}forEach APOC_AA_BaseOptions;

_endSupMenu = ["Cancel Airdrop", [_i+2], "", -3, [["expression", ""]], "1", "1"];
BaseMenu pushback _endSupMenu;
///////////////////////////////////////////////////////


showCommandingMenu "#USER:AirdropMenu";