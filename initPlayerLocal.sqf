// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: initPlayerLocal.sqf
//	@file Author: AgentRev

if (!isServer) then
{
	"BIS_fnc_MP_packet" addPublicVariableEventHandler compileFinal preprocessFileLineNumbers "server\antihack\filterExecAttempt.sqf";
};

//GOM Addition

params ["_unit","_JIP"];

if (_unit getvariable ["GOM_fnc_aircraftLoadoutAllowed",false]) then {

	_unit spawn GOM_fnc_addAircraftLoadout;
};

null = [player] execVM "addons\GrassCutter\grasscutter.sqf";
player addEventhandler["respawn","_this execVM 'addons\GrassCutter\grasscutter.sqf'"];

[] execVM "addons\scripts\voyagerCompass.sqf";


_pic = "media\pics\SKJ.paa";

[
    '<img align=''left'' size=''1.5'' shadow=''0'' image='+(str(_pic))+' />',
    safeZoneX+0.00,
    safeZoneY+safeZoneH-0.16,
    99999,
    0,
    0,
    3090
] spawn bis_fnc_dynamicText;

halo addAction ["<t size='1.5' shadow='2' color='#00ffff'>HALO</t> <img size='4' color='#00ffff' shadow='2' image='\A3\Air_F_Beta\Parachute_01\Data\UI\Portrait_Parachute_01_CA.paa'/>", "call TG_fnc_halo", nil, 5, true, true, "","alive _target"];
