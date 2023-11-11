#include "script_component.hpp"

if (GVAR(enable)) then {
	ISNILS(GVAR(serverDone),false);

	[{ GVAR(serverDone) && 
	!isNull player  &&
	ADDON
	}, {
		[] call FUNC(playerInit);
	}] call CBA_fnc_waitUntilAndExecute;
};