#include "script_component.hpp"

[{ !isNil QGVAR(enable)}, {
    if (isServer && isMultiplayer && GVAR(enable)) then {


        _handle = [{
            if (GVAR(value) > 0) then {
                DEC(GVAR(value));
                publicVariable QGVAR(value);
            };
            if (cba_missiontime > 0) then {
                [_handle] call CBA_fnc_removePerFrameHandler;
            };
        }, 1, []] call CBA_fnc_addPerFrameHandler;
    };

    if (hasInterface && isMultiplayer && GVAR(enable)) then {
        GVAR(Notifications) = [];
        [{ !isNull findDisplay 53 || !isNull findDisplay 52 }, {

            private _display = [53, 52] select !isNull findDisplay 52;

            private _control = findDisplay _display ctrlCreate [QGVAR(timeText), 320001];
            uiNamespace setVariable [QGVAR(timeText), _control ];

            _handle = [{
                private _time = [GVAR(value), "M:SS"] call CBA_fnc_formatElapsedTime;
                private _text = format["Briefing time left: %1", _time];
                (uiNamespace getVariable QGVAR(timeText)) ctrlSetText _text;

                if (cba_missiontime > 0) then {
                    [_handle] call CBA_fnc_removePerFrameHandler;
                    player removeDiarySubject QGVAR(briefingTimeDiary);
                };
            }, 1, []] call CBA_fnc_addPerFrameHandler;

            player createDiarySubject [QGVAR(briefingTimeDiary),"Briefing Time"];
            player createDiaryRecord [QGVAR(briefingTimeDiary), ["Briefing Time",
            "Do not abuse!
            <br/><br/><font size=20><execute expression=' [] call "+QFUNC(openTimeDialog)+"'> Request more time / Modify briefing time</execute>
            </font>"
            ]];

        }] call CBA_fnc_waitUntilAndExecute;
    };
}] call CBA_fnc_waitUntilAndExecute;