/*
 * Author: [Tuntematon]
 * [Description]
 * Starst/Ends planning mode for clients. Creates markers on player positions.
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call tunuti_planningmode_fnc_planningModeServer
 */
#include "script_component.hpp"
if (!isServer) exitWith {LOG("Not Server");};

ISNILS(GVAR(isRunning),false);
ISNILS(GVAR(playerPositionMarkers),[]);

private _newStatus = false; // Default off

if !(GVAR(isRunning)) then { //Start planning mode
	_newStatus= true;
	[{
		params ["_args", "_handle"];

		{ 
			deleteMarker _x;	
		} forEach GVAR(playerPositionMarkers); 
		GVAR(playerPositionMarkers) = []; 

		if (GVAR(isRunning)) then {
			{ 
				private _unit = _x; 
				private _marker = createMarker [format["%1_%2", QGVAR(playerPosMarker),_unit], position _unit]; 
				_marker setMarkerTextLocal name _unit ; 
				_marker setMarkerTypeLocal "mil_triangle"; 
				_marker setMarkerDir direction _unit; 
				GVAR(playerPositionMarkers) pushBack _marker; 
			} forEach allPlayers; 
		} else {
			_handle call CBA_fnc_removePerFrameHandler;
		};
	}, 1] call CBA_fnc_addPerFrameHandler;
};

[_newStatus] remoteExecCall [QFUNC(planningModeClient), [0, -2] select isDedicated, true];

GVAR(isRunning) = _newStatus;