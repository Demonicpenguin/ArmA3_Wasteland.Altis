/*******************************************************************************************
* This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com
********************************************************************************************
* @file Name: STCreateUnit.sqf
* @author: The Scotsman
*
* Creates a random unit according to given parameters
* Parameters: [_position, _group, _type, _rank ]:
*
* _position: Position to spawn the unit
* _group: Unit Group
* _type: (Optional) INFANTRY,PILOT,SNIPER,SQUID,DELTA. Default=INFANTRY
* _rank: (Optional) PRIVATE, CORPORAL, SERGENT, LIEUTENANT, CAPTAIN, MAJOR, COLONEL.  Default=PRIVATE
* _leader: (Optional) When true the unit is set as the group leader.  Default=False
*/

#include "..\..\..\STConstants.h"

if (!isServer) exitWith {};

params ["_position", "_group", ["_type", ST_INFANTRY], ["_rank", ST_PRIVATE], ["_leader", false]];
private ["_backpack", "_uniform", "_speaker", "_weapon", "_helmet", "_vest", "_unit", "_optic", "_goggles"];

_optic = nil;
_goggles = nil;
_speaker = ["Male01ENG","Male01ENGB","Male02ENG","Male02ENGB","Male03ENG","Male03ENGB","Male04ENG","Male04ENGB","Male05ENG","Male06ENG","Male07ENG","Male08ENG","Male09ENG"] call BIS_fnc_selectRandom;
_weapon = ["arifle_TRG20_F","LMG_Mk200_F","arifle_MXM_F","arifle_MX_GL_F"] call BIS_fnc_selectRandom;
_helmet = ["H_Booniehat_dgtl","H_Cap_blk","H_HelmetB_camo","H_MilCap_tna_F","H_HelmetSpecO_ghex_F","H_HelmetB_tna_F","H_HelmetB_light_snakeskin","H_HelmetB_desert","H_Hat_camo"] call BIS_fnc_selectRandom;
_vest = ["V_PlateCarrier1_rgr","V_PlateCarrier2_rgr", "V_PlateCarrierIA1_dgtl"] call BIS_fnc_selectRandom;
_unit = ["C_man_polo_1_F", "C_man_polo_2_F", "C_man_polo_3_F", "C_man_polo_4_F", "C_man_polo_5_F", "C_man_polo_6_F"] call BIS_fnc_selectRandom;

if( _leader ) then { _rank = ST_LIEUTENANT; };

//Figure out AA & AT -- Does not apply to pilots
private _launcher = 20 > random 100 && _type != ST_PILOT;

//Use the default backpack, or generate a larger one for AA/AT guys
_backpack = [(["B_AssaultPack_dgtl","rhsusf_assault_eagleaiii_ucp"] call BIS_fnc_selectRandom), (["B_Carryall_mcamo", "B_TacticalPack_rgr"]call BIS_fnc_selectRandom)] select (_launcher);

//Pilot?
switch (_type) do {
  case ST_PILOT:{

    _backpack = "B_Parachute";
    _uniform = "U_B_HeliPilotCoveralls";
    _helmet = "rhsusf_hgu56p_visor_black";
    _goggles = "rhs_googles_clear";

  };
  case ST_SNIPER:{

    _uniform = "U_I_Ghilliesuit";
    _vest = ["V_PlateCarrierIA1_dgtl", "V_HarnessOSpec_brn"] call BIS_fnc_selectRandom;
    _weapon = ["srifle_GM6_SOS_F", "srifle_EBR_SOS_F", "srifle_DMR_01_F", "srifle_DMR_02_sniper_F","srifle_DMR_03_MRCO_F","srifle_LRR_F","srifle_GM6_ghex_F"] call BIS_fnc_selectRandom;
    _optic = ["optic_Holosight", "optic_KHS_blk","optic_LRPS","optic_Arco","optic_MRCO","optic_tws","optic_Yorris","optic_NVS","optic_SOS","optic_SOS_khk_F"] call BIS_fnc_selectRandom;

    //Leader has 50% Chance of NightStalker
    if( _leader && 50 > random 100 ) then { _optic = "optic_Nightstalker"; };

  };
  case ST_SQUID: {

    _uniform = "U_BG_Guerilla2_1";
    _vest = "V_TacVest_blk_POLICE";

  };
  case ST_SEAL: {

    _rank = [ST_SERGEANT, ST_LIEUTENANT, ST_CAPTAIN, ST_MAJOR] call BIS_fnc_selectRandom;
    _vest = "rhsusf_iotv_ucp_Teamleader";
    _helmet = "rhsusf_lwh_helmet_marpatd_headset";
    _uniform = "rhs_uniform_cu_ucp_10th";
    _backpack = "rhsusf_assault_eagleaiii_ucp";
    _goggles  = "rhs_googles_clear";
    _weapon = ["arifle_Katiba_F","arifle_Katiba_C_F","arifle_MXC_Black_F","arifle_MXM_Black_F","srifle_DMR_03_F","rhs_weap_mk18_bk","rhs_weap_m4a1_blockII_bk"] call BIS_fnc_selectRandom;
    _optic = ["optic_Arco_blk_F", "rhsusf_acc_ACOG3_USMC", "rhsusf_acc_eotech_552", "rhsusf_acc_ACOG_RMR", "rhsusf_acc_RX01"] call BIS_fnc_selectRandom;

    //Chance of a higher weapon
    if( random 100 <= 5 ) then { _weapon = ["rhs_weap_hk416d10_LMT", "rhs_weap_m27iar", "rhs_weap_m4", "rhs_weap_mk18_bk", "rhsusf_weap_MP7A2"] call BIS_fnc_selectRandom; };

    if( _leader ) then { _rank = ST_MAJOR; };

  };
  case ST_DELTA: {

    _rank = [ST_SERGEANT, ST_LIEUTENANT] call BIS_fnc_selectRandom;
    _vest = "V_Chestrig_blk";
  	_uniform = "rhs_uniform_g3_blk";
    _backpack = "B_ViperLightHarness_blk_F";
    _helmet = "rhsusf_hgu56p_black";
    _weapon = ["arifle_Katiba_F","arifle_Katiba_C_F","arifle_MXC_Black_F","arifle_MXM_Black_F","srifle_DMR_03_F","rhs_weap_mk18_bk","rhs_weap_m4a1_blockII_bk"] call BIS_fnc_selectRandom;
    _goggles  = "rhs_ess_black";
    _optic = selectRandom ["optic_Arco_blk_F", "rhsusf_acc_ACOG3_USMC", "rhsusf_acc_eotech_552", "rhsusf_acc_ACOG_RMR", "rhsusf_acc_RX01"];

    //Chance of a higher weapon
    if( random 100 <= 5 ) then { _weapon = ["rhs_weap_hk416d10_LMT", "rhs_weap_m27iar", "rhs_weap_m4", "rhs_weap_mk18_bk", "rhsusf_weap_MP7A2"] call BIS_fnc_selectRandom; };

  };
  case ST_GUERRILLA: {

    _uniform = ["U_I_C_Soldier_Bandit_1_F","U_C_Man_casual_5_F","U_C_Man_casual_4_F"] call BIS_fnc_selectRandom;
    _vest = "V_BandollierB_rgr";

  };
  default {

    //TODO: More random uniforms
    _uniform = ["U_B_CombatUniform_mcam_vest", "U_B_CombatUniform_mcam_tshirt" ,"U_B_CombatUniform_mcam"] call BIS_fnc_selectRandom;

    //Two percent chance of a unit having a special weapon
    if( random 100 <= 2 ) then { _weapon = selectRandom STSpecialWeapons; };

  };
};

private _soldier = _group createUnit [_unit, _position, [], 0, "FORM"];

removeAllAssignedItems _soldier;
removeHeadgear _soldier;

sleep 0.1; // Without this delay, headgear doesn't get removed properly

//Group Leader?
if( _leader ) then { _group selectLeader _soldier; };

_soldier setSpeaker _speaker;
_soldier setRank _rank;
_soldier addVest _vest;
_soldier addHeadgear _helmet;
_soldier addBackpack _backpack;
_soldier forceAddUniform  _uniform;
_soldier setVariable ["A3W_Mission_Object", true, true];
//_soldier addRating 1e11;

//Launcher is randomly AA or AT
if( _launcher ) then {[_soldier, (["launch_B_Titan_F", "launch_B_Titan_short_F"] call BIS_fnc_selectRandom), ([1,3]call BIS_fnc_randomInt)] call BIS_fnc_addWeapon; };

//Random Hand Grenades
for "_x" from 1 to ([1,4]call BIS_fnc_randomInt) do { _soldier addMagazine "HandGrenade"; };

//Configure Weapon
[_soldier, _weapon, ([2,8]call BIS_fnc_randomInt)] call BIS_fnc_addWeapon;

//Add Optic
if( !isNil "_optic" ) then {  _soldier addPrimaryWeaponItem _optic; };

//Goggles?
if( !isNil "_goggles" ) then { _soldier addGoggles _goggles; };

//Add Rangefinder to Spotters
if( _weapon == "srifle_EBR_SOS_F" ) then { _soldier addItem "Rangefinder"; };

//diag_log format ["STCreateUnit (%1)%2 - %3:%4:%5:%6%7 Launcher:[%8]", _type, _rank, _uniform, _vest, _helmet, _weapon, _backpack, _launcher];

//Give infantrymen flashlights
if( _type == ST_INFANTRY ) then {

  _soldier addPrimaryWeaponItem "acc_flashlight";
  _soldier enablegunlights "AUTO";
  _soldier spawn addMilCap;

};

//Can only be done after unit has been created
if( _type == ST_DELTA ) then { _soldier linkItem "rhsusf_ANPVS_15"; };

_soldier call setMissionSkill;
_soldier triggerDynamicSimulation true;

_soldier addEventHandler ["Killed", server_playerDied];
_soldier
