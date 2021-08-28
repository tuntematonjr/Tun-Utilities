/*
 * Author: [Tuntematon]
 * [Description]
 * Clear additional
 *
 * Arguments:
 * 0: is SR radio <BOOL>
 *
 * Return Value:
 * True if changed, false if not
 *
 * Example:
 * [true] call tun_radiochannels_fnc_clearAdditional
 */
#include "script_component.hpp"
params ["_isSR"];


if (cba_missionTime isEqualTo 0) exitWith { false };

if (_isSR) then {
	if (!(call TFAR_fnc_haveSWRadio)) exitWith { false };
	if (((call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getAdditionalSwChannel) isNotEqualTo -1) then {
		[(call TFAR_fnc_activeSwRadio), ((call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getAdditionalSwChannel)] call TFAR_fnc_setAdditionalSwChannel;
	};
} else {
	if (!(call TFAR_fnc_haveLRRadio)) exitWith { false };
	if (((call TFAR_fnc_ActiveLrRadio) call TFAR_fnc_getAdditionalLrChannel) isNotEqualTo -1) then {
		[call TFAR_fnc_activeLrRadio, ((call TFAR_fnc_ActiveLrRadio) call TFAR_fnc_getAdditionalLrChannel) ] call TFAR_fnc_setAdditionalLrChannel;
	};
};

true