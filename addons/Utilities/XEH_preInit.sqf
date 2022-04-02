#include "script_component.hpp"
#include "XEH_prep.sqf"

[
    QGVAR(runLoadScreen), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Run load screen", "On mission start, force players to map screen, so decreasing desync"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["Tun Utilities - Utilities", "Load Screen"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    true, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(loadScreenTime), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Load screen time", "Duration for load screen (Seconds)"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["Tun Utilities - Utilities", "Load Screen"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [15, 120, 20, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    { }, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(loadScreenText), // Unique setting name. Matches resulting variable name <STRING>
    "EDITBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Load screen text", "Text shown during mission start"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["Tun Utilities - Utilities", "Load Screen"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    "Ladataan Tehtävää \n Loading mission", // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {  }, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(rulesHintEnable), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    "Enable rules hint", // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["Tun Utilities - Utilities", "Load Screen"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    true, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(rulesTitleText), // Unique setting name. Matches resulting variable name <STRING>
    "EDITBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Rules title text", "this is title for hintC, look more info in arma wiki"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["Tun Utilities - Utilities", "Load Screen"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    "The Ten Commandments", // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {  }, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(rulesMessageText), // Unique setting name. Matches resulting variable name <STRING>
    "EDITBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Rules message text", "this is message for hintC, look more info in arma wiki"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["Tun Utilities - Utilities", "Load Screen"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    '["1. Be polite, kind and consider others in all situations","2. Play fair. Don’t cheat/hack/ghost.","3. Listen to the event host and admin","4. Act according to your leaders intent","5. Do not use any enemy vehicles or equipment unless specifically instructed by the mission","6. Do not misuse markers.","7. Do not solo. Always accompany your friendly forces. If separated, find friendly forces.","8. Do not loot dead bodies for additional equipment during mission start.","9. There is picture of each sides soldier in briefing. Take good look at them in INTEL tab in briefing, to prevent Blue on Blue!!!","10. Good Luck & Have fun"]', // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    { GVAR(rulesMessageText) = call compile _this}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(enableSpectatorStats), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    "Enable spectator stats", // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["Tun Utilities - Utilities", "Spectator stats"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    true, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

