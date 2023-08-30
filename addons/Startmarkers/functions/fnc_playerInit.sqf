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
 * [] call tun_startmarkers_fnc_imanexample
 */
#include "script_component.hpp"

GVAR(squadTogle) = true;
GVAR(vehicleTogle) = true;
GVAR(vehicleTextToggle) = true;
GVAR(vehicleOccupationToggle) = true;
GVAR(runBFT) = true; //Variable to disable bft for unit in game

LOG("Initialized player init starmarkers");

[{ (!isNil {TUN_FIND_MAPDISPLAY} || {!isMultiplayer} || {cba_missiontime > 0})}, {
	LOG("Briefing player init");

	[] call FUNC(sortAllowedSides);

	if (TUN_FIND_MAPDISPLAY isNotEqualTo 12) then {
		[] call FUNC(createVehicleMarkers);
	} else {
		LOG("Skipped running createvehicle, due to skiping briefing");
	};
	
	[] call FUNC(createSquadMarkers);
	[] call FUNC(createDiaryRecord);

	[{
		//This will runn after mission start
		LOG("Ingame player init starmarkers");

		GVAR(vehicleMarkers) = [];

		[{!isNil {TUN_FIND_MAPDISPLAY} }, {
			[] call FUNC(createVehicleMarkers);
		}] call CBA_fnc_waitUntilAndExecute;

		[] call FUNC(startBFT);

	}, [], 3] call CBA_fnc_waitAndExecute;

}, nil, 120] call CBA_fnc_waitUntilAndExecute;