/*
 * Author: [Tuntematon]
 * [Description]
 * Set SR channel
 *
 * Arguments:
 * 0: Channel to change <NUMBER>
 * 1: frequency number in string <STRING>
 * 2: Is additional <BOOL>
 *
 * Return Value:
 * True if changed, false if not
 *
 * Example:
 * [2, "123", false] call tun_radiochannels_fnc_setSRchannel
 */
#include "script_component.hpp"

params ["_index", "_mode", ["_isLR", false], ["_setSquadValuest", false]];

private _debugText = format ["set SR start: %1, %2, %3, %4", _index , _mode, _isLR, _setSquadValuest];
LOG(_debugText);
if (cba_missionTime isEqualTo 0) exitWith { false };
if (!(call TFAR_fnc_haveSWRadio)) exitWith { [parseText "You don't have SR radio", 5] call TFAR_fnc_showHint; false };

private _srValues = [];
private _lrValues = [];
private _frequency = "error";
private _channel = 0;

switch (playerSide) do {
	case west: { 
		_srValues = GVAR(srWEST);
		_lrValues =  GVAR(lrWEST);
	};
	case east: { 
		_srValues = GVAR(srEAST);
		_lrValues = GVAR(lrEAST);
	};
	case independent: { 
		_srValues = GVAR(srINDEPENDENT);
		_lrValues = GVAR(lrINDEPENDENT);
	};
};

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
		private _debugText = format ["set mode: SR main: %1, %2", _channel - 1, _frequency];
		LOG(_debugText);
		[(call TFAR_fnc_activeSwRadio), _channel, _frequency] call TFAR_fnc_SetChannelFrequency;
		[(call TFAR_fnc_activeSwRadio), _channel - 1] call TFAR_fnc_setSwChannel;
	};
	
	case 2: { //SET additional for sr or lr frequency
		if (toLower call TFAR_fnc_activeSwRadio select [0,11] in ["tf_rf7800st","tf_anprc154","tf_pnr1000a"]) exitWith { [parseText "Your SR radio does not support additional", 7] call TFAR_fnc_showHint;};
		private _debugText = format ["set mode: SR additonal: %1, %2, %3", _channel - 1, _frequency, _isLR];
		LOG(_debugText);
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
			private _debugText = format ["set mode: SR team: %1, %2", _frequency, _channel];
			LOG(_debugText);
			if (((call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getAdditionalSwChannel) isNotEqualTo -1) then {
				[true] call FUNC(clearAdditional);
			};

			[(call TFAR_fnc_activeSwRadio), 8, _frequency] call TFAR_fnc_SetChannelFrequency;
			[(call TFAR_fnc_activeSwRadio), 7] call TFAR_fnc_setAdditionalSwChannel;
		} else {
			LOG("Missing SR channels");
		};
	};
	default { [parseText "Missing SR mode", 7] call TFAR_fnc_showHint; };
};

[(call TFAR_fnc_activeSwRadio), false] call TFAR_fnc_ShowRadioInfo;

true