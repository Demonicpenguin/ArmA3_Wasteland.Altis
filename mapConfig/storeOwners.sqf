// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: storeOwners.sqf
//	@file Author: AgentRev, JoSchaap, His_Shadow

// Notes: Gun and general stores have position of spawned crate, vehicle stores have an extra air spawn direction
//
// Array contents are as follows:
// Name, Building Position, Desk Direction (or [Desk Direction, Front Offset]), Excluded Buttons
storeOwnerConfig = compileFinal str
[
	["GenStore1", 6, 240, []],
	["GenStore2", 6, 250, []],
	["GenStore3", -1, 46, []],
	["GenStore4", 0, 265, []],
	["GenStore5", 5, 350, []],
	["GenStore5_1", -1, 257, []],
	["GenStore5_2", -1, 101, []],	

	["GunStore1", 1, 0, []],
	["GunStore2", 1, 75, []],
	["GunStore3", 6, 135, []],
	["GunStore4", 1, 65, []],
	["GunStore5", -1, 108, []],
	["GunStore6", -1, 124.389, []],	

	// Buttons you can disable: "land", "armored", "tanks", "helicopters", "boats", "planes", "uavs", "submarines", "ships"
	["VehStore1", 1, 75, ["uavs","submarines","ships"]],							//Molos
	["VehStore2", -1, [], ["boats","uavs","submarines","ships"]],					//Saltlakes
	["VehStore3", 4, 250, ["boats","uavs","submarines","ships"]],					//Selekano
	["VehStore4", -1, 182, ["boats","uavs","submarines","ships"]],					//Main Airfield
	["VehStore5", 0, 190, ["planes","uavs","submarines","ships"]],					//Above Kavala
	["VehStore6", -1, 276, ["boats","uavs","submarines","ships"]],					//NW Airfield
	["VehStore7", -1, 78, ["boats","submarines","ships"]],							//ACC Airfield
	["VehStore8", -1, 98, ["uavs","planes","submarines","ships"]],					//Military Camp Pyrgos
	["VehStore9", -1, 4, ["land","armored","tanks","uavs", "submarines","ships"]],	//Aircraft Carrier	
	["VehStore10", -1, 330, ["planes","uavs"]]										//Shipyard		
	
	//["BaseStore1", -1, 358, []],
	//["BaseStore2", -1, 176, []],
	//["BaseStore3", -1, 248, []]	

	
];

// Outfits for store owners
storeOwnerConfigAppearance = compileFinal str
[
	["GenStore1", [["weapon", ""], ["uniform", "U_IG_Guerilla2_2"]]],
	["GenStore2", [["weapon", ""], ["uniform", "U_IG_Guerilla2_3"]]],
	["GenStore3", [["weapon", ""], ["uniform", "U_IG_Guerilla3_1"]]],
	["GenStore4", [["weapon", ""], ["uniform", "U_IG_Guerilla2_1"]]],
	["GenStore5", [["weapon", ""], ["uniform", "U_IG_Guerilla3_2"]]],
	["GenStore5_1", [["weapon", ""], ["uniform", "U_IG_Guerilla3_2"]]],
	["GenStore5_2", [["weapon", ""], ["uniform", "U_IG_Guerilla3_2"]]],	

	["GunStore1", [["weapon", ""], ["uniform", "U_B_SpecopsUniform_sgg"]]],
	["GunStore2", [["weapon", ""], ["uniform", "U_O_SpecopsUniform_blk"]]],
	["GunStore3", [["weapon", ""], ["uniform", "U_I_CombatUniform_tshirt"]]],
	["GunStore4", [["weapon", ""], ["uniform", "U_IG_Guerilla1_1"]]],
	["GunStore5", [["weapon", ""], ["uniform", "U_IG_Guerilla1_1"]]],
	["GunStore6", [["weapon", ""], ["uniform", "U_IG_Guerilla1_1"]]],	

	["VehStore1", [["weapon", ""], ["uniform", "U_Competitor"]]],
	["VehStore2", [["weapon", ""], ["uniform", "U_Competitor"]]],
	["VehStore3", [["weapon", ""], ["uniform", "U_Competitor"]]],
	["VehStore4", [["weapon", ""], ["uniform", "U_Competitor"]]],
	["VehStore5", [["weapon", ""], ["uniform", "U_Competitor"]]],
	["VehStore6", [["weapon", ""], ["uniform", "U_Competitor"]]],	
	["VehStore7", [["weapon", ""], ["uniform", "U_Competitor"]]],
	["VehStore8", [["weapon", ""], ["uniform", "U_Competitor"]]],
	["VehStore9", [["weapon", ""], ["uniform", "U_Competitor"]]],
	["VehStore10", [["weapon", ""], ["uniform", "ffaa_ar_uniforme_marinero_item"]]]	
	
	/*["BaseStore1", [["weapon", ""], ["uniform", "U_Competitor"]]],
	["BaseStore2", [["weapon", ""], ["uniform", "U_Competitor"]]],
	["BaseStore3", [["weapon", ""], ["uniform", "U_Competitor"]]]*/	
];
