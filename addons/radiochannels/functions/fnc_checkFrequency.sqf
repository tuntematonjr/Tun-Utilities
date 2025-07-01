/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: frequency to check <NUMBER>
 *
 * Return Value:
 * Valid frequency
 *
 * Example:
 * [frequency] call tunuti_radiochannels_fnc_checkFrequency
 */
#include "script_component.hpp"
params [["_frequency", nil, [""]]];

_frequency = parseNumber _frequency;
if (_frequency isEqualTo (round _frequency)) then {
	_frequency = round _frequency;
};

str _frequency
