/*
 * Author: [Tuntematon]
 * Enables or disables side chat for the player
 *
 * Arguments:
 * 0: Toggle enable/disable <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [false] call tunuti_planningmode_fnc_updateChat
 */

#include "script_component.hpp"
params ["_enable"];

if (isDedicated) exitWith {LOG("Not Dedicated");};

1 enableChannel [false, _enable];

//Update SWT if using it.
if (isClass(configFile >> "CfgPatch" >> "swt_markers") ) then {
	[[[1, localize "str_channel_side"], [2, localize "str_channel_command"], [3, localize "str_channel_group"], [4, localize "str_channel_vehicle"], [5, localize "str_channel_direct"]]] call swt_markers_updateAvailableChannels;
};
