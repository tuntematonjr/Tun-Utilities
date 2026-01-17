/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * None
 *
 * Return Value:
 * none
 *
 * Example:
 * [] call tunuti_utilities_fnc_combatZone
 */
 
#include "script_component.hpp"

[{
	if !(GVAR(disableCombazone)) then {
		[] call FUNC(combatZone);
	};
}, GVAR(updateInterval)] call CBA_fnc_addPerFrameHandler;
