/*
 * Author: [Tuntematon]
 * Adds a combat zone definition for the specified sides.
 *
 * Arguments:
 * 0: Sides <ARRAY of SIDE>
 * 1: Marker prefix <STRING>
 * 2: Marker count <NUMBER>
 * 3: Reset zones <BOOL> (default: false)
 * 4: Show markers <BOOL> (default: true)
 * 5: Hide markers on reset <BOOL> (default: false)
 *
 * Return Value:
 * Hash key <STRING>
 *
 * Example:
 * [[west, east], "c", 10, false, true, false] call tunuti_combatZone_fnc_addCombatZone
 */

 
#include "script_component.hpp"
if (isServer && !hasInterface) exitWith {};
params [["_sides", nil, [[]]],["_markerPreFix", nil, [""]], ["_markerCount", nil, [0]], ["_resetZones", false, [false]], ["_showMarkers", true, [false]], ["_hideMarkersOnReset", false, [false]]];

private _hashkey = "";

if (playerSide in _sides) then {
	private _polygon = [];
	for "_i" from 1 to _markerCount do {
		private _markerName = format ["%2_%1", _i,_markerPreFix];
		if (_showMarkers) then {
			_markerName setMarkerAlphaLocal 1;
		};
		_polygon pushBack (getMarkerPos _markerName);
	};

	_hashkey = hashValue _polygon;

	if (_resetZones) then {
		if (_hideMarkersOnReset) then {
			private _polygons = values GVAR(combatZones);
			{
				_x params ["_markerPreFixOld", "_markerCountOld"];
				for "_i" from 1 to _markerCountOld do {
					private _markerName = format ["%2_%1", _i,_markerPreFixOld];
					_markerName setMarkerAlphaLocal 0;
				};

			} forEach (values GVAR(combatZonesMarkers));
		};
		GVAR(combatZones) = createHashMap;
	};
	GVAR(combatZonesMarkers) set [_hashkey, [_markerPreFix, _markerCount]];
	GVAR(combatZones) set [_hashkey, _polygon];

	[] call FUNC(updateCombatZonePolygon);
};

_hashkey
