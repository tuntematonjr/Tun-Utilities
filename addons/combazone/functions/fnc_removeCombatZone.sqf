/*
 * Author: Tuntematon
 * Removes a combat zone by hash key
 *
 * Arguments:
 * 0: Hash key <STRING>
 *
 * Return Value:
 * Boolean - true if the zone existed and was removed
 *
 * Example:
 * ["123456"] call tunuti_combazone_fnc_removeCombatZone
 */
 
#include "script_component.hpp"
if (!isServer) exitWith {false};
params [["_hashKey", "", [""]]];

private _removedValue = GVAR(combatZones) deleteAt _hashKey;
private _removed = !isNil { _removedValue };

if (_removed) then {
	[] call FUNC(updateCombatZonePolygon);
};

_removed
