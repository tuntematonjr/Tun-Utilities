/*
 * Author: [Tuntematon]
 * Draws a vehicle or other icon on map displays
 *
 * Arguments:
 * 0: Marker params <ARRAY>
 *     0: Text <STRING>
 *     1: Position <ARRAY>
 *     2: Direction <NUMBER>
 *     3: Color RGBA <ARRAY of NUMBERs>
 *     4: Update time <NUMBER>
 *     5: Icon path <STRING>
 * 1: Last update time <NUMBER> (default: nil)
 * 2: Lost contact time <NUMBER> (default: nil)
 * 3: Is other marker <BOOL> (default: false)
 *
 * Return Value:
 * None
 *
 * Example:
 * [["Text", [0, 0, 0], 0, [1, 1, 1, 1], 0, "icon.paa"], 0, 0, false] call tunuti_startmarkers_fnc_createVehicleIcon
 */

#include "script_component.hpp"
disableSerialization;

params["_params", ["_lastUpdateTime", nil, [0]], ["_lostContactTime", nil, [0]], ["_isOther", false, [false]]];
_params params [["_text",nil, [""]], ["_pos",nil, [[]]], ["_direction",nil, [0]], ["_color",nil, [[]]], ["_updateTime",nil, [-1]], ["_icon",nil, [""]]];


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


if ((_updateTime >= 0) && {(_lastUpdateTime > ( _lostContactTime + _updateTime))}) then {
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
	if (_isOther) then {
		GVAR(otherMarkers) pushBack [_display, _IDC];
	} else {
		GVAR(vehicleMarkers) pushBack [_display, _IDC];
	};
} forEach _displays;
