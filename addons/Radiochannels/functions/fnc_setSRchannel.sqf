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

params ["_channel", "_frequency", "_isAdditional"];

if (cba_missionTime isEqualTo 0) exitWith { false };
if (!(call TFAR_fnc_haveSWRadio)) exitWith { [parseText "You don't have SR radio", 5] call TFAR_fnc_showHint; false };

_channel = _channel - 1;

if (_isAdditional) then {
	if (toLower call TFAR_fnc_activeSwRadio select [0,11] in ["tf_rf7800st","tf_anprc154","tf_pnr1000a"]) exitWith { [parseText "Your SR radio does not support additional", 7] call TFAR_fnc_showHint;};
	if (_channel > 6) then {
		_channel = 7
	};

	if (((call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getAdditionalSwChannel) isNotEqualTo -1) then {
		[true] call FUNC(clearAdditional);
	};

	[(call TFAR_fnc_activeSwRadio), _channel + 1, _frequency] call TFAR_fnc_SetChannelFrequency;
	[(call TFAR_fnc_activeSwRadio), _channel] call TFAR_fnc_setAdditionalSwChannel;
} else {
	[(call TFAR_fnc_activeSwRadio), _channel + 1, _frequency] call TFAR_fnc_SetChannelFrequency;
	[(call TFAR_fnc_activeSwRadio), _channel] call TFAR_fnc_setSwChannel;
};

[(call TFAR_fnc_activeSwRadio), false] call TFAR_fnc_ShowRadioInfo;

true