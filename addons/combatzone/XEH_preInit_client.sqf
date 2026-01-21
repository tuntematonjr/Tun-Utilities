#include "script_component.hpp"

GVAR(combatZones) = createHashMap;
GVAR(combatZonesMarkers) = createHashMap;
GVAR(ctrlEH_IDs) = [];
GVAR(combatZoneRunning) = false;
GVAR(disableCombatZone) = false;
