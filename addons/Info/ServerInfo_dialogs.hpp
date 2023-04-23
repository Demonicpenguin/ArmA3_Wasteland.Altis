// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2015 509th.net *
// ******************************************************************************************
//	@file Name: ServerInfo_dialog.hpp
//	@file Author: [509th] Coyote Rogue

#include "ServerInfo_defines.hpp"

class ServerInfo_DIALOG
{
	idd = -1; 
	movingEnable = true; 
	enableSimulation = 1;
	enableDisplay = 1; 
	
	onLoad = ""; 
    
    class Controls
    {
		class MainBG : w_RscPicture {
			idc = -1;
			colorText[] = {1, 1, 1, 1};
			colorBackground[] = {0,0,0,0};
			text = "#(argb,8,8,3)color(0,0,0,0.6)";
			moving = true;
			x = 0.0; y = 0.1;
			w = .995; h = 0.995;
		};

		class TopBar: w_RscPicture
		{
			idc = -1;
			colorText[] = {1, 1, 1, 1};
			colorBackground[] = {0,0,0,0};
			text = "#(argb,8,8,3)color(0.25,0.51,0.96,0.8)";

			x = 0;
			y = 0.1;
			w = 0.995;
			h = 0.05;
		};

		class MainTitle : w_RscText 
		{
			idc = -1;
			text = "Server Information";
			sizeEx = 0.04;
			shadow = 2;
			x = 0.380; y = 0.1;
			w = 0.3; h = 0.05;
		};

		class InfoLogo: w_RscPicture
		{
			idc = -1;
			text = "media\pics\SKJ.paa"; //--- ToDo: Localize;
			x = 0.303562 * safezoneW + safezoneX;
			y = 0.322 * safezoneH + safezoneY;
			w = 0.0541405 * safezoneW;
			h = 0.099 * safezoneH;
			tooltip = "Duty | Honor | Courage"; //--- ToDo: Localize;
		};
		
		class InfoTitle: w_RscText
		{
			idc = -1;
			text = "Welcome to ROG Gaming"; //--- ToDo: Localize;
			sizeEx = 0.050;
			shadow = 4;
			colorText[] = {1, .8, 0, 1};			
			x = 0.355312 * safezoneW + safezoneX;
			y = 0.322 * safezoneH + safezoneY;
			w = 0.355781 * safezoneW;
			h = 0.033 * safezoneH;
			tooltip = ""; //--- ToDo: Localize;			
		};		

		class InfoServerInfo: w_RscText
		{
			idc = -1;
			text = "Server #3: A3Wasteland Altis v1.4d | IP: 195.154.181.159 :2502"; //--- ToDo: Localize;
			sizeEx = 0.035;
			shadow = 2;				
			x = 0.355312 * safezoneW + safezoneX;
			y = 0.350 * safezoneH + safezoneY;
			w = 0.355781 * safezoneW;
			h = 0.022 * safezoneH;
		};
		
		class InfoWebsite: w_RscText
		{
			idc = -1;
			text = "ROG Gaming | TeamSpeak 195.154.181.159"; //--- ToDo: Localize;
			sizeEx = 0.035;
			shadow = 2;				
			x = 0.355312 * safezoneW + safezoneX;
			y = 0.370 * safezoneH + safezoneY;
			w = 0.355781 * safezoneW;
			h = 0.022 * safezoneH;
		};
		
		class RulesTitle: w_RscText
		{
			idc = -1;
			text = "Rules"; //--- ToDo: Localize;
			sizeEx = 0.04;
			shadow = 2;
			style = 112;			
			x = 0.297 * safezoneW + safezoneX;
			y = 0.432 * safezoneH + safezoneY;
			w = 0.405 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.3,0,0,0.5};
			colorText[] = {1, .8, 0, 1};			
		};
		class NewsTitle: w_RscText
		{
			idc = -1;
			text = "Join our Discord for help https://discord.gg/XBJrA68"; //--- ToDo: Localize;
			sizeEx = 0.04;
			shadow = 2;
			style = 112;				
			x = 0.297 * safezoneW + safezoneX;
			y = 0.619 * safezoneH + safezoneY;
			w = 0.405 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.14, 0.18, 0.13, 0.5};
			colorText[] = {1, .8, 0, 1};			
		}; 

		class ServerRules: w_RscControlsGroup 
				{    
					idc = -1;				
					x = 0.2937 * safezoneW + safezoneX;
					y = 0.456 * safezoneH + safezoneY;
					w = 0.4082 * safezoneW;
					h = 0.158 * safezoneH;
					sizeEx = 0.04;				
					class Controls
					{
						class ServerRulesText: w_RscStructuredText 
						{
							idc = -1;
							type = 0; 
							style = 528;
							font = "PuristaMedium";
							sizeEx = 0.04;
							shadow = 2;				
							x = 0.297 * safezoneW + safezoneX;
							y = 0.225 * safezoneH + safezoneY;
							w = 0.399 * safezoneW;
							h = 0.999 * safezoneH;
							colorBackground[] = {0.3,0,0,0.5};
							lineSpacing = 1;
							text = "\nWebsite: <t color='#0091CD'><a href='https://units.arma3.com/unit/r-a-w'>\n\ncolor='#0091CD'><a href='https://www.dropbox.com/s/91fgrmrry38rjhi/Naval%20Weapon%20Systems.pdf?dl=0'>Ship/Sub Weapons Manual\n\n 2.  Admin/Mod decisions are final, respect that!\n\n 3.  If you have proof of someone glitching/hacking/being abusive,\n     report it to an admin!\n\n 4.  No Arguing with Staff. Staff's decision is FINAL.\n\n\n A3WASTELAND SERVER SPECIFIC RULES:\n\n 1.  No intentional teamkilling if you are on Blufor or Opfor!\n\n 2.  No Intentional Team killing, or Trolling teammates. This includes Towing, blocking\n     runways with vehicles.\n\n 3.  No Racism (THIS MEANS NO RACIAL SLURS/TERMINOLOGY,\n     REGARDLESS OF YOUR HERITAGE)\n\n 4.  No team-switching to gain an advantage on other players!\n\n 5.  Admins/Mods may unlock you depending on the situation!\n\n 6.  Admins/Mods may refund money depending on the situation!\n\n 7.  Logging out before depositing money as any HVT (high value target) CAN Result In Loss\n     ALL money earned. Temp ban if Necessary\n\n\n BANNABLE OFFENSES ON THIS SERVER:\n\n 1.  Hacking, Glitching or Cheating will get you banned (PERM – NO EXCEPTIONS)\n\n 2.  Exploiting map bugs/glitches (temp or PERM)\n\n 3.  Intentional Teamkilling (temp or PERM)\n\n 4.  Trolling our servers (temp)\n\n 5.  Disrupting the server / Being an Asshat (temp)\n\n 6.  If caught repeating the offence after being temp banned,\n     you will receive a 30-day ban.\n\n 7.  Spawn Island is a restricted location. You may not land on this island;\n     you may not shoot at anyone on this island.\n\n 8.  If you are found shooting players here, you will be banned\n     without question.\n\n 9.  Team switching, or switching from Blufor / Opfor to Indie, with the goal\n     of figuring out players locations, buying vehicles, etc. Will result in a ban.\n     DO NOT team switch at a hacker’s mission it will be a bannable offence\n     and result in loss of money.\n\n 10. Impersonating Staff will result in a 30-day ban, even if it was only a joke.\n\n 11. DO NOT attempt to multi-hack at a hacker’s mission or it will result in a ban.\n     Hacked money must be shared with those involved in the mission.\n\n 12. DO NOT put vehicles inside or on stores and DO NOT block doorways with vehicles.\n     Attempting to deal with team killers, glitchers, thieving teammates,\n     hackers, trolls, etc. yourself instead of contacting staff may result in\n     a ban for you as well as the player in question.\n     We DO NOT advocate team killing in order to deal with the aforementioned types of\n     players! If you are caught teamkilling a player that is trolling, you will be banned\n     as well as them.\n\n 13. Please remember, staff members are NOT required to give a set number of warnings\n     before a ban is issued. They do, however, have to warn you at least once.\n     Should you ignore their requests or simply fail to hear them, an appropriate action\n     will be taken at the staff member’s discretion.\n\n 14. These rules are only here so that the server runs smoothly so that everyone can have fun.\n\n 15. If we see a Rule violation, we will make attempts to contact you either\n     in game or on Discord. If we are not able to reach you, we will handle the\n     violation accordingly without your knowledge.\n\n 16. If your base is actively affecting the overall game-play on the server\n     (example: your base completely blocks the only safe passage to an area or your base has caused\n     a major resource to despawn), Admin reserves the right to remove your base\n     immediately without contacting you.\n\n\n STORES: You are not permitted to build a base within 1400 meters of a store.\n\n\n SIZE OF BASE: If we see your bases occupying an unreasonable amount of land or if\n     your base is completely spread out on the map, it will be at Admin’s discretion to\n     have you reduce the size of your base.\n\n\n PREMADE STRUCTURES:\n\n 1.  DO NOT build on any premade structures on the map like temples or ruins.\n\n 2.  There are premade bases on the map. If you find one without a key, you can claim it by purchasing\n     2 keys from the General Store, locking it and utilizing a base locker to lock\n     down the base.\n\n 3.  If you have any buildings near premade structures, we reserve the right to have you\n     remove them if your buildings block structures or in game interactions for players\n     (i.e. loot chests, emotes or lore).\n\n 4.  Off-line raiding is NOT PERMITTED. If a player is NOT LOGGED in, do not attempt to raid\n     or destroy the base.\n\n 5.  Base raiding – in the event you are able to raid a player’s base,\n     DO NOT UNLOCK base parts. You are permitted to take items that are unlocked or steal or destroy vehicles.\n\n\n ACCESS: Blocking any passages to any part of the map is not allowed. Even if players can climb,\n     jump or walk over your structure, you will be required to remove it.  Public walkways,\n     tunnels or bridges may be considered but it will require Admin approval. We reserve\n     the right to have you alter or completely remove your structure after it is\n     built if it does not adhere to rules or if Admin sees potential issues.\n\n\n VEHICLES:\n\n 1.  Any vehicles left at around or at vehicle stores will be deleted.\n\n 2.  There are garages to park your vehicles, use them.\n\n\n SHIPS:\n\n 1.  Ships spawn up at the North West Vehicle Store.\n\n 2.  To park the ships, go to the rearm rigs, shipyard, storage island or Kavala storage\n     shed closest the water to park them.\n\n 3.  To retrieve you ship you must go to the rearming stations. There are ATM’s at the\n     rearm stations.";
						};
					};
				};

		class ServerNews: w_RscControlsGroup 
				{    
					idc = -1;				
					x = 0.2937 * safezoneW + safezoneX;
					y = 0.644 * safezoneH + safezoneY;
					w = 0.4082 * safezoneW;
					h = 0.158 * safezoneH;
					sizeEx = 0.04;				
					class Controls
					{
						class ServerNewsText: w_RscStructuredText 
						{
							idc = -1;
							type = 0; 
							style = 528;
							font = "PuristaMedium";
							sizeEx = 0.04;
							shadow = 2;				
							x = 0.297 * safezoneW + safezoneX;
							y = 0.225 * safezoneH + safezoneY;
							w = 0.399 * safezoneW;
							h = 0.999 * safezoneH;
							colorBackground[] = {0.14, 0.18, 0.13, 0.5};
							lineSpacing = 0.9;
							text = "\n * January 2019 - SERVER UPDATE!\n\n    [Updated] 1.88 for Wasteland v1.4d \n\n __________________________________________________________________\n\n Tips and Hints\n\n * Ask any ROG member to help. We will gladly provide advice, cash/supplies\n   and anything else needed to enjoy your time on our server.\n\n * Most ROG members play on the Independent faction. Request an in-game\n   invite via the 'Side' channel to be added to our group. Otherwise, you are\n   fair game!\n\n * Install the STGI and STNames mods to be able to spot 'friendly' players.\n   Normal player markers are disabled.\n\n * Vehicles and items (including base parts) that are NOT locked will be\n   removed at server reset.\n\n * Vehicles not used in a 14 day period will be removed.\n\n * You must enter the server every 90 days or you will start over from\n   scratch.\n\n * Press the Windows key to toggle player names.\n\n * Press the End key to toggle earplugs.\n\n * Report bugs and suggestions on our forums\n\n *** Visit our other ArmA and Call of Duty servers!"; //--- ToDo: Localize;
						};
					};
				};				
							
		class InfoButton: w_RscButton
		{
			idc = -1;
			text = "Continue";		
			x = 0.453604 * safezoneW + safezoneX;
			y = 0.829011 * safezoneH + safezoneY;
			w = 0.0876363 * safezoneW;
			h = 0.0440016 * safezoneH;
			tooltip = "Click here to return to Player Menu"; //--- ToDo: Localize;
			action = "closeDialog 0";
		};	
    };
};