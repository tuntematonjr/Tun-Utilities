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
 * [2, "123", false]] call tunuti_radiochannels_fnc_setLRchannel
 */
#include "script_component.hpp"

params ["_index", ["_isAdditional", false], ["_setSquadValues", false]];
private ["_channel", "_frequency"];
private _debugText = format ["set LR start: %1, %2, %3", _index, _isAdditional, _setSquadValues];
LOG(_debugText);
if (cba_missionTime isEqualTo 0) exitWith { };
if (!(call TFAR_fnc_haveLRRadio)) exitWith { [parseText "You don't have LR radio", 5] call TFAR_fnc_showHint; };

private _radioValues = GVAR(radioValues) getOrDefault [playerSide, [[],[]]];
private _lrValues = _radioValues select 1;

if (_setSquadValues) then {
	private _values = (group player) getVariable [QGVAR(radioValues), [[],[],[]]];
	private _lrValues = _values select 1;
	_channel = _lrValues select 1;
	_frequency = _lrValues select 0;
} else {
	_frequency = (_lrValues select _index) select 0;
	_channel = (_lrValues select _index) select 1;
};

_channel = _channel - 1;

if (_isAdditional) then {
	_frequency = [_frequency] call FUNC(checkFrequency);

	private _debugText = format ["Set LR additional: %1, %2", _channel, _frequency];
	LOG(_debugText);
	if (_channel > 6)then {
		_channel = 7
	};

	if (((call TFAR_fnc_ActiveLrRadio) call TFAR_fnc_getAdditionalLrChannel) isNotEqualTo -1) then {
		[false] call FUNC(clearAdditional);
	};

	[(call TFAR_fnc_activeLrRadio), _channel + 1, _frequency] call TFAR_fnc_SetChannelFrequency;
	[call TFAR_fnc_activeLrRadio, _channel] call TFAR_fnc_setAdditionalLrChannel;
} else {
	_frequency = [_frequency] call FUNC(checkFrequency);
	private _debugText = format ["Set LR: %1, %2", _channel, _frequency];
	LOG(_debugText);
	[(call TFAR_fnc_activeLrRadio), _channel + 1, _frequency] call TFAR_fnc_SetChannelFrequency;
	[call TFAR_fnc_activeLrRadio, _channel] call TFAR_fnc_setLrChannel;
};

[(call TFAR_fnc_activeLrRadio), true] call TFAR_fnc_ShowRadioInfo;

