/*
 * Author: [Tuntematon]
 * Adds a combat zone definition for the specified sides.
 *
 * Arguments:
 * 0: Sides <ARRAY of SIDE>
 * 1: Marker prefix <STRING>
 * 2: Marker count <NUMBER>
 * 3: Reset zones <BOOL> (default: false)
 *
 * Return Value:
 * Hash key <STRING>
 *
 * Example:
 * [[west, east], "marker_", 5, false] call tunuti_combazone_fnc_addCombatZone
 */

 
#include "script_component.hpp"
if (isServer && !hasInterface) exitWith {};
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
