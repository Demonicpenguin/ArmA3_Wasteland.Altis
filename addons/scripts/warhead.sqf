["Warhead Self Destruct sequence Activated, ***WARNING - CLEAR THE AREA!!! *** detonation in 20 seconds!!!","hint",true,true] call BIS_fnc_MP;
playSound3D [call currMissionDir + "media\warhead.ogg", player, false, getPosASL player, 5,1,2000];
sleep 23;
_explos = "Bo_GBU12_LGB" createVehicle getPos warHead; 
warHead setDamage 1;
