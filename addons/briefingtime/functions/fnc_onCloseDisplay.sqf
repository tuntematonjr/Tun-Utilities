/*
 * Author: [Tuntematon]
 * [Description]
 *
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call tunuti_briefingtime_fnc_onCloseDisplay
 */
#include "script_component.hpp"

private _newTime = sliderPosition ((uiNamespace getVariable QGVAR(Time)) displayCtrl SLIDER_IDC);

//Create notification and admin will modify
if (IS_ADMIN) then {
	//Update time
	_newTime = _newTime * 60;
	GVAR(briefingTime) = _newTime;
	publicVariable QGVAR(briefingTime);
	private _debugText = format ["set new time: %1", _newTime];
	LOG(_debugText);
	["Briefing time has been modified"] remoteExecCall [QFUNC(notification), [0,-2] select isDedicated, false];
} else {
	private _text = format ["%2 (%1) Has requested an additional %3 minutes of briefing time.", playerSide, profileName, _newTime];
	private _debugText = format ["ask new time: %1", _text];
	LOG(_debugText);
	[_text] remoteExecCall [QFUNC(notification), [0,-2] select isDedicated, false];
};
