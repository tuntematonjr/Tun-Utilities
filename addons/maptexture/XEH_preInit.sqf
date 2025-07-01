#include "script_component.hpp"
ADDON = false;

[
	QGVAR(toggleMapTexture),
	"CHECKBOX",
	["Toggle map texture", "When true, map will load colored map initially, false is black and white"],
	["Tun Utilities - Map texture", "Map texture"],
	false,
	2,
	{},
	false
] call CBA_fnc_addSetting;

ADDON = true;
