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
 * [2, "123", false]] call tun_radiochannels_fnc_setLRchannel
 */
#include "script_component.hpp"

params ["_channel", "_frequency", "_isAdditional"];

if (cba_missionTime isEqualTo 0) exitWith { };
if (!(call TFAR_fnc_haveLRRadio)) exitWith { [parseText "You don't have LR radio", 5] call TFAR_fnc_showHint; };

_channel = _channel - 1;

if !(IS_STRING(_frequency)) then {
	_frequency = str _frequency;
};

if (_isAdditional) then {

	if (_channel > 6)then {
		_channel = 7
	};

	if (((call TFAR_fnc_ActiveLrRadio) call TFAR_fnc_getAdditionalLrChannel) isNotEqualTo -1) then {
		[false] call FUNC(clearAdditional);
	};

	[(call TFAR_fnc_activeLrRadio), _channel + 1, _frequency] call TFAR_fnc_SetChannelFrequency;
	[call TFAR_fnc_activeLrRadio, _channel] call TFAR_fnc_setAdditionalLrChannel;
} else {
	[(call TFAR_fnc_activeLrRadio), _channel + 1, _frequency] call TFAR_fnc_SetChannelFrequency;
	[call TFAR_fnc_activeLrRadio, _channel] call TFAR_fnc_setLrChannel;
};

[(call TFAR_fnc_activeLrRadio), true] call TFAR_fnc_ShowRadioInfo;