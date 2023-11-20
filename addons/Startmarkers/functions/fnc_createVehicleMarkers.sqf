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
 * [] call tunuti_startmarkers_fnc_createVehicleMarkers
 */
#include "script_component.hpp"
disableSerialization;

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

private _vehicleTextToggle = GVAR(vehicleTextToggle);
private _vehicleOccupationToggle = GVAR(vehicleOccupationToggle);
private _lastUpdateTime = GVAR(lastDataUpdate);
private _lostContactTime = GVAR(lostContactTime) * 60;
private _deleteMarkerTime = GVAR(deleteMarkerTime) * 60;

private _displays = [];
_displays pushBack ((findDisplay TUNUTI_FIND_MAPDISPLAY) displayCtrl 51);

private _minimapDisplay = uiNamespace getVariable ["RscCustomInfoMiniMap", displayNull];
if (!isNull _minimapDisplay) then {
	private _miniMapControlGroup = _minimapDisplay displayCtrl 13301;
	private _miniMap = _miniMapControlGroup controlsGroupCtrl 101;
	_displays pushBack _miniMap;
};

//DialogDisplay
private _dialogDisplay = uiNamespace getVariable [["ace_microdagr_RscTitleDisplay", "ace_microdagr_DialogDisplay"] select (ace_microdagr_currentShowMode == 2), displayNull];
if (!isNull _dialogDisplay) then {
	private _microDagrCtrl= [_display displayCtrl 77702, _display displayCtrl 77703] select (!ace_microdagr_mapShowTexture);
	//private _miniMap = _microDagrDetail controlsGroupCtrl 101;
	_displays pushBack _microDagrCtrl;
};

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

	{
		private _display = _x;
		private _drawValues = format ['
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
			];

		private _IDC = _display ctrlAddEventHandler ["Draw",_drawValues];
		GVAR(vehicleMarkers) pushBack [_display, _IDC];
	} forEach _displays;	
} forEach _markerData;
 