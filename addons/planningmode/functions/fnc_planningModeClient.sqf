/*
 * Author: [Tuntematon]
 * [Description]
 * Enables/Disables palnnig mode
 * Arguments:
 * 0: Toggle enable/disable <BOOL>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [true] call tunuti_planningmode_fnc_planningModeClient
 */
#include "script_component.hpp"
if (!hasInterface) exitWith {LOG("Not Client");};
params ["_state"];


hint format["Planning mode: %1", ["Disabled", "Enabled"] select _state];

[_state] call FUNC(losCheck);
[_state] call FUNC(teleport);

if (GVAR(sideChatIsDisabledDefault)) then { // update sidechat, if disabled by default
	[_state] call FUNC(updateChat);
};
