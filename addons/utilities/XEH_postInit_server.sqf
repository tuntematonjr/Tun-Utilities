#include "script_component.hpp"

private _units = ([switchableUnits, playableUnits] select isMultiplayer);
GVAR(spectatorInitCountWest) = west countSide _units;
GVAR(spectatorInitCountEast) = east countSide _units;
GVAR(spectatorInitCountIndependent) = independent countSide _units;

publicVariable QGVAR(spectatorInitCountWest);
publicVariable QGVAR(spectatorInitCountEast);
publicVariable QGVAR(spectatorInitCountIndependent);
