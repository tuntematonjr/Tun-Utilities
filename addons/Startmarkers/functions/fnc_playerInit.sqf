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

[{ (!isNil {TUN_FIND_MAPDISPLAY} || {!isMultiplayer} || {cba_missiontime > 0})}, {

	if (isMultiplayer) then {
		[] call FUNC(createVehicleMarkers);
	};
	
	[] call FUNC(createSquadMarkers);

	[{
		//GVAR(displayIDD) = 12;
		GVAR(vehicleMarkers) = [];

		[{!isNil {TUN_FIND_MAPDISPLAY} }, {
			[] call FUNC(createVehicleMarkers);
		}] call CBA_fnc_waitUntilAndExecute;

		[{!isNil QGVAR(enableBFT) && !isNil QGVAR(bftItems)}, {
			if (GVAR(enableBFT)) then {
				_handle = [{
					if (GVAR(runBFT)) then {
						private _items = (assignedItems player + items player);
						MAP(_items, toLower _x);
						if ((GVAR(bftItems) findIf {_x in _items} ) isNotEqualTo -1 || GVAR(bftAlwaysOn) ) then {
							[] call FUNC(updateData);
							[] call FUNC(createSquadMarkers);
							[] call FUNC(createVehicleMarkers);
						};
					};
				}, GVAR(updateInterval)] call CBA_fnc_addPerFrameHandler;
				if ( GVAR(addAllVehicles) ) then {
					["AllVehicles", "GetIn", {
						params ["_vehicle", "_role", "_unit", "_turret"];
						if !( isNil { _vehicle getVariable "Tun_startmarkers_vehilce_side" } ) exitWith {};

						_vehicle setVariable ["Tun_startmarkers_vehilce_side", side _unit, true];
					}] call CBA_fnc_addClassEventHandler;
				};
			} else {
				[{
					GVAR(squadTogle) = false;
					GVAR(vehicleTogle) = false;
					[] call FUNC(createSquadMarkers);
					[] call FUNC(createVehicleMarkers);	
				}, [], GVAR(prepTime)] call CBA_fnc_waitAndExecute;
			};
		}] call CBA_fnc_waitUntilAndExecute;

	}, [], 5] call CBA_fnc_waitAndExecute;

	private _text = "<font face='PuristaBold' size='15'>This missions uses automatic startpositions markers.</font>
	<br/>The markers are hidden after the safe start is over.
	<br/>You can bring them up again through the settings menu.
	<br/>If mission uses BFT, same settings apply for it.
	<br/><br/><font size=20><execute expression=' [true] call "+ QFUNC(settingsDisplay) +"'>Open Settings</execute>
	</font>";

	player createDiarySubject [QGVAR(briefing),"Startpositions & BFT"];
	player createDiaryRecord [QGVAR(briefing), ["Startpositions & BFT",_text]];
	player createDiaryRecord ["diary", ["Startpositions & BFT",_text]];

}, nil, 120] call CBA_fnc_waitUntilAndExecute;