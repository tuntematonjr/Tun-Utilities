/*
 * Author: [Tuntematon]
 * Sets SR channel or additional/team channel based on mode
 *
 * Arguments:
 * 0: Channel index <NUMBER>
 * 1: Mode (1 main, 2 additional, 3 team) <NUMBER>
 * 2: Use LR values <BOOL> (default: false)
 * 3: Use squad values <BOOL> (default: false)
 *
 * Return Value:
 * True if changed, false otherwise <BOOL>
 *
 * Example:
 * [2, 1, false, false] call tunuti_radiochannels_fnc_setSRchannel
 */

#include "script_component.hpp"

params ["_index", "_mode", ["_isLR", false], ["_setSquadValuest", false]];

TRACE_4("set SR start",_index,_mode,_isLR,_setSquadValuest);
if (cba_missionTime isEqualTo 0) exitWith { false };
if (!(call TFAR_fnc_haveSWRadio)) exitWith { [parseText "You don't have SR radio", 5] call TFAR_fnc_showHint; false };

private _radioValues = GVAR(radioValues) getOrDefault [playerSide, [[],[]]];
private _srValues = _radioValues select 0;
private _lrValues = _radioValues select 1;
private _frequency = "error";
private _channel = 0;

if (_setSquadValuest) then {
	private _values = (group player) getVariable [QGVAR(radioValues), [[],[],[]]];
	_values = _values select _isLR;
	_channel = _values select 1;
	_frequency = _values select 0;
} else {
	_frequency = (_srValues select _index) select 0;
	_channel = (_srValues select _index) select 1;
	if (_isLR) then {
		_frequency = (_lrValues select _index) select 0;
		_channel = 8;
	};
};

_frequency = [_frequency] call FUNC(checkFrequency);

switch (_mode) do {
	case 1: { //set main channel
		TRACE_2("set mode: SR main",_channel - 1,_frequency);
		[(call TFAR_fnc_activeSwRadio), _channel, _frequency] call TFAR_fnc_SetChannelFrequency;
		[(call TFAR_fnc_activeSwRadio), _channel - 1] call TFAR_fnc_setSwChannel;
	};
	
	case 2: { //SET additional for sr or lr frequency
		if (toLower call TFAR_fnc_activeSwRadio select [0,11] in ["tf_rf7800st","tf_anprc154","tf_pnr1000a"]) exitWith { [parseText "Your SR radio model does not support additional channels", 7] call TFAR_fnc_showHint;};
		TRACE_3("set mode: SR additonal",_channel - 1,_frequency,_isLR);
		
		if (_channel > 6 && !_isLR) then {
			_channel = 8;
		};

		if (_isLR) then {
			_channel = 8;
		};

		if (((call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getAdditionalSwChannel) isNotEqualTo -1) then {
			[true] call FUNC(clearAdditional);
		};

		[(call TFAR_fnc_activeSwRadio), _channel, _frequency] call TFAR_fnc_SetChannelFrequency;
		[(call TFAR_fnc_activeSwRadio), _channel - 1] call TFAR_fnc_setAdditionalSwChannel;
	};

	case 3: { // Set Team channel
		private _values = ((group player) getVariable [QGVAR(radioValues), [[],[],[]]]) select 2;
		if (count _values > 0) then {
			private _frequency = _values select _index;
			_frequency = [_frequency] call FUNC(checkFrequency);
			TRACE_2("set mode: SR team",_frequency,_channel);
			
			if (((call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getAdditionalSwChannel) isNotEqualTo -1) then {
				[true] call FUNC(clearAdditional);
			};

			[(call TFAR_fnc_activeSwRadio), 8, _frequency] call TFAR_fnc_SetChannelFrequency;
			[(call TFAR_fnc_activeSwRadio), 7] call TFAR_fnc_setAdditionalSwChannel;
		} else {
			LOG("Missing SR channels");
		};
	};
	default { [parseText "Invalid SR channel mode", 7] call TFAR_fnc_showHint; };
};

[(call TFAR_fnc_activeSwRadio), false] call TFAR_fnc_ShowRadioInfo;

true
