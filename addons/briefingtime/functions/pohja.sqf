/*
 * Author: [Tuntematon]
 * Template function header for the briefingtime addon
 *
 * Arguments:
 * 0: The first argument <STRING>
 * 1: The second argument which contains sub values <ARRAY>
 *     0: Number of bananas <NUMBER>
 *     1: Banana color RGBA <ARRAY of NUMBERs>
 * 2: Multiple input types <STRING or ARRAY or CODE>
 * 3: Optional input <BOOL> (default: true)
 * 4: Optional input with multiple types <CODE or STRING> (default: {true})
 * 5: Not mandatory input <STRING> (default: "")
 *
 * Return Value:
 * The return value <BOOL>
 *
 * Example:
 * ["something", [2, [1, 1, 0, 1]], {}, false, {false}] call tunuti_briefingtime_fnc_pohja
 */

#include "script_component.hpp"
