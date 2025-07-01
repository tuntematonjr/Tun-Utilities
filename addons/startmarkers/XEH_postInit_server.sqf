#include "script_component.hpp"

[{ ADDON }, {
	if (GVAR(enable)) then {
		[] call FUNC(serverInit);
	};
}] call CBA_fnc_waitUntilAndExecute;
