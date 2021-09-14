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
 * ["something", player] call tun_radiochannels_fnc_serverInit
 */
#include "script_component.hpp"

GVAR(srWEST) = [];
GVAR(srEAST) = [];
GVAR(srINDEPENDENT) = [];
GVAR(lrWEST) = [];
GVAR(lrEAST) = [];
GVAR(lrINDEPENDENT) = [];

ISNILS(GVAR(commandElementID),"10");
ISNILS(GVAR(trimNames),"1234567890 ");

private _untrimmed = GVAR(CommandElementID) splitString ",";
GVAR(HQelement) = [];
{
	GVAR(HQelement) pushBackUnique ([_x] call CBA_fnc_trim);
} forEach _untrimmed;

private _sr_west = TFAR_defaultFrequencies_sr_west;
private _sr_east = TFAR_defaultFrequencies_sr_east;
private _sr_independent = TFAR_defaultFrequencies_sr_independent;

private _lr_west = TFAR_defaultFrequencies_lr_west;
private _lr_east = TFAR_defaultFrequencies_lr_east;
private _lr_independent = TFAR_defaultFrequencies_lr_independent;

private _groupsWest = allGroups select {side _x isEqualTo west};
private _groupsEast = allGroups select {side _x isEqualTo east};
private _groupsIndependent = allGroups select {side _x isEqualTo independent};

{
	private _groups = _x select 0;
	private _side = _x select 1;
	private _valuesSR = [];
	private _valuesLR = [];
	private _valuesSR_final = [];
	private _valuesLR_final = [];
	private _groupCount = 0;
	private _currentSRchannel = 1;
	private _currentLRchannel = 1;
	

	switch (_side) do {
		case west: { 
			_valuesSR = _sr_west;
			_valuesLR = _lr_west;
			_groupCount = count _groupsWest;
		};
		case east: { 
			_valuesSR = _sr_east;
			_valuesLR = _lr_east;
			_groupCount = count _groupsEast;
		};
		case independent: { 
			_valuesSR = _sr_independent;
			_valuesLR = _lr_independent;
			_groupCount = count _groupsIndependent;
		};
	};

	{
		private _group = _x;
		private _isCommandElement = _group getVariable [QGVAR(isCommandElement), false];
		private _commandTrimmed = ((groupID _group) splitString GVAR(trimNames)) select 0;
		private _squadNameTrimmed = (groupID _group);
		private _lrFrequency = nil;
		private _srFrequency = nil;
		private _lrData = [];
		private _srData = [];

		if (!(_group getVariable [QGVAR(skipSquad), false]) && {!(vehicle leader _group isKindOf "UAV")}) then {
			if ({ (toLower str _group) find toLower _x  isNotEqualTo -1} count GVAR(HQelement) > 0) then {
				_isCommandElement = true;
			};

			if (_isCommandElement) then {
				private _channelLR = _currentLRchannel;

				if (_channelLR <= 7) then {
					_lrFrequency = _valuesLR select (_channelLR - 1);
					INC(_currentLRchannel);
				} else {
					_lrFrequency = ([0,87,30,10] call TFAR_fnc_generateFrequencies) select 0;
				};
				
				if (_channelLR > 6) then {
					_channelLR = 7;
				};

				_lrData = [_lrFrequency, _channelLR, _commandTrimmed];
				_valuesLR_final pushBack _lrData;
			} else {
				private _findLR = _valuesLR_final findIf {(_x select 2) isEqualTo _commandTrimmed};
				if (_findLR isNotEqualTo -1) then {
					_lrData = (_valuesLR_final select _findLR);
				};
			};

			private _channelSR = _currentSRchannel;
			if ((_currentSRchannel < 7 && !_isCommandElement) || (_currentSRchannel < 7 && _groupCount < 8 && _isCommandElement)) then {
				_srFrequency = _valuesSR select (_channelSR - 1);
				INC(_currentSRchannel);
			} else {
				_srFrequency = ([0,512,30,10] call TFAR_fnc_generateFrequencies) select 0;
				_channelSR = 7;
			};

			_srData = [_srFrequency, _channelSR, _squadNameTrimmed, _commandTrimmed];
			_valuesSR_final pushBack _srData;
			
			private _partolFrequencies = [4,512,30,10] call TFAR_fnc_generateFrequencies;
			_group setVariable [QGVAR(radioValues), [_srData, _lrData, _partolFrequencies], true];
		};
	} forEach _groups;


	switch (_side) do {
		case west: { 
			GVAR(srWEST) = _valuesSR_final;
			GVAR(lrWEST) = _valuesLR_final;
		};
		case east: { 
			GVAR(srEAST) = _valuesSR_final;
			GVAR(lrEAST) = _valuesLR_final;
		};
		case independent: { 
			GVAR(srINDEPENDENT) = _valuesSR_final;
			GVAR(lrINDEPENDENT) = _valuesLR_final;
		};
	};

} forEach [[_groupsWest, west],[_groupsEast, east], [_groupsIndependent, independent]];

private _Tun_FNC_create_LR_channel = {
	params ["_values", "_count"];

	private _valuesLR_final = [];
	{
		private _name = _x;
		private _lrFrequency = ([0,87,30,10] call TFAR_fnc_generateFrequencies) select 0;
		private _channelLR =_count;
		INC(_count);
		if (_channelLR > 6) then {
			_channelLR = 7;
		};

		_valuesLR_final pushBack [_lrFrequency, _channelLR, _name];
	} forEach _values;

	_valuesLR_final
};

if ((count GVAR(additional_LR_west)) isNotEqualTo 0) then {
	private _count = (count GVAR(lrWEST)) + 1;
	private _valuesLR_final = [GVAR(additional_LR_west), _count] call _Tun_FNC_create_LR_channel;
	GVAR(lrWEST) append _valuesLR_final;
};

if ((count GVAR(additional_LR_east)) isNotEqualTo 0) then {
	private _count = (count GVAR(lrEAST)) + 1;
	private _valuesLR_final = [GVAR(additional_LR_east), _count] call _Tun_FNC_create_LR_channel;
	GVAR(lrEAST) append _valuesLR_final;
};

if ((count GVAR(additional_LR_independent)) isNotEqualTo 0) then {
	private _count = (count GVAR(lrINDEPENDENT)) + 1;
	private _valuesLR_final = [GVAR(additional_LR_independent), _count] call _Tun_FNC_create_LR_channel;
	GVAR(lrINDEPENDENT) append _valuesLR_final;
};

publicVariable QGVAR(lrWEST);
publicVariable QGVAR(lrEAST);
publicVariable QGVAR(lrINDEPENDENT);

publicVariable QGVAR(srWEST);
publicVariable QGVAR(srEAST);
publicVariable QGVAR(srINDEPENDENT);

GVAR(serverDone) = true;
publicVariable QGVAR(serverDone);