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
 * [] call tunuti_combatZone_fnc_updateCombatZonePolygon
 */

 
#include "script_component.hpp"

if (isServer && !hasInterface) exitWith {};

private _displayIDD = TUNUTI_FIND_MAPDISPLAY;
private _displayControl = (findDisplay _displayIDD) displayCtrl 51;

// Remove any previous Draw handlers for this display to avoid duplicates.
{
	_x params ["_oldID", "_id"];
	if (_oldID isEqualTo _displayIDD) then {
		(_displayControl) ctrlRemoveEventHandler ["Draw", _id];
	};
} forEach GVAR(ctrlEH_IDs);
GVAR(ctrlEH_IDs) = [];

// Re-register Draw handler to render the current set of combat zone polygons.
private _id = (_displayControl) ctrlAddEventHandler ["Draw", {
	params ["_control"];
	private _polygons = values GVAR(combatZones);
	{
		private _polygon = _x;
		_control drawPolygon [_polygon, [1,0,0,1]];
	} forEach _polygons;
}];

GVAR(ctrlEH_IDs) pushBack [_displayIDD,_id];
