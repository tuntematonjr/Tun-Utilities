//Exported via Arma Dialog Creator (https://github.com/kayler-renslow/arma-dialog-creator)

class	RscButton;
class	RscText;
class	RscCheckBox;

#include "\a3\3DEN\UI\macros.inc"
//#include "\a3\3DEN\UI\macroexecs.inc"
#include "\a3\ui_f\hpp\definedikcodes.inc"
#include "\a3\ui_f\hpp\definecommoncolors.inc"
#include "\a3\ui_f\hpp\definecommongrids.inc"
#include "\a3\ui_f\hpp\defineresincl.inc"

//{COLOR_ACTIVE_RGBA}

class tun_starmakersSettings
{
	idd = 321000;
	
	class ControlsBackground
	{
		class background : RscText
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.325;
			y = safeZoneY + safeZoneH * 0.325;
			w = safeZoneW * 0.35;
			h = safeZoneH * 0.3;
			style = 0;	
			colorBackground[] = {0.2, 0.2, 0.2, 0.75};
			onDestroy = "[false] call tun_startmarkers_fnc_settingsDisplay;";
		};
		
	};
	class Controls
	{
		class toggle_squadMarkersText : RscText
		{
			x = safeZoneX + safeZoneW * 0.35;
			y = safeZoneY + safeZoneH * 0.425;
			w = safeZoneW * 0.125;
			h = safeZoneH * 0.025;
			text = "Toggle squad markers";
			
		};
		class toggle_vehicleMarkersText : toggle_squadMarkersText
		{
			idc = -1;
			y = safeZoneY + safeZoneH * 0.475;
			text = "Toggle vehicle markers";
			
		};
		class toggle_textTovehiclesText : toggle_squadMarkersText
		{
			idc = -1;
			y = safeZoneY + safeZoneH * 0.525;
			text = "Toggle vehicle text";
		};
		class toggle_vehicleOccupationText : toggle_squadMarkersText
		{
			idc = -1;
			y = safeZoneY + safeZoneH * 0.575;
			text = "Toggle vehicle occupation";
			
		};
		class header : RscText
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.35;
			y = safeZoneY + safeZoneH * 0.35;
			w = safeZoneW * 0.3;
			h = safeZoneH * 0.05;
			style = 2;
			text = "Starmarker & BFT settings";
			colorBackground[] = {COLOR_ACTIVE_RGBA};
			
		};
		class toggle_squadMarkers_button : RscCheckBox
		{
			idc = 321001;
			x = safeZoneX + safeZoneW * 0.5;
			y = safeZoneY + safeZoneH * 0.425;
			w = safeZoneW * 0.015;
			h = safeZoneH * 0.025;
			onCheckedChanged = "params ['_control', '_checked']; Tun_startmarkers_squadTogle = ([false, true] select _checked);";
			
		};
		class toggle_vehicleMarkers_button : toggle_squadMarkers_button
		{
			idc = 321002;
			y = safeZoneY + safeZoneH * 0.475;	
			onCheckedChanged = "params ['_control', '_checked']; Tun_startmarkers_vehicleTogle = ([false, true] select _checked);";
		};
		class toggle_vehicleText_button : toggle_squadMarkers_button
		{
			idc = 321003;
			y = safeZoneY + safeZoneH * 0.525;
			onCheckedChanged = "params ['_control', '_checked']; Tun_startmarkers_vehicleTextToggle = ([false, true] select _checked);";

		};
		class toggle_vehicleOccupation_button : toggle_squadMarkers_button
		{
			idc = 321004;
			y = safeZoneY + safeZoneH * 0.575;	
			onCheckedChanged = "params ['_control', '_checked']; Tun_startmarkers_vehicleOccupationToggle = ([false, true] select _checked);";
		};
		class toggle_ok_button : RscButton
		{
			idc = 321005;
			x = safeZoneX + safeZoneW * 0.6;
			y = safeZoneY + safeZoneH * 0.55;
			w = safeZoneW * 0.04010417;
			h = safeZoneH * 0.05;
			style = 2;
			text = "OK";
			colorBackground[] = {COLOR_ACTIVE_RGBA};	
			onButtonClick = "(uiNamespace getVariable 'tun_starmakersSettings') closeDisplay 1;";			
		};
		
	};
	
};
