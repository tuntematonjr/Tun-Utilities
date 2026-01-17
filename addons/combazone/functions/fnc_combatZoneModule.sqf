/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * None
 *
 * Return Value:
 * none
 *
 * Example:
 * [] call tunuti_utilities_fnc_combatZone
 */
 
#include "script_component.hpp"

if (!isServer) exitWith {};

private _module = param [0,objNull,[objNull]];
private _markerPreFix = _module getVariable ["markerPreFix", ""];
private _markerCount = _module getVariable ["markerCount", 0];
private _sideWest = _module getVariable ["sideWest", false];
private _sideEast = _module getVariable ["sideEast", false];
private _sideResistance = _module getVariable ["sideResistance", false];
private _sideCiv = _module getVariable ["sideCiv", false];
private _sides = [];

if (_sideWest) then {
	_sides pushBack west;
};

if (_sideEast) then {
	_sides pushBack east;
};

if (_sideResistance) then {
	_sides pushBack resistance;
};

if (_sideCiv) then {
	_sides pushBack civilian;
};

[_sides, _markerPreFix, _markerCount] call FUNC(addCombatZone);
