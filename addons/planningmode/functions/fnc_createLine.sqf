/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: The first argument <STRING>
 * 1: The second argument <OBJECT>
 * 2: Multiple input types <STRING|ARRAY|CODE>
 * 3: Optional input <BOOL> (default: true)
 * 4: Optional input with multiple types <CODE|STRING> (default: {true})
 * 5: Not mandatory input <STRING> (default: nil)
 *
 * Return Value:
 * The return value <BOOL>
 *
 * Example:
 * ["something", player] call tunuti_planningmode_fnc_createLine
 */
#include "script_component.hpp"
params ["_lineStart", "_lineEnd", "_color"];

private _lineDistance = (_lineEnd distance2D _lineStart) / 2;
private _lineDir = _lineStart getDir _lineEnd;
private _lineMiddlePos = _lineStart getPos [_lineDistance, _lineDir];
private _markerLine = createMarkerLocal [format["%%3_%1-%2", _lineStart, _lineEnd, QGVAR(losCheckMarker)], _lineMiddlePos];
_markerLine setMarkerDirLocal _lineDir;
_markerLine setMarkerShapeLocal "RECTANGLE";
_markerLine setMarkerBrushLocal "SolidBorder";
_markerLine setMarkerSizeLocal [0.5, _lineDistance];
_markerLine setMarkerColorLocal _color;
_markerLine setMarkerDrawPriority -1000;
_markerLine setMarkerShadowLocal false;

_markerLine