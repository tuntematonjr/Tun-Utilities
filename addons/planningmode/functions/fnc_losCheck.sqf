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
 * ["something", player] call tunuti_planningmode_fnc_losCheck
 */
#include "script_component.hpp"
params ["_enable"];

ISNILS(GVAR(losMarkers),[]);

if (_enable) then {
	onMapSingleClick {_shift};
	GVAR(losCheckerEH) = addMissionEventHandler ["MapSingleClick", {
		params ["_units", "_endPos", "_alt", "_shift"];

		{
			deleteMarkerLocal _x;
		} forEach GVAR(losMarkers);

		if (_shift) then {
			private _startPos = eyePos player;
			private _newZ = (getTerrainHeightASL _endPos + 1);
			_endPos set [2, _newZ];
			private _intersections = lineIntersectsSurfaces [_startPos, _endPos, player, objNull, true, -1];
			private _markerStart = createMarkerLocal [QGVAR(losCheckMarker_start), _startPos];
			_markerStart setMarkerText "Start"; 
			_markerStart setMarkerType "hd_start";
			_markerStart setMarkerShadowLocal false;

			private _markerEnd = createMarkerLocal [QGVAR(losCheckMarker_end), _endPos]; 
			private _distance2D = round(_startPos distance2D _endPos);
			private _distance = round(_startPos distance _endPos);
			_markerEnd setMarkerText format["End. Distances: 2D = %1 - 3D = %2", _distance2D, _distance]; 
			_markerEnd setMarkerType "mil_end";
			_markerEnd setMarkerShadowLocal false;
			GVAR(losMarkers) append [_markerStart, _markerEnd];
			
			private _lineStart = _startPos;
			private _color = "ColorGreen";
			private _prefixText = QGVAR(losCheckMarker);
			{
				private _pos = _x select 0;
				private _obj = _x select 2;

				private _markerLine = [_lineStart, _pos, _color] call FUNC(createLine);
				
				_lineStart = _pos;

				private _markerBlock = createMarkerLocal [format["%2_%1", _forEachIndex, _prefixText], _pos];
				
				if (!isnull _obj) then {
					private _name =  getText(configOf _obj >> "Displayname");
					_markerBlock setMarkerText "Block";
					_color = "ColorYellow";
				} else {
					_markerBlock setMarkerText "Blocked by ground";
					_color = "ColorRed";
				};
				
				_markerBlock setMarkerType "loc_LetterX";
				_markerBlock setMarkerShadowLocal false;
				GVAR(losMarkers) append [_markerBlock,_markerLine];

			} forEach _intersections;

			private _markerLine = [_lineStart, _endPos, _color] call FUNC(createLine);
			GVAR(losMarkers) pushBack _markerLine;
		};
	}];
} else {
	onMapSingleClick "";
	{
		deleteMarkerLocal _x;
	} forEach GVAR(losMarkers);

	removeMissionEventHandler ["MapSingleClick", GVAR(losCheckerEH)];
};