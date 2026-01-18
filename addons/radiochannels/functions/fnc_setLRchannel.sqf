/*
 * Author: [Tuntematon]
 * Sets LR channel or additional channel
 *
 * Arguments:
 * 0: Channel index <NUMBER>
 * 1: Is additional <BOOL> (default: false)
 * 2: Use squad values <BOOL> (default: false)
 *
 * Return Value:
 * None
 *
 * Example:
 * [2, false, false] call tunuti_radiochannels_fnc_setLRchannel
 */

#include "script_component.hpp"

params ["_index", ["_isAdditional", false], ["_setSquadValues", false]];
private ["_channel", "_frequency"];

TRACE_3("set LR start",_index,_isAdditional,_setSquadValues);

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

	TRACE_2("Set LR additional",_channel,_frequency);
	if (_channel > 6)then {
		_channel = 7;
	};

	if (((call TFAR_fnc_ActiveLrRadio) call TFAR_fnc_getAdditionalLrChannel) isNotEqualTo -1) then {
		[false] call FUNC(clearAdditional);
	};

	[(call TFAR_fnc_activeLrRadio), _channel + 1, _frequency] call TFAR_fnc_SetChannelFrequency;
	[call TFAR_fnc_activeLrRadio, _channel] call TFAR_fnc_setAdditionalLrChannel;
} else {
	_frequency = [_frequency] call FUNC(checkFrequency);

	TRACE_2("Set LR",_channel,_frequency);
	[(call TFAR_fnc_activeLrRadio), _channel + 1, _frequency] call TFAR_fnc_SetChannelFrequency;
	[call TFAR_fnc_activeLrRadio, _channel] call TFAR_fnc_setLrChannel;
};

[(call TFAR_fnc_activeLrRadio), true] call TFAR_fnc_ShowRadioInfo;
