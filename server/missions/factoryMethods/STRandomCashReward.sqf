/*******************************************************************************************
* This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com
********************************************************************************************
* @file Name: STRandomCashReward.sqf
* @author: The Scotsman
*
* Creates a random cash reward
* Arguments: [ position, values ]: Array of money values
*
*/
#include "..\..\..\STConstants.h"

if (!isServer) exitWith {};

params ["_position", "_values"];

private ["_cash", "_reward"];

_reward =  _values call BIS_fnc_selectRandom;

for "_x" from 1 to 10 do {
  _cash = "Land_Money_F" createVehicle _position;
  _cash setPos ((_position) vectorAdd ([[2 + random 2,0,0], random 360] call BIS_fnc_rotateVector2D));
  _cash setDir random 360;
  _cash setVariable["cmoney", _reward, true];
  _cash setVariable["owner","world", true];
  _cash setVariable["A3W_Mission_Object", true, true];
};

_reward
