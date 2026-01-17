/*
 * Author: Tuntematon
 * Checks if the player is inside a combat zone for their side
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean - true if player is in a combat zone, false otherwise
 *
 * Example:
 * [] call tunuti_utilities_fnc_combatZoneCheck
 */
 
#include "script_component.hpp"

private _polygons = GVAR(combatZones) get side ace_player;
private _isInside = false;
private _playerPoss = getPosATL ace_player;

{
	_x params ["_markerPrefix", "_markerCount"];
	private _polygon = [];
	for "_i" from 1 to _markerCount do {
		_polygon pushBack (getMarkerPos (format ["%2_%1", _i,_markerPrefix]));
	};

	if (_playerPoss inPolygon _polygon) exitWith {
		_isInside = true;
	};
} forEach _polygons;

_isInside
