#include "script_component.hpp"

#undef PREP
#define PREP(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction;

PREP(openTimeDialog);
PREP(SliderPosUpdated);
PREP(onCloseDisplay);
PREP(notification);