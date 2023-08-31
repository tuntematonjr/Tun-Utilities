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
 * [] call tun_briefingtime_fnc_openTimeDialog
 */
#include "script_component.hpp"

private _display = TUN_FIND_MAPDISPLAY;
private _control = findDisplay _display createDisplay "Tun_Briefingtime_Time";
uiNamespace setVariable ["Tun_Briefingtime_Time", _control ];
[{!isNull findDisplay 320000}, {
	_sliderControl = (uiNamespace getVariable "Tun_Briefingtime_Time") displayCtrl 320003;
	_sliderControl sliderSetRange [0, 30];
	_sliderControl sliderSetSpeed [1, 1];

	private _text = ["Requesting additional time:", "Set briefing time to:"] select IS_ADMIN;
	private _value = [0, round(GVAR(value) / 60)] select IS_ADMIN;
	_sliderControl sliderSetPosition _value;
	_textControl = (uiNamespace getVariable "Tun_Briefingtime_Time") displayCtrl 320002;
	_textControl ctrlSetText (format ["%1 %2min", _text, _value]);

}] call CBA_fnc_waitUntilAndExecute;