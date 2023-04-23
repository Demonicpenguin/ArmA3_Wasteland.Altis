//Client Menu Building for Airdrop Assistance
//Builds client commanding menus dynamically based on config file arrays
//Author: Apoc, GMG_Monkey
//Credits to Cre4mpie for the command menu approach and static structure of menus

AirSupportMenu =
[
	["Air Support",true],
			["Air Support Options", [2], "#USER:VehicleMenu", -5, [["expression", ""]], "1", "1"],
			["Cancel Air Support", [3], "", -3, [["expression", ""]], "1", "1"]
];


MTP_fnc_numberToString =
{
   _number = _this;
   _str = "";
   if (_number % 1 == 0) then
   {
       while { _number > 0 } do
       {
           _digit = floor (_number % 10);
           _str = (str _digit) + _str;
           _number = floor (_number / 10);
       };
   }
   else
   {
       _decimals = _number % 1;
       _decimals = _decimals * 1000000;
       _number = floor _number;
       _str = _number call MTP_fnc_numberToString;
       _str = _str + "." + str _decimals;
   };

   _str;
};



//////////////////////////////////////////////////////
//Setting up the Vehicle Menu ///////////////////////
/////////////////////////////////////////////////////
VehicleMenu = [];
_startVehMenu = ["Vehicles",true];
VehicleMenu pushback _startVehMenu;

_i=0;
{
	_optionVehMenu = [];
	_lineElement1=format ["%1 ($%2)",(Monkey_AirSupport_Options select _i) select 0, ((Monkey_AirSupport_Options select _i) select 1 call MTP_fnc_numberToString)];
	_type = (Monkey_AirSupport_Options select _i) select 2;
	_optionVehMenu pushback _lineElement1;

	_optionVehMenu append [[_i+2], "", -5];

	_optionVehMenu pushback [["expression", format ['["%1",%2,player] execVM "addons\Monkeys_Air_Support\Monkey_cli_startAirSupport.sqf"',_type,_i]]];

	_optionVehMenu append ["1","1"];

	VehicleMenu pushback _optionVehMenu;
	//diag_log format["Here's the menu structure: %1",VehicleMenu];
	_i=_i+1;
}forEach Monkey_AirSupport_Options;

_endVehMenu = ["Cancel Air Support", [_i+2], "", -3, [["expression", ""]], "1", "1"];
VehicleMenu pushback _endVehMenu;



showCommandingMenu "#USER:AirSupportMenu";
