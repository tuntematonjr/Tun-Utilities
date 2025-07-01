/*
 * Author: [Tuntematon]
 * [Description]
 * Teleport player to clicked position while holding ALT
 * Arguments:
 * 0: Toggle enable/disable <BOOL>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [true] call tunuti_planningmode_fnc_teleport
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
