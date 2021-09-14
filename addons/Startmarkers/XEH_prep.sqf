#include "script_component.hpp"

#undef PREP
#define PREP(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction

PREP(squadIcon);
PREP(createVehicleMarkers);
PREP(deleteVehicleMarkers);
PREP(hideSquadMarkers);
PREP(createSquadMarkers);
PREP(updateData);
PREP(serverInit);
PREP(playerInit);
PREP(settingsDisplay);