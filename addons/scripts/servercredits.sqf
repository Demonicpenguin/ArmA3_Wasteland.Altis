/* 	*********************************************************************** */
 
/*	=======================================================================
/*	SCRIPT NAME: Server Intro Credits Script by IT07
/*	SCRIPT VERSION: v1.3.5 BETA
/*	Credits for original script: Bohemia Interactive http://bistudio.com
/*	=======================================================================
 
/*	*********************************************************************** */
 
//	========== SCRIPT CONFIG ============
	
_onScreenTime = 8; 		//how long one role should stay on screen. Use value from 0 to 10 where 0 is almost instant transition to next role 
//NOTE: Above value is not in seconds!
 
//	==== HOW TO CUSTOMIZE THE CREDITS ===
//	If you want more or less credits on the screen, you have to add/remove roles.
//	Watch out though, you need to make sure BOTH role lists match eachother in terms of amount.
//	Just take a good look at the _role1 and the rest and you will see what I mean.
 
//	For further explanation of it all, I included some info in the code.
 
//	== HOW TO CUSTOMIZE THE COLOR OF CREDITS ==
//	Find line **** and look for: color='#C80000'
//	The numbers and letters between the 2 '' is the HTML color code for a certain yellow.
//	If you want to change the color of the text, search on google for HTML color codes and pick the one your like.
//	Then, replace the existing color code for the code you would like to use instead. Don't forget the # in front of it.
//	HTML Color Codes Examples:	
//	#FFFFFF (white)
//	#000000 (black)	No idea why you would want black, but whatever
//	#C80000 (red)
//	#009FCF (light-blue)
//	#31C300 (Razer Green)			
//	#FF8501 (orange)
//	===========================================
 
 
//	SCRIPT START
//waitUntil {!isNil "dayz_animalCheck"};
sleep 60; //Wait in seconds before the credits start after player IS ingame
 
_role1 = "Welcome to";
_role1names = ["lace server name here Altis"];
_role2 = "Occasionally Admin ran ZEUS Missions";
_role2names = ["and ZEUS Enhanced Standard Missions"];
_role3 = "Server restarts every 6 hours";
_role3names = ["0600H, 1200H, 1800H, 0000H "];
_role4 = "Visit our website @";
_role4names = ["Comminsoon"];
_role5 = "TS3 Server:";
_role5names = ["rawus.teamspeak3.com"];
_role6 = "Useful Commands";
_role6names = ["CTRL+R-Mag Repacker, END and INSERT - Volume Control and Earplugs, H-Holster, 0 Auto Run"];
_role7 = "Custom Missions";
_role7names = ["Better Gear can be found in mission crates. HVT are marked on map"];
_role8 = "This server supports";
_role8names = ["Blastcore standalone, Enhanced Movement, Advanced Rappelling, Advanced Urban Rappelling, JSRS Soundmod"];
_role9 = "This custom Wasteland server offers a lot more to the player and may at times seem Over Powered";
_role9names = ["Please do not complain about getting killed. It is a FUN packed server with high rewards and a great variation on the theme"];
_role10 = "Base Payment Reminder";
_role10names = ["Remember to pay for the upkeep of your base every 29 days through the Base Management Menu"];
_role11 = "So with that said from all of us at lace server name here";
_role11names = ["Please enjoy your time here. If you get killed take it like a Man/Woman and get back in the fight"];
 
{
	sleep 2;
	_memberFunction = _x select 0;
	_memberNames = _x select 1;
	_finalText = format ["<t size='0.50' color='#C80000' align='right'>%1<br /></t>", _memberFunction];
	_finalText = _finalText + "<t size='0.70' color='#FFFFFF' align='right'>";
	{_finalText = _finalText + format ["%1<br />", _x]} forEach _memberNames;
	_finalText = _finalText + "</t>";
	_onScreenTime + (((count _memberNames) - 1) * 0.5);
	[
		_finalText,
		[safezoneX + safezoneW - 0.8,0.50],	//DEFAULT: 0.5,0.35
		[safezoneY + safezoneH - 0.8,0.7], 	//DEFAULT: 0.8,0.7
		_onScreenTime,
		0.5
	] spawn BIS_fnc_dynamicText;
	sleep (_onScreenTime);
} forEach [
	//The list below should have exactly the same amount of roles as the list above
	[_role1, _role1names],
	[_role2, _role2names],
	[_role3, _role3names],
	[_role4, _role4names],
	[_role5, _role5names],
	[_role6, _role6names],
	[_role7, _role7names],
	[_role8, _role8names],  
	[_role9, _role9names],
	[_role10, _role10names],	
	[_role11, _role11names]		//make SURE the last one here does NOT have a , at the end
];
