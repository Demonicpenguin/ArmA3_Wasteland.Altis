// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: briefing.sqf

if (!hasInterface) exitWith {};

_trimName = { _this select [1, count _this - 2] };
_aKeyName = { _arr = actionKeysNamesArray _this; if (count _arr == 0) exitWith {"<UNDEFINED>"}; _arr select 0 };

#define NKEYNAME(DIK) (keyName DIK call _trimName)
#define AKEYNAME(ACT) (ACT call _aKeyName)

waitUntil {!isNull player};


player createDiarySubject ["AIRBORNE", "Airborne Missions"];
player createDiarySubject ["ARMORED", "Armored Missions"];
player createDiarySubject ["INFANTRY", "Infantry Missions"];
player createDiarySubject ["MARINE", "Marine Missions"];
player createDiarySubject ["OCCUPATION", "Occupation Missions"];
player createDiarySubject ["PREMIUM", "Premium Missions"];
player createDiarySubject ["BOUNTY", "Bounty Missions"];
player createDiarySubject ["INSTRUCTIONS", "item Instructions"];
player createDiarySubject ["RULES", "Server Rules"];
player createDiarySubject ["infos", "Infos and Help"];
player createDiarySubject ["changelog", "Changelog"];
player createDiarySubject ["credits", "Credits"];

player createDiaryRecord ["changelog",
[
"v1.4d",
"
<br/>[Added] ADR-97 SMG
<br/>[Added] Paint vehicle option at stores
<br/>[Added] Weapon filter for gunstore accessories
<br/>[Added] Territory capture warning icons on map
<br/>[Fixed] UAVs retrieved from parking are unconnectable
<br/>[Fixed] Other minor changes and fixes
"
]];

player createDiaryRecord ["changelog",
[
"v1.4c",
"
<br/>[Added] Tanks DLC
<br/>[Added] 3rd column in vehicle store for parts
<br/>[Added] AA jet variants
<br/>[Added] HE cannons to gun-only jets
<br/>[Added] Smoke launchers to tank driver and gunner seats
<br/>[Changed] All hidden vehicle paint-jobs now available
<br/>[Changed] Improved crate and supply truck loot
<br/>[Changed] Some store prices
<br/>[Fixed] Mortar resupply bugs
<br/>[Fixed] Selling of laser designators
<br/>[Fixed] More money exploits
<br/>[Fixed] Other minor changes and fixes
"
]];

player createDiaryRecord ["changelog",
[
"v1.4b",
"
<br/>[Added] Artillery Strike in random mission crates
<br/>[Added] Player body marker
<br/>[Added] Diving gear to purchased RHIB, Speedboat, SDV
<br/>[Added] SDAR turret to SDV gunner
<br/>[Added] Object loading capacity to SDV
<br/>[Added] Tac-Ops DLC Police Van and Gorgon skins
<br/>[Added] Apex DLC laser designator skins
<br/>[Added] Saving of 'Autonomous' option for UAVs
<br/>[Changed] Private storage space 4 times bigger
<br/>[Changed] Allow towing of locked personal vehicles
<br/>[Changed] Allow boat purchase on dry land
<br/>[Changed] Disabled slingloading of locked vehicles
<br/>[Changed] UAVs now sellable
<br/>[Changed] Improved kill attribution
<br/>[Fixed] Resupply error for static weapons
<br/>[Fixed] Ejection of injured units
<br/>[Fixed] Static designator ownership saving
<br/>[Fixed] Saving of stashed uniform contents and weapon items
<br/>[Fixed] Disappearing parked vehicles
<br/>[Fixed] Annoying switch to rocket launcher on revive
<br/>[Fixed] Drowned on dry land
<br/>[Fixed] Camo nets not saving
<br/>[Fixed] Many minor changes and fixes
"
]];

player createDiaryRecord ["changelog",
[
"v1.4",
"
<br/>[Added] Laws of War DLC
<br/>[Added] Killfeed HUD
<br/>[Changed] Improved revive system
<br/>[Changed] Improved kill attribution
<br/>[Changed] Improved antihack
<br/>[Fixed] Prone reload freeze
<br/>[Fixed] Many minor changes and fixes
"
]];

player createDiaryRecord ["changelog",
[
"v1.3c",
"
<br/>[Added] Jets DLC
<br/>[Added] Aircraft carrier on Stratis
<br/>[Added] Resupply trucks on Altis and Stratis
<br/>[Added] Driver assist
<br/>[Changed] Aircraft prices
<br/>[Changed] Blocked explosives near parking and storage
<br/>[Changed] Migrated saving system from extDB2 to extDB3
<br/>[Fixed] Fast revive exploits
<br/>[Fixed] Could perform your duty after being revived
<br/>[Fixed] Other minor changes and fixes
"
]];

player createDiaryRecord ["changelog",
[
"v1.3b",
"
<br/>[Added] Private parking
<br/>[Added] Private storage
<br/>[Added] Vehicle ownership
<br/>[Added] Vehicle locking
<br/>[Added] Vehicle selling
<br/>[Added] Mine saving
<br/>[Added] Resupply trucks
<br/>[Added] CH View Distance
<br/>[Added] Map legend
<br/>[Added] UAV side persistence
<br/>[Added] headless server cleanup
<br/>[Changed] Static designators now available to indies
<br/>[Changed] Some store prices
<br/>[Fixed] Many other minor changes and fixes
"
]];

player createDiaryRecord ["changelog",
[
"v1.3",
"
<br/>[Added] Tanoa version
<br/>[Added] Apex content on dev/preview branches
<br/>[Added] Sticky explosive charges
<br/>[Added] Heavy towing and airlifting
<br/>[Added] Load dragged injured friendly in vehicles
<br/>[Added] Eject loaded injured friendly from vehicles
<br/>[Added] Autostabilize when loaded in medical vehicle
<br/>[Added] 'Finish off' action to slay injured enemies
<br/>[Added] Improved injured unit detection
<br/>[Added] Scoreboard persistence option for servers
<br/>[Added] Fatal PvP headshots option for servers
<br/>[Added] Custom death messages option for servers
<br/>[ADded] Auto-center heli turret on manual fire
<br/>[Added] UAV side persistence
<br/>[Added] More textures for some vehicles in store
<br/>[Added] Abandoned quadcopter cleanup
<br/>[Added] More admin menu logging
<br/>[Changed] Reduced heli missile damage
<br/>[Changed] Improved mission crate loot
<br/>[Changed] Vest armor values in general store
<br/>[Changed] Increased Mag Repack flexibility
<br/>[Changed] Toggled off autonomous on static designators
<br/>[Changed] Disabled rain due to weather desync
<br/>[Fixed] Engineer with toolkit can now always repair
<br/>[Fixed] Improved missile lock-on
<br/>[Fixed] Improvements to kill tracking system
<br/>[Fixed] Items and money not dropping on injured logout
<br/>[Fixed] Combat log timer not resetting on death
<br/>[Fixed] Player not always ejected on injury
<br/>[Fixed] Double kill/death count
<br/>[Fixed] Spawn cooldowns resetting on rejoin
<br/>[Fixed] Striders spawning without laser batteries
<br/>[Fixed] Disabled rain due to syncing issues
<br/>[Fixed] Various minor bugfixes and optimizations
"
]];

player createDiaryRecord ["changelog",
[
"v1.2b",
"
<br/>[Added] Scoreboard scrolling via mousewheel
<br/>[Added] New paintjobs for Kajman, Strider, Gorgon, Hatchback
<br/>[Changed] Hostile Heli (single) crates now spawn on touchdown
<br/>[Changed] Lowered Ifrit center of mass to reduce rollovers
<br/>[Changed] Updated antihack database
<br/>[Fixed] Saved grenades not throwable on rejoin
<br/>[Fixed] Corpses not ejecting from vehicle wrecks
<br/>[Fixed] Items not dropping from vehicle wreck corpses
<br/>[Fixed] Revive not triggering properly on fatal shot
<br/>[Fixed] Vehicle turret ammo saving issues
<br/>[Fixed] Too low damage resistance during revive mode
<br/>[Fixed] UGVs not airliftable via R3F
<br/>[Fixed] Revive broken after getting run over by vehicles
<br/>[Fixed] Veh respawn not being delayed when owner is within 1km
<br/>[Fixed] All armor values showing 0 in general store
<br/>[Fixed] Supplies category in general store sometimes empty
<br/>[Fixed] Server rules not showing anymore in map menu
<br/>[Fixed] Territory info overlapping with vehicle HUD
<br/>[Fixed] Vehicle contents selling money exploit
<br/>[Fixed] Antihack kicks not always working properly
<br/>[Fixed] Various minor bugfixes and optimizations
"
]];

player createDiaryRecord ["changelog",
[
"v1.2",
"
<br/>[Added] Mag Repack by Outlawled (Ctrl + " + NKEYNAME(19) + ")
<br/>[Added] Adjustable NV by xx-LSD-xx (Shift + PageUp/Down)
<br/>[Added] New vehicle store paintjobs
<br/>[Added] Town spawn cooldown
<br/>[Added] Ghosting timer
<br/>[Added] Object lock restriction near stores and missions
<br/>[Added] Headless client object saving
<br/>[Added] Time and weather saving
<br/>[Changed] Expanded UAV control restriction to quadcopters
<br/>[Changed] Injured players no longer count as town enemies
<br/>[Changed] Upgraded extDB to extDB2 by Torndeco
<br/>[Changed] Updated antihack
<br/>[Fixed] Old spawn beacons no longer shown on spawn menu
<br/>[Fixed] Multiple money duping exploits
<br/>[Fixed] Vehicles and objects sometimes disappearing from DB
<br/>[Fixed] Severe injuries caused by jumping over small ledges
<br/>[Fixed] Antihack kicks due to RHS, MCC, AGM, ACE3, ALiVE
<br/>[Fixed] Various minor bugfixes and optimizations
"
]];

player createDiaryRecord ["changelog",
[
"v1.1b",
"
<br/>[Added] Marksmen DLC content
<br/>[Added] Prevent usage of commander camera
<br/>[Added] Emergency eject hotkey (Ctrl + " + AKEYNAME("GetOut") + ")
<br/>[Added] Restricted UAV connection to owner's group
<br/>[Changed] Improved purchased vehicle setup time
<br/>[Changed] Admins can now use global voice chat
<br/>[Changed] Updated antihack
<br/>[Fixed] Corpses not being ejected from vehicles
<br/>[Fixed] Thermal imaging not working for UAVs
<br/>[Fixed] Various minor bugfixes and optimizations
"
]];

player createDiaryRecord ["changelog",
[
"v1.1",
"
<br/>[Added] ATMs
<br/>[Added] Union Jack vehicle color
<br/>[Added] Skins hidden in gamefiles for MH-9, Mohawk, and Taru
<br/>[Added] Improved admin spectate camera by micovery
<br/>[Added] Earplugs (End key)
<br/>[Changed] Full rewrite of vehicle respawning system
<br/>[Fixed] Player moved to position too early during save restore
<br/>[Fixed] Mission timeout not extending on AI kill
<br/>[Fixed] Admin teamkill unlocking
<br/>[Fixed] Improved FPS fix
<br/>[Fixed] Running animation parachute glitch
<br/>[Fixed] Various other minor bugfixes and optimizations
"
]];

player createDiaryRecord ["changelog",
[
"v1.0c",
"
<br/>[Added] MySQL support via extDB extension
<br/>[Added] Town Invasion mission
<br/>[Added] Chain-reaction player kill tracking
<br/>[Added] Force Save action for purchased and captured vehicles
<br/>[Added] Autokick players previously detected by antihack
<br/>[Added] Entity caching script for headless client
<br/>[Added] Tron suits to general store
<br/>[Added] Red lines on map for AIs wandering away from missions
<br/>[Changed] Mission timeout gets extended on AI kill
<br/>[Changed] Transport Heli mission Taru variant to Bench
<br/>[Changed] Spawn beacon item drop to sleeping bag
<br/>[Fixed] More money exploits
<br/>[Fixed] Scoreboard ordering
<br/>[Fixed] Vehicle repair and refuel sometimes not working
<br/>[Fixed] Injured players' corpses being deleted on disconnect
<br/>[Fixed] Static weapon disassembly prevention
<br/>[Fixed] Excess bought rockets ending up in uniform or vest
<br/>[Fixed] Various other minor bugfixes and optimizations
"
]];

player createDiaryRecord ["changelog",
[
"v1.0b",
"
<br/>[Added] Helicopters DLC content
<br/>[Added] Revamped respawn menu
<br/>[Added] 250m altitude limit for territory capture
<br/>[Added] HALO insertion on spawn beacons
<br/>[Added] New vehicle store textures
<br/>[Changed] Increased damage done to planes by 50%
<br/>[Changed] Plane engines shutdown when above 90% damage
<br/>[Changed] Player names can also be toggled with Home key
<br/>[Changed] Increased ATGM UAV price
<br/>[Changed] Increased prices from thermal scopes again
<br/>[Changed] Minor edits to spawn loadouts
<br/>[Fixed] FPS drop that began in v0.9h
<br/>[Fixed] Saved UAVs not being connectable
<br/>[Fixed] Indies unable to get in UGVs
<br/>[Fixed] Blinking fog
<br/>[Fixed] Clipped numbers on scoreboard
<br/>[Fixed] Minor other optimizations and fixes
"
]];

player createDiaryRecord ["changelog",
[
"v1.0",
"
<br/>[Added] Custom scoreboard
<br/>[Added] Mission and store vehicle saving
<br/>[Added] Player markers on GPS and UAV Terminal
<br/>[Added] Holster actions
<br/>[Changed] Full rewrite of side mission system
<br/>[Changed] Windows key toggles player marker names too
<br/>[Changed] New loading picture by Gameaholic.se
<br/>[Fixed] Weapon sometimes disppearing when moving objects
<br/>[Fixed] More money duping exploits
<br/>[Fixed] Store menu sizes on smaller aspect ratios
<br/>[Fixed] Hunger and thirst reset on rejoin
<br/>[Fixed] Other minor optimizations and fixes
"
]];

player createDiaryRecord ["changelog",
[
"v0.9h",
"
<br/>[Added] Custom revive system based on Farooq's Revive
<br/>[Added] Territory payroll at regular intervals
<br/>[Added] Emergency eject and free parachutes (jump key)
<br/>[Added] Player names toggled with Windows key
<br/>[Added] Increased missile damage against tanks and helis
<br/>[Added] Ability to stash money in weapon crates
<br/>[Added] Ability to sell vehicle inventory at stores
<br/>[Added] More money shipment mission variants
<br/>[Added] Reduced wheel damage from collisions
<br/>[Added] Wreck salvaging
<br/>[Added] Selling bin in stores
<br/>[Added] Karts DLC content in stores
<br/>[Added] Camo sniper rifles in gunstore
<br/>[Added] Repair Offroad in vehicle store
<br/>[Added] Team players on map as server option
<br/>[Added] Unlimited stamina server option
<br/>[Added] Static weapon saving server option
<br/>[Added] More push vehicle actions
<br/>[Added] Paradrop option for airlifted vehicles
<br/>[Added] Preload checkbox on respawn menu
<br/>[Added] Remote explosives store distance restriction
<br/>[Added] Server time multipliers for day and night
<br/>[Added] Addon-less profileNamespace server persistence
<br/>[Added] Linux server compatibility
<br/>[Added] Basic support for headless client
<br/>[Changed] Independent territory capture is now group-based
<br/>[Changed] Towns blocked if more enemies than friendlies
<br/>[Changed] Increased ammo/fuel/repair cargo for resupply trucks
<br/>[Changed] Increased territory capture rewards for Altis
<br/>[Changed] Increased money mission rewards
<br/>[Changed] Weapon loot in buildings now disabled by default
<br/>[Changed] Mission crates loot was made more random
<br/>[Changed] Thermal imaging is now available on UAVs
<br/>[Changed] Increased vehicle store prices
<br/>[Changed] Increased prices for thermal optics
<br/>[Changed] Increased player icons up to 2000m
<br/>[Changed] Improved antihack
<br/>[Changed] Improved FPS
<br/>[Fixed] Vehicle store purchase errors due to server lag
<br/>[Fixed] Corpse created when leaving with player saving
<br/>[Fixed] Custom vehicle damage handling not working
<br/>[Fixed] Indie-indie spawn beacon stealing
<br/>[Fixed] Repair kit and jerrycan distance limit
<br/>[Fixed] Spawn beacon packing and stealing restrictions
<br/>[Fixed] Not able to lock static weapons
<br/>[Fixed] Unbreakable store windows
<br/>[Fixed] Stratis airbase gunstore desk glitches
<br/>[Fixed] Missions sometimes completing instantaneously
<br/>[Fixed] Object ammo/fuel/repair cargo not saving
<br/>[Fixed] Respawn menu aspect ratio on some resolutions
<br/>[Fixed] Minor bugs with group system
<br/>[Fixed] Minor bugs with player items
<br/>[Fixed] Various other minor bugfixes and optimizations
"
]];

player createDiaryRecord ["changelog",
[
"v0.9g",
"
<br/>[Added] - Vehicle stores
<br/>[Added] - New lootspawner by Na_Palm, stuff in ALL buildings
<br/>[Added] - New jets and truck added in A3 v1.14
<br/>[Added] - New AAF vehicles added in A3 v1.08
<br/>[Added] - New camos for Mk20 and MX in gunstores
<br/>[Added] - Ability to push plane backwards
<br/>[Added] - Ability to sell quadbike contents like crates
<br/>[Added] - Abort delay during combat when player saving on
<br/>[Changed] - Improved respawn menu
<br/>[Changed] - Respawn now longer to preload destination
<br/>[Changed] - Optimized player icons
<br/>[Changed] - Optimized FPS fix
<br/>[Changed] - Improved server persistence (requires iniDBI v1.4+)
<br/>[Changed] - Improved player saving (server-specific)
<br/>[Changed] - Improved base saving (server-specific)
<br/>[Changed] - Reduced starting gear
<br/>[Changed] - Modified some store prices
<br/>[Changed] - Reduced initial fuel in cars and helis
<br/>[Changed] - Removed Buzzard jet from too short runways
<br/>[Changed] - Removed Kavala castle territory for use as base
<br/>[Changed] - Increased vehicle repair time to 20 sec.
<br/>[Changed] - Increased owner unlocking time to 10 sec.
<br/>[Changed] - Toggling spawn beacon perms is now instant
<br/>[Changed] - Improved Take option for player items
<br/>[Changed] - Added option to cancel towing selection
<br/>[Changed] - Added machine gunner to main mission NPCs
<br/>[Changed] - Added grenadier to side mission NPCs
<br/>[Fixed] - Error messages in various menus
<br/>[Fixed] - Crash when toggling spawn beacon perms
<br/>[Fixed] - Error when hacking warchests
<br/>[Fixed] - Vehicle towing and lifting positions
<br/>[Fixed] - Repair Vehicle option showing for brand new vehicles
<br/>[Fixed] - Vest purchase price
<br/>[Fixed] - Vest and helmet armor value
<br/>[Fixed] - NPC leader now has launcher ammo
"
]];

player createDiaryRecord ["changelog",
[
"v0.9f",
"
<br/>[Added] - Money missions
<br/>[Added] - Sell Crate Items option at stores when moving crate
<br/>[Changed] - Reorganized loots for crates and trucks
<br/>[Fixed] - Broken Warchest menu
<br/>[Fixed] - Spawn beacons not working for Independent groups
<br/>[Fixed] - Player icons position inside buildings
<br/>[Fixed] - MRAPs and quadbikes not spawning
<br/>[Fixed] - Broken money rewards for territories
"
]];

player createDiaryRecord ["changelog",
[
"v0.9e",
"
<br/>[Added] - Territory system
<br/>[Added] - Jumping option (step over while running)
<br/>[Added] - New weapons from v1.04 update
<br/>[Changed] - Water and food now use water bottles and baked beans
<br/>[Fixed] - Store object purchases not operating as intended
<br/>[Fixed] - Objects purchased from stores not saving properly
<br/>[Fixed] - Minor server-side memory leak
"
]];

player createDiaryRecord ["changelog",
[
"v0.9d",
"
<br/>[Added] - Store object purchases
<br/>[Changed] - New UI by KoS
"
]];

player createDiaryRecord ["changelog",
[
"v0.9c",
"
<br/>[Changed] - Instant money pickup and drop
<br/>[Changed] - Increased plane and heli spawning odds
<br/>[Fixed] - FPS fix improvements
<br/>[Fixed] - Vehicles disappearing when untowed or airdropped
"
]];

player createDiaryRecord ["changelog",
[
"v0.9b",
"
<br/>[Initial release] - Welcome to Altis!
"
]];


player createDiaryRecord ["credits",
[
"Credits",
"
<br/><font size='16' color='#BBBBBB'>Developed by A3Wasteland.com:</font>
<br/>	* AgentRev (TeamPlayerGaming)
<br/>	* JoSchaap (GoT/Tweakers.net)
<br/>	* MercyfulFate
<br/>	* His_Shadow (KoS/KillonSight)
<br/>	* Bewilderbeest (KoS/KillonSight)
<br/>	* Torndeco
<br/>	* Del1te (404Games)
<br/>
<br/><font size='16' color='#BBBBBB'>Original Arma 2 Wasteland missions by:</font>
<br/>	* Tonic
<br/>	* Sa-Matra
<br/>	* MarKeR
<br/>
<br/><font size='16' color='#BBBBBB'>Improved and ported to Arma 3 by 404Games:</font>
<br/>	* Deadbeat
<br/>	* Costlyy
<br/>	* Pulse
<br/>	* Domuk
<br/>
<br/><font size='16' color='#BBBBBB'>Other contributors:</font>
<br/>	* Team over on Trailer Park for file support. Thanks
<br/>	* 82ndab-Bravo17 (GitHub)
<br/>	* afroVoodo (Armaholic)
<br/>	* Austerror (GitHub)
<br/>	* AWA (OpenDayZ)
<br/>	* bodybag (Gameaholic.se)
<br/>	* Champ-1 (CHVD)
<br/>	* code34 (iniDBI)
<br/>	* Das Attorney (Jump MF)
<br/>	* Ed! (404Games forums)
<br/>	* Farooq (GitHub)
<br/>	* gtoddc (A3W forums)
<br/>	* HatchetHarry (GitHub)
<br/>	* Hub (TeamPlayerGaming)
<br/>	* k4n30 (GitHub)
<br/>	* Killzone_Kid (KillzoneKid.com)
<br/>	* Krunch (GitHub)
<br/>	* LouDnl (GitHub)
<br/>	* madbull (R3F)
<br/>	* Mainfrezzer (Magnon)
<br/>	* meat147 (GitHub)
<br/>	* micovery (GitHub)
<br/>	* Na_Palm (BIS forums)
<br/>	* Outlawled (Armaholic)
<br/>	* red281gt (GitHub)
<br/>	* RockHound (BierAG)
<br/>	* s3kShUn61 (GitHub)
<br/>	* Sa-Matra (BIS forums)
<br/>	* Sanjo (GitHub)
<br/>	* SCETheFuzz (GitHub)
<br/>	* Shockwave (A3W forums)
<br/>	* SicSemperTyrannis (iniDB)
<br/>	* SPJESTER (404Games forums)
<br/>	* spunFIN (BIS forums)
<br/>	* Tonic (BIS forums)
<br/>	* wiking.at (A3W forums)
<br/>	* xx-LSD-xx (Armaholic)
<br/>	* Zenophon (BIS Forums)
<br/>
<br/><font size='16'>Thanks A LOT to everyone involved for the help and inspiration!</font>
"
]];


_WASD = AKEYNAME("MoveForward") + "," + AKEYNAME("MoveBack") + "," + AKEYNAME("TurnLeft") + "," + AKEYNAME("TurnRight");

player createDiaryRecord ["infos",
[
"Admin Spectate keys",
"
<br/>Admin menu Spectate camera controls:
<br/>
<br/>Shift + " + AKEYNAME("NextChannel") + " (next player)
<br/>Shift + " + AKEYNAME("PrevChannel") + " (previous player)
<br/>Ctrl + " + NKEYNAME(18) + " (exit camera)
<br/>Ctrl + " + AKEYNAME("Chat") + " (attach/detach camera from target)
<br/>Ctrl + " + NKEYNAME(35) + " (toggle target HUD)
<br/>" + AKEYNAME("NightVision") + " (nightvision, thermal)
<br/>" + _WASD + " (move camera around)
<br/>" + NKEYNAME(16) + " (move camera up)
<br/>" + NKEYNAME(44) + " (move camera down)
<br/>Mouse Move (rotate camera)
<br/>Mouse Wheel Up (increase camera speed)
<br/>Mouse Wheel Down (decrease camera speed)
<br/>Shift + " + _WASD + " (move camera around faster)
<br/>" + AKEYNAME("ShowMap") + " (open/close map - click on map to teleport camera)
"
]];

player createDiaryRecord ["infos",
[
"Player hotkeys",
"
<br/>List of default player hotkeys:
<br/>
<br/>" + NKEYNAME(41) + " (open player menu)
<br/>" + NKEYNAME(207) + " (toggle earplugs)
<br/>" + NKEYNAME(199) + ", " + NKEYNAME(219) + ", " + NKEYNAME(220) + " (toggle player names)
<br/>Ctrl + " + AKEYNAME("GetOut") + " (emergency eject)
<br/>" + AKEYNAME("GetOver") + " (open parachute)
<br/>Shift + " + NKEYNAME(201) + " / " + NKEYNAME(209) + " (adjust nightvision)
<br/>" + NKEYNAME(22) + " (admin menu)
"
]];

player createDiaryRecord ["infos",
[
"Hints and Tips",
"
<br/><font size='18'>A3Wasteland</font>
<br/>
<br/>* At the start of the game, spread out and find supplies before worrying about where to establish a meeting place or a base, supplies are important and very valuable.
<br/>
<br/>* When picking a base location, it is best advised to pick a place that is out of the way and not so obvious such as airports, cities, map-bound bases, etc. remember, players randomly spawn in and around towns and could even spawn inside your base should you set it up in a town.
<br/>
<br/>* If you spawn in an area with no vehicles or supplies in the immediate area, DO NOT just click respawn from the pause menu, chances are if you search an area of a few hundred meters, you will find something.
<br/>
<br/>* Always be on the lookout for nightvision. they are located in the ammo crates, and there are pairs scattered throughout vehicles. You can also purchase them from the gunstores. Nighttime without them SUCKS, and if you have them, you can conduct stealth raids on enemy bases under the cover of complete darkness.
<br/>
<br/>* When you set up a base, never leave your supplies unguarded, one guard will suffice, but it is recommended you have at least 2, maybe 3 guards at base at all times.
<br/>
<br/>* There are very aggressive AI characters that spawn with most missions and will protect the mission objectives with deadly force, be aware of them.
"
]];

player createDiaryRecord ["infos",
[
"About Wasteland",
"
<br/>Wasteland is a team versus team versus team sandbox survival experience. The objective of this mission is to rally your faction, scavenge supplies, weapons, and vehicles, and destroy the other factions. It is survival at its best! Keep in mind this is a work in progress, please direct your reports to http://forums.a3wasteland.com/
<br/>
<br/>FAQ:
<br/>
<br/>Q. What am I supposed to do here?
<br/>A. See the above description
<br/>
<br/>Q. Where can I get a gun?
<br/>A. Weapons are found in one of three places, first in ammo crates that come as rewards from missions, inside and outside buildings, and second, in the gear section of the vehicles, which also randomly spawn around the map. The last place to find a gun would be at the gunshops located throughout the map. You can also find them on dead players whose bodies have not yet been looted.
<br/>
<br/>Q. What are the blue circles on the map?
<br/>A. The circles represent town limits. If friendly soldiers are in a town, you can spawn there from the re-spawn menu; however if there is an enemy presence, you will not be able to spawn there.
<br/>
<br/>Q. Why is it so dark, I cant see.
<br/>A. The server has a day/night cycle just like in the real world, and as such, night time is a factor in your survival. It is recommended that you find sources of light or use your Nightvision Goggles as the darkness sets in.
<br/>
<br/>Q. Is it ok for me to shoot my team mates?
<br/>A. If you are member of BLUFOR or OPFOR teams, then you are NOT allowed to shoot or steal items and vehicles from other players. If you play as Independent, you are free to engage anyone as well as team up with anyone you want.
<br/>
<br/>Q. Whats with the canisters, baskets and big bags?
<br/>A. This game has a food and water system that you must stay on top of if you hope to survive. You can collect food and water from food sacks and wells, or baskets and plastic canisters dropped by dead players. Food and water will also randomly spawn around the map.
<br/>
<br/>Q. I saw someone breaking a rule, what do I do?
<br/>A. Simply go into global chat and get the attention of one of the admins or visit our forums, and make a report if the offense is serious.
"
]];

player createDiaryRecord ["infos",
[
"Bullet Cam",
"
<br/>   This is being tested on the server and at the moment only available in four weapons :
<br/>
<br/>   - All Sniper Rifles
"
]];

player createDiaryRecord ["infos",
[
"Vehicle Tuning System",
"
<br/>   For a bit of fun and drag racing up at the Saltflats of an evening why not tune up an old rust bucket and have a race.
<br/>
<br/>   All Armored vehicles and Tanks have been removed for your own safety.
"
]];


player createDiaryRecord ["RULES",
[
"Ships",
"
<br/>1. Ships spawn up at the North West Vehicle Store.  
<br/>
<br/>2. To park the ships, go to the rearm rigs, shipyard, storage island or Kavala storage shed closest the water to park them. 
<br/>
<br/>3. To retrieve you ship you must go to the rearming stations. There are ATM’s at the rearm stations for your convenience. 
"
]];

player createDiaryRecord ["RULES",
[
"Vehicles ",
"
<br/>1. Any vehicles left at around or at vehicle stores will be deleted. 
<br/>
<br/>2. There are garages to park your vehicles, use them. 
"
]];

player createDiaryRecord ["RULES",
[
"Access",
"
<br/>Blocking any passages to any part of the map is not allowed. Even if players can climb, jump or walk over your structure, you will be required to remove it.  Public walkways, tunnels or bridges may be considered but it will require Admin approval.  We reserve the right to have you alter or completely remove your structure after it is built if it does not adhere to rules or if Admin sees potential issues
"
]];

player createDiaryRecord ["RULES",
[
"Premade Structures",
"
<br/>1. DO NOT build on any premade structures on the map like temples or ruins. 
<br/>
<br/>2. There are premade bases on the map. If you find one without a key, you can claim it by purchasing 2 keys from the General Store, locking it and utilizing a base locker to lock down the base. 
<br/>
<br/>3. If you have any buildings near premade structures, we reserve the right to have you remove them if your buildings block structures or in game interactions for players (i.e. loot chests, emotes or lore).  
<br/>
<br/>4. Off-line raiding is NOT PERMITTED. If a player is NOT LOGGED in, do not attempt to raid or destroy the base. 
<br/>
<br/>5. Base raiding – in the event you are able to raid a player’s base, DO NOT UNLOCK base parts. You are permitted to take items that are unlocked or steal or destroy vehicles. 
"
]];

player createDiaryRecord ["RULES",
[
"Size of Base",
"
<br/>If we see your bases occupying an unreasonable amount of land or if your base is completely spread out on the map, it will be at Admin’s discretion to have you reduce the size of your base. 
"
]];

player createDiaryRecord ["RULES",
[
"Stores",
"
<br/>You are not permitted to build a base within 1400 meters of a store. 
"
]];

player createDiaryRecord ["RULES",
[
"Bannable Offences on this Server",
"
<br/>1. Hacking, Glitching or Cheating will get you banned (PERM – NO EXCEPTIONS)
<br/>
<br/>2. Exploiting map bugs/glitches (temp or PERM) 
<br/>
<br/>3. Intentional Teamkilling (temp or PERM) 
<br/>
<br/>4. Trolling our servers (temp)
<br/>
<br/>5. Disrupting the server / Being an Asshat (temp) 
<br/>
<br/>6. If caught repeating the offence after being temp banned, you will receive a 30-day ban. 
<br/>
<br/>7. Spawn Island is a restricted location. You may not land on this island; you may not shoot at anyone on this island. 
<br/>
<br/>8. If you are found shooting players here, you will be banned without question. 
<br/>
<br/>9. Team switching, or switching from Blufor / Opfor to Indie, with the goal of figuring out players locations, buying vehicles, etc. Will result in a ban. DO NOT team switch at a hacker’s mission it will be a bannable offence and result in loss of money.
<br/>
<br/>10. Impersonating Staff will result in a 30-day ban, even if it was only a joke
<br/>
<br/>11. DO NOT attempt to multi-hack at a hacker’s mission or it will result in a ban. Hacked money must be shared with those involved in the mission. 
<br/>
<br/>12. DO NOT put vehicles inside or on stores and DO NOT block doorways with vehicles. Attempting to deal with team killers, glitchers, thieving teammates, hackers, trolls, etc. yourself instead of contacting staff may result in a ban for you as well as the player in question. We DO NOT advocate team killing in order to deal with the aforementioned types of players! If you are caught teamkilling a player that is trolling, you will be banned as well as them. 
<br/>
<br/>13. Please remember, staff members are NOT required to give a set number of warnings before a ban is issued. They do, however, have to warn you at least once. Should you ignore their requests or simply fail to hear them, an appropriate action will be taken at the staff member’s discretion. 
<br/>
<br/>14. These rules are only here so that the server runs smoothly so that everyone can have fun. 
<br/>
<br/>15. If we see a Rule violation, we will make attempts to contact you either in game or on Discord.  If we are not able to reach you, we will handle the violation accordingly without your knowledge
<br/>
<br/>16. If your base is actively affecting the overall game-play on the server (example: your base completely blocks the only safe passage to an area or your base has caused a major resource to despawn), Admin reserves the right to remove your base immediately without contacting you. 
<br/>
<br/>17. GOM systems have not to be exploited by purchasing a GOM fuel truck or similar vehicle and parking it next to a GOM system to gain access to the rearm facility. If caught both vehicles will be destroyed and incur a 1 week ban.
"
]];

player createDiaryRecord ["RULES",
[
"A3Wasteland Specific Offences",
"
<br/>1. No intentional teamkilling if you are on Blufor or Opfor! 
<br/>
<br/>2. No Intentional Team killing, or Trolling teammates. This includes Towing, blocking runways with vehicles. 
<br/>
<br/>3. No Racism (THIS MEANS NO RACIAL SLURS/TERMINOLOGY, REGARDLESS OF YOUR HERITAGE) 
<br/>
<br/>4. No team-switching to gain an advantage on other players! 
<br/>
<br/>5. Admins/Mods may unlock you depending on the situation!
<br/>
<br/>6. Admins/Mods may refund money depending on the situation! 
<br/>
<br/>7. Logging out before depositing money as any HVT (high value target) CAN Result In Loss ALL money earned. Temp ban if Necessary 
"
]];

player createDiaryRecord ["RULES",
[
"Basic Rules of all our Servers",
"
<br/>1. ALWAYS respect other players and the server admins! 
<br/>
<br/>2. Admin/Mod decisions are final, respect that! 
<br/>
<br/>3. If you have proof of someone glitching/hacking/being abusive, report it to an admin! 
<br/>
<br/>4. No Arguing with Staff. Staff's decision is FINAL.
<br/>
<br/>5. Players are limited to 2 drones in the sky at any one time.
<br/>
<br/>6. Players are limited to 1 Base Management System.
<br/>
<br/>7. You are not allowed to kill Players at their base when they are Base Building (Gentlemens agreement - Sportmanship - Player Respect and all that) 
<br/>
<br/>8. THIS IS A BANNABLE OFFENCE (1st offfence you will receive a WARNING - 2nd offence carrys a 1 WEEK BAN - 3rd offence will carry a 30 BAN)
<br/>
<br/>9. You are allowed to kill players who may be in transit between their base and getting baseparts - this is a calculated risk the player must make, making sure their route to the store and back is safe.
<br/>
<br/>10. Players in transit with baseparts: You carry the risk of being attacked, so please don't complain to admins or other players if you take this calculated risk, thanks 
<br/>
<br/>11. Players on or around their base and not base building may be attacked as this is deemed fair play within the rules of the game.
<br/>
<br/>12. Bases that are legally breached; Attacking players can steal and blow up collected items within base, BUT do not destroy any base management systems or destroy the base itself. THIS IS A BANNABLE OFFENCE
<br/>
<br/>13. Soft logging to the lobby to circumvent any in game player systems will get you kicked and repeated offences will lead to a ban. I.E Halo jump
"
]];

player createDiaryRecord ["RULES",
[
"Operational Jail",
"
<br/>1. Yes!! We have an actual operational Jail on this server. 
<br/>
<br/>2. Minor misdemeanours that do not deserve a kick or ban will result in a short prison service. 
<br/>
<br/>3. You will not be informed prior to being sent to Jail, but you should know by your current or previous actions WHY! 
<br/>
<br/>4. You can ask the admin for his/her reasons, Don't always expect an answer. 
<br/>
<br/>5. You will be released at the admins discretion.
<br/>
<br/>6. On release the door will be open and you can make your own way back to your previous location for your penance.
<br/>
<br/>7. You can disconnect or respawn but this may result in a longer sentence on your return.
<br/>
<br/>8. Please learn from your short time in our Altis Hotel and don't be an ass about it.
<br/>
<br/>9. The Jail may become crowded some nights with players of various factions, please no PVP while inside our lovely establishment.
<br/>
<br/>10. It's all part of the FUN.....
"
]];

player createDiaryRecord ["RULES",
[
"Server Complaint Instructions",
"
<br/>Complaint Instructions
<br/>This instructional will guide you in placing a formal complaint regarding server rule violations.
<br/>Each complaint will be investigated.
<br/>• When submitting a formal complaint, please include any and all evidence including
<br/>  video, photos, and or audio recordings of the violation.
<br/>• All investigations will be conducted thoroughly and objectively. They will all be based on
<br/>  evidence gathered in the case.
<br/>• Facts that should be included in your complaint. You must include brief details of the
<br/>  incident that transpired as well as when the incident occurred. We will review all logs of
<br/>  the incident.
<br/>• Once the investigation is complete, findings of the incident will be published along with
<br/>  the evidence for review by members of our community.
<br/>• Once the findings are published, should the findings be sustained, any disciplinary
<br/>  action will be imposed by the administration staff. All findings are final.
<br/>If it is found during the course of the investigation and its discovered the complaint filed a false
<br/>complaint, penalties will be imposed on that party which may result in a permanent server ban
<br/>
<br/>Findings:
<br/>
<br/>1. Minor misdemeanours that do not deserve a kick or ban will result in a short prison service. 
<br/>
<br/>2. Sustained: The investigation disclosed sufficient evidence to prove the allegation, and
the actions of the player violated the server rules.
<br/>
<br/>3. Not Sustained: The investigation failed to disclose sufficient evidence to clearly prove or
disprove the allegation.
<br/>
<br/>4. Unfounded: The alleged incident did not occur.
<br/>
<br/>A system of progressive discipline can include the following elements:
<br/>
<br/>1. Oral reprimand
<br/>
<br/>2. A fine can be imposed on the player and or restitution paid to the player deemed as the
victim of the incident.
<br/>
<br/>3. Players account can be purged from database as well as any and all objects and vehicles
both on the map and in the virtual garage.
<br/>
<br/>4. Temporary ban from server
<br/>
<br/>5. Permanent ban from server.
"
]];

player createDiaryRecord ["INSTRUCTIONS",
[
"Safes",
"
<br/>   Safes serve three functions. 
<br/>   They will allow you to safely store cash within your base, Service Vehicles and Store items
<br/>
<br/>  
<br/>1. Place safe where you want it and lock it down
<br/>
<br/>2. Access Safe Menu by scrolling mouse wheel and open safe menu
<br/>
<br/>3. Change Pin Code to prevent other players from accessing it
<br/>
<br/>4. Safes must be locked down from the safe menu to prevent players from accessing your banked cash and inventory
<br/>
<br/>5. The safe doubles as a GOM Servicing System. It will rearm all vehicles, hence the price in Store
"
]];

player createDiaryRecord ["INSTRUCTIONS",
[
"Loud Speakers",
"
<br/>   Loud Speakers are used in conjuction with the American and Scottish Flags to play corresponding music. 
<br/>
<br/>1. Lock in place where you want the music to come form.
<br/>
<br/>2. Place either the American Flag of Scottish Flag anywhere within your base. Purchased from General Store
<br/>
<br/>3. Go up to and look at the flag, scroll your mouse wheel and you will get an option to Salute. 
<br/>
<br/>4. Select this option and enjoy the sound
"
]];

player createDiaryRecord ["INSTRUCTIONS",
[
"Base Building Tool",
"
<br/>   The Base Building Tool can be used in conjunction with base building (not required for base building)
<br/>   To use there is no requirement to lock it down unless finished with it
<br/>   Its primary use is to give the player a visual aid for aligning their base parts, walls etc.
<br/>   Place it where you want your base to be
<br/>   There are various options opened to the builder
<br/>
<br/>
<br/>1. Draw Grid - this will give you a 10 x 10 grid which can be increased up to a 100 x 100 grid by using the shift key and up/down arrows 
<br/>
<br/>2. Draw Line - this will give you a set square for 90 degree corner placement
<br/>
<br/>3. Draw Angle - requires two of the building tools and one can be place at a higher position. A line is drawn from one to the other giving you an angled line
<br/>
<br/>4. Bounding Box - puts a cuded shaped bounding box around all base parts in the vicinity of the tool to allow easy alignment of objects
"
]];

player createDiaryRecord ["INSTRUCTIONS",
[
"Retractable Roof and Walls",
"
<br/>   Retractable Roofs and Walls allow for a large aperture on your roof or Base Wall to be opened to facilitate helicopters to be piloted in and out
<br/>   You can use as many retractable roofs or Walls as required to form as big an aperture as you need
<br/>   They will all disappear when you choose the option to open roof
<br/>
<br/>
<br/>
<br/>1. Place roof or wall panels where you want the aperture to be and lock the objects down
<br/>
<br/>2. Opening and closing of roofs and walls can be done via a door key, Base Management System or remotely if you have a UAV terminal on your person
"
]];

player createDiaryRecord ["INSTRUCTIONS",
[
"Base door and Base Door Key",
"
<br/>   Base doors and keys give you a convenient way to enter and exit your base
<br/>   Base Door Keys can be used to open a variety of doors including the premade base structures on map
<br/>   All self explanatory once inside the Door Menu
<br/>
<br/>
<br/>1. Place your Base Door where you want the entrance to be and lock the object down
<br/>
<br/>2. Place a Base Door Key next to the Door you want to operate
<br/>
<br/>3. Change the Pin Code of the Door Key by scrolling mouse and selecting Door Menu, default Pincode 0000 to access menu
<br/>
<br/>4. Once the Pincode has been changed, To operate door, need I say, access menu and select Open Door and vice versa to close door  
"
]];

player createDiaryRecord ["INSTRUCTIONS",
[
"Base Management System",
"
<br/>   The Base Management System (BMS) is used to put your Base, once built, under lockdown, preventing other players from unlocking your base parts and moving them
<br/>   The BMS has 5 levels of upgrade, from level 1 (small base radius) to level 5 (large base radius) to accommodate various sizes of bases
<br/>   When you purchse a BMS it will be on level 1
<br/>   Upgrade prices L2 - $150000, L3 - $250000, L4 - $350000, L5 - $500000
<br/>
<br/>
<br/>1. Place BMS within your base, preferably central but somewhere the whole base is within the base border
<br/>
<br/>2. Lock the BMS down by scrolling your mouse wheel and clicking on Lock object
<br/>
<br/>3. To access the BMS system menu stand back and look just in front of the BMS, scroll mouse wheel and select Open Base Locker Menu  
<br/>
<br/>4. To prevent other players from accessing your BMS you are advised to change the Pin Code
<br/>
<br/>5. To Lockdown the baseparts, sslect Lock Down Base - This prevents base parts from being unlocked and removed 
<br/>
<br/>6. Release Lock Down allows you to unlock and reposition base parts or add new base parts, or to lockdown boxes from missions
<br/>
<br/>7. To upgrade you must have the required cash on your person
<br/>
<br/>8. Show base border will display a red ring of 3D arrows around the perimeter of the base. This allows you to check all base parts are within this radius
<br/>
<br/>9. Lights off/on will turn all lights off/on within the base border of your BMS
<br/>
<br/>10. Lock/Unlock Doors will lock/unlock all doors to military towers purchased from the store and within the perimeter of the base border
<br/>
<br/>11. Open/Close Roof will open/close a retractable roof if you have one on your base, purchased from store
<br/>
<br/>12. Open/Close Wall will open/close a retractable wall if you have one on your base, purchased from store
<br/>
<br/>13. Open/Close Canal Door will open/close a Canal Door if you have one on your base and in close proximity to the BMS 
<br/>
<br/>14. Relock Base Objects is not in use
<br/>
<br/>15. Set Auto Guns to Sentry and Disable Auto Guns is not working - turned off
<br/>
<br/>16. Reupply will resupply any mortars and static weapons if you have a resupply truck withing the base border
<br/>
<br/>17. UNLOCK/LOCK all base parts will do as it says. handy if you ever want to move your base loction
<br/>
<br/>18. Toggle Rearm Security will unlock or relock all Helipads and rearm supplies withing the base
<br/>
<br/>19. Lock all Vehicles will allow you to lock all vehicles within the circumference of your BMS
"
]];

player createDiaryRecord ["INSTRUCTIONS",
[
"Base Building",
"
<br/>   You can buy base building material from the General Stores located around the map 
<br/>
<br/>   There are general rules regarding where you are allowed to build. Please read these prior to building your base.
<br/>
<br/>   If in doubt just ask one of the Admins
<br/>
<br/>   ALL base parts MUST be within the boundary of the base border set by the Base Management System upgrade level
<br/>
<br/>   This will ensure they are not deleted by the server
<br/>
<br/>   The server now deletes all base parts that are not protected by the base management system i.e. within the confines of the base border
<br/>
<br/>   If not protected by the base management system other players have the right to unlock said base parts and move them
<br/>
<br/>   This has been changed to keep bases from becoming too large and affecting performance (FPS) i.e. Controlled to some extent by the Admins
"
]];

player createDiaryRecord ["INSTRUCTIONS",
[
"Helipads",
"
<br/>1. Place Helipad where you want it but do not lock it just yet  
<br/>
<br/>2. Go to centre of Helipad, look down, and scroll wheel mouse and left click on show Helipad
<br/>
<br/>3. To put a number on Helipad, again go to centre of Helipad, look down and scroll mouse wheel to select a number (1 -6)
<br/>
<br/>4. Now you can lock Helipad into place
<br/>
<br/>5. If you have purchased a Helipad (Rearm) generator, place it on top of and in the centre of the helipad and lock it down
<br/>
<br/>6. look at the generator and scroll mouse wheel to install Security System, the generator will disappear and be installed
<br/>
<br/>7. You now have to give the helipad a pin code to allow you to lock it prevent other players from using it
<br/>
<br/>8. Go to centre of Helipad and scroll mouse to access Security Settings. Enter default pin 0000 to access panel
<br/>
<br/>9. Select change pin and give it a pin code you will remember
<br/>
<br/>10. To lock the Helipad, access Security Settings as before and enter the unique pin code you set and once on the panel choose to lock Helipad Resupply 
<br/>
<br/>11. To unlock the Helipad Resupply and allow you to use it, same as instruction 10 above but choose to unock Helipad Resupply
<br/>
<br/>12. You can now rearm your Vehicles from inside the vehicle by holding down the Alt key ( left of space bar ) and looking down with your mouse until you get the resupply option.
<br/>
<br/>YOU CAN NOT UNLOCK THE HELIPAD RESUPPLY FROM INSIDE A VEHICLE 
"
]];

player createDiaryRecord ["AIRBORNE",
[
"Ghost Swarm",
"
<br/><font size='20' color='#82DCFC'>Ghost Swarm</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	Three Ghost hawks, although beautiful to watch are terrorizing our skies.
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Take care of this convoy an be handsomely rewarded
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	Three crates with specialized equipment inside.
<br/>
<br/>  	Difficulty Level:(1-10): 4	
"
]];

player createDiaryRecord ["AIRBORNE",
[
"Black Patrol",
"
<br/><font size='20' color='#82DCFC'>Black Patrol</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	This is a combo mission. A ground convoy is passing through Altis escorted by an attack chopper. Very Aggressive.
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	This will require pre planning and loads of weaponry. Take out the convoy. Be careful with this one.
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	Executed properly you may get some vehicles for your base or to sell for profit. Get these vehicles and their two crates of cargo.	
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["AIRBORNE",
[
"Carpet Bombing",
"
<br/><font size='20' color='#82DCFC'>Carpet Bombing</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	A single jet has been tasked with a bombing run on one of Altis towns. It could be your neighborhood. Don't let this happen. Innocent lives are at risk.   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	prevent this atrocity from happening. Intercept this Jet and take her down.	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$500000 and two randomly selected crates carried on board the Jet.
<br/>
<br/>  	Difficulty Level:(1-10): 6	
"
]];

player createDiaryRecord ["AIRBORNE",
[
"Holiday on Sky",
"
<br/><font size='20' color='#82DCFC'>Holiday on Sky</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	Don't be fooled by the name this is no holiday mission. Two light aircraft, equiped with machine guns are buzzing around like they own the skies above Altis.
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Strap yourself into a light aircraft and be transported back in time to a day without missiles and test your dog fighting skills against our best pilots. Your mission is to take these to chancers out.
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$500000 and two crates.
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["AIRBORNE",
[
"Cargo Container",
"
<br/><font size='20' color='#82DCFC'>Cargo Container</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	A C130J transport plane is in transit over the island. She is being escorted by a minimum of 2 attack helicopters of varying strengths and capabilities. They are transporting a shipment of static weapons.
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Intercept this air convoy and take it down. Very aggressive mission after initial shot is fired.	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	Container containing varying numbers of static weapons. Could be one item or more. Depends on the day and delivery.
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["AIRBORNE",
[
"Air Superiority Sortie",
"
<br/><font size='20' color='#82DCFC'>Air Superiority Sortie</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	Two specially equipped jets have been scrambled to intercept specifically air targets over Altis
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Don't be one of the statistics, intercept these guys and take them out. they are highly skilled and will require our best fliers. 
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$500000 and two randomly generated crates.
<br/>
<br/>  	Difficulty Level:(1-10): 8	
"
]];

player createDiaryRecord ["AIRBORNE",
[
"Sky Smuggler",
"
<br/><font size='20' color='#82DCFC'>Sky Smuggler</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	A money smuggler is in transit with two experimental escorts. Doesn't look good for Altis letting these bad guys go.
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Destroy this convoy and take the money for your team.
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$750000 and random number of cargo crates.
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["AIRBORNE",
[
"Double Trouble",
"
<br/><font size='20' color='#82DCFC'>Double Trouble</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	The clue is in the name. These pair of muppets need to be taken down. 
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Intercept and take out this double act by any means at your disposal.
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$500000 and two crates
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["AIRBORNE",
[
"Supply Drop",
"
<br/><font size='20' color='#82DCFC'>Supply Drop</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	A VTOL is transporting money and weapons to somewhere on ALtis.
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Take it down and get the money for your team and your own cause.
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	WOW!! this is some amount of Cargo. Nine crates of weapons and goodies. Make this yours.
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["AIRBORNE",
[
"Helicopter Squadron",
"
<br/><font size='20' color='#82DCFC'>Helicopter Squadron</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	A squadron of three armed helicopters are out patrolling the island. They are up to no good.
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Gear up, Locate, Identify and destroy this squadron.
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	Three yet to be identified crates of goodies.
<br/>
<br/>  	Difficulty Level:(1-10): 6	
"
]];

player createDiaryRecord ["AIRBORNE",
[
"Hostile Helicopter",
"
<br/><font size='20' color='#82DCFC'>Hostile Helicopter</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	A Hostile helicopter carrying cargo is patrolling Altis. 
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Locate, Identify and eradicate this Heli to get to its cargo.	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	Two crates with unidentified contents. Good Luck!
<br/>
<br/>  	Difficulty Level:(1-10): 4	
"
]];

player createDiaryRecord ["AIRBORNE",
[
"Mosquito Attack",
"
<br/><font size='20' color='#82DCFC'>Mosquito Attack</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	An Ace pilot is buzzing around the skies looking for his next victim. It could be you.
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Don't let it be you or your team mates. Intercept and take him out at any cost.
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$400000 and two cargo crates currently on board the Jet.
<br/>
<br/>  	Difficulty Level:(1-10): 6	
"
]];

player createDiaryRecord ["AIRBORNE",
[
"Hostile Gunship",
"
<br/><font size='20' color='#82DCFC'>Hostile Gunship</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	A gunship, yet to be identified is patrolling the island attacking any ground target it comes across
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Intercept this nuisance and take him out and make Altis safe for the time being
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	Two nice crates with great kit inside.
<br/>
<br/>  	Difficulty Level:(1-10): 4	
"
]];

player createDiaryRecord ["AIRBORNE",
[
"Pawnee Squadron",
"
<br/><font size='20' color='#82DCFC'>Pawnee Squadron</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	Three very agile Pawnee helicopters and patrolling the island. They mean danger to all ground forces.
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Gear up and chase down these three pilots and eliminate them one at a time to clear the skies.
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	Three crates of cargo, one from each chopper destroyed.
<br/>
<br/>  	Difficulty Level:(1-10): 5	
"
]];

player createDiaryRecord ["AIRBORNE",
[
"Blackfoot Twins",
"
<br/><font size='20' color='#82DCFC'>Blackfoot Twins</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	Two armed Blackfoot helicopters are patrolling the island.   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Take them down. Be careful as once attacked they are like angry wasps	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$500000 and two crates with randomly generated items inside
<br/>
<br/>  	Difficulty Level:(1-10): 6	
"
]];

player createDiaryRecord ["AIRBORNE",
[
"Hostile Fighters",
"
<br/><font size='20' color='#82DCFC'>Hostile Fighters</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	Two jets are patrolling the skies over Altis. They are causing havoc for our ground troops and players.
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	intercept these jets and take care of the situation by whatever means you can.
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$500000 and two crates to the player that ends this sortie.
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["AIRBORNE",
[
"Valar morgulis",
"
<br/><font size='20' color='#82DCFC'>Valar morgulis</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	Difficult mission as these two pilots and there jets are highly trained and very skilled in high tech Jets
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Valar morghulis is a High Valyrian saying originating from Braavos, a city located on the northwestern tip of Essos. It means all men must die,. Don't let this happen!! Take these guys down..
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$500000 and two crates
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["AIRBORNE",
[
"Heavy Armored Cargo Drop",
"
<br/><font size='20' color='#82DCFC'>Heavy Armored Cargo Drop</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	A C130J transport plane is in transit over the island. She is being escorted by a minimum of 2 attack helicopters of varying strengths and capabilities. They are transporting various tanks to the front line.
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Intercept and take down the entire air convoy.	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$300000 and either a anti-air tank or a conventional ground tank with various strengths and capabilities. Check the manifesto for todays delivery to the front line. 
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["AIRBORNE",
[
"Operation Triple Trouble",
"
<br/><font size='20' color='#82DCFC'>Operation Triple Trouble</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	Gear up, Pilot up and try your skills against three highly skilled Jet pilots. Watch your six.
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	This is no easy sortie, you may need a wingman. Intercept this squadron and show them who is King of the skies.
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$400000 and two crates
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["ARMORED",
[
"Military Patrol",
"
<br/><font size='20' color='#D4C62B'>Military Patrol</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>		Another classic convoy mission containing six armored vehicles are patrolling a high valued area of Altis
<br/>	
<br/>	MISSION OBJECTIVE
<br/>
<br/>		Destroy all enemy maybe acquiring a tank or two along the way for your team. This is a heavy patrol so make sure you have adequate hardware for the mission. You have been warned....
<br/>
<br/>	MISSION REWARD
<br/>
<br/>		$500000 and three crates with randomly generated supplies
<br/>
<br/>	Difficulty Level:(1-10): 7  	
"
]];

player createDiaryRecord ["ARMORED",
[
"Radioactive Tower Demolition",
"
<br/><font size='20' color='#D4C62B'>Radioactive Tower Demolition</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>		A Tower is leaking radiation all over Altis. The area is heavily guarded by a highly trained Platoon with two tanks in Support. They are holding a radiation expert hostage while trying to fix the leak.
<br/>
<br/>	MISSION OBJECTIVE
<br/>
<br/>		Kill as many enemy as you can to allow you to get to the tower. Place explosives on the tower (explosive satchel or explosive charges). Make sure the radiation expert is not killed by your team or caught in the crossfire. Detonate your placed explosives to destroy the tower and stop the leak for good. This is a radiation zone so you will require a radiation/gas mask to protect youself
<br/>
<br/>	MISSION REWARD
<br/>
<br/>		$1500000 found in a crate at the mission marker
<br/>
<br/>  	Difficulty Level:(1-10): 7
"
]];

player createDiaryRecord ["ARMORED",
[
"Troops Relocation",
"
<br/><font size='20' color='#D4C62B'>Troops Relocation</font>
<br/>
<br/>	MISSION DESCRIPTION   
<br/> 
<br/>		Several armed mobile units are on their way to a randomly selected location to relocate their new headquarters
<br/>
<br/>	MISSION OBJECTIVE
<br/>
<br/>		Intercept this convoy, loot their cargo and get their money
<br/>
<br/>	MISSION REWARD
<br/>
<br/>		$250000 in cash, A drug stash and two crates containing specialized equipment and weapons
<br/>
<br/>  	Difficulty Level:(1-10): 5
"
]];

player createDiaryRecord ["ARMORED",
[
"Small Money Shipment",
"
<br/><font size='20' color='#D4C62B'>Small Money Shipment</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	Small money shipment mission consisting of two lightly armed but deadly vehicles.
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Secure the money and cargo by eliminating the enemy on this convoy
<br/>
<br/>	MISSION REWARD  	
<br/>
<br/>	$250000
<br/>
<br/>  	Difficulty Level:(1-10): 4	
"
]];

player createDiaryRecord ["ARMORED",
[
"Medium Money Shipment",
"
<br/><font size='20' color='#D4C62B'>Medium Money Shipment</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	Medium money shipment mission consisting of three lightly armed but deadly vehicles. You might even encounter an APC.
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Intercept and destroy all enemy to take the money. Be care ful as the mission is getting slightly harder to complete.
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$500000
<br/>
<br/>  	Difficulty Level:(1-10): 5	
"
]];

player createDiaryRecord ["ARMORED",
[
"Hard Money Shipment",
"
<br/><font size='20' color='#D4C62B'>Hard Money Shipment</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	large money shipment mission consisting of three heavily armed and deadly Tanks. This patrol is escorted by Anti-Air tanks.
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	You'll need to carry a lot of AT missiles for this mission or employ the capabilities of a competent pilot to assist you. Destroy all enemy to claim your reward.
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$750000
<br/>
<br/>  	Difficulty Level:(1-10): 8	
"
]];

player createDiaryRecord ["ARMORED",
[
"Extreme Money Shipment",
"
<br/><font size='20' color='#D4C62B'>Extreme Money Shipment</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	This is the hardest of all the Money Shipment missions. You will encounter 4 Tanks armed with highly skilled soldiers determined to protect their stash.
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Take out the AI and try and keep a few of these vehicles for yourself. Maybe even team up with another player to make it slightly easier.
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$1000000
<br/>
<br/>  	Difficulty Level:(1-10): 9	
"
]];

player createDiaryRecord ["ARMORED",
[
"Altis Patrol",
"
<br/><font size='20' color='#D4C62B'>Altis Patrol</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	Wasteland Classic! A convoy of heavily armored vehicles are circuiting Altis. This convoy is made up of five heavy tanks of varying capabilities.
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Destroy this convoy to capture their money, drug haul and loot.
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$500000 - Drug haul and three weapon crates
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["ARMORED",
[
"Combined Arms",
"
<br/><font size='20' color='#D4C62B'>Combined Arms</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	A combined military convoy of at least 4 armed tanks are moving from town to town.   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Destroy the convoy to take their cash and cargo
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	Depending on your luck you can possibly earn a large some of cash, quantity unknown!
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["ARMORED",
[
"Breaking Bad",
"
<br/><font size='20' color='#D4C62B'>Breaking Bad</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	A drug Cartel is awaiting a delivery of high end drugs. The only issue is the pilot is dead.    
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Get to the unmanned Helicopter and make the drop off. You become the mission once you enter the chopper. Watch out for an ambush at your destination.	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$850000 and a set of new set of friends
<br/>
<br/>  	Difficulty Level:(1-10): 4	
"
]];

player createDiaryRecord ["ARMORED",
[
"Altis Patrol Variant",
"
<br/><font size='20' color='#D4C62B'>Altis Patrol Variant</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	A reinforced armored patrol with specialized armor plating is patrolling Altis. This won't be an easy task as the tanks are of a new prototype metal. The patrol consists of four tanks.
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	You will need all your skill and plenty of rockets for this one. Destroy all enemy and try and secure one of these new breed of tanks for yourself.
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$250000 - four weapon and ammo crates - possible prototyped armored tank
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["ARMORED",
[
"Mad Scientist",
"
<br/><font size='20' color='#D4C62B'>Mad Scientist</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	A mad scientist has found a treatment for eternal youth. The Altis Management don't want this secret revealed. He is being held under guard. Go free him so we can all enjoy Arma forever. He is being protected by a large squad of soldiers and a Tigris in support.
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Don't kill the Mad Scientist or the mission is over. Take out the protection unit and armed tank.
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	Selection of three weapon and equipment crates
<br/>
<br/>  	Difficulty Level:(1-10): 6	
"
]];

player createDiaryRecord ["ARMORED",
[
"Quick Attack",
"
<br/><font size='20' color='#D4C62B'>Quick Attack</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	Quick Attack mission is part of the Mechanized Patrol. It is the lightest of these mech missions but still carries a hefty punch. Three light armed vehicles are in this convoy.
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Destroy this convoy to secure the cargo.
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$150000 and 1 crate.
<br/>
<br/>  	Difficulty Level:(1-10): 5	
"
]];

player createDiaryRecord ["ARMORED",
[
"Light Mechanized",
"
<br/><font size='20' color='#D4C62B'>Light Mechanized</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	Light Mechanized mission is part of the Mechanized Patrol. It consists of two light vehicles and a heavier armed tank.
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Destroy this convoy to secure the money and cargo.
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$250000 and two crates.
<br/>
<br/>  	Difficulty Level:(1-10): 6	
"
]];

player createDiaryRecord ["ARMORED",
[
"Medium Mechanized",
"
<br/><font size='20' color='#D4C62B'>Medium Mechanized</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	Medium Mechanized is the third variant of this Mechanized Patrol. The mission is getting a little trickier and dangerous. This convoy consists of a couple of light vehicles and a heavy tank escort.
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Destroy the convoy and secure the money and cargo.
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$550000 and three cargo crates
<br/>
<br/>  	Difficulty Level:(1-10): 8	
"
]];

player createDiaryRecord ["ARMORED",
[
"Heavy Mechanized",
"
<br/><font size='20' color='#D4C62B'>Heavy Mechanized</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	Heavy Mechanized is the toughest of all the mechanized missions. This can have up to nine armored vehicles of varying capabilities from conventional to anti-air. The convoy must be stopped. It is a threat to all Altis.
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Use all your military know how to destroy all enemy AI within the mission.
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$950000 and six weapon crates.
<br/>
<br/>  	Difficulty Level:(1-10): 9	
"
]];

player createDiaryRecord ["ARMORED",
[
"Small Payday",
"
<br/><font size='20' color='#D4C62B'>Small Payday</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/> 	This is another money shipment mission of the easier small variety. You will encounter 2 light vehicles or APC's
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Destroy all enemy to claim your reward.
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$550000
<br/>
<br/>  	Difficulty Level:(1-10): 3	
"
]];

player createDiaryRecord ["ARMORED",
[
"Medium Payday",
"
<br/><font size='20' color='#D4C62B'>Medium Payday</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	Medium Pay Day consists of three armed vehicles. But don't be fooled by there lack of fire power. They mean business and will fight to the bitter end, and that might mean you.
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Destroy all enemy to claim your reward.
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$750000
<br/>
<br/>  	Difficulty Level:(1-10): 4	
"
]];

player createDiaryRecord ["ARMORED",
[
"Large Payday",
"
<br/><font size='20' color='#D4C62B'>Large Payday</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	With the Large Pay Day the money starts to get a bit more interesting. Watch out for other players trying to ambush you after the mission is over for the cash. This mission consists of three Tanks with varying degrees of skill and fire power.  
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Get in quick, destroy the enemy and grab that cash before anyone turns up.	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$950000
<br/>
<br/>  	Difficulty Level:(1-10): 6	
"
]];

player createDiaryRecord ["ARMORED",
[
"Heavy Payday",
"
<br/><font size='20' color='#D4C62B'>Heavy Payday</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	Heavy Pay Day consists of four Tanks with varying degrees of skill and fire power. Watch out for other players trying to ambush you after the mission is over for the cash.  
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Plan your attack with cunning and guile. Destroy the convoy to collect your cash reward.	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$1200000
<br/>
<br/>  	Difficulty Level:(1-10): 8	
"
]];

player createDiaryRecord ["ARMORED",
[
"APC Patrol",
"
<br/><font size='20' color='#D4C62B'>APC Patrol</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	An Armored Personnel Carrier escorted by an armored division are navigating from town to town. Aggressive and Dangerous.
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Destroy this convoy at all cost.
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$100000, crates and weapons
<br/>
<br/>  	Difficulty Level:(1-10): 6	
"
]];

player createDiaryRecord ["ARMORED",
[
"Armored Patrol",
"
<br/><font size='20' color='#D4C62B'>Armored Patrol</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	A military convoy is patrolling the towns across Altis Aggressive and Dangerous
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Tool up and deploy your team to take out this convoy of armed vehicles
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$100000, crates and weapons
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["ARMORED",
[
"Anti-Air Patrol",
"
<br/><font size='20' color='#D4C62B'>Anti-Air Patrol</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	A Military Patrol including Air supported tanks are going from town to town. The skies are not safe while they are active on the ground.
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Intercept this land convoy and destroy all enemy, maybe saving a tank or two fro your base. Highly Aggressive and deadly.
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$100000, crates and weapons
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["ARMORED",
[
"Heavy Metal Convoy",
"
<br/><font size='20' color='#D4C62B'>Heavy Metal Convoy</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	A combined convoy of conventional tanks and anti-air tanks are crossing Altis
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Intercept and destroy these vehicles before they become a danger to everyone.
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$600000 and two equipment crates
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["ARMORED",
[
"Bobcat Delivery",
"
<br/><font size='20' color='#D4C62B'>Bobcat Delivery</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	A specialized rearming vehicle in the form of a Bobcat is being escorted to the front lines across Altis. The escort consists of two armed vehicles.
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Take out the escort vehicles and try get this rearming, refueling and repairing vehicle for your Base.
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	Bobcat possibly and two weapon crates.
<br/>
<br/>  	Difficulty Level:(1-10): 6	
"
]];

player createDiaryRecord ["ARMORED",
[
"Large Weapons Crate Delivery",
"
<br/><font size='20' color='#D4C62B'>Large Weapons Crate Delivery</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	A medical or Ammo truck is carrying a very big load of cargo and weapons. It is being escorted by two armed vehicles across Altis. 
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Take the convoy out and secure the contents of this cargo for your team.
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	Six weapon crates of cargo.
<br/>
<br/>  	Difficulty Level:(1-10): 6	
"
]];

player createDiaryRecord ["ARMORED",
[
"SUV Escort",
"
<br/><font size='20' color='#D4C62B'>SUV Escort</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	Small convoy consisting of 3 vehicles. Usually a small unarmed vehicle escorted by two light support vehicles.
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Destroy all AI while trying to secure one of the light vehicles for your base.
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$300000 and two cargo crates
<br/>
<br/>  	Difficulty Level:(1-10): 4	
"
]];

player createDiaryRecord ["ARMORED",
[
"Car Jacking",
"
<br/><font size='20' color='#D4C62B'>Car Jacking</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	A transport van full of enemy soldiers escorted to two or three light support vehicles is crossing Altis. 
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Intercept this convoy. Do not destroy the Van. Stop it and eliminate the soldiers within. Kill or outrun the light escort and delivery that van to its final destination to collect the reward.
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	Depending on the generosity of the Cartel Leader you can earn between $100000 - $400000 on successful delivery.
<br/>
<br/>  	Difficulty Level:(1-10): 8	
"
]];

player createDiaryRecord ["ARMORED",
[
"Heavy HEMTT Transport",
"
<br/><font size='20' color='#D4C62B'>Heavy HEMTT Transport</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	A HEMTT transport is on the move across Altis. It is heavily guarded by a Blackfoot attack chopper and several armed vehicles.
<br/>		
<br/>	MISSION OBJECTIVE  	
<br/>
<br/>	Head there and save their cargo for your team
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$500000, An assorted array of Drugs and several crates of weapons
<br/>
<br/>  	Difficulty Level:(1-10): 8	
"
]];

player createDiaryRecord ["INFANTRY",
[
"Foot Patrol",
"
<br/><font size='20' color='#478A08'>Foot Patrol</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   A Recon Patrol are making their way from town to town checking for any  Hostiles en route.
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Intercept or Ambush this patrol. eliminate all units and collect the reward.
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$240000 - $940000 depending on the size of the patrol.
<br/>
<br/>  	Difficulty Level:(1-10): 4
"
]];

player createDiaryRecord ["INFANTRY",
[
"Geocache",
"
<br/><font size='20' color='#478A08'>Geocache</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   A laptop containing critical intelligence has been left behind at the mission  location.
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Find a lost laptop to prevent it falling into enemy hands.
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$600000 and a random crate of supplies dropped from the sky.
<br/>
<br/>  	Difficulty Level:(1-10): 3
"
]];

player createDiaryRecord ["INFANTRY",
[
"Bomb disposal",
"
<br/><font size='20' color='#478A08'>Bomb disposal</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   A highly explosive device has been found in a random town.
<br/>	 One player on the server has received the colour code to which wire to Cut
<br/>	
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Take a chance and try to cut the correct wire ( fraught with danger ) or
<br/>	Negotiate with the player that received the Intel ( beware they may double  cross you ) or
<br/>	Ambush the player that has received the Intel when he disarms the bomb    ( again fraught with danger )
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$1000000
<br/>
<br/>  	Difficulty Level:(1-10): 2
"
]];

player createDiaryRecord ["INFANTRY",
[
"SpecOps Paratroops",
"
<br/><font size='20' color='#478A08'>SpecOps Paratroops</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["INFANTRY",
[
"Aircraft Wreck",
"
<br/><font size='20' color='#478A08'>Aircraft Wreck</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["INFANTRY",
[
"Drugs n' Surf",
"
<br/><font size='20' color='#478A08'>Drugs n Surf</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["INFANTRY",
[
"Army Bounty",
"
<br/><font size='20' color='#478A08'>Army Bounty</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["INFANTRY",
[
"Red Dawn",
"
<br/><font size='20' color='#478A08'>Red Dawn</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/> 	Land Mission  
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Fourteen (14) paratroopers are airdropped into a location. The troopers are constantly on the move. Encounter the squad and eliminate 	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	Three (3) random weapons creates.
<br/>
<br/>  	Difficulty Level:(1-10): 4	
"
]];

player createDiaryRecord ["INFANTRY",
[
"Sam Site",
"
<br/><font size='20' color='#478A08'>Sam Site</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["INFANTRY",
[
"Defender of Altis Skies",
"
<br/><font size='20' color='#478A08'>Defender of Altis Skies</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["INFANTRY",
[
"Spetsnaz",
"
<br/><font size='20' color='#478A08'>Spetsnaz</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["INFANTRY",
[
"Altis Roulette",
"
<br/><font size='20' color='#478A08'>Altis Roulette</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["INFANTRY",
[
"Captured Engineer",
"
<br/><font size='20' color='#478A08'>Captured Engineer</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["INFANTRY",
[
"Artillery Hardware",
"
<br/><font size='20' color='#478A08'>Artillery Hardware</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["INFANTRY",
[
"Downed Falcon",
"
<br/><font size='20' color='#478A08'>Downed Falcon</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["INFANTRY",
[
"Stomper SOS",
"
<br/><font size='20' color='#478A08'>Stomper SOS</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["INFANTRY",
[
"Explosive Experts",
"
<br/><font size='20' color='#478A08'>Explosive Experts</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["INFANTRY",
[
"UAV Terminal",
"
<br/><font size='20' color='#478A08'>UAV Terminal</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["INFANTRY",
[
"Sniper Nest",
"
<br/><font size='20' color='#478A08'>Sniper Nest</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/> 	Land Mission  
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Encounter ten (10) soldiers and eliminate. 	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	One crate with randomly generated supplies. Low reward!!
<br/>
<br/>  	Difficulty Level:(1-10): 3	
"
]];

player createDiaryRecord ["INFANTRY",
[
"Anti-Aircraft Vehicle",
"
<br/><font size='20' color='#478A08'>Anti-Aircraft Vehicle</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["INFANTRY",
[
"Infantry Fighting Vehicle",
"
<br/><font size='20' color='#478A08'>Infantry Fighting Vehicle</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["INFANTRY",
[
"Armored Personnel Carrier",
"
<br/><font size='20' color='#478A08'>Armored Personnel Carrier</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["INFANTRY",
[
"Main Battle Tank",
"
<br/><font size='20' color='#478A08'>Main Battle Tank</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["INFANTRY",
[
"Abandoned Jet",
"
<br/><font size='20' color='#478A08'>Abandoned Jet</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["INFANTRY",
[
"VTOL",
"
<br/><font size='20' color='#478A08'>VTOL</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["INFANTRY",
[
"Light Armed Vehicle",
"
<br/><font size='20' color='#478A08'>Light Armed Vehicle</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["INFANTRY",
[
"Armed Helicopter",
"
<br/><font size='20' color='#478A08'>Armed Helicopter</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["INFANTRY",
[
"Transport Helicopter",
"
<br/><font size='20' color='#478A08'>Transport Helicopter</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["INFANTRY",
[
"Weapons Cache",
"
<br/><font size='20' color='#478A08'>Weapons Cache</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["INFANTRY",
[
"Tropical Smugglers",
"
<br/><font size='20' color='#478A08'>Tropical Smugglers</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["INFANTRY",
[
"Supply Truck",
"
<br/><font size='20' color='#478A08'>Supply Truck</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["INFANTRY",
[
"EXORCISM",
"
<br/><font size='20' color='#478A08'>EXORCISM</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["INFANTRY",
[
"Zombie Fest",
"
<br/><font size='20' color='#478A08'>Zombie Fest</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["INFANTRY",
[
"Zombie Apocalypse",
"
<br/><font size='20' color='#478A08'>Zombie Apocalypse</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["INFANTRY",
[
"Small Infantry Group",
"
<br/><font size='20' color='#478A08'>Small Infantry Group</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["INFANTRY",
[
"Medium Infantry Group",
"
<br/><font size='20' color='#478A08'>Medium Infantry Group</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["INFANTRY",
[
"Large Infantry Group",
"
<br/><font size='20' color='#478A08'>Large Infantry Group</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["INFANTRY",
[
"Heavy Infantry Group",
"
<br/><font size='20' color='#478A08'>Heavy Infantry Group</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["INFANTRY",
[
"Assassins",
"
<br/><font size='20' color='#478A08'>Assassins</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["INFANTRY",
[
"Army Bounty",
"
<br/><font size='20' color='#478A08'>Army Bounty</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["MARINE",
[
"Mine Fantastic",
"
<br/><font size='20' color='#2A7AD0'>Mine Fantastic</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 8
"
]];

player createDiaryRecord ["MARINE",
[
"Destroy Nuclear Warhead",
"
<br/><font size='20' color='#2A7AD0'>Destroy Nuclear Warhead</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 6	
"
]];

player createDiaryRecord ["MARINE",
[
"Mayan Temple Incursion",
"
<br/><font size='20' color='#2A7AD0'>Mayan Temple Incursion</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	Underwater Mission   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Dive to an underwater Mayan pyramid which is located in the Southern Ocean is patrolled by divers. This is a heavy patrol so make sure you have adequate underwater gear and transportation to the location to recover the rewards.	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$1000000 and two crates with randomly generated supplies. The cash is in the creates.
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 6	
"
]];

player createDiaryRecord ["MARINE",
[
"Armed Diving Expedition",
"
<br/><font size='20' color='#2A7AD0'>Armed Diving Expedition</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 6
"
]];

player createDiaryRecord ["MARINE",
[
"Sunken Treasure",
"
<br/><font size='20' color='#2A7AD0'>Sunken Treasure</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 6
"
]];

player createDiaryRecord ["MARINE",
[
"Deep Offshore Sunken Treasure",
"
<br/><font size='20' color='#2A7AD0'>Deep Offshore Sunken Treasure</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	Underwater Mission  
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Dive to a deep offshore position to encounter sixteen (16) divers patrolling the mission location. There will be a boat on the surface to mark the location. Terminate the divers and recover the rewards.	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$2000000 and one weapon crate. The boat on the surface can be used to return your create and reward to shore.
<br/>
<br/>  	Difficulty Level:(1-10): 6
"
]];

player createDiaryRecord ["MARINE",
[
"CB90 Coastal Patrol",
"
<br/><font size='20' color='#2A7AD0'>CB90 Coastal Patrol</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	Surface Water Mission   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	The coast is being patrolled by two (2) CB90 Patrol Boats. Destroy the patrol boats and collect your reward. The patrol boats are equipped with missiles.	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$0000000 and two crates with randomly generated supplies. The cash is in the creates.
<br/>
<br/>  	Difficulty Level:(1-10): 4
"
]];

player createDiaryRecord ["MARINE",
[
"Dark Days on High Seas",
"
<br/><font size='20' color='#2A7AD0'>Dark Days on High Seas</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/> 	Naval Mission  
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Patrolling the ocean, a small convoy of warships as well as air support. Attempt to defeat all ship, and air support and claim your prize. Attempt this mission with ships, subs or however you want to challenge these vehicles. Remember some of the ships are equipped with long range anti-air missiles and torpedoes. 	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$4000000 air-dropped in a speedboat at end of mission. The cash is in the create.
<br/>
<br/>  	Mission Hint
<br/>
<br/>	In your player menu, Info, you will find a link to download the user manuals for the ships and subs.
<br/>
<br/>  	Difficulty Level:(1-10): 8	
"
]];



player createDiaryRecord ["OCCUPATION",
[
"The Maze",
"
<br/><font size='20' color='#f56701'>The Maze</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	Foot Mission   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Make your way through a maze, located near the Salt Flats. The maze is patrolled by a team of soldiers who have laid mines down for you to navigate through. Mark your way to the reward then try to find your way out.	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$1000000 cash and a create with randomly generated supplies.
<br/>
<br/>	Mission Hint
<br/>
<br/>	Once the mission is completed, the front door will close, find the teleport zone to get out. Players may attempt to steal your prize on your out. Be prepared!!
<br/>
<br/>  	Difficulty Level:(1-10): 6	
"
]];

player createDiaryRecord ["OCCUPATION",
[
"Town Invasion",
"
<br/><font size='20' color='#f56701'>Town Invasion</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 6	
"
]];

player createDiaryRecord ["OCCUPATION",
[
"Bandit Stronghold",
"
<br/><font size='20' color='#f56701'>Bandit Stronghold</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 6	
"
]];

player createDiaryRecord ["OCCUPATION",
[
"Hunter's Rescue",
"
<br/><font size='20' color='#f56701'>Hunter's Rescue</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 6	
"
]];

player createDiaryRecord ["OCCUPATION",
[
"Paramilitary Base",
"
<br/><font size='20' color='#f56701'>Paramilitary Base</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 6	
"
]];

player createDiaryRecord ["OCCUPATION",
[
"Alcatraz jail Break",
"
<br/><font size='20' color='#f56701'>Alcatraz jail Break</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	Land Mission   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Alcatraz has an active jail which is located in the North Western region of the map. The island is used to penalize player(s) that just don’t bother reading the rules or choose to break the rules. Attempt to defeat the soldiers patrolling the island. 	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$1500000 cash and a create with randomly generated supplies.
<br/>
<br/>  	Mission Hint
<br/>
<br/>	There are guard in the tower and up at the jail. You will have to take a boat or fly.
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 6	
"
]];

player createDiaryRecord ["OCCUPATION",
[
"Squad Assault",
"
<br/><font size='20' color='#f56701'>Squad Assault</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 6	
"
]];

player createDiaryRecord ["OCCUPATION",
[
"Military Incursion",
"
<br/><font size='20' color='#f56701'>Military Incursion</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 6	
"
]];

player createDiaryRecord ["OCCUPATION",
[
"Violent Riot",
"
<br/><font size='20' color='#f56701'>Violent Riot</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 6	
"
]];

player createDiaryRecord ["OCCUPATION",
[
"Terrorists",
"
<br/><font size='20' color='#f56701'>Terrorists</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	Land Mission   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	A military base is patrolled by two (2) Hunters and one (1) Marshall. Destroy the vehicles as well as the occupants and recover the reward.	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$400,000 and three crates with randomly generated supplies. The cash will appear in the base once the objective is completed.
<br/>
<br/>  	Difficulty Level:(1-10): 5	
"
]];

player createDiaryRecord ["OCCUPATION",
[
"Infiltration of Oak Island",
"
<br/><font size='20' color='#f56701'>Infiltration of Oak Island</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 6	
"
]];

player createDiaryRecord ["OCCUPATION",
[
"Airport Outpost",
"
<br/><font size='20' color='#f56701'>Airport Outpost</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 6	
"
]];

player createDiaryRecord ["OCCUPATION",
[
"Harbor Invasion",
"
<br/><font size='20' color='#f56701'>Harbor Invasion</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 6	
"
]];

player createDiaryRecord ["OCCUPATION",
[
"Annexation of Industry",
"
<br/><font size='20' color='#f56701'>Annexation of Industry</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 6	
"
]];

player createDiaryRecord ["OCCUPATION",
[
"Gas Theft",
"
<br/><font size='20' color='#f56701'>Gas Theft</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 6	
"
]];

player createDiaryRecord ["OCCUPATION",
[
"Bandit Camp",
"
<br/><font size='20' color='#f56701'>Bandit Camp</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 6	
"
]];

player createDiaryRecord ["OCCUPATION",
[
"Airpost Blockage",
"
<br/><font size='20' color='#f56701'>Airpost Blockage</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 6	
"
]];

player createDiaryRecord ["PREMIUM",
[
"Hackers",
"
<br/><font size='20' color='#FACB32'>Hackers</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/> 	A 24 strong platoon are trying to hack into in game players bank accounts to steal thier hard won savings. Expect to find static weapons and AA support protecting the efforts  
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	A computer linked to every players bank account is sitting on a table waiting for you to hack into all players account. Attempt to defeat the soldiers patrolling the area as well as a number of other surprises. After hacking seven (7) percent of the players account, attempt to make your way to an ATM to deposit the cash. 	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	Seven (7) percent of each players bank account.
<br/>
<br/>	Mission Hint
<br/>	
<br/>	Players will attempt to hunt you down to recover or steal the reward. They will also try to protect their account. 	
<br/>
<br/>  	Difficulty Level:(1-10): 8 - 9	
"
]];

player createDiaryRecord ["PREMIUM",
[
"Ghost Sniper",
"
<br/><font size='20' color='#FACB32'>Ghost Sniper</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 6	
"
]];

player createDiaryRecord ["PREMIUM",
[
"Black Magic Autonomous Weapons",
"
<br/><font size='20' color='#FACB32'>Black Magic Autonomous Weapons</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>	Land Mission   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Locate a small magic lamp within the radius of the red circle. 	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	Two (2) autonomous weapons
<br/>
<br/>	Mission Hint
<br/>
<br/>	When you find the lamp, stand over it, then two (2) autonomous weapons will appear. These weapons can be used to protect your base when you are away from your base, in the event you get raided or you have trespassers in the area. 	
<br/>
<br/>  	Difficulty Level:(1-10): 4	
"
]];

player createDiaryRecord ["PREMIUM",
[
"Tank Blitz",
"
<br/><font size='20' color='#FACB32'>Tank Blitz</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 6	
"
]];

player createDiaryRecord ["PREMIUM",
[
"ATM Hacker",
"
<br/><font size='20' color='#FACB32'>ATM Hacker</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 6	
"
]];

player createDiaryRecord ["PREMIUM",
[
"$100,000,000 Jackpot Bonanza",
"
<br/><font size='20' color='#FACB32'>$100,000,000 Jackpot Bonanza</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>  	Land Mission 
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Find the gold trophy in the red zone. 	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$100,000,000 – a create will airdrop containing the reward.
<br/>
<br/>	Mission Hint
<br/>
<br/>	Team up with a number of players to find the objective and recover the reward.
<br/>
<br/>  	Difficulty Level:(1-10): 7	
"
]];

player createDiaryRecord ["PREMIUM",
[
"Prototype Tanks",
"
<br/><font size='20' color='#FACB32'>Prototype Tanks</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 6	
"
]];

player createDiaryRecord ["PREMIUM",
[
"Artillery Patrol",
"
<br/><font size='20' color='#FACB32'>Artillery Patrol</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 6	
"
]];

player createDiaryRecord ["PREMIUM",
[
"Chopper Strike",
"
<br/><font size='20' color='#FACB32'>Chopper Strike</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/>   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>
<br/>
<br/>  	Difficulty Level:(1-10): 6	
"
]];

player createDiaryRecord ["BOUNTY",
[
"Bounty Mission - Catch the Rabbit",
"
<br/><font size='20' color='#8E1212'>Bounty Mission - Catch the Rabbit</font>
<br/>
<br/>	MISSION DESCRIPTION
<br/> 
<br/> 	A randomly selected player will be selected as a Bounty, creating the mission.   
<br/>		
<br/>	MISSION OBJECTIVE
<br/>
<br/>	Your job is to kill the bounty.	
<br/>
<br/>	MISSION REWARD
<br/>
<br/>	$500000 dollars to the Bounty killer and $50000 to each of your team mates (Group) or vice versa if the Bounty survives without being killed
<br/>
<br/>  	Difficulty Level:(1-10): 4	
"
]];












