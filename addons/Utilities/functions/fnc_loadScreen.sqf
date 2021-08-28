/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: Time <number>
 *
 * Return Value:
 * None
 *
 * Example:
 * [20] call tun_utilities_fnc_loadScreen
 */
#include "script_component.hpp"
params [["_time", round(count allUnits / 10)], ["_rulesHint", false]];

if (!isMultiplayer) exitWith { }; // skip if singleplayer

[{!isNull player && cba_missiontime > 0}, {
    if !(playerside in [west, east, resistance, civilian]) exitWith { };
	_this params ["_time", "_rulesHint"];
    tun_loadscreen_done = false;

    if (_time < 15) then {
        _time = 15;
    };
    
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
            cutText["Ladataan Tehtävää \n Loading mission", "PLAIN", 5, true];
            [_handle] call CBA_fnc_removePerFrameHandler;
            tun_loadscreen_done = true;
        } else {
            cutText[format ["Ladataan Tehtävää \n Loading mission \n %1", _time], "PLAIN", 1, true];
        };
    }, 1, _time] call CBA_fnc_addPerFrameHandler;

    // Destroy camera after loadtime is done
    [{tun_loadscreen_done}, {
        private _camera = _this select 0;
        player cameraEffect ["terminate","back"];
        camDestroy _camera;
        cutText["", "BLACK IN", 5];
        openMap [false, false];
		if (_this select 1) then {
		"The Ten Commandments" hintC [
			"1. Be polite, kind and consider others in all situations",
			"2. Play fair. Don’t cheat/hack/ghost.",
			"3. Listen to the event host and admin",
			"4. Act according to your leaders intent",
			"5. Do not use any enemy vehicles or equipment unless specifically instructed by the mission",
			"6. Do not misuse markers.",
			"7. Do not solo. Always accompany your friendly forces. If separated, find friendly forces.",
			"8. Do not loot dead bodies for additional equipment during mission start.",
			"9. There is picture of each sides soldier in briefing. Take good look at them in INTEL tab in briefing, to prevent Blue on Blue!!!",
			"10. Good Luck & Have fun"];
		};
    }, [_camera, _rulesHint]] call CBA_fnc_waitUntilAndExecute;

}, [_time, _rulesHint]] call CBA_fnc_waitUntilAndExecute;