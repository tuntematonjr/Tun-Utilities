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
 * [] call tun_utilities_fnc_initSpectatorStats
 */
#include "script_component.hpp"

private _id = ["ace_spectator_displayLoaded", {
	[{!isNull findDisplay 60000}, {

		private _control = findDisplay 60000 ctrlCreate ["tun_utilities_spectatorStatsWest", 1];
		uiNamespace setVariable ["tun_utilities_spectatorStatsWest", _control ];

		private _control = findDisplay 60000 ctrlCreate ["tun_utilities_spectatorStatsEast", 2];
		uiNamespace setVariable ["tun_utilities_spectatorStatsEast", _control ];

		private _control = findDisplay 60000 ctrlCreate ["tun_utilities_spectatorStatsIndependent", 3];
		uiNamespace setVariable ["tun_utilities_spectatorStatsIndependent", _control ];

		_handle = [{
			if (isNull findDisplay 60000) exitWith {
				 _handle call CBA_fnc_removePerFrameHandler;
			};
			private _westCount = west countSide allPlayers;
			private _eastCount = east countSide allPlayers;
			private _independentCount = independent countSide allPlayers;
			{
				_x params ["_side", "_aliveCount", "_originalCount", "_respawnTime", "_tickets", "_control"];
				if (_originalCount isNotEqualTo 0) then {
					private _text = format["%2:%1Alive: %3/%4%1",endl, _side, _aliveCount, _originalCount];
					if (tun_respawn_enable) then {
						private _time = "None";
						if (_respawnTime isNotEqualTo 0) then {
							_time = [ceil (_respawnTime - cba_missiontime), "MM:SS"] call BIS_fnc_secondsToString;
						};
						
						_text =  format["%2Respawn:%1Tickets: %4%1Next Wave: %3",endl, _text, _time, _tickets];
					};
					(uiNamespace getVariable _control) ctrlSetText _text;
				};
			} forEach [["Blufor", _westCount, GVAR(spectatorInitCountWest), tun_respawn_wait_time_west, tun_respawn_tickets_west, "tun_utilities_spectatorStatsWest"],
			["Opfor", _eastCount, GVAR(spectatorInitCountEast), tun_respawn_wait_time_east, tun_respawn_tickets_east, "tun_utilities_spectatorStatsEast"],
			["Indfor", _independentCount, GVAR(spectatorInitCountIndependent), tun_respawn_wait_time_guer, tun_respawn_tickets_guer, "tun_utilities_spectatorStatsIndependent"]];
		}, 1, []] call CBA_fnc_addPerFrameHandler;
	}] call CBA_fnc_waitUntilAndExecute;
}] call CBA_fnc_addEventHandler;