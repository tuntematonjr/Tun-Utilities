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
 * [] call tunuti_startmarkers_fnc_createVehicleIcon
 */
#include "script_component.hpp"
disableSerialization;

params["_params", "_lastUpdateTime", "_lostContactTime", ["_isOther",false]];
_params params ["_text", "_pos", "_direction", "_color", "_updateTime"];


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
	private _microDagrCtrl= [_dialogDisplay displayCtrl 77702, _dialogDisplay displayCtrl 77703] select (ace_microdagr_mapShowTexture);
	//private _miniMap = _microDagrDetail controlsGroupCtrl 101;
	_displays pushBack _microDagrCtrl;
};


if ( !(_updateTime < 0) && {(_lastUpdateTime > ( _lostContactTime + _updateTime))}) then {
	_color set [-1, 0.5];
};

{
	private _display = _x;
	private _drawValues = format ['
			(_this select 0) drawIcon [
			"%1",
			%2,
			%3,
			25,
			25,
			%4,
			%5,
			0,
			0.04
			];',
			_icon,
			_color,
			_pos,
			_direction,
			str _text
		];

	private _IDC = _display ctrlAddEventHandler ["Draw",_drawValues];
	TRACE_2("create Icon",_display, _IDC);
	if (_isOther) then {
		LOG("add other marcer to array");
		GVAR(otherMarkers) pushBack [_display, _IDC];
		TRACE_1("Other array",GVAR(otherMarkers));
	} else {
		LOG("add vehicle marcer to array");
		GVAR(vehicleMarkers) pushBack [_display, _IDC];
		TRACE_1("vehicle array",GVAR(vehicleMarkers));
	};
} forEach _displays;