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
	[{!isNull findDisplay STARTMARKER_IDD}, {
		private _display = uiNamespace getVariable "tunuti_starmakersSettings";
		private _squadTogleButton = (_display displayCtrl SQUADMARKER_BUTTON_IDC);
		private _vehicleTogleButton = (_display displayCtrl VEHICLEMARKER_BUTTON_IDC);
		private _vehicleTextTogleButton = (_display displayCtrl VEHICLETEXT_BUTTON_IDC);
		private _vehicleOccupationTogleButton = (_display displayCtrl VEHICLOCCUPATION_BUTTON_IDC);
		private _otherTogleButton = (_display displayCtrl OTHERMARKER_BUTTON_IDC);
		private _otherTextTogleButton = (_display displayCtrl OTHERTEXT_BUTTON_IDC);
	
		_squadTogleButton cbSetChecked GVAR(squadTogle);
		_vehicleTogleButton cbSetChecked GVAR(vehicleTogle);
		_vehicleTextTogleButton cbSetChecked GVAR(vehicleTextToggle);
		_vehicleOccupationTogleButton cbSetChecked GVAR(vehicleOccupationToggle);
		_otherTogleButton cbSetChecked GVAR(otherToggle);
		_otherTextTogleButton cbSetChecked GVAR(otherTextToggle);

	}] call CBA_fnc_waitUntilAndExecute;
} else {
	[] call FUNC(createSquadMarkers);
	[] call FUNC(createVehicleMarkers);
	[] call FUNC(createOthereMarkers);
};
