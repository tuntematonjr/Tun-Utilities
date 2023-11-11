/*
 * Author: [Tuntematon]
 * [Description]
 * Set Stereo for radio
 *
 * Arguments:
 * 0: Stereo 0 - Both, 1 - Left, 2 - Right <NUMBER>
 * 1: IS additional <BOOL>
 *
 * Return Value:
 * True if changed, false if not
 *
 * Example:
 * [0, false] call tunuti_radiochannels_fnc_setLRstereo
 */
#include "script_component.hpp"
params ["_ear", "_isAdditional"];

LOG("set LR stereo");
if (cba_missionTime isEqualTo 0) exitWith { false };
if (!(call TFAR_fnc_haveLRRadio)) exitWith { [parseText "You don't have LR radio", 5] call TFAR_fnc_showHint; false };

if (_isAdditional) then {
	[call TFAR_fnc_activeLrRadio, _ear] call TFAR_fnc_setAdditionalLrStereo;
} else {
	[call TFAR_fnc_activeLrRadio, _ear] call TFAR_fnc_setLrStereo;
};

[(call TFAR_fnc_activeLrRadio)] call TFAR_fnc_ShowRadioVolume;

true