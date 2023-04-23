playSound "intro";

sleep 3;

[
  [
    ["Welcome to Wasteland,","<t align='center' shadow='1' size='0.7'>%1</t>"],
    [name player,"<t align='center' shadow='1' size='0.7' color='#92dd18' font='PuristaBold'>%1</t><br/>"],
    ["Let the onslaught begin!","<t align='center' shadow='1' size='1.0'>%1</t>"]
  ]
] spawn BIS_fnc_typeText;
