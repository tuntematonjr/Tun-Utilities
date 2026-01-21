#include "script_component.hpp"

if (GVAR(enableCombatZone)) then {
    ["CBA_loadingScreenDone", {
        LOG("CombatZone received loading screen done event");
        [] call FUNC(updateCombatZonePolygon);
        if (!GVAR(combatZoneRunning) && values GVAR(combatZones) isNotEqualTo []) then {
            GVAR(combatZoneRunning) = true;
            [] call FUNC(startCombatZone);
            LOG("CombatZone enforcement started");
        };
    }] call CBA_fnc_addEventHandler;
};
