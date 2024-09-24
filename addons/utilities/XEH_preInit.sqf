#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
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
    QGVAR(loadScreenTime),
    "SLIDER",
    ["Load screen time", "Duration for load screen (Seconds)"],
    ["Tun Utilities - Utilities", "Load Screen"],
    [15, 120, 20, 0],
    1,
    {
        params ["_value"];
        GVAR(loadScreenTime) = round _value;
    },
    true
] call CBA_fnc_addSetting;

[
    QGVAR(loadScreenText),
    "EDITBOX",
    ["Load screen text", "Text shown during mission start"],
    ["Tun Utilities - Utilities", "Load Screen"],
    "Ladataan Tehtävää \n Loading mission",
    1,
    {  },
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rulesHintEnable),
    "CHECKBOX",
    "Enable rules hint",
    ["Tun Utilities - Utilities", "Load Screen"],
    true,
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rulesTitleText),
    "EDITBOX",
    ["Rules title text", "this is title for hintC, look more info in arma wiki"],
    ["Tun Utilities - Utilities", "Load Screen"],
    "The Ten Commandments",
    1,
    {  },
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rulesMessageText),
    "EDITBOX",
    ["Rules message text", "this is message for hintC, look more info in arma wiki"],
    ["Tun Utilities - Utilities", "Load Screen"],
    '["1. Be polite, kind and consider others in all situations","2. Play fair. Don’t cheat/hack/ghost.","3. Listen to the event host and admin","4. Act according to your leaders intent","5. Do not use any enemy vehicles or equipment unless specifically instructed by the mission","6. Do not misuse markers.","7. Do not solo. Always accompany your friendly forces. If separated, find friendly forces.","8. Do not loot dead bodies for additional equipment during mission start.","9. There is picture of each sides soldier in briefing. Take good look at them in INTEL tab in briefing, to prevent Blue on Blue!!!","10. Good Luck & Have fun"]',
    1,
    { GVAR(rulesMessageText) = call compile _this},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(enableSpectatorStats),
    "CHECKBOX",
    "Enable spectator stats",
    ["Tun Utilities - Utilities", "Spectator stats"],
    true,
    1,
    {},
    true
] call CBA_fnc_addSetting;

ADDON = true;