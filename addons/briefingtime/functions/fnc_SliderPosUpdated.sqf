/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: UI Control <CONTROL>
 * 1: New Time <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [slider, 15] call tunuti_briefingtime_fnc_SliderPosUpdated
 */
#include "script_component.hpp"
params ["_control", "_newValue"];

private _text = ["Requesting additional time:", "Set briefing time to:"] select IS_ADMIN;
private _textControl = (uiNamespace getVariable QGVAR(Time)) displayCtrl SLIDER_TEXT_IDC;
private _roundValue = round _newValue;
//_control sliderSetPosition _roundValue;
_textControl ctrlSetText (format ["%1 %2min", _text, _roundValue]);