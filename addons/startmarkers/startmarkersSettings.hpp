//Exported via Arma Dialog Creator (https://github.com/kayler-renslow/arma-dialog-creator)

class tunuti_starmakersSettings
{
	idd = 321000;
	
	class ControlsBackground
	{
		class GVAR(background) : RscText
		{
			type = 0;
			idc = -1;
			x = "safeZoneX + safeZoneW * 0.325";
			y = "safeZoneY + safeZoneH * 0.325";
			w = "safeZoneW * 0.35";
			h = "safeZoneH * 0.3";
			style = 0;	
			colorBackground[] = {0.2, 0.2, 0.2, 0.75};
			onDestroy = "[false] call tunuti_startmarkers_fnc_settingsDisplay;";
		};
		
	};
	class Controls
	{
		class GVAR(toggle_squadMarkersText) : RscText
		{
			idc = -1;
			x = "safeZoneX + safeZoneW * 0.35";
			y = "safeZoneY + safeZoneH * 0.425";
			w = "safeZoneW * 0.125";
			h = "safeZoneH * 0.025";
			text = "Toggle squad markers";
			
		};
		class GVAR(toggle_vehicleMarkersText) : GVAR(toggle_squadMarkersText)
		{
			idc = -1;
			y = "safeZoneY + safeZoneH * 0.475";
			text = "Toggle vehicle markers";
			
		};
		class GVAR(toggle_textToVehiclesText) : GVAR(toggle_squadMarkersText)
		{
			idc = -1;
			y = "safeZoneY + safeZoneH * 0.525";
			text = "Toggle vehicle text";
		};
		class GVAR(toggle_vehicleOccupationText) : GVAR(toggle_squadMarkersText)
		{
			idc = -1;
			y = "safeZoneY + safeZoneH * 0.575";
			text = "Toggle vehicle occupation";
			
		};
		class GVAR(header) : RscText
		{
			idc = -1;
			x = "safeZoneX + safeZoneW * 0.35";
			y = "safeZoneY + safeZoneH * 0.35";
			w = "safeZoneW * 0.3";
			h = "safeZoneH * 0.05";
			style = 2;
			text = "Starmarker & BFT settings";
			colorBackground[] = GUI_BCG_COLOR;
			
		};
		class GVAR(toggle_squadMarkers_button) : RscCheckBox
		{
			idc = SQUADMARKER_BUTTON_IDC;
			x = "safeZoneX + safeZoneW * 0.5";
			y = "safeZoneY + safeZoneH * 0.425";
			w = "safeZoneW * 0.015";
			h = "safeZoneH * 0.025";
			onCheckedChanged = "params ['_control', '_checked']; tunuti_startmarkers_squadTogle = ([false, true] select _checked);";
			
		};
		class GVAR(toggle_vehicleMarkers_button) : GVAR(toggle_squadMarkers_button)
		{
			idc = VEHICLEMARKR_BUTTON_IDC;
			y = "safeZoneY + safeZoneH * 0.475";	
			onCheckedChanged = "params ['_control', '_checked']; tunuti_startmarkers_vehicleTogle = ([false, true] select _checked);";
		};
		class GVAR(toggle_vehicleText_button) : GVAR(toggle_squadMarkers_button)
		{
			idc = VEHICLETEXT_BUTTON_IDC;
			y = "safeZoneY + safeZoneH * 0.525";
			onCheckedChanged = "params ['_control', '_checked']; tunuti_startmarkers_vehicleTextToggle = ([false, true] select _checked);";

		};
		class GVAR(toggle_vehicleOccupation_button) : GVAR(toggle_squadMarkers_button)
		{
			idc = VEHICLOCCUPATION_BUTTON_IDC;
			y = "safeZoneY + safeZoneH * 0.575";	
			onCheckedChanged = "params ['_control', '_checked']; tunuti_startmarkers_vehicleOccupationToggle = ([false, true] select _checked);";
		};
		class GVAR(toggle_ok_button) : RscButton
		{
			idc = 321005;
			x = "safeZoneX + safeZoneW * 0.6";
			y = "safeZoneY + safeZoneH * 0.55";
			w = "safeZoneW * 0.04010417";
			h = "safeZoneH * 0.05";
			style = 2;
			text = "OK";
			colorBackground[] = GUI_BCG_COLOR;	
			onMouseButtonClick = QUOTE(ctrlParent (_this select 0) closeDisplay 1);
		};
	};
};
