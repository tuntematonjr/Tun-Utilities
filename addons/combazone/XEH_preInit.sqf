#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_prep.hpp"
PREP_RECOMPILE_END;

[
	QGVAR(runLoadScreen), // Unique setting name. Matches resulting variable name <STRING>
	"CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
	["Run load screen", "On mission start, force players to map screen, so decreasing desync"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
	["Tun Utilities - Utilities", "Load Screen"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
	true, // Extra properties of the setting depending of _settingType.
	1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
	{}, // Script to execute when setting is changed. (optional) <CODE>
	true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;

[
	QGVAR(updateInterval),
	"SLIDER",
	["Combazone check interval", "Interval in seconds between combazone checks."],
	"Tun Utilities - Combazone",
	[1, 10, 60],
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
