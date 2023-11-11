#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

[
    QGVAR(sideChatIsDisabledDefault),
    "CHECKBOX",
    "Check if sidechat is disabled during mission by default",
    ["Tun Utilities - Utilities", "Planning Mode"],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

ADDON = true;