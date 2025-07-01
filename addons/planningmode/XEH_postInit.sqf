#include "script_component.hpp"

[{ADDON}, {
	if (GVAR(enable)) then {
		["planningmode", {
			remoteExecCall [QFUNC(planningModeServer), 2];
		}, "admin"] call CBA_fnc_registerChatCommand;
	};		
}] call CBA_fnc_waitUntilAndExecute;
