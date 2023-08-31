
class GVAR(biggerPictureInBriefingUI)
{
	idd = 330000;
	class ControlsBackground
	{
		class GVAR(BiggerPictureBackground): RscText
		{
			x = 0.175156 * safezoneW + safezoneX;
			y = 0.148 * safezoneH + safezoneY;
			w = 0.665156 * safezoneW;
			h = 0.704 * safezoneH;
			style = 0;	
			colorBackground[] = {0.2, 0.2, 0.2, 0.75};
		};
	};

	class Controls
	{
		class GVAR(biggerPictureImage) : RscPictureKeepAspect
		{
			idc = 330001;
			x = 0.175156 * safezoneW + safezoneX;
			y = 0.148 * safezoneH + safezoneY;
			w = 0.665156 * safezoneW;
			h = 0.704 * safezoneH;
			text = "";
		};

		class GVAR(exitButton) : RscButton
		{
			idc = 330002;
			x = 0.783593 * safezoneW + safezoneX;
			y = 0.148 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.044 * safezoneH;
			//style = 0+2;
			text = "Close";
			onMouseButtonClick = QUOTE(ctrlParent (_this select 0) closeDisplay 1);
		};
	};
}; 