/*
 * Author: [Tuntematon]
 * Normalizes a frequency value and returns it as a string
 *
 * Arguments:
 * 0: Frequency to check <STRING or NUMBER>
 *
 * Return Value:
 * Valid frequency <STRING>
 *
 * Example:
 * ["123.4"] call tunuti_radiochannels_fnc_checkFrequency
 */

#include "script_component.hpp"
params [["_frequency", nil, [""]]];

_frequency = parseNumber _frequency;
if (_frequency isEqualTo (round _frequency)) then {
	_frequency = round _frequency;
};

str _frequency
