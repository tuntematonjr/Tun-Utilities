#include "script_component.hpp"
#include "XEH_prep.sqf"

[
    QGVAR(enable), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    "Enable radiochannels", // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    "Tun Utilities - Radio channels", // Category for the settings menu + optional sub-category <STRING, ARRAY>
    true, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(enableAutoSetup), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Enable Autosetup","While enabled, radios will be automatically set to squad and lr frequencies"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    "Tun Utilities - Radio channels", // Category for the settings menu + optional sub-category <STRING, ARRAY>
    true, // Extra properties of the setting depending of _settingType.
    0, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    false //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(commandElementID), // Unique setting name. Matches resulting variable name <STRING>
    "EDITBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Command element ID", "If this is found in names of squads, command net is automatically made. Like if name is Alpha 10, and this has 10 in it, there will be command net named ALPHA. There can be multiple, seperate by comas"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    "Tun Utilities - Radio channels", // Category for the settings menu + optional sub-category <STRING, ARRAY>
    "10", // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(trimNames), // Unique setting name. Matches resulting variable name <STRING>
    "EDITBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Trim auto names", "Trim net names defined in Command element ID. This will remove all these from name."], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    "Tun Utilities - Radio channels", // Category for the settings menu + optional sub-category <STRING, ARRAY>
    "1234567890 ", // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(additional_LR_west), // Unique setting name. Matches resulting variable name <STRING>
    "EDITBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["West", "Names for additional channels, seperate with comas"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["Tun Utilities - Radio channels", "Custom LR channels"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    "", // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    { GVAR(additional_LR_west) = (_this splitString ",")}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(additional_LR_east), // Unique setting name. Matches resulting variable name <STRING>
    "EDITBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["East", "Names for additional channels, seperate with comas"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["Tun Utilities - Radio channels", "Custom LR channels"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    "", // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    { GVAR(additional_LR_east) = (_this splitString ",")}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(additional_LR_independent), // Unique setting name. Matches resulting variable name <STRING>
    "EDITBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Resistance", "Names for additional channels, seperate with comas"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["Tun Utilities - Radio channels", "Custom LR channels"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    "", // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    { GVAR(additional_LR_independent) = (_this splitString ",")}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;