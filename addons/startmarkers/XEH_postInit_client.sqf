#include "script_component.hpp"

[{ ADDON }, {
	if (GVAR(enable)) then {

		//Wait server to gather first data
		ISNILS(GVAR(serverDone),false);
		[{GVAR(serverDone) && !isNull player}, {
			[] call FUNC(playerInit);
		}] call CBA_fnc_waitUntilAndExecute;
	};
}] call CBA_fnc_waitUntilAndExecute;