#include "script_component.hpp"
#include "XEH_prep.sqf"

[
    QGVAR(enable), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Enable startmakers", "Enable whole system"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    "Tun Utilities - Startmakers & BFT", // Category for the settings menu + optional sub-category <STRING, ARRAY>
    true, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(showAI), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Add tag if vehicle crew or squad is AI", "Add tag for squad where is only AI units and vehicles which crew is only AI."], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    "Tun Utilities - Startmakers & BFT", // Category for the settings menu + optional sub-category <STRING, ARRAY>
    true, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(prepTime), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Preparation time (minutes)", "After this time is passed, all markers are auto hidden. You can bring them up again through the settings menu."], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["Tun Utilities - Startmakers & BFT","Startposition"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [1, 60, 15, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    { GVAR(prepTime) = (["Afi_safeStart_duration", _this ] call BIS_fnc_getParamValue) * 60; }, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(commandElementID), // Unique setting name. Matches resulting variable name <STRING>
    "EDITBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Command element ID", "If this is found in names of squads, squad marker will be HQ. There can be multiple, seperate by comas"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    "Tun Utilities - Startmakers & BFT", // Category for the settings menu + optional sub-category <STRING, ARRAY>
    "10", // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {  }, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

//BFT
[
    QGVAR(enableBFT), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Blue Force Tracking", "Enable BFT"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["Tun Utilities - Startmakers & BFT","BFT"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    false, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(bftAlwaysOn), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["BFT always on", "Enable BFT for everyone. No item requirements"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["Tun Utilities - Startmakers & BFT","BFT"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    false, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(addAllVehicles), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Add all vehicles", "Add all vehicles. Even if created after mission start. If vehicle side is not defined. First unit who get in vehicle will specify it."], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["Tun Utilities - Startmakers & BFT","BFT"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    false, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(updateInterval), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["BFT update interval (seconds)", "Time between updates (seconds)"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["Tun Utilities - Startmakers & BFT","BFT"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [1, 60, 5, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(bftItems), // Unique setting name. Matches resulting variable name <STRING>
    "EDITBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Required item", "List of item classnames to allow BFT. Seperate by comas"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["Tun Utilities - Startmakers & BFT","BFT"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    '"ACE_microDAGR", "ItemGPS"', // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    { GVAR(bftItems) = _this splitString """, """ }, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;