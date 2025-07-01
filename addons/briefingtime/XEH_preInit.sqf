#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_prep.hpp"
PREP_RECOMPILE_END;

[
	QGVAR(enable), // Unique setting name. Matches resulting variable name <STRING>
	"CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
	"Enable Briefingtime", // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
	"Tun Utilities - Briefingtime", // Category for the settings menu + optional sub-category <STRING, ARRAY>
	true, // Extra properties of the setting depending of _settingType.
	1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
	{}, // Script to execute when setting is changed. (optional) <CODE>
	true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;

[
	QGVAR(valueSettings),
	"TIME",
	["Briefingtime", "How much there is briefing time at start"],
	"Tun Utilities - Briefingtime",
	[0, 60, 17*60, 0],
	1,
	{
		params ["_value"];
		GVAR(briefingTime) = round _value;
	},
	true
] call CBA_fnc_addSetting;

ADDON = true;
