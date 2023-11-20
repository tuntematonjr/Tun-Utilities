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
 * ["something", player] call tunuti_planningmode_fnc_teleport
 */
#include "script_component.hpp"
params ["_enable"];

if (_enable) then {
	onMapSingleClick {_shift};
	GVAR(tpEH) = addMissionEventHandler ["MapSingleClick", {
		params ["_units", "_pos", "_alt", "_shift"];
		if (_alt) then {
			player setPos _pos;
		};
	}];
} else {
	onMapSingleClick "";
	removeMissionEventHandler ["MapSingleClick", GVAR(tpEH)];
};