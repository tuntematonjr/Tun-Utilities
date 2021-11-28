#include "script_component.hpp"

GVAR(squadMarkers) = [];
GVAR(vehicleMarkers) = [];

[{!isNil QGVAR(enable)}, {
    if (GVAR(enable)) then {
        if (isServer) then {
            [] call FUNC(serverInit);
        };

        if (hasInterface) then {
            ISNILS(GVAR(serverDone),false);
            [{GVAR(serverDone) && !isNull player}, {
                [] call FUNC(playerInit);
            }] call CBA_fnc_waitUntilAndExecute;
        };
    };
}] call CBA_fnc_waitUntilAndExecute;