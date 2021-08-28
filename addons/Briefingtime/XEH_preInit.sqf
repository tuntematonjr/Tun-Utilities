#include "script_component.hpp"
#include "XEH_prep.sqf"

[
    QGVAR(enable), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    "Enable Briefingtime", // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    "Tun Utilities - Briefingtime", // Category for the settings menu + optional sub-category <STRING, ARRAY>
    true, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(value), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Briefingtime", "How much there is briefing time at start"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    "Tun Utilities - Briefingtime", // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [0, 30, 17, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {GVAR(value) = _this * 60}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;