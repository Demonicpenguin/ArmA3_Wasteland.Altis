// nul=[nameofvehicle,rateofleak] execvm "Fuel_Consumption.sqf"; 

_unit = _this select 0;
_rate = _this select 1;
hint "Fuel Consumption has been accelerated on this Vehicle";

while {(alive _unit) and (fuel _unit > 0)} do { 

if (isengineon _unit) then {
_unit setFuel ( Fuel _unit -_rate);
};
sleep 1;
};

// hint "Out!!!";