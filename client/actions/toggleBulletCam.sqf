//toggleBulletCam.sqf

player setVariable ["BulletCam", !(player getVariable ["BulletCam", false])];

if (!(player getVariable ["BulletCam", false])) exitWith {player groupChat format ["Bullet Cam Off"];};

player groupChat format ["Bullet Cam On"];


