#include "script_component.hpp"

if (hasInterface) then {
	[] call FUNC(initSpectatorStats);

	[{ !isNil QGVAR(runLoadScreen) }, {
		[] call FUNC(loadScreen);
	}] call CBA_fnc_waitUntilAndExecute;
};

