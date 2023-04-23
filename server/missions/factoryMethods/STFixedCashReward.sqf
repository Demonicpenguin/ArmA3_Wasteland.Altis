/*******************************************************************************************
* This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com
********************************************************************************************
* @file Name: STFixedCashReward.sqf
* @author: The Scotsman
*
* Creates a fixed cash reward
* Arguments: [ position, value ]:
*
*/
#include "..\..\..\STConstants.h"

if (!isServer) exitWith {};

params ["_position", "_reward"];
private ["_cash"];


for "_x" from 1 to 10 do {
  _cash = "Land_Money_F" createVehicle _position;
  _cash setPos (_position vectorAdd ([[2 + random 2,0,0], random 360] call BIS_fnc_rotateVector2D));
  _cash setDir random 360;
  _cash setVariable["cmoney", _reward / 10, true];
  _cash setVariable["owner","world",true];
  _cash setVariable["A3W_Mission_Object", true, true];
};
