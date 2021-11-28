/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call tun_utilities_fnc_loadScreen
 */
#include "script_component.hpp"
if (!isMultiplayer) exitWith { }; // skip if singleplayer

[{!isNull player && !isNull findDisplay 12 && !isNil QGVAR(runLoadScreen)}, {
    if (GVAR(runLoadScreen)) exitWith { };
    if !(playerside in [west, east, resistance, civilian]) exitWith { };
    LOG("Start load screen");
	private _time = GVAR(loadScreenTime);
    tun_loadscreen_done = false;
  
    _camera = "camera" camCreate [(getPos player select 0),(getPos player select 1),100];
    _camera cameraEffect ["internal","back"];
    _camera camSetFOV 0.700;
    _camera camSetTarget player;
    _camera camCommit 0;
	openMap [true, true];
    //Run loadscreen text loop
    [{
        _time = ceil (_args - cba_missiontime);

        if (_time <= 0) then {
            cutText[GVAR(loadScreenText), "PLAIN", 5, true];
            [_handle] call CBA_fnc_removePerFrameHandler;
            tun_loadscreen_done = true;
        } else {
            cutText[format ["%2\n%1", _time, GVAR(loadScreenText)], "PLAIN", 1, true];
        };
    }, 1, _time] call CBA_fnc_addPerFrameHandler;

    // Destroy camera after loadtime is done
    [{tun_loadscreen_done}, {
        private _camera = _this;
        player cameraEffect ["terminate","back"];
        camDestroy _camera;
        cutText["", "BLACK IN", 5];
        openMap [false, false];
		if (GVAR(rulesHintEnable)) then {
		GVAR(rulesTitleText) hintC GVAR(rulesMessageText);
		};
        LOG("End load screen");
    }, _camera] call CBA_fnc_waitUntilAndExecute;

}] call CBA_fnc_waitUntilAndExecute;

