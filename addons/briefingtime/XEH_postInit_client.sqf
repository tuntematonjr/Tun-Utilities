#include "script_component.hpp"
 
if (isMultiplayer) then {
	[{ ADDON && !isNil "cba_missiontime" }, {
		if (GVAR(enable)) then {
			GVAR(Notifications) = [];

			[{ !isNull findDisplay 53 || !isNull findDisplay 52 }, {
				private _display = TUNUTI_FIND_MAPDISPLAY;
				private _control = findDisplay _display ctrlCreate [QGVAR(timeText), TIME_TEXT_IDC];
				uiNamespace setVariable [QGVAR(timeText), _control ];

				_handle = [{
					private _time = [GVAR(briefingTime), "M:SS"] call CBA_fnc_formatElapsedTime;
					private _realTime = ((systemTime select 3) * 60 * 60) + ((systemTime select 4) * 60) + (systemTime select 5) + GVAR(briefingTime); 
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
	}] call CBA_fnc_waitUntilAndExecute;
};
