/*
 * Author: [Tuntematon]
 * Checks if the player is inside a combat zone for their side.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * True if player is in a combat zone, false otherwise <BOOL>
 *
 * Example:
 * [] call tunuti_combatZone_fnc_combatZoneCheck
 */

 
#include "script_component.hpp"
if (isServer && !hasInterface) exitWith {};

private _polygons = values GVAR(combatZones);
private _isInside = false;
private _playerPoss = getPosATL ace_player;
{
	private _polygon = _x;
	if (_playerPoss inPolygon _polygon) exitWith {
		_isInside = true;
	};
} forEach _polygons;

GVAR(playerIsInsideCombatZone) = _isInside;
_isInside
