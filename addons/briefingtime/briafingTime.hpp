//Exported via Arma Dialog Creator (https://github.com/kayler-renslow/arma-dialog-creator)

class GVAR(timeText) : RscText
{
	type = 0;
	idc = TIME_TEXT_IDC;
	x = "safeZoneX + safeZoneW * 0.403125";
	y = "safeZoneY + safeZoneH * 0.00462963";
	w = "safeZoneW * 0.2625";
	h = "safeZoneH * 0.025";
	style = 0;
};

class GVAR(notificationBox) : GVAR(timeText)
{
    type = 0;
    idc = NOTIFICATION_BOX_IDC;
    y = "safeZoneY + safeZoneH * 0.10462963";
    h = "safeZoneH * 0.125";
    style = 2+16;
	sizeEx = QUOTE(GUI_TEXT_SIZE_MEDIUM);
};

class GVAR(Time)
{
	idd = TIME_IDD;
	class ControlsBackground
	{
		class GVAR(background) : RscText
		{
			type = 0;
			idc = BACKGROUND_IDC;
			x = "safeZoneX + safeZoneW * 0.4140625";
			y = "safeZoneY + safeZoneH * 0.43425926";
			w = "safeZoneW * 0.171875";
			h = "safeZoneH * 0.12222223";
			style = 0;	
			colorBackground[] = GUI_BCG_MENU;			
		};
		
	};
	class Controls
	{

		class GVAR(timeSlider) : RscXSliderH
		{
			type = 43;
			idc = SLIDER_IDC;
			x = "safeZoneX + safeZoneW * 0.41875";
			y = "safeZoneY + safeZoneH * 0.475";
			w = "safeZoneW * 0.1625";
			h = "safeZoneH * 0.02962963";
			style = 1024;
			onSliderPosChanged = QUOTE(LINKFUNC(SliderPosUpdated)); 
			sliderStep = 1;
		};

		class GVAR(sliderTimeText) : RscText
		{
			type = 0;
			idc = SLIDER_TEXT_IDC;
			x = "safeZoneX + safeZoneW * 0.41875";
			y = "safeZoneY + safeZoneH * 0.44351852";
			w = "safeZoneW * 0.1625";
			h = "safeZoneH * 0.025";
			style = 2;
			text = "test";
			colorBackground[] = GUI_BCG_COLOR;	
		};

		class GVAR(sliderOk) : RscButton
		{
			type = 1;
			idc = SLIDER_OK_IDC;
			x = "safeZoneX + safeZoneW * 0.54375";
			y = "safeZoneY + safeZoneH * 0.525";
			w = "safeZoneW * 0.0375";
			h = "safeZoneH * 0.025";
			style = 0;
			text = "Ok";
			onMouseButtonClick = QUOTE((uiNamespace getVariable QQGVAR(Time)) closeDisplay 1; [] call FUNC(onCloseDisplay));
		};

		class GVAR(sliderCancel) : GVAR(sliderOk)
		{
			idc = SLIDER_CANCEL_IDC;
			x = "safeZoneX + safeZoneW * 0.41875";
			text = "Cancel";
			onMouseButtonClick = QUOTE(ctrlParent (_this select 0) closeDisplay 1);
		};
	};
};