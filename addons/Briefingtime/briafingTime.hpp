//Exported via Arma Dialog Creator (https://github.com/kayler-renslow/arma-dialog-creator)

class  RscButton;
class  RscText;
class  RscXSliderH;

#include "\a3\3DEN\UI\macros.inc"
#include "\a3\ui_f\hpp\definecommon.inc"
//#include "\a3\ui_f\hpp\definedikcodes.inc"
#include "\a3\ui_f\hpp\definecommoncolors.inc"
#include "\a3\ui_f\hpp\definecommongrids.inc"
//#include "\a3\ui_f\hpp\defineresincl.inc"

//#include "script_component.hpp"

class Tun_Briefingtime_timeText : RscText
{
	type = 0;
	idc = 320001;
	x = safeZoneX + safeZoneW * 0.403125;
	y = safeZoneY + safeZoneH * 0.00462963;
	w = safeZoneW * 0.2625;
	h = safeZoneH * 0.025;
	style = 0;
};

class Tun_Briefingtime_notificationBox : RscText
{
    type = 0;
    idc = 320006;
    x = safeZoneX + safeZoneW * 0.403125;
    y = safeZoneY + safeZoneH * 0.10462963;
    w = safeZoneW * 0.2625;
    h = safeZoneH * 0.125;
    style = 2+16;
	sizeEx = GUI_TEXT_SIZE_LARGE;
};

class Tun_Briefingtime_Time
{
	idd = 320000;
	class ControlsBackground
	{
		class Tun_Briefingtime_backgreound : RscText
		{
			type = 0;
			idc = 320000;
			x = safeZoneX + safeZoneW * 0.4140625;
			y = safeZoneY + safeZoneH * 0.43425926;
			w = safeZoneW * 0.171875;
			h = safeZoneH * 0.12222223;
			style = 0;	
			colorBackground[] = {0.2, 0.2, 0.2, 0.75};			
		};
		
	};
	class Controls
	{

		class Tun_Briefingtime_time_slider : RscXSliderH
		{
			type = 43;
			idc = 320003;
			x = safeZoneX + safeZoneW * 0.41875;
			y = safeZoneY + safeZoneH * 0.475;
			w = safeZoneW * 0.1625;
			h = safeZoneH * 0.02962963;
			style = 1024;
			onSliderPosChanged = " params ['_control', '_newValue']; [_control,_newValue] call Tun_Briefingtime_fnc_SliderPosUpdated";
			
		};
		class Tun_Briefingtime_slider_time_text : RscText
		{
			type = 0;
			idc = 320002;
			x = safeZoneX + safeZoneW * 0.41875;
			y = safeZoneY + safeZoneH * 0.44351852;
			w = safeZoneW * 0.1625;
			h = safeZoneH * 0.025;
			style = 2;
			text = "test";
			colorBackground[] = {COLOR_ACTIVE_RGBA};
			
		};
		class Tun_Briefingtime_slider_ok : RscButton
		{
			type = 1;
			idc = 320004;
			x = safeZoneX + safeZoneW * 0.54375;
			y = safeZoneY + safeZoneH * 0.525;
			w = safeZoneW * 0.0375;
			h = safeZoneH * 0.025;
			style = 0;
			text = "Ok";
			onMouseButtonClick = "(uiNamespace getVariable 'Tun_Briefingtime_Time') closeDisplay 1; [] call Tun_Briefingtime_fnc_onCloseDisplay";
			
		};
		class Tun_Briefingtime_slider_cancel : RscButton
		{
			type = 1;
			idc = 320005;
			x = safeZoneX + safeZoneW * 0.41875;
			y = safeZoneY + safeZoneH * 0.525;
			w = safeZoneW * 0.0375;
			h = safeZoneH * 0.025;
			style = 0;
			text = "Cancel";
			onMouseButtonClick = "(uiNamespace getVariable 'Tun_Briefingtime_Time') closeDisplay 0;";
		};
		
	};
	
};
