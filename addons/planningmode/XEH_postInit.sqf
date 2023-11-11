#include "script_component.hpp"

["planningmode", {
	remoteExecCall [QFUNC(planningModeServer), 2];
}, "admin"] call CBA_fnc_registerChatCommand;