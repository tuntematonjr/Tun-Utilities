#include "script_component.hpp"
ADDON = false;

[
	QGVAR(enableServerInfo), // Unique setting name. Matches resulting variable name <STRING>
	"CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
	["Enable server info", "Enable briefing tab where server info like max ping etc. is shown"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
	["Tun Utilities - Server info", "Server info"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
	true, // Extra properties of the setting depending of _settingType.
	1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
	{}, // Script to execute when setting is changed. (optional) <CODE>
	true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;

ADDON = true;
