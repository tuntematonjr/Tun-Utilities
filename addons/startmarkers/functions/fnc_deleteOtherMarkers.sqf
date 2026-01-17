/*
 * Author: [Tuntematon]
 * Removes other marker draw event handlers
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call tunuti_startmarkers_fnc_deleteOtherMarkers
 */

#include "script_component.hpp"
LOG("Runned delete other markers");
{
	_x params ["_display", "_idc"];
	_display ctrlRemoveEventHandler ["Draw", _idc];
} forEach GVAR(otherMarkers);

GVAR(otherMarkers) = [];
