#include "script_component.hpp"

[{ !isNil QGVAR(enable) && ((diag_tickTime > _this && isMultiplayer) || !isMultiplayer ) }, {
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
                private _realTime = ((systemTime select 3) * 60 * 60) + ((systemTime select 4) * 60) + (systemTime select 5) + GVAR(value); 
                if (_realTime > 86400) then {
                    _realTime = _realTime - 86400;
                };
                _realTime = [_realTime, "H:MM:SS"] call CBA_fnc_formatElapsedTime;
                private _text = format["Briefing time left: %1 ( %2 )", _time, _realTime];
                (uiNamespace getVariable QGVAR(timeText)) ctrlSetText _text;

                if (cba_missiontime > 0) then {
                    [_handle] call CBA_fnc_removePerFrameHandler;
                    player removeDiarySubject QGVAR(briefingTimeDiary);
                };
            }, 1, []] call CBA_fnc_addPerFrameHandler;
            
            player createDiarySubject [QGVAR(briefingTimeDiary),"Briefing Time"];
            player createDiaryRecord [QGVAR(briefingTimeDiary), ["Briefing Time",
            "Request more briefing time. Do not spam!
            <br/><br/><font size=20><execute expression=' [] call "+QFUNC(openTimeDialog)+"'> Request more time / Modify briefing time</execute></font>"
            ]];

        }] call CBA_fnc_waitUntilAndExecute;
    };
}, (diag_tickTime + 3)] call CBA_fnc_waitUntilAndExecute;