// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: inviteToGroup.sqf
//	@file Author: [404] Deadbeat
//	@file Created: 20/11/2012 05:19

if(player != leader group player) exitWith {player globalChat format["you are not the leader and can't invite people"];};

#define groupManagementDialog 55510
#define groupManagementPlayerList 55511

disableSerialization;

private["_dialog","_playerListBox","_groupInvite","_target","_index","_playerData","_check","_unitCount","_hasInvite"];

_dialog = findDisplay groupManagementDialog;
_playerListBox = _dialog displayCtrl groupManagementPlayerList;

_index = lbCurSel _playerListBox;
_playerData = _playerListBox lbData _index;
_hasInvite = false;

//Check selected data is valid
{ if (getPlayerUID _x == _playerData) exitWith { _target = _x } } forEach allPlayers;

diag_log "Invite to group: Before the checks";

//*******************************************************
// Limit group number of players

// Amount of players allowed in a group
//MAX_GROUP_COUNT = ["A3W_Max_Group_Count", 10] call getPublicVar;

//#define MAX_GROUP_COUNT 6

/*_groupCount = count units player;

if (_groupCount < MAX_GROUP_COUNT) then
{
	{
		_senderUID = _x select 0;

		if ({getPlayerUID _x == _senderUID} count units player > 0) then
		{
			_groupCount = _groupCount + 1;
		};
	} forEach currentInvites;
};

if (_groupCount >= MAX_GROUP_COUNT) exitWith { [format ["You cannot have more than %1 group members, including pending invites.", MAX_GROUP_COUNT]] spawn BIS_fnc_guiMessage };*/

//********************************************************
//Checks
if(isNil "_target") exitWith {player globalChat "you must select someone to invite first"};
if(_target == player) exitWith {player globalChat "you can't invite yourself"};
if((count units group _target) > 1) exitWith {player globalChat "This player is already in a group"};

{ if (_x select 1 == getPlayerUID _target) then { _hasInvite = true } } forEach currentInvites;
if(_hasInvite) exitWith {player globalChat "This player already has a pending invite"};

diag_log "Invite to group: After the checks";

//currentInvites pushBack [getPlayerUID player, getPlayerUID _target];
//publicVariable "currentInvites";

pvar_processGroupInvite = ["send", player, _target];
publicVariableServer "pvar_processGroupInvite";

//[format ["You have been invited to join %1's group", name player], "A3W_fnc_titleTextMessage", _target, false] call A3W_fnc_MP;

player globalChat format["You have invited %1 to join the group", name _target];

player setVariable ["currentGroupRestore", group player, true];
player setVariable ["currentGroupIsLeader", true, true];
