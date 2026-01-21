#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_prep.hpp"
PREP_RECOMPILE_END;

[
	QGVAR(enableCombazone),
	"CHECKBOX",
	["Enable Combazone", "Enable or disable the combazone functionality."],
	"Tun Utilities - Combazone",
	true,
	1,
	{},
	true
] call CBA_fnc_addSetting;

[
	QGVAR(updateInterval),
	"TIME",
	["Combazone check interval", "Interval in seconds between combazone checks."],
	"Tun Utilities - Combazone",
	[0, 60, 10, 0],
	1,
	{
		params ["_value"];
		GVAR(updateInterval) = round _value;
	},
	true
] call CBA_fnc_addSetting;

[
	QGVAR(hintText),
	"EDITBOX",
	["Combazone hint text", "Text displayed when player is outside combat zone."],
	"Tun Utilities - Combazone",
	"You are outside of the combat zone! Return immediately!",
	1,
	{},
	true
] call CBA_fnc_addSetting;

[
	QGVAR(enableVoiceEffect),
	"CHECKBOX",
	["Combazone voice effect", "Enable voice warning when player is outside combat zone heard by everyone nearby."],
	"Tun Utilities - Combazone",
	true,
	1,
	{},
	true
] call CBA_fnc_addSetting;

ADDON = true;
