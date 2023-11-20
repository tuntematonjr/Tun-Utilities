
class GVAR(biggerPictureInBriefingUI)
{
	idd = 330000;
	class ControlsBackground
	{
		class GVAR(BiggerPictureBackground): RscText
		{
			x = "safeZoneW + safeZoneX * 0.175156";
			y = "safeZoneH + safeZoneY * 0.148";
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
			idc = 330001;
			x = "safeZoneW + safeZoneX * 0.175156";
			y = "safeZoneH + safeZoneY * 0.148";
			w = "safeZoneW * 0.665156";
			h = "safeZoneH * 0.704";
			text = "";
		};

		class GVAR(exitButton) : RscButton
		{
			idc = 330002;
			x = "safeZoneW + safeZoneX * 0.783593";
			y = "safeZoneH + safeZoneY * 0.148";
			w = "safeZoneW * 0.0515625";
			h = "safeZoneH * 0.044";
			//style = 0+2;
			text = "Close";
			onMouseButtonClick = QUOTE(ctrlParent (_this select 0) closeDisplay 1);
		};
	};
}; 