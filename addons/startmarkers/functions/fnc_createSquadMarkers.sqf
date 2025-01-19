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
 * [] call tunuti_startmarkers_fnc_createSquadMarkers
 */
#include "script_component.hpp"

// LOG("Runned squad vehicle markers");
[] call FUNC(deleteSquadMarkers); 
if !(GVAR(squadTogle)) exitWith { 
	LOG("exited squad markers, they should be hidden");
};

private _allowedSides = [GVAR(allowedSidesStarmarker), GVAR(allowedSidesBFT)] select ((cba_missiontime > 0) && GVAR(enableBFT));
private _markerData = [];

if (west in _allowedSides) then {
	_markerData append values GVAR(squadMarkersWestData);
};

if (east in _allowedSides) then {
	_markerData append values GVAR(squadMarkersEastData);
};

if (resistance in _allowedSides) then {
	_markerData append values GVAR(squadMarkersIndependentData);
};

if (civilian in _allowedSides) then {
	_markerData append values GVAR(squadMarkersCivilianData);
};

private _playableUnits = playableUnits + switchableUnits;
private _lastUpdateTime = GVAR(lastDataUpdate);
private _showAI = GVAR(showAI);
private _lostContactTime = GVAR(lostContactTime);
private _deleteMarkerTime = GVAR(deleteMarkerTime);

{
	_x params ["_icon", "_pos", "_color", "_group", "_text", "_updateTime", "_hide"];

	if ((_updateTime >= 0) && {(_lastUpdateTime > ( _deleteMarkerTime + _updateTime))}) exitWith {
		private _logText = format ["Marker %1 has not been updated long time, so it is skipped. Should be deleted in next update.",_text];
		LOG(_logText);
	};

	private _alpha = 1;
	if ((_updateTime >= 0) && {(_lastUpdateTime > ( _lostContactTime + _updateTime))}) then {
		_alpha = 0.5;
	};

	if (_hide) then {
		_alpha = 0;
	};

	private _name = format["tun_startmarkers_%1", _group];
	
	if (_showAI && { units _group findIf {_x in _playableUnits} isEqualTo -1 }) then {
		_text = format["%1 (AI)", _text];
	};
	
	private _marker = createMarkerLocal [_name, _pos];
	_marker setMarkerShapeLocal "ICON";
	_marker setMarkerTypeLocal _icon;
	_marker setMarkerSizeLocal [0.7,0.7];
	_marker setMarkerColorLocal _color;
	_marker setMarkerTextLocal _text;
	_marker setMarkerAlphaLocal _alpha;

	GVAR(squadMarkers) pushBack _marker;
} forEach _markerData;