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
 * [] call tunuti_utilities_fnc_initSpectatorStats
 */
#include "script_component.hpp"


GVAR(spectatorInitCountHash) = createHashMap;
GVAR(spectatorControHash) = createHashMapFromArray [[west, QGVAR(spectatorStatsWest)], [east, QGVAR(spectatorStatsEast)], [resistance, QGVAR(spectatorStatsResistance)]];


private _id = ["ace_spectator_displayLoaded", {
	[{!isNull findDisplay 60000  && !isNil QGVAR(enableSpectatorStats)}, {

		if !(GVAR(enableSpectatorStats)) exitWith { LOG("spectator stats disabled"); };
		LOG("init spectator stats");
		private _control = findDisplay 60000 ctrlCreate [QGVAR(spectatorStatsWest), 1];
		uiNamespace setVariable [QGVAR(spectatorStatsWest), _control ];

		private _control = findDisplay 60000 ctrlCreate [QGVAR(spectatorStatsEast), 2];
		uiNamespace setVariable [QGVAR(spectatorStatsEast), _control ];

		private _control = findDisplay 60000 ctrlCreate [QGVAR(spectatorStatsResistance), 3];
		uiNamespace setVariable [QGVAR(spectatorStatsResistance), _control ];

		private _handle = [{
			if (isNull findDisplay 60000) exitWith {
				_handle call CBA_fnc_removePerFrameHandler;
			};

			private _allowRespawnHash = tunres_Respawn_allowRespawnHash;

			{
				_x params ["_side"];

				private _unitCountNew = { side _x isEqualTo _side && alive _x } count allPlayers;
				private _unitCount = GVAR(spectatorInitCountHash) getOrDefault [_side, 0];
				if (_unitCountNew > _unitCount) then {
					GVAR(spectatorInitCountHash) set [_side,_unitCountNew];
					_unitCount =_unitCountNew;
				};
				
				private _awakeCount = { side _x isEqualTo _side && [_x] call ace_common_fnc_isAwake } count allPlayers;
				private _unconCount = { side _x isEqualTo _side && alive _x  && _x getVariable ["ACE_isUnconscious", false] } count allPlayers;

				if (_unitCount isNotEqualTo 0) then {
					private _text = format["%2:%1Alive: %3(Uncons: %5)/%4%1",endl, _side, _awakeCount, _unitCount, _unconCount];

					if (missionNamespace getVariable ["tunres_Respawn_enable", false]) then {
						private _ticketCount = "Not using side tickets";
						if (tunres_Respawn_respawnType isEqualTo 1) then {
							private _hash = tunres_Respawn_ticketsHash;
							_ticketCount = str(_hash get _side);
						};

						private _waitingRespawnCount = ([_side, false] call tunres_Respawn_fnc_getWaitingRespawnCount) + ([_side, true] call tunres_Respawn_fnc_getWaitingRespawnCount);

						private _time = "Disabled";
						if (_allowRespawnHash getOrDefault [_side,false]) then {
							_time = [_side] call tunres_respawn_fnc_getRemainingTime;
							_time = [_time, "M:SS"] call CBA_fnc_formatElapsedTime;
						};
						
						_text =  format["%2Respawn:%1Tickets: %4%1Next Wave: %3%1Waiting Respawn: %5",endl, _text, _time, _ticketCount, _waitingRespawnCount];
					};
					
					private _control = GVAR(spectatorControHash) get _side;
					(uiNamespace getVariable _control) ctrlSetText _text;
				};
			} forEach [west,east,resistance];
		}, 1, []] call CBA_fnc_addPerFrameHandler;
	}] call CBA_fnc_waitUntilAndExecute;
}] call CBA_fnc_addEventHandler;