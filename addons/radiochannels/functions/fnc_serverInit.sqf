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
 * [] call tunuti_radiochannels_fnc_serverInit
 */
#include "script_component.hpp"

LOG("Server init start");
private _radioValuesHash = createHashMap;

ISNILS(GVAR(commandElementID),"10");
ISNILS(GVAR(trimNames),"1234567890 ");

private _untrimmed = GVAR(CommandElementID) splitString ",";
GVAR(HQelement) = [];
{
	GVAR(HQelement) pushBackUnique ([_x] call CBA_fnc_trim);
} forEach _untrimmed;

private _usedFrequencies = [];

private _sr_west = TFAR_defaultFrequencies_sr_west;
private _sr_east = TFAR_defaultFrequencies_sr_east;
private _sr_independent = TFAR_defaultFrequencies_sr_independent;

private _lr_west = TFAR_defaultFrequencies_lr_west;
private _lr_east = TFAR_defaultFrequencies_lr_east;
private _lr_independent = TFAR_defaultFrequencies_lr_independent;

private _playableUnits = playableUnits + switchableUnits;
private _groupsWest = groups west;
private _groupsEast = groups east;
private _groupsIndependent = groups resistance;
FILTER(_groupsWest,{ if (_x in _playableUnits) exitWith {true}; false } forEach units _x);
FILTER(_groupsEast,{ if (_x in _playableUnits) exitWith {true}; false } forEach units _x);
FILTER(_groupsIndependent,{ if (_x in _playableUnits) exitWith {true}; false } forEach units _x);

{
	_x params ["_groups", "_side"];
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
					_usedFrequencies pushBack _lrFrequency;
					INC(_currentLRchannel);
				} else {
					while {true} do {
						_lrFrequency = ([0,87,30,10] call TFAR_fnc_generateFrequencies) select 0;
						if !(_lrFrequency in _usedFrequencies) exitWith {
							_usedFrequencies pushBack _lrFrequency;
						};
					};
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
				_channelSR = 7;
				while {true} do {
					_srFrequency = ([0,512,30,10] call TFAR_fnc_generateFrequencies) select 0;
					if !(_srFrequency in _usedFrequencies) exitWith {
						_usedFrequencies pushBack _srFrequency;
					};
				};
			};

			_srData = [_srFrequency, _channelSR, _squadNameTrimmed, _commandTrimmed];
			_valuesSR_final pushBack _srData;
			
			private _partolFrequencies = [4,512,30,20] call TFAR_fnc_generateFrequencies;
			_group setVariable [QGVAR(radioValues), [_srData, _lrData, _partolFrequencies], true];
		};
	} forEach _groups;

    _radioValuesHash set [_side, [_valuesSR_final,_valuesLR_final]];

} forEach [[_groupsWest, west],[_groupsEast, east], [_groupsIndependent, independent]];

private _tunuti_FNC_create_LR_channel = {
	params ["_values", "_count"];
	private _valuesLR_final = [];
	{
		private _name = _x;
		private _lrFrequency = 0;
		while {true} do {
			_lrFrequency = ([0,87,30,10] call TFAR_fnc_generateFrequencies) select 0;
			if !(_lrFrequency in _usedFrequencies) exitWith {
				_usedFrequencies pushBack _lrFrequency;
			};
		};
		private _channelLR =_count;
		INC(_count);
		if (_channelLR > 6) then {
			_channelLR = 7;
		};

		_valuesLR_final pushBack [_lrFrequency, _channelLR, _name];
	} forEach _values;

	_valuesLR_final
};


{
	_x params ["_side", "_additionalLR"];
	if ((count _additionalLR) isNotEqualTo 0) then {
		private _values = _radioValuesHash getOrDefault [west, [[],[]]];
		private _lrValues = _values select 1;
		private _srValues = _values select 0;
		private _count = (count _lrValues) + 1;
		private _valuesLR_final = [_additionalLR, _count] call _tunuti_FNC_create_LR_channel;
		_lrValues append _valuesLR_final;

		_radioValuesHash set [_side, [_srValues,_lrValues]];
		
	};
} forEach [
			[west, GVAR(additional_LR_west)],
			[east, GVAR(additional_LR_east)],
			[resistance, GVAR(additional_LR_independent)]];

missionNamespace setVariable [QGVAR(radioValues),_radioValuesHash, true];
missionNamespace setVariable [QGVAR(serverDone), true, true];