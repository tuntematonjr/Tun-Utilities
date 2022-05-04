#include "script_component.hpp"

if (GVAR(enable) && isMultiplayer) then {
    if (isServer) then {
        [{ !isNil "TFAR_defaultFrequencies_sr_west" && !isNil "TFAR_defaultFrequencies_sr_east" && !isNil "TFAR_defaultFrequencies_sr_independent" &&  !isNil "TFAR_defaultFrequencies_lr_west" && !isNil "TFAR_defaultFrequencies_lr_east" && !isNil "TFAR_defaultFrequencies_lr_independent" && diag_tickTime > _this }, {
            [] call FUNC(serverInit);
        }, (diag_tickTime + 10)] call CBA_fnc_waitUntilAndExecute;
    };

    if (hasInterface) then {
        ISNILS(GVAR(serverDone),false);
        [{ GVAR(serverDone) && !isNull player }, {
            [] call FUNC(playerInit);
        }] call CBA_fnc_waitUntilAndExecute;
    };
};