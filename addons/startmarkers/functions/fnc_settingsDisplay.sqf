/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: True if open GUI <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [false] call tunuti_startmarkers_fnc_settingsDisplay
 */
#include "script_component.hpp"

params ["_open"];

if (_open) then {
	private _control = findDisplay TUNUTI_FIND_MAPDISPLAY createDisplay "tunuti_starmakersSettings";
	uiNamespace setVariable ["tunuti_starmakersSettings", _control ];
	[{!isNull findDisplay 321000}, {
		private _display = uiNamespace getVariable "tunuti_starmakersSettings";
		private _squadTogleButton = (findDisplay 321000 displayCtrl 321001);
		private _vehicleTogleButton = (_display displayCtrl 321002);
		private _vehicleTextTogleButton = (_display displayCtrl 321003);
		private _vehicleOccupationTogleButton = (_display displayCtrl 321004);
	
		_squadTogleButton cbSetChecked GVAR(squadTogle);
		_vehicleTogleButton cbSetChecked GVAR(vehicleTogle);
		_vehicleTextTogleButton cbSetChecked GVAR(vehicleTextToggle);
		_vehicleOccupationTogleButton cbSetChecked GVAR(vehicleOccupationToggle);

	}] call CBA_fnc_waitUntilAndExecute;
} else {
	[] call FUNC(createSquadMarkers);
	[] call FUNC(createVehicleMarkers);
};



