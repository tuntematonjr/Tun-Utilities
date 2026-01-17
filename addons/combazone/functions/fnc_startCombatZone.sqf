/*
 * Author: [Tuntematon]
 * Starts the per-frame handler that enforces combat zone restrictions.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call tunuti_combazone_fnc_startCombatZone
 */

 
#include "script_component.hpp"
if (isServer && !hasInterface) exitWith {};

[{
	if !(GVAR(disableCombazone)) then {
		[] call FUNC(combatZone);
	};
}, GVAR(updateInterval)] call CBA_fnc_addPerFrameHandler;
