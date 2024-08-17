//Exported via Arma Dialog Creator (https://github.com/kayler-renslow/arma-dialog-creator)

class GVAR(spectatorStatsWest) : RscText
{
	type = 0;
	idc = -1;
	x = "safeZoneX + safeZoneW * 0.79010417";
	y = "safeZoneY + safeZoneH * 0.025";
	w = "safeZoneW * 0.08489584";
	h = "safeZoneH * 0.15";
	colorBackground[] = {0,0,0,0};
	style = 0+16;
	colorText[] = {0,0.3,0.6,1};
	shadow = 0;
	//sizeEx = GUI_TEXT_SIZE_SMALL;
};

class GVAR(spectatorStatsResistance : GVAR(spectatorStatsWest)
{
	colorText[] = {0,0.5,0,1};
	x = "safeZoneX + safeZoneW * 0.70104167";
};

class GVAR(spectatorStatsEast) : GVAR(spectatorStatsWest)
{
	colorText[] = {0.5,0,0,1};
	x = "safeZoneX + safeZoneW * 0.61197917";
};