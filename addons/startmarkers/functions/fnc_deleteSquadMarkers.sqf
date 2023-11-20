/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call tunuti_startmarkers_fnc_deleteSquadMarkers
 */
#include "script_component.hpp"

{
	deleteMarkerLocal _x;
} forEach GVAR(squadMarkers);

GVAR(squadMarkers) = [];