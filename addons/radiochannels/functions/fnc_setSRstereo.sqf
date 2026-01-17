/*
 * Author: [Tuntematon]
 * Sets SR stereo mode
 *
 * Arguments:
 * 0: Stereo 0 - Both, 1 - Left, 2 - Right <NUMBER>
 * 1: Is additional <BOOL>
 *
 * Return Value:
 * True if changed, false otherwise <BOOL>
 *
 * Example:
 * [0, false] call tunuti_radiochannels_fnc_setSRstereo
 */

#include "script_component.hpp"
params ["_ear", "_isAdditional"];

LOG("set SR stereo");
if (cba_missionTime isEqualTo 0) exitWith { false };
if (!(call TFAR_fnc_haveSWRadio)) exitWith { [parseText "You don't have SR radio", 5] call TFAR_fnc_showHint; false };

if (_isAdditional) then {
	[(call TFAR_fnc_ActiveSWRadio), _ear] call TFAR_fnc_setAdditionalSwStereo;
} else {
	[(call TFAR_fnc_ActiveSWRadio), _ear] call TFAR_fnc_setSwStereo;
};

[(call TFAR_fnc_activeSwRadio)] call TFAR_fnc_ShowRadioVolume;

true
