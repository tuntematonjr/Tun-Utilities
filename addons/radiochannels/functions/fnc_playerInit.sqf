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
 * [] call tunuti_radiochannels_fnc_playerInit
 */
#include "script_component.hpp"

if ([west,east,resistance] find playerSide isEqualTo -1) exitWith { };

LOG("Player init start");

private _radioValues = GVAR(radioValues) getOrDefault [playerSide, [[],[]]];
private _srValues = _radioValues select 0;
private _lrValues = _radioValues select 1;

private _text = "<font face='PuristaBold' size='20'>Long Range Net(s)</font><br/><br/>";

{ 
	_x params ["_frequency", "_channel", "_name"];
	_frequency = [_frequency] call FUNC(checkFrequency);
	private _index = _forEachIndex;
	_text = _text + format ["[<execute expression='[%6,false] call %5;'>Set LR</execute> - <execute expression='[%6,true] call %5;'>Set LR Additional</execute> - <execute expression='[%6,2,true] call %4;'>Set SR Additional</execute> ] Channel: %1 (%2) - %3<br/>", _channel, _frequency, toUpper _name, QFUNC(setSRchannel), QFUNC(setLRchannel), _index];
} forEach _lrValues;

_text = _text + "<br/><br/><font face='PuristaBold' size='20'>Squad Net(s)</font>";

private _commandTrimmedLast = "";
{ 
	_x params ["_frequency", "_channel", "_name", "_commandTrimmed"];
	_frequency = [_frequency] call FUNC(checkFrequency);
	private _divader = "<br/>";
	private _index = _forEachIndex;
	if (_commandTrimmed isNotEqualTo _commandTrimmedLast) then {
		_divader = "<br/><br/>";
	};

	private _space = " ";
	if (parseNumber _frequency < 100) then {
		_space = "   ";
	};
	_text = _text + (format ["%4[ <execute expression='[%7,1] call %5;'>Set</execute> - <execute expression='[%7,2] call %5;'>Set Additional</execute> ] Channel: %1 (%2)%6- %3", _channel, _frequency, _name, _divader, QFUNC(setSRchannel), _space, _index]);

	_commandTrimmedLast = _commandTrimmed;
} forEach _srValues;

_text = _text + (format ["<br/><br/><execute expression='[true] call %1;'>Clear SR additional</execute> - <execute expression='[false] call %1;'>Clear LR additional</execute>", QFUNC(clearAdditional)]);

_text = _text + (format ["<br/><br/>Radio channels are set automatically after mission start.<br/>It will try to find LR net for you, if you are in Alpha platoon, it will set LR to Alpha LR net if found, if not found no LR set.<br/>If you dont have LR, it will set your command net to your SR additional.<br/><br/>Buttons will start to work after the game begins.<br/>Channel 7 is reserved for separately defined frequencies.<br/>Channel 8 is for additional channels.<br/><br/><font color='#4F4F4F' size='11'>Powered By TuntematonEngine v%1.%2.%3.%4</font>", MAJOR, MINOR, PATCH, BUILD]);

player createDiaryRecord ["Diary",["Command & Signal",_text]];
player createDiarySubject ["Command & Signal","Command & Signal", QPATHTOF(images\TunUti_Radios.paa)];
player createDiaryRecord ["Command & Signal",["Command & Signal",_text]];

[{ cba_missionTime > 0 && {!isNull player}  && {TFAR_core_SettingsInitialized}}, {
	LOG("Player start auto set radios");
	if (GVAR(enableAutoSetup)) then {
		[{
			if (GVAR(enableAutoSetup)) then {
				private _values = (group player) getVariable [QGVAR(radioValues), [[],[],[]]];

				private _lrStatement = {
					LOG("Player LR auto set");
					if ((count (_this select 1) > 0)) then {
						LOG("Auto set LR");
						[nil, false, true] call FUNC(setLRchannel);
					};
				};

				private _timeoutCodeLR = {
					LOG("Player LR auto set to SR");
					if ((count (_this select 1) > 0) && leader group player isEqualTo player) then {
						LOG("Auto set LR to SR");
						//LR skipped, try to put those so SR
						[nil, 2, true, true] call FUNC(setSRchannel);
					};
				};

				private _srStatement = {
					LOG("Player SR auto set");
					if ((count (_this  select 0) > 0)) then {
						LOG("Auto set SR");
						[nil, 1, false, true] call FUNC(setSRchannel);
					}; 
				};

				[{call TFAR_fnc_haveLRRadio}, _lrStatement, _values, 20, _timeoutCodeLR] call CBA_fnc_waitUntilAndExecute;   
				[{call TFAR_fnc_haveSWRadio}, _srStatement, _values, 20] call CBA_fnc_waitUntilAndExecute;
				[{[parseText "Automatic radio settings applied", 5] call TFAR_fnc_showHint; }, nil, 3] call CBA_fnc_waitAndExecute;
				[] call FUNC(createAceActions);
			};
		}, nil, 3] call CBA_fnc_waitAndExecute;
	};
}] call CBA_fnc_waitUntilAndExecute;