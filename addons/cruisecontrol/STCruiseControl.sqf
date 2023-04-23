/*******************************************************************************************
* This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com
********************************************************************************************
* @file Name: STCruiseControl.sqf
* @author: The Scotsman - Adapted from script originally by Allen
*
* Enables Vehicle Cruise Control
*
* Arguments: none
*
*/


// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: Rearm_Menu.sqf
//	@file Author: The Scotsman
//	@file Description: Lockable Reammo Crates

Cruise_Control_Setup = {

  _trigger2 = createTrigger ["EmptyDetector", [0,0,0]];
  _trigger2 setTriggerArea [0, 0, 0, false];
  _trigger2 setTriggerActivation ["NONE", "PRESENT", true];
  _trigger2 setTriggerStatements ["('LandVehicle' countType [(vehicle player)] > 0)",
  	"uwg_cruise = vehicle player;uwg_cruise_control = uwg_cruise addAction ['Enable Cruise Control','["""""""",call Cruise_Control_Menu,player,false] spawn BIS_fnc_MP;',[], 0, false, false, '', 'driver uwg_cruise == player'];",
  	"uwg_cruise removeAction uwg_cruise_control; uwg_cruise = nil;"];

} call mf_compile;

Cruise_Control_Menu = {
  	cruiseControlSet = false;
    _picture = getText (configFile >> "CfgVehicles" >> typeOf(vehicle player) >> "picture");
    _velocity = velocity uwg_cruise;
  	_x = _velocity select 0;
  	_y = _velocity select 1;
  	_xy = sqrt ( _x*_x + _y*_y ) * 3.6;
  	cspeed = _xy;

    if( _xy > 20 ) then {

      cruiseControlSet = true;

      hint parseText format ["
        <t size='1.30' font='puristaMedium' align='center'>--------------------------------------</t><br/>
        <t size='1.30' font='puristaMedium' align='center' color='#0D82DF'>Cruise Control: </t><t size='1.30' font='puristaMedium' align='center' color='#33CC00'>ON</t><br/>
          <t size='1.30' font='puristaMedium' align='center'>--------------------------------------</t><br/><br/>
        <t size='0.90' font='puristaLight' align='center'><img image='%1' size='3.75' /></t><br/>
        <t size='2.35' font='puristaMedium' align='center' color='#008000'>%2 km\h</t><br/><br/>
        <t size='0.90' font='puristaLight' align='center' color='#CC9900'>Terminate Cruise with Breaks (S)</t><br/>",
        _picture, [_xy] call fn_numbersText];

        uwg_cruise removeAction uwg_cruise_control;
        (findDisplay 46) displayAddEventHandler ["KeyDown",{
          _keyDown = _this select 1;
          if (_keyDown == 0x1F) then {
            if (cruiseControlSet) then {
              uwg_cruise_control = uwg_cruise addAction ['Cruise Control','["""""""",call Cruise_Control_Menu,player,false] spawn BIS_fnc_MP;',[], 0, false, false, '', 'driver uwg_cruise == player'];
              cruiseControlSet = false;
              hint parseText format ["
                    <t size='1.30' font='puristaMedium' align='center'>--------------------------------------</t><br/>
                    <t size='1.30' font='puristaMedium' align='center'>Cruise Control: </t><t size='1.30' font='puristaMedium' align='center' color='#990000'>OFF</t><br/>
                    <t size='1.30' font='puristaMedium' align='center'>--------------------------------------</t><br/>"
                  ];
            };
          };}];

    } else { //CC Not Set

      hint parseText format ["
					<t size='1.30' font='puristaMedium' align='center' color='#0D82DF'>Cruise Control</t><br/><br/>
					<t size='0.90 'font='puristaLight' align='left'>Cruise Control:</t><t size='0.90 'font='puristaLight' align='left' color='#990000'> NOT Activated!</t><br/><br/>
					<t size='0.90' font='puristaLight' align='left' color='#0D82DF'>Current Speed</t><t size='0.90' font='puristaLight'align='right' color='#0D82DF'>Cruise Speed</t><br/>
					<t size='0.90' font='puristaLight' align='left'>45 - 55 km/h :</t><t size='0.90' font='puristaLight'align='right'>50 km/h</t><br/>
					<t size='0.90' font='puristaLight' align='left'>65 - 75 km/h :</t><t size='0.90' font='puristaLight'align='right'>70 km/h</t><br/>
					<t size='0.90' font='puristaLight' align='left'>115 - 125 km/h :</t><t size='0.90' font='puristaLight'align='right'>120 km/h</t><br/>
					<t size='0.90' font='puristaLight' align='left'>155 - 165 km/h :</t><t size='0.90' font='puristaLight'align='right'>160 km/h</t><br/><br/>
					<t size='0.90' font='puristaLight' align='center' color='#CC9900'>Terminate Cruise with Breaks (S)</t><br/><br/>
					<t size='1.30' font='puristaMedium' align='center' color='#0D82DF'>- Cruise Control -</t><br/>"];

    };

  	while {cruiseControlSet} do {
  		if (getDammage uwg_cruise > 0.1) exitWith {
  			cruiseControlSet = false;
  			hint parseText format ["
  								<t size='1.30' font='puristaMedium' align='center' color='#0D82DF'>Cruise Control</t><br/><br/>
  								<t size='0.90 'font='puristaLight' align='left'>Cruise Control:</t><t size='0.90 'font='puristaLight' align='left' color='#990000'> Deactivated!</t><br/><br/>
  								<t size='0.90 'font='puristaLight' align='left'>The vehicle is too damaged to use Cruise Control, try repairing the vehicle.<br/><br/>
  								<t size='1.30' font='puristaMedium' align='center' color='#0D82DF'>- Cruise Control -</t><br/>"
  							];
  		};
  		if (fuel uwg_cruise < 0.1) exitWith {
  			cruiseControlSet = false;
  			hint parseText format ["
  								<t size='1.30' font='puristaMedium' align='center' color='#0D82DF'>Cruise Control</t><br/><br/>
  								<t size='0.90 'font='puristaLight' align='left'>Cruise Control:</t><t size='0.90 'font='puristaLight' align='left' color='#990000'> Deactivated!</t><br/><br/>
  								<t size='0.90 'font='puristaLight' align='left'>The vehicle does not have enough fuel.<br/><br/>
  								<t size='1.30' font='puristaMedium' align='center' color='#0D82DF'>- Cruise Control -</t><br/>"
  							];
  		};
  		_dir = getDir uwg_cruise;
  		_newX = (sin _dir)*(cspeed/3.6);
  		_newY = (cos _dir)*(cspeed/3.6);
  		uwg_cruise setVelocity [_newX, _newY, (velocity uwg_cruise) select 2];
  		sleep 0.05;
  	};

} call mf_compile;


CruiseControlInitialized = true;
