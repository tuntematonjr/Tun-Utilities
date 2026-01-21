#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_prep.hpp"
PREP_RECOMPILE_END;

[
	QGVAR(enableCombatZone),
	"CHECKBOX",
	["Enable CombatZone", "Enable or disable the combatZone functionality."],
	"Tun Utilities - CombatZone",
	true,
	1,
	{},
	true
] call CBA_fnc_addSetting;

[
	QGVAR(updateInterval),
	"TIME",
	["CombatZone check interval", "Interval in seconds between combatZone checks."],
	"Tun Utilities - CombatZone",
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
	["CombatZone hint text", "Text displayed when player is outside combat zone."],
	"Tun Utilities - CombatZone",
	"You are outside of the combat zone! Return immediately!",
	1,
	{},
	true
] call CBA_fnc_addSetting;

[
	QGVAR(enableVoiceEffect),
	"CHECKBOX",
	["CombatZone voice effect", "Enable voice warning when player is outside combat zone heard by everyone nearby."],
	"Tun Utilities - CombatZone",
	true,
	1,
	{},
	true
] call CBA_fnc_addSetting;

ADDON = true;
