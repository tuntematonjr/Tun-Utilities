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
 * [] call tun_startmarkers_fnc_deleteSquadMarkers
 */
#include "script_component.hpp"

LOG("Deleted all squad markers");

{
	deleteMarkerLocal _x;
} forEach GVAR(squadMarkers);

GVAR(squadMarkers) = [];