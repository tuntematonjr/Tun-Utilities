#include "script_component.hpp"

if (isMultiplayer) then {
    [{ ADDON && !isnil "cba_missiontime" }, {
        if (GVAR(enable)) then {

            _handle = [{
                if (GVAR(value) > 0) then {
                    DEC(GVAR(value));
                    publicVariable QGVAR(value);
                };

                if (cba_missiontime > 0) then {
                    [_handle] call CBA_fnc_removePerFrameHandler;
                };
            }, 1, []] call CBA_fnc_addPerFrameHandler;
        };
    }] call CBA_fnc_waitUntilAndExecute;
};