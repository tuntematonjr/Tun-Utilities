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
 * [] call tun_startmarkers_fnc_deleteVehicleMarkers
 */
#include "script_component.hpp"

private _display = (findDisplay TUN_FIND_MAPDISPLAY) displayCtrl 51;
{
	_display ctrlRemoveEventHandler ["Draw", _x];
} forEach GVAR(vehicleMarkers);

GVAR(vehicleMarkers) = [];