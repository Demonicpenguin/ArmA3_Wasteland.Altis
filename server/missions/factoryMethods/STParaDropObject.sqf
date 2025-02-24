/*******************************************************************************************
* This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com
********************************************************************************************
* @file Name: STParaDropObject.sqf
* @author: The Scotsman
*
* Paradrops a given object
* Arguments: [ position, value ]:
*
*/
if (!isServer) exitWith {};

private ["_class","_para","_paras","_p","_veh","_vel","_time"];

_class = "I_parachute_02_F";

_para = createVehicle [_class, [0,0,0], [], 0, "FLY"];
_para setDir getDir _this;
_para setPos getPos _this;
_paras =  [_para];
_this attachTo [_para, [0,2,0]];

{
    _p = createVehicle [_class, [0,0,0], [], 0, "FLY"];
    _paras set [count _paras, _p];
    _p attachTo [_para, [0,0,0]];
    _p setVectorUp _x;
} count [
    [0.5,0.4,0.6],[-0.5,0.4,0.6],[0.5,-0.4,0.6],[-0.5,-0.4,0.6]
];
0 = [_this, _paras] spawn {
    _veh = _this select 0;
    waitUntil {getPos _veh select 2 < 4};
    _vel = velocity _veh;
    detach _veh;
    _veh setVelocity _vel;
    missionNamespace setVariable ["#FX", [_veh, _vel select 2]];
    publicVariable "#FX";
    playSound3D [
        "a3\sounds_f\weapons\Flare_Gun\flaregun_1_shoot.wss",
        _veh
    ];
    {
        detach _x;
        _x disableCollisionWith _veh;
    } count (_this select 1);
    _time = time + 5;
    waitUntil {time > _time};
    {
        if (!isNull _x) then {deleteVehicle _x};
    } count (_this select 1);
};
