#include "script_component.hpp"

if (GVAR(enableCombazone)) then {
    ["CBA_loadingScreenDone", {
        LOG("Combazone received loading screen done event");
        [] call FUNC(updateCombatZonePolygon);
        if !(GVAR(combatZoneRunning)) then {
            GVAR(combatZoneRunning) = true;
            [] call FUNC(startCombatZone);
            LOG("Combazone enforcement started");
        };
    }] call CBA_fnc_addEventHandler;
};
