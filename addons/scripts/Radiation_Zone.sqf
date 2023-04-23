//Spawns over Kavala in Altis. To move it just change the grid numbers to wear you want  [3753.826, 12999.547,0].

Private ["_radPos"];

_radPos = _this select 0;
radPosRepeat = _radPos;
 
//[3753.826, 12999.547,0] 

Rad_Zone_1 = createTrigger ["EmptyDetector", _radPos];
Rad_Zone_1 setTriggerArea [1100, 1100, 0, false];  // this is the area the radiation will be
Rad_Zone_1 setTriggerActivation ["ANY", "PRESENT", true];

Rad_Zone_1 setTriggerStatements

    [
      "this",
      "
      {
                 [_x,thisTrigger] spawn
                {
                  _unit = _this select 0;
                  _trg  = _this select 1;             

  

                  private ['_timer','_dmg','_GasMask'];

                  _GasMask = ['G_AirPurifyingRespirator_02_black_F','G_AirPurifyingRespirator_02_olive_F','G_AirPurifyingRespirator_02_sand_F','G_AirPurifyingRespirator_01_F','G_RegulatorMask_F'];

 

                  while {alive _unit && local _unit} do
                  {
                      waitUntil {sleep 0.5; _unit inArea _trg && !(goggles _unit in _GasMask)};

                       if (isPlayer _unit) then
                         {
                             hint parseText format['<t size=""1.10"" font=""PuristaMedium"" color=""#F0133C"">Radiation hazard! Check your equipment</t>'];
                              _unit setVariable ['radiat', ppEffectCreate ['ChromAberration', 200]];
                              (_unit getVariable 'radiat') ppEffectEnable true;
                              (_unit getVariable 'radiat') ppEffectAdjust [0.03, 0.03, true];
                              (_unit getVariable 'radiat') ppEffectCommit 10;

                              _unit setVariable ['radiat2', ppEffectCreate ['ColorInversion', 500]];
                              (_unit getVariable 'radiat2') ppEffectEnable true;
                              (_unit getVariable 'radiat2') ppEffectAdjust [0.0, 0.0, 0.2];
                              (_unit getVariable 'radiat2') ppEffectCommit 10;
							  _unit setVariable ['inRadiationZone', true];							  
                         };

                    _dmg   = getDammage _unit;
                    _timer = diag_tickTime;

                    _dmgTick = 0.2;


                   waitUntil {sleep 0.5; !(_unit inArea _trg) or diag_tickTime > _timer + 3 or (goggles _unit in _GasMask)};
                  if (diag_tickTime > _timer + 3) then {_unit setDamage ((damage _unit) + _dmgTick)};

                   waitUntil {sleep 0.5; !(_unit inArea _trg) or diag_tickTime > _timer + 6 or (goggles _unit in _GasMask)};
                  if (diag_tickTime > _timer + 3) then {_unit setDamage ((damage _unit) + _dmgTick)};

                   waitUntil {sleep 0.5; !(_unit inArea _trg) or diag_tickTime > _timer + 9 or (goggles _unit in _GasMask)};
                  if (diag_tickTime > _timer + 3) then {_unit setDamage ((damage _unit) + _dmgTick)};

                   waitUntil {sleep 0.5; !(_unit inArea _trg) or diag_tickTime > _timer + 12 or (goggles _unit in _GasMask)};
                  if (diag_tickTime > _timer + 3) then {_unit setDamage ((damage _unit) + _dmgTick)};

                   waitUntil {sleep 0.5; !(_unit inArea _trg) or diag_tickTime > _timer + 15 or (goggles _unit in _GasMask)};
                   if (diag_tickTime > _timer + 15) exitWith {_unit setDamage 1};

				   
                   if (isPlayer _unit) then
                   {
                      hint parseText format['<t size=""1.10"" font=""PuristaMedium"" color=""#13F03C"">You are out of contamination</t>'];
					  
                              _unit setVariable ['noradiat', ppEffectCreate ['ChromAberration', 200]];
                              (_unit getVariable 'noradiat') ppEffectEnable true;
                              (_unit getVariable 'noradiat') ppEffectAdjust [0.0, 0.0, true];
                              (_unit getVariable 'noradiat') ppEffectCommit 10;

                              _unit setVariable ['noradiat2', ppEffectCreate ['ColorInversion', 500]];
                              (_unit getVariable 'noradiat2') ppEffectEnable true;
                              (_unit getVariable 'noradiat2') ppEffectAdjust [0, 0, 0];
                              (_unit getVariable 'noradiat2') ppEffectCommit 10;
							  _unit setVariable ['inRadiationZone', false];							  
                   };
                  }
                }
             } forEach allUnits;",
        ""
     ];

_Radiation = Rad_Zone_1 getRelPos [0,0];
_radPosOffset = [(_radPos select 0) - 100, (_radPos select 1) - 100, _radPos select 2];
_Rad_Obj_1 = "Land_HelipadEmpty_F" createVehicle _Radiation;


_Warning_Marker = createMarker ["Warning_Marker_1", getPos _Rad_Obj_1];
_Warning_Marker setMarkerShape "ELLIPSE";
_Warning_Marker setMarkerColor "ColorRed";
_Warning_Marker setMarkerSize [1100, 1100];
_Warning_Marker setMarkerBrush "DIAGGRID";

 

//Change [3753.826, 12999.547,0] to where ever you want the radiation to be

_City_marker = createMarker ["Kavala", _radPosOffset]; 
_City_marker setMarkerType "hd_warning";
_City_marker setMarkerSize [1,1];
_City_marker setMarkerColor "ColorYellow";
_City_marker setMarkerText "Warning - RADIATION ZONE";