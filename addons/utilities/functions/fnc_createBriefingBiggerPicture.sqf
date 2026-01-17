/*
 * Author: [Tuntematon]
 * Creates briefing text with a clickable larger image
 *
 * Arguments:
 * 0: Text <STRING>
 * 1: Image path <STRING>
 *
 * Return Value:
 * Formatted text <STRING>
 *
 * Example:
 * ["Map", "image.paa"] call tunuti_utilities_fnc_createBriefingBiggerPicture
 */

#include "script_component.hpp"

params ["_text", "_imagePath"];

private _text = format[ "<br/><font face='PuristaBold' size='15'><execute expression='[%4] call %2'>%3 - Click here to open as bigger</execute></font> <br/><img image='%1' width='370m'/>", _imagePath, QFUNC(openBiggerPicture), _text, str _imagePath];

_text
