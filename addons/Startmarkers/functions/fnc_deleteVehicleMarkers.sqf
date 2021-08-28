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

{
	(findDisplay GVAR(displayIDD)) displayCtrl 51 ctrlRemoveEventHandler ["Draw", _x];
} forEach GVAR(vehicleMarkers);
GVAR(vehicleMarkers) = [];