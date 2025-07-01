/*
 * Author: KoffeinFlummi. Modified by Tuntematon
 * Get the apropriate marker for a group.
 * 
 *
 * Arguments:
 * 0: Group <GROUP>
 *
 * Return Value:
 * Marker Type <STRING>
 *
 * Example:
 * [_group] call tunuti_startmarkers_fnc_squadIcon
 */
#include "script_component.hpp"

params ["_group"];

private _leader = leader _group;
private _side = side _leader;

private _groupID = groupId _group;

private _isHQ = {
	private _return = _x in _groupID;
	if (_return) exitWith {
		true
	};
	false
} forEach (GVAR(commandElementID) splitString ",");

if ( _isHQ ) exitWith {
	["n_hq", "b_hq", "o_hq"] select ((["GUER", "WEST", "EAST"] find str _side) max 0)
};  

[_group] call ace_common_fnc_getMarkerType
