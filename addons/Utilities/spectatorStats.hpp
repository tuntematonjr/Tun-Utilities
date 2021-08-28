//Exported via Arma Dialog Creator (https://github.com/kayler-renslow/arma-dialog-creator)

class  RscButton;
class  RscText;
class  RscXSliderH;

#include "\a3\3DEN\UI\macros.inc"
//#include "\a3\3DEN\UI\macroexecs.inc"
#include "\a3\ui_f\hpp\definedikcodes.inc"
#include "\a3\ui_f\hpp\definecommoncolors.inc"
#include "\a3\ui_f\hpp\definecommongrids.inc"
#include "\a3\ui_f\hpp\defineresincl.inc"

//#include "script_component.hpp"

class tun_utilities_spectatorStatsWest : RscText
{
	type = 0;
	idc = -1;
	x = safeZoneX + safeZoneW * 0.79010417;
	y = safeZoneY + safeZoneH * 0.025;
	w = safeZoneW * 0.08489584;
	h = safeZoneH * 0.15;
	colorBackground[] = {0,0,0,0};
	style = 0+16;
	colorText[] = {0,0.3,0.6,1};
	shadow = 0;
	//sizeEx = GUI_TEXT_SIZE_SMALL;
};

class tun_utilities_spectatorStatsIndependent : tun_utilities_spectatorStatsWest
{
	colorText[] = {0,0.5,0,1};
	x = safeZoneX + safeZoneW * 0.70104167;
};

class tun_utilities_spectatorStatsEast : tun_utilities_spectatorStatsWest
{
	colorText[] = {0.5,0,0,1};
	x = safeZoneX + safeZoneW * 0.61197917;
};