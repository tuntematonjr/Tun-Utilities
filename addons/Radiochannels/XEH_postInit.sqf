#include "script_component.hpp"

if (GVAR(enable)) then {
    if (isServer) then {
        [{ !isNil "TFAR_defaultFrequencies_sr_west" && !isNil "TFAR_defaultFrequencies_sr_east" && !isNil "TFAR_defaultFrequencies_sr_independent" &&  !isNil "TFAR_defaultFrequencies_lr_west" && !isNil "TFAR_defaultFrequencies_lr_east" && !isNil "TFAR_defaultFrequencies_lr_independent" }, {
            [] call FUNC(serverInit);
        }] call CBA_fnc_waitUntilAndExecute;
    };

    if (hasInterface) then {
        ISNILS(GVAR(serverDone),false);
        [{ GVAR(serverDone) && !isNull player }, {
            [] call FUNC(playerInit);
        }] call CBA_fnc_waitUntilAndExecute;
    };
};