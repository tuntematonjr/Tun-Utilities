/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: Text to show <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["Hello World!"] call tun_briefingtime_fnc_notification
 */
#include "script_component.hpp"

params ["_text"];

//Notification queye
if (!isNull (uiNamespace getVariable QGVAR(notificationBox))) exitWith {
	GVAR(Notifications) pushBackUnique _text;
	private _debugText = format ["add text to queue: %1", _text];
	LOG(_debugText);
	[{isNull (uiNamespace getVariable QGVAR(notificationBox))}, {
		private _text = GVAR(Notifications) select 0;
		REM(GVAR(Notifications),_text);
		LOG("call next text");
		[_text] call FUNC(notification);
	}] call CBA_fnc_waitUntilAndExecute;
};
private _display = [53, 52] select !isNull findDisplay 52;

private _control = findDisplay _display ctrlCreate [QGVAR(notificationBox), 320006];
uiNamespace setVariable [QGVAR(notificationBox), _control ];
LOG("create display");

if (!IS_STRING(_text)) then {
	_text = str _text;
};

private _debugText = format ["set text for notification: %1", _text];
LOG(_debugText);
(uiNamespace getVariable QGVAR(notificationBox)) ctrlSetText _text;

[{ diag_tickTime > _this select 1 }, {
	LOG("delete display");
	ctrlDelete (_this select 0);
}, [_control, (diag_tickTime + 10)]] call CBA_fnc_waitUntilAndExecute;