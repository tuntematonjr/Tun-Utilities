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
 * [] call tun_startmarkers_fnc_createVehicleMarkers
 */
#include "script_component.hpp"


[] call FUNC(deleteVehicleMarkers);
if !(GVAR(vehicleTogle)) exitWith { };

private _markerData = switch (playerSide) do {
	case west: { 
		GVAR(vehicleMarkersWestData)
	};
	case east: { 
		GVAR(vehicleMarkersEastData)
	};
	case independent: { 
		GVAR(vehicleMarkersIndependentData)
	};
	default { 
		GVAR(vehicleMarkersCivilianData)
	};
};

if (playerSide isNotEqualTo civilian) then {
	if (playerSide isNotEqualTo west && { [west, playerSide] call BIS_fnc_sideIsFriendly }) then {
		_markerData append GVAR(vehicleMarkersWestData);
	};

	if (playerSide isNotEqualTo east && { [east, playerSide] call BIS_fnc_sideIsFriendly }) then {
		_markerData append GVAR(vehicleMarkersEastData);
	};

	if (playerSide isNotEqualTo independent && { [independent, playerSide] call BIS_fnc_sideIsFriendly }) then {
		_markerData append GVAR(vehicleMarkersIndependentData);
	};
};

{
	_x params ["_classname", "_texts", "_pos", "_direction", "_color"];
	private _text = "";
	private _icon = getText (configFile >> "CfgVehicles" >> _classname >> "Icon");

	if (GVAR(vehicleTextToggle)) then {
		
		_text = _texts select 0;
		private _occupationText = _texts select 1;

		if (GVAR(vehicleOccupationToggle) && {!(_classname isKindOf "thing")} && {!(_classname isKindOf "uav")} && {( "" isNotEqualTo _occupationText )}) then {
			_text = format["%1 - [ %2 ]", _text, _occupationText];
		};
	};

	private _IDC = ((findDisplay GVAR(displayIDD)) displayCtrl 51) ctrlAddEventHandler ["Draw", format ['
			(_this select 0) drawIcon [
			"%1",
			%2,
			%3,
			30,
			30,
			%4,
			%5,
			2
			];',
			_icon,
			_color,
			_pos,
			_direction,
			str _text
		]
	];
	GVAR(vehicleMarkers) pushBack _IDC;
} forEach _markerData;
