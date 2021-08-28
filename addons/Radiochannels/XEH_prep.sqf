#include "script_component.hpp"

#undef PREP
#define PREP(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction;

PREP(setSRchannel);
PREP(setLRchannel);
PREP(setSRstereo);
PREP(setLRstereo);
PREP(clearAdditional);
PREP(createAceActions);
PREP(serverInit);
PREP(playerInit);