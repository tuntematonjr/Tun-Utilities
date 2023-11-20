/*
 * Author: [Tuntematon]
 * [Description]
 * Filter unused data out
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call tunuti_startmarkers_fnc_filterData
 */
#include "script_component.hpp"

private _westSquadHash = GVAR(squadMarkersWestData);
private _eastSquadHash = GVAR(squadMarkersEastData);
private _resistanceSquadHash = GVAR(squadMarkersIndependentData);
private _civilianSquadHash = GVAR(squadMarkersCivilianData);

private _westVehicleHash = GVAR(vehicleMarkersWestData);
private _eastVehicleHash = GVAR(vehicleMarkersEastData);
private _resistanceVehicleHash = GVAR(vehicleMarkersIndependentData);
private _civilianVehicleHash = GVAR(vehicleMarkersCivilianData);

private _lastUpdateTime = GVAR(lastDataUpdate);
private _deleteMarkerTime = GVAR(deleteMarkerTime) * 60;

{
	private _hash = _x;
	{
		private _key = _x;
		private _value = _y;
		private _valueUpdateTime = _value select 5;

		if (( !(_valueUpdateTime < 0) && {(_lastUpdateTime > ( _deleteMarkerTime + _valueUpdateTime))})) then {
			_hash deleteAt _key;
		};
	} forEach _hash;	
} forEach [_westSquadHash, _eastSquadHash, _resistanceSquadHash, _civilianSquadHash, _westVehicleHash, _eastVehicleHash, _resistanceVehicleHash, _civilianVehicleHash];