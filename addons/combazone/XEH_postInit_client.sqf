#include "script_component.hpp"

["CBA_loadingScreenDone", {
    [] call FUNC(updateCombatZonePolygon);
    if (GVAR(combatZoneRunning)) then {
        GVAR(combatZoneRunning) = true;
        [] call FUNC(startCombatZone);
    };
}] call CBA_fnc_addEventHandler;
