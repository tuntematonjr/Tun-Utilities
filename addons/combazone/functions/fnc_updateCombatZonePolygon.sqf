/*
 * Author: [Tuntematon]
 * Updates the combat zone polygon display on the map.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call tunuti_combazone_fnc_updateCombatZonePolygon
 */

 
#include "script_component.hpp"
if (isServer && !hasInterface) exitWith {};
private _displayIDD = TUNUTI_FIND_MAPDISPLAY;

{
	_x params ["_oldID", "_id"];
	if (_oldID isEqualTo _displayIDD) then {
		((findDisplay _displayIDD) displayCtrl 51) ctrlRemoveEventHandler ["Draw", _id];
	};
} forEach GVAR(ctrlEH_IDs);
GVAR(ctrlEH_IDs) = [];

private _id = ((findDisplay _displayIDD) displayCtrl 51) ctrlAddEventHandler ["Draw", {
	params ["_ctrl"];
	private _polygons = GVAR(combatZones) get playerSide;
	{
		_x params ["_markerPrefix", "_markerCount"];
		private _polygon = [];
		for "_i" from 1 to _markerCount do {
			_polygon pushBack (getMarkerPos (format ["%2_%1", _i,_markerPrefix]));
		};
		_ctrl drawPolygon [_polygon, [1,0,0,1]];
	} forEach _polygons;
}];

GVAR(ctrlEH_IDs) pushBack [_displayIDD,_id];
