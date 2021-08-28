/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call tun_startmarkers_fnc_createSquadMarkers
 */
#include "script_component.hpp"

[] call FUNC(deleteSquadMarkers);
if !(GVAR(squadTogle)) exitWith { };

private _markerData = switch (playerSide) do {
	case west: { 
		GVAR(squadMarkersWestData)
	};
	case east: { 
		GVAR(squadMarkersEastData)
	};
	case independent: { 
		GVAR(squadMarkersIndependentData)
	};
	default { 
		GVAR(squadMarkersCivilianData)
	};
};

if (playerSide isNotEqualTo civilian) then {

	if (playerSide isNotEqualTo west && { [west, playerSide] call BIS_fnc_sideIsFriendly }) then {
		_markerData append GVAR(squadMarkersWestData);
	};

	if (playerSide isNotEqualTo east && { [east, playerSide] call BIS_fnc_sideIsFriendly }) then {
		_markerData append GVAR(squadMarkersEastData);
	};

	if (playerSide isNotEqualTo independent && { [independent, playerSide] call BIS_fnc_sideIsFriendly }) then {
		_markerData append GVAR(squadMarkersIndependentData);
	};
};

{
	_x params ["_icon", "_pos", "_color", "_group"];
	private _text = groupId _group;
	if (GVAR(showAI) && { units _group findIf {_x in playableUnits + switchableUnits} isEqualTo -1 }) then {
		_text = format["%1 (AI)", _text];
	};
	private _marker = createMarkerLocal [(format["Tun_startmarkers_%1", _group]), _pos];
	_marker setMarkerShapeLocal "ICON";
	_marker setMarkerTypeLocal _icon;
	_marker setMarkerSizeLocal [0.7,0.7];
	_marker setMarkerColorLocal _color;
	_marker setMarkerTextLocal _text;

	GVAR(squadMarkers) pushBack _marker;
} forEach _markerData;