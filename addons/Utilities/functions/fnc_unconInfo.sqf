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
 * [] call tun_utilities_fnc_unconInfo
 */
#include "script_component.hpp"

if !(GVAR(allowUnconInfo)) exitWith { };

private _distance = 50;
private _nearUnits = (player nearEntities ["CAManBase", _distance]) - [player];
FILTER(_nearUnits, playerside isEqualTo side _x);
private _closestUnit = objNull;
private _closestMedic = objNull;
private _closestUnitDistance = _distance;
private _closestMedicDistance = _distance;

{
	private _unit = _x;
	private _distance = player distance _unit;
	if (_distance <= _closestUnitDistance && {!(_unit getVariable ["ACE_isUnconscious", false])}) then {
		_closestUnit = _unit;
		_closestUnitDistance = _distance;
	};

	if ([_unit] call ace_common_fnc_isMedic && {_distance <= _closestMedicDistance}) then {
		_closestMedic = _unit;
		_closestMedicDistance = _distance;           
	};
} forEach _nearUnits;

private _text ="You sense that<br/>";

if (player getvariable ["ace_medical_woundBleeding", 0] > 0) then {
	_text = _text + "You are bleeding<br/>";
};

if (player getvariable ["ace_medical_heartRate", 0] > 0) then {
	_text = _text + "You still have pulse<br/>";
};

if (player getvariable ["ace_medical_inCardiacArrest", false]) then {
	_text = _text + "You are in cardiac arrest<br/>";
};

if ([player] call ace_medical_status_fnc_hasStableVitals) then {
	_text = _text + "You have stable vitals (you can wake up)<br/>";
} else {
	_text = _text + "You don't have stable vitals (you can't wake up)<br/>";
};

if ([player, "Epinephrine"] call ace_medical_status_fnc_getMedicationCount > 0) then {
	_text = _text + "You have epipherine in your system (huge increase on waking up)<br/>";
};

if (_closestUnit isNotEqualTo objNull) then {
	if (_closestMedic isNotEqualTo objNull) then {
		if (_closestUnit isEqualTo _closestMedic) then {
			_text = format["%1Closest unit is %2 and is also medic (%3m)",_text, name _closestUnit, round _closestUnitDistance];
		} else {
			_text = format["%1Closest unit is %2 (%3m)<br/>Closest medic is %4 (%5m)",_text, name _closestUnit, round _closestUnitDistance, name _closestMedic, round _closestMedicDistance];
		};
	} else {
		_text = format["%1Closest unit is %2 (%3m), but no medics nearby",_text, name _closestUnit, round _closestUnitDistance];
	};
} else {
	_text = _text + "There are no friendlies nearby";

	if ((player getvariable ["ace_medical_woundBleeding", 0] > 0) && !([player] call ace_medical_status_fnc_hasStableVitals)) then {
		_text = _text + "<br/>Your current sitsuation is not looking very good, you can try and wait or feel free to just press Esc -> Respawn.";
	};
};

cutText ["<t size='2'>"+_text+"</t>", "PLAIN NOFADE" , -1, false, true];