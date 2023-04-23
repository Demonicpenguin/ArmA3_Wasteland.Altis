private _nearestManagers = nearestObjects [player, ["Land_SatellitePhone_F"], 100];
private _nearestManager = _nearestManagers select 0;
private _playerUID = getPlayerUID player;
private _ManagerOwner = _nearestManager getvariable "ownerUID";

if ((player distance _nearestManager) < 100) then  
{
    if (_nearestManager getVariable ["objectLocked", false]) then 
    {
      if (_playerUID == _ManagerOwner) then 
      {
        execVM "addons\BoS\BoS_remote_ownerMenu.sqf";
        hint "Welcome Owner";
      } 
      else 
      {
        execVM "addons\BoS\remote_password_enter.sqf";
        hint "Welcome";
      };
    } 
    else 
    {
      hint "Base Manager refused connection";
    };
} 
else
{
  hint "No Base Manager in Range";
};
