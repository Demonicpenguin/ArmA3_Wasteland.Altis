//Init for Air Support
//Author: GMG_Monkey
//Author: Apoc
//
#include "config.sqf"

if (isServer) then
{
  Monkey_srv_StartAirSupport 	= compile preprocessFileLineNumbers "addons\Monkeys_Air_Support\Monkey_srv_StartAirSupport.sqf";
};
