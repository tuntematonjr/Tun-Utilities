/*
 * Author: [Tuntematon]
 * Removes vehicle marker draw event handlers
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call tunuti_startmarkers_fnc_deleteVehicleMarkers
 */

#include "script_component.hpp"
LOG("Runned delete vehicle markers");
{
	_x params ["_display", "_idc"];
	_display ctrlRemoveEventHandler ["Draw", _idc];
} forEach GVAR(vehicleMarkers);

GVAR(vehicleMarkers) = [];
