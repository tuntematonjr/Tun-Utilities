/*
 * Author: [Tuntematon]
 * [Description]
 * Starts BFT loop
 *
 * Arguments:
 * None
 *
 * Return Value:
 *
 * Example:
 * [] call tunuti_startmarkers_fnc_startBFT
 */
#include "script_component.hpp"

[{!isNil QGVAR(enableBFT) && !isNil QGVAR(bftItems)}, {

	if (GVAR(enableBFT)) then {
		LOG("BFT Started");

		//BFT PFH
		_handle = [{
			if (GVAR(runBFT) && GVAR(lastDataUpdate) < cba_missiontime) then {
				private _items = (assignedItems player + items player);
				MAP(_items, toLower _x);
				if ((getNumber (configOf vehicle player >> "enableGPS") isEqualTo 1 || (GVAR(bftItems) findIf {_x in _items} ) isNotEqualTo -1 || GVAR(bftAlwaysOn))) then {
					LOG("BFT update");
					
					[] call FUNC(filterData);
					[] call FUNC(updateData);
					[] call FUNC(createSquadMarkers);
					[] call FUNC(createVehicleMarkers);
				};
			};
		}, GVAR(updateInterval)] call CBA_fnc_addPerFrameHandler;
		
		//Add all vehicles
		if ( GVAR(addAllVehicles) ) then {
			["AllVehicles", "GetIn", {
				params ["_vehicle", "_role", "_unit", "_turret"];
				if !( isNil { _vehicle getVariable QGVAR(vehicleSide) } ) exitWith {};
				LOG("Added new vehicle");
				_vehicle setVariable [QGVAR(vehicleSide), side _unit, true];
			}] call CBA_fnc_addClassEventHandler;
		};
	} else {
		LOG("No BFT");
		[{
			GVAR(squadTogle) = false;
			GVAR(vehicleTogle) = false;
			[] call FUNC(createSquadMarkers);
			[] call FUNC(createVehicleMarkers);	
		}, [], GVAR(prepTime)] call CBA_fnc_waitAndExecute;
	};
}] call CBA_fnc_waitUntilAndExecute;