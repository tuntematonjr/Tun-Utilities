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
 * [] call tunuti_startmarkers_fnc_deleteVehicleMarkers
 */
#include "script_component.hpp"

{
	_x params ["_display", "_idc"];
	_display ctrlRemoveEventHandler ["Draw", _idc];
} forEach GVAR(vehicleMarkers);

GVAR(vehicleMarkers) = [];