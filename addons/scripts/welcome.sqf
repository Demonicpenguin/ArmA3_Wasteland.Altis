sleep 5;
playSound "intro";
sleep 5;
[] spawn {
		waitUntil{player == player};
		_worldName = switch(toLower worldName)do{
                case "altis"             :{"Altis"};
                case "bornholm"             :{"Bornholm"};
                case "chernarus"             :{"Chernarus"};
                default{worldName};
        };
        [[format["Welcome to Scottish Special Forces", _worldName],"", format["Let the onslaught begin, %1", name player],"","","","",""," ","","","",""], -.5, .85] call BIS_fnc_typeText;
        //sleep 2;
        [["Visit us at:","www.ssf-a3-wasteland.proboards.com","For Rules","Forums","and other info...","",""], .5, .85] call BIS_fnc_typeText;
};
