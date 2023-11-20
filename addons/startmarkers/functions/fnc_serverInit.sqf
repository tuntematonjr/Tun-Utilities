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
 * [] call tunuti_startmarkers_fnc_serverInit
 */
#include "script_component.hpp"

LOG("Runned server init starmarkers");

[{diag_tickTime > _this || {(is3DENPreview && !isNull findDisplay 12)}}, {
	GVAR(squadMarkersWestData) = createHashMap;
	GVAR(squadMarkersEastData) = createHashMap;
	GVAR(squadMarkersIndependentData) = createHashMap;
	GVAR(squadMarkersCivilianData) = createHashMap;

	GVAR(vehicleMarkersWestData) = createHashMap;
	GVAR(vehicleMarkersEastData) = createHashMap;
	GVAR(vehicleMarkersIndependentData) = createHashMap;
	GVAR(vehicleMarkersCivilianData) = createHashMap;
	
	[] call FUNC(updateData);
}, (diag_tickTime + 10)] call CBA_fnc_waitUntilAndExecute;