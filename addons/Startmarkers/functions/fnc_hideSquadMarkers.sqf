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
 * [] call tun_startmarkers_fnc_hideSquadMarkers
 */
#include "script_component.hpp"
params ["_hide"];

_hide = [1,0] select _hide;
{
	_x setMarkerAlphaLocal _hide;
} forEach GVAR(squadMarkers);
GVAR(squadMarkers) = [];