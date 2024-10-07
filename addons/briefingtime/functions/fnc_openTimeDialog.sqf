/*
 * Author: [Tuntematon]
 * [Description]
 *
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call tunuti_briefingtime_fnc_openTimeDialog
 */
#include "script_component.hpp"

private _display = TUNUTI_FIND_MAPDISPLAY;
private _control = findDisplay _display createDisplay QGVAR(Time);
uiNamespace setVariable [QGVAR(Time), _control ];
[{!isNull findDisplay BACKGROUND_IDC}, {
	_sliderControl = (uiNamespace getVariable QGVAR(Time)) displayCtrl SLIDER_IDC;
	_sliderControl sliderSetRange [0, 30];
	_sliderControl sliderSetSpeed [1, 1];

	private _text = ["Requesting additional time:", "Set briefing time to:"] select IS_ADMIN;
	private _value = [0, round(GVAR(value) / 60)] select IS_ADMIN;
	_sliderControl sliderSetPosition _value;
	_textControl = (uiNamespace getVariable QGVAR(Time)) displayCtrl SLIDER_TEXT_IDC;
	_textControl ctrlSetText (format ["%1 %2min", _text, _value]);

}] call CBA_fnc_waitUntilAndExecute;