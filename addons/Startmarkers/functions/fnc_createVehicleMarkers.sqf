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

LOG("Runned create vehicle markers");

[] call FUNC(deleteVehicleMarkers);
if !(GVAR(vehicleTogle)) exitWith { LOG("exited vehicle markers, they should be hidden");};

private _allowedSides = [GVAR(allowedSidesStarmarker), GVAR(allowedSidesBFT)] select ((cba_missiontime > 0) && GVAR(enableBFT));
private _markerData = [];

if (west in _allowedSides) then {
	_markerData append values GVAR(vehicleMarkersWestData);
};

if (east in _allowedSides) then {
	_markerData append values GVAR(vehicleMarkersEastData);
};

if (resistance in _allowedSides) then {
	_markerData append values GVAR(vehicleMarkersIndependentData);
};

if (civilian in _allowedSides) then {
	_markerData append values GVAR(vehicleMarkersCivilianData);
};

// private _logText = format ["Create vehicle marker data has %1 entries", count _markerData];
// LOG(_logText);

private _display = (findDisplay TUN_FIND_MAPDISPLAY) displayCtrl 51;
private _vehicleTextToggle = GVAR(vehicleTextToggle);
private _vehicleOccupationToggle = GVAR(vehicleOccupationToggle);
private _lastUpdateTime = GVAR(lastDataUpdate);
private _lostContactTime = GVAR(lostContactTime) * 60;
private _deleteMarkerTime = GVAR(deleteMarkerTime) * 60;

{
	_x params ["_classname", "_texts", "_pos", "_direction", "_color", "_updateTime"];

	if ( !(_updateTime < 0) && {(_lastUpdateTime > (_deleteMarkerTime + _updateTime))}) exitWith {
		private _logText = format ["Vehicle marker %1 has not been updated long time, so it is skipped", _texts select 0];
		LOG(_logText);
	};

	if ( !(_updateTime < 0) && {(_lastUpdateTime > ( _lostContactTime + _updateTime))}) then {
		_color set [-1, 0.5];
	};

	private _text = "";
	private _icon = getText (configFile >> "CfgVehicles" >> _classname >> "Icon");

	if (_vehicleTextToggle) then {
		
		_text = _texts select 0;
		private _occupationText = _texts select 1;

		if (_vehicleOccupationToggle && {!(_classname isKindOf "thing")} && {!(_classname isKindOf "uav")} && {( "" isNotEqualTo _occupationText )}) then {
			_text = format["%1 - [ %2 ]", _text, _occupationText];
		};
	};

	private _IDC = _display ctrlAddEventHandler ["Draw", format ['
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
