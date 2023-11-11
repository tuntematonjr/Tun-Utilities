/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: The first argument <STRING>
 * 1: The second argument <OBJECT>
 * 2: Multiple input types <STRING|ARRAY|CODE>
 * 3: Optional input <BOOL> (default: true)
 * 4: Optional input with multiple types <CODE|STRING> (default: {true})
 * 5: Not mandatory input <STRING> (default: nil)
 *
 * Return Value:
 * The return value <BOOL>
 *
 * Example:
 * ["something", player] call tunuti_planningmode_fnc_planningModeClient
 */
#include "script_component.hpp"
if (!hasInterface) exitWith {LOG("Not Client");};
params ["_state"];


hint format["Planning mode: %1", ["Disabled", "Enabled"] select _state];

[_state] call FUNC(losCheck);

if (GVAR(sideChatIsDisabledDefault)) then { // update sidechat, if disabled by default
	[_state] call FUNC(updateChat);
};