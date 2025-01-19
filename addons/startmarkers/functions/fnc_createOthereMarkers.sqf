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
 * [] call tunuti_startmarkers_fnc_createOthereMarkers
 */
#include "script_component.hpp"
disableSerialization;

LOG("Runned create other markers");
[] call FUNC(deleteOtherMarkers);
if !(GVAR(otherToggle)) exitWith { LOG("exited other markers, they should be hidden");};

private _allowedSides = [GVAR(allowedSidesStarmarker), GVAR(allowedSidesBFT)] select ((cba_missiontime > 0) && GVAR(enableBFT));
private _markerData = [];

if (west in _allowedSides) then {
	_markerData append values GVAR(otherMarkersWestData);
};

if (east in _allowedSides) then {
	_markerData append values GVAR(otherMarkersEastData);
};

if (resistance in _allowedSides) then {
	_markerData append values GVAR(otherMarkersIndependentData);
};

if (civilian in _allowedSides) then {
	_markerData append values GVAR(otherMarkersCivilianData);
};

private _otherTextToggle = GVAR(otherTextToggle);
private _lastUpdateTime = GVAR(lastDataUpdate);
private _lostContactTime = GVAR(lostContactTime);
private _deleteMarkerTime = GVAR(deleteMarkerTime);

{
	_x params ["_classname", "_texts", "_pos", "_direction", "_color", "_updateTime"];

	if ((_updateTime >= 0) && {(_lastUpdateTime > (_deleteMarkerTime + _updateTime))}) exitWith {
		private _logText = format ["other marker %1 has not been updated long time, so it is skipped", _texts select 0];
		LOG(_logText);
	};

	private _text = "";
	private _icon = getText (configFile >> "CfgVehicles" >> _classname >> "Icon");

	if (_otherTextToggle) then {
		_text = _texts select 0;
		private _occupationText = _texts select 1;
	};

	[[_text,_pos,_direction,_color,_updateTime,true]] call FUNC(createVehicleIcon);
} forEach _markerData;