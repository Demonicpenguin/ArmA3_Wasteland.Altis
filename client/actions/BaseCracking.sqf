/*
Author: BIB_Monkey
Filename: BaseCraking.sqf
Purpose: Allow player to hack into enemy base manager remotely
*/
// Setup Variables
	//Initialize Hack in progress flag
	HackInProgress = false;
	// What vehicle is to be used
	private _crackervehicle = "O_Truck_03_device_F";
	// Initialize time to hack variable
	private _hacktime = (60);//* 60 *1.5
	// Hack _range in meters. Should be more half the radius of the base manager
	private _range = 60;
	//what to tell the player if they exit the vehile
	private _failtext = "Hack Aborted, No User Input";
	player globalchat format ["Fail Text is '%1'", _failtext];
	//Establish Base Cracker Vehicle
	private _cracker = vehicle player;
	//Figure out where the Base Cracker is
	private _crackerpos = getpos _cracker;
	//Make sure the player is a passanger in the vehicle
	private _operatorcheck = _cracker getCargoIndex player;
	//Find the closest base manager
	private _manager = nearestObject [player, "Land_SatellitePhone_F"];
	//Get the position of the nearest manager
	private _managerpos = getpos _manager;
	//Get the distance to the base Manager
	private _distance = _cracker distance2D _manager;
	//Get the level of the base manager
	private _managerLevel = _manager getVariable ["ManagerLevel", 1];
	//Set time to hack based on manager level
	switch (_managerLevel) do
	{
		case (2):
		{
			_hacktime = (60 * 60 * 2);
		};
		case (3):
		{
			_hacktime = (60 * 60 * 2.5);
		};
		case (4):
		{
			_hacktime = (60 * 60 * 3);
		};
		case (5):
		{
			_hacktime = (60 * 60 * 3.5);
		};
	};
	
	//Figure out who own the base manager
	private _managerOwner = _manager getVariable "OwnerUID";
	//Get the players UID for owner check
	private _playerUID = getPlayerUID player;
	//Extablish Mutex Script no in progress
	mutexScriptInProgress = false;
// Start Hack Action
	//Make sure player is in correct vehicle type
	if (_cracker iskindof _crackervehicle) then
	{
		//Make sure player is in correct seat
		if (_operatorcheck == 0) then
		{
			//Make sure there's a base manager in _range
			if (_distance <= _range) then
			{
				if (_playerUID == _managerOwner) then
				{
					titletext ["Closest Base manager owned by operator, hack cancelled", "PLAIN DOWN"];
				} else
				{
					//Switch Mutex to true to prevent player from doing multiple actions
					mutexScriptInProgress = true;
					//Get the start time
					private _StartTime = serverTime;
					//Set Hack in progress
					HackInProgress = true;
					player globalchat format ["Fail Text is '%1'", _failtext];
					private _Hack = [_hacktime, _manager, _failtext] spawn
					{
						//gotta get the variable back
						private _hacktime = _this select 0;
						private _manager = _this select 1;
						private _failtext = _this select 2;
						player globalchat format ["Fail Text is '%1'", _failtext];
						//stuff to let the player know the hack is still working
						titletext ["Begining hack.", "PLAIN DOWN"];
						sleep (_hacktime / 10);
						//Lets get the time remaining
						if !((vehicle player) iskindof 'O_Truck_03_device_F') exitwith {titletext [format ["%1",_failtext], "PLAIN DOWN"]; HackInProgress = false};
						titletext ["Probing Firewall for weaknesses","PLAIN DOWN"];
						sleep (_hacktime / 10);
						if !((vehicle player) iskindof 'O_Truck_03_device_F') exitwith {titletext [format ["%1",_failtext], "PLAIN DOWN"]; HackInProgress = false};
						titletext ["Firewall bypassed, Second firewall encountered", "PLAIN DOWN"];
						sleep (_hacktime / 10);
						if !((vehicle player) iskindof 'O_Truck_03_device_F') exitwith {titletext [format ["%1",_failtext], "PLAIN DOWN"]; HackInProgress = false};
						titletext ["Second Firewall bypassed, Scanning system", "PLAIN DOWN"];
						sleep (_hacktime / 10);
						if !((vehicle player) iskindof 'O_Truck_03_device_F') exitwith {titletext [format ["%1",_failtext], "PLAIN DOWN"]; HackInProgress = false};
						titletext ["System Scan complete, Overwriting Security protocols", "PLAIN DOWN"];
						sleep (_hacktime / 10);
						if !((vehicle player) iskindof 'O_Truck_03_device_F') exitwith {titletext [format ["%1",_failtext], "PLAIN DOWN"]; HackInProgress = false};
						titletext ["Security Protocols overwritten, Gaining access to root files", "PLAIN DOWN"];
						sleep (_hacktime / 10);
						if !((vehicle player) iskindof 'O_Truck_03_device_F') exitwith {titletext [format ["%1",_failtext], "PLAIN DOWN"]; HackInProgress = false};
						titletext ["Scanning files for base manager controls", "PLAIN DOWN"];
						sleep (_hacktime / 10);
						if !((vehicle player) iskindof 'O_Truck_03_device_F') exitwith {titletext [format ["%1",_failtext], "PLAIN DOWN"]; HackInProgress = false};
						titletext ["Base manager control files located, Gaining Access", "PLAIN DOWN"];
						sleep (_hacktime / 10);
						if !((vehicle player) iskindof 'O_Truck_03_device_F') exitwith {titletext [format ["%1",_failtext], "PLAIN DOWN"]; HackInProgress = false};
						titletext ["Overwritting Base Manager controlls", "PLAIN DOWN"];
						sleep (_hacktime / 10);
						if !((vehicle player) iskindof 'O_Truck_03_device_F') exitwith {titletext [format ["%1",_failtext], "PLAIN DOWN"]; HackInProgress = false};
						titletext ["Base Manager control overwritting, applying changes", "PLAIN DOWN"];
						sleep (_hacktime / 10);
						if !((vehicle player) iskindof 'O_Truck_03_device_F') exitwith {titletext [format ["%1",_failtext], "PLAIN DOWN"]; HackInProgress = false};
						titletext ["Hack Successfull, password reset to 1234", "PLAIN DOWN"];
						_manager setVariable ["Password", "1234"];
						HackInProgress = false;
						mutexScriptInProgress = false;
					};
					while {HackInProgress} do
					{
						//Lets figure out how much time is left until hack completed
						private _CurrentTime = serverTime;
						private _TimeElapsed = (_CurrentTime - _StartTime);
						private _TimeRemainingTotal = (_hacktime - _TimeElapsed);
						//Lets Figure out how much time until next interval
						private _TimeInterval = (_hacktime / 10);
						private _TimeRemainingIntervalAdjust = 0;
						private _Checkpoint = floor (_TimeElapsed / _TimeInterval);
						if (_checkpoint > 0) then
						{
							_TimeRemainingIntervalAdjust = (_Checkpoint * _TimeInterval);
						};
						//Setup Countdown timers
						private _TimeRemainingInterval = (_TimeInterval - (_TimeElapsed - _TimeRemainingIntervalAdjust));
						private _TimeRemainingTotalHrs = floor (_TimeRemainingTotal / 3600);
						private _TimeRemainingTotalMins = floor ((_TimeRemainingTotal - (_TimeRemainingTotalHrs * 3600)) / 60);
						private _TimeRemainingTotalSecs = floor (_TimeRemainingTotal - (_TimeRemainingTotalHrs * 3600)- (_TimeRemainingTotalMins * 60));
						private _TimeRemainingIntervalHrs = floor (_TimeRemainingInterval / 3600);
						private _TimeRemainingIntervalMins = floor ((_TimeRemainingInterval - (_TimeRemainingIntervalHrs * 3600)) / 60);
						private _TimeRemainingIntervalSecs = floor (_TimeRemainingInterval - (_TimeRemainingIntervalHrs * 3600)- (_TimeRemainingIntervalMins * 60));
						//Set up the text
						_txt1 = format ["Hack In progress. Time Remaining: %1:%2:%3", _TimeRemainingTotalHrs, _TimeRemainingTotalMins, _TimeRemainingTotalSecs];
						_txt2 = format ["Time Remaing until Next user input required: %1:%2:%3", _TimeRemainingIntervalHrs, _TimeRemainingIntervalMins, _TimeRemainingIntervalSecs];
						_DisplayText = [_txt1, _txt2];
						player setvariable ["Hacking", _DisplayText];
					};
					player setvariable ["Hacking", ""];
				};
			// inform the player there's no base manager in _range
			} else
			{
				titletext ["No base manager in _range", "PLAIN DOWN"]
			};
		// Let the player know they're in the wrong seat
		} else
		{
			titletext ["You must be in the passanger seat to operate base hacking system", "PLAIN DOWN"];
		};
	// Let the player know they're no in the correct vehicle
	}else
	{
		titletext ["This vehicle doesn't contain base hacking systems", "PLAIN DOWN"];
	};
//makesure mutex exits if action aborted by vehicle exit and script complete
mutexScriptInProgress = false;

