#include "script_component.hpp"

if (isMultiplayer) then {
	[{ ADDON && !isNil "cba_missiontime" }, {
		if (GVAR(enable)) then {

			_handle = [{
				if (GVAR(briefingTime) > 0) then {
					DEC(GVAR(briefingTime));
					publicVariable QGVAR(briefingTime);
				};

				if (cba_missiontime > 0) then {
					[_handle] call CBA_fnc_removePerFrameHandler;
				};
			}, 1, []] call CBA_fnc_addPerFrameHandler;
		};
	}] call CBA_fnc_waitUntilAndExecute;
};
