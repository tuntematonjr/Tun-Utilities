/*
 * Author: [Tuntematon]
 * Shows a briefing time notification (queued)
 *
 * Arguments:
 * 0: Text to show <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["Hello World!"] call tunuti_briefingtime_fnc_notification
 */

#include "script_component.hpp"

params ["_text"];

//Notification queye
if (!isNull (uiNamespace getVariable QGVAR(notificationBox))) exitWith {
	GVAR(Notifications) pushBackUnique _text;

	TRACE_1("add text to queue",_text);
	[{isNull (uiNamespace getVariable QGVAR(notificationBox))}, {
		private _text = GVAR(Notifications) select 0;
		REM(GVAR(Notifications),_text);
		LOG("call next text");
		[_text] call FUNC(notification);
	}] call CBA_fnc_waitUntilAndExecute;
};
private _display = TUNUTI_FIND_MAPDISPLAY;

private _control = findDisplay _display ctrlCreate [QGVAR(notificationBox), NOTIFICATION_BOX_IDC];
uiNamespace setVariable [QGVAR(notificationBox), _control ];
LOG("create display");

if (!IS_STRING(_text)) then {
	_text = str _text;
};

TRACE_1("set text for notification", _text);
(uiNamespace getVariable QGVAR(notificationBox)) ctrlSetText _text;

[{ diag_tickTime > _this select 1 }, {
	LOG("delete display");
	ctrlDelete (_this select 0);
}, [_control, (diag_tickTime + 10)]] call CBA_fnc_waitUntilAndExecute;
