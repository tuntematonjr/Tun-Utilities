#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

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
    QGVAR(enableAutoSetup),
    "CHECKBOX",
    "Enable Autosetup",
    "Tun Utilities - Radio channels",
    true,
    0,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(enableAutoSetup),
    "CHECKBOX",
    ["Enable Autosetup","While enabled, radios will be automatically set to squad and lr frequencies"],
    "Tun Utilities - Radio channels",
    true,
    0,
    {},
    false
] call CBA_Settings_fnc_init;

[
    QGVAR(commandElementID),
    "EDITBOX",
    ["Command element ID", "If this is found in names of squads, command net is automatically made. Like if name is Alpha 10, and this has 10 in it, there will be command net named ALPHA. There can be multiple, seperate by comas"],
    "Tun Utilities - Radio channels",
    "10",
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(trimNames),
    "EDITBOX",
    ["Trim auto names", "Trim net names defined in Command element ID. This will remove all these from name."],
    "Tun Utilities - Radio channels",
    "1234567890 ",
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(additional_LR_west),
    "EDITBOX",
    ["West", "Names for additional channels, seperate with comas"],
    ["Tun Utilities - Radio channels", "Custom LR channels"],
    "",
    1,
    { GVAR(additional_LR_west) = (_this splitString ",")},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(additional_LR_east),
    "EDITBOX",
    ["East", "Names for additional channels, seperate with comas"],
    ["Tun Utilities - Radio channels", "Custom LR channels"],
    "",
    1,
    { GVAR(additional_LR_east) = (_this splitString ",")},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(additional_LR_independent),
    "EDITBOX",
    ["Resistance", "Names for additional channels, seperate with comas"],
    ["Tun Utilities - Radio channels", "Custom LR channels"],
    "",
    1,
    { GVAR(additional_LR_independent) = (_this splitString ",")},
    true
] call CBA_Settings_fnc_init;

ADDON = true;