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
 * [false] call tunuti_planningmode_fnc_updateChat
 */
#include "script_component.hpp"
params ["_enable"];

if (isDedicated) exitWith {LOG("Is Dedicated");};

1 enableChannel [false, _enable];

//Update SWT if using it.
if (isClass(configFile >> "CfgPatch" >> "swt_markers") ) then {
	[[[1, localize "str_channel_side"], [2, localize "str_channel_command"], [3, localize "str_channel_group"], [4, localize "str_channel_vehicle"], [5, localize "str_channel_direct"]]] call swt_markers_updateAvailableChannels;
};