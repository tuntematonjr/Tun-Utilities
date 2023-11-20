/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: image path <STRING>
 *
 * Return Value:
 * 
 *
 * Example:
 * [_imagePath] call tunuti_utilities_fnc_openBiggerPicture
 */
#include "script_component.hpp"

params ["_imagePath"];
private _display = findDisplay TUNUTI_FIND_MAPDISPLAY;

private _control = _display createDisplay QGVAR(biggerPictureInBriefingUI);
uiNamespace setVariable [QGVAR(biggerPictureInBriefingUI), _control ];
[{!isNull findDisplay 330000}, {
	private _imagePath = _this;
	_textControl = (uiNamespace getVariable QGVAR(biggerPictureInBriefingUI)) displayCtrl 330001;
	_textControl ctrlSetText _imagePath;
}, _imagePath] call CBA_fnc_waitUntilAndExecute;