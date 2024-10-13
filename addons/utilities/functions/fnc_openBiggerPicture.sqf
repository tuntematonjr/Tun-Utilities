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

private _display = uiNamespace getVariable [QGVAR(biggerPictureInBriefingUI), displayNull];

if (!isNull _display) then {
	_display closeDisplay 1;
};

private _control = findDisplay TUNUTI_FIND_MAPDISPLAY createDisplay QGVAR(biggerPictureInBriefingUI);
uiNamespace setVariable [QGVAR(biggerPictureInBriefingUI), _control];

[{!isNull findDisplay BIGGER_PICTURE_MAIN_IDD}, {
	private _imagePath = _this;
	_textControl = (uiNamespace getVariable QGVAR(biggerPictureInBriefingUI)) displayCtrl BIGGER_PICTURE_IMAGE_IDC;
	_textControl ctrlSetText _imagePath;
}, _imagePath] call CBA_fnc_waitUntilAndExecute; 