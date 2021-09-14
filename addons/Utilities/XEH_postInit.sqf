#include "script_component.hpp"

if (hasInterface) then {
	[] call FUNC(initSpectatorStats);

	[{ !isNil QGVAR(runLoadScreen) }, {
		[] call FUNC(loadScreen);
	}] call CBA_fnc_waitUntilAndExecute;
};

if (isServer) then {
	private _units = ([switchableUnits, playableUnits] select isMultiplayer);
	GVAR(spectatorInitCountWest) = west countSide _units;
	GVAR(spectatorInitCountEast) = east countSide _units;
	GVAR(spectatorInitCountIndependent) = independent countSide _units;

	publicVariable QGVAR(spectatorInitCountWest);
	publicVariable QGVAR(spectatorInitCountEast);
	publicVariable QGVAR(spectatorInitCountIndependent);
};