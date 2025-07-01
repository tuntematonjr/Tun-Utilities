#include "script_component.hpp"

if (!GVAR(toggleMapTexture)) then {
	[{ !isNull player && ( !isNull findDisplay 52 || !isNull findDisplay 53 || !isNull findDisplay 12 || !isNull findDisplay 37 )}, {
		ctrlActivate (findDisplay (TUNUTI_FIND_MAPDISPLAY) displayCtrl 107);
	}] call CBA_fnc_waitUntilAndExecute;
};
