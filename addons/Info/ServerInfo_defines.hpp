   class w_RscControlsgroup  
     {
     	type = CT_CONTROLS_GROUP;
     	idc = -1;
     	style = 528;
     	x = (safeZoneX + (SafezoneW * 0.0163));
     	y = (safeZoneY + (SafezoneH * 0.132));   
     	w = (SafezoneW  * 0.31);                 
     	h = (SafezoneH  * 0.752);             
     	
     	class VScrollbar 
     	{
     		color[] = {0.5, 0.5, 0.5, 1};
     		width = 0.0090;
     		autoScrollSpeed = -1;
     		autoScrollDelay = 0;
     		autoScrollRewind = 0;
		     arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow 
		     arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on 
		     border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa"; // Slider background (stretched vertically) 
		     thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa"; // Dragging element (stretched vertically) 
     	};
     	
     	class HScrollbar 
     	{
     		color[] = {1, 1, 1, 1};
     		height = 0.028;
    		autoScrollSpeed = -1;
     		autoScrollDelay = 0;
     		autoScrollRewind = 0;
		     arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow 
		     arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on 
		     border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa"; // Slider background (stretched vertically) 
		     thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa"; // Dragging element (stretched vertically) 			
     	};
     	
     	class ScrollBar
     	{
     		color[] = {1,1,1,0.6};
     		colorActive[] = {1,1,1,1};
     		colorDisabled[] = {1,1,1,0.3};
		     arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow 
		     arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on 
		     border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa"; // Slider background (stretched vertically) 
		     thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa"; // Dragging element (stretched vertically) 
     	};
     	
     	class Controls {};
     };