/*
 * Author: [Tuntematon]
 * Adds a combat zone to the specified side's combat zone list
 *
 * Arguments:
 * 0: Sides <ARRAY of SIDE>
 * 1: Marker prefix <STRING>
 * 2: Marker count <NUMBER>
 *
 * Return Value:
 * Hash key <STRING>
 *
 * Example:
 * [[west, east], "marker_", 5] call tunuti_combazone_fnc_addCombatZone
 */
 
#include "script_component.hpp"
if (!isServer) exitWith {};
params [["_sides", nil, [[]]],["_markerPreFix", nil, [""]], ["_markerCount", nil, [0]], ["_resetZones", false, [false]]];

private _value = [_markerPreFix, _markerCount];

private _hashkey = hashValue _value;

if (playerSide in _sides) then {
	if (_resetZones) then {
		GVAR(combatZones) = createHashMap;
	};
	GVAR(combatZones) set [_hashkey, _value];

	[] call FUNC(updateCombatZonePolygon);
};

_hashkey
