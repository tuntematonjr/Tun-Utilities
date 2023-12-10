class GVAR(biggerPictureInBriefingUI)
{
	idd = BIGGER_PICTURE_MAIN_IDD;
	onUnload = "_display closeDisplay 1;";
	class ControlsBackground
	{
		class GVAR(BiggerPictureBackground): RscText
		{
			x = "safeZoneX + safeZoneW * 0.175156";
			y = "safeZoneY + safeZoneH * 0.148";
			w = "safeZoneW * 0.665156";
			h = "safeZoneH * 0.704";
			style = 0;	
			colorBackground[] = {0.2, 0.2, 0.2, 0.75};
		};
	};

	class Controls
	{
		class GVAR(biggerPictureImage) : RscPictureKeepAspect
		{
			idc = BIGGER_PICTURE_IMAGE_IDC;
			x = "safeZoneX + safeZoneW * 0.175156";
			y = "safeZoneY + safeZoneH * 0.148";
			w = "safeZoneW * 0.665156";
			h = "safeZoneH * 0.704";
			text = "";
		};

		class GVAR(exitButton) : RscButton
		{
			idc = BIGGER_PICTURE_BUTTON_IDC;
			x = "safeZoneX + safeZoneW * 0.783593";
			y = "safeZoneY + safeZoneH * 0.148";
			w = "safeZoneW * 0.0515625";
			h = "safeZoneH * 0.044";
			//style = 0+2;
			text = "Close";
			onMouseButtonClick = QUOTE(ctrlParent (_this select 0) closeDisplay 1);
		};
	};
}; 