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
if (!isNull (uiNamespace getVariable "Tun_Briefingtime_notificationBox")) exitWith {
	GVAR(Notifications) pushBackUnique _text;
	[{isNull (uiNamespace getVariable "Tun_Briefingtime_notificationBox")}, {
		private _text = GVAR(Notifications) select 0;
		REM(GVAR(Notifications),_text);
		[_text] call FUNC(notification);
	}] call CBA_fnc_waitUntilAndExecute;
};

private _display = [53, 52] select !isNull findDisplay 52;
private _control = findDisplay _display ctrlCreate ["Tun_Briefingtime_notificationBox", 320006];
uiNamespace setVariable ["Tun_Briefingtime_notificationBox", _control ];

if (!IS_STRING(_text)) then {
	_text = str _text;
};
_control ctrlSetText _text;

[{ diag_tickTime > _this select 1 }, {
	ctrlDelete (_this select 0);
}, [_control, (diag_tickTime + 10)]] call CBA_fnc_waitUntilAndExecute;