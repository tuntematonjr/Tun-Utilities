﻿/*
 * Author: KoffeinFlummi. Modified by Tuntematon
 * Get the apropriate marker for a group.
 * Loaned from ace. https://github.com/acemod/ACE3/blob/master/addons/common/functions/fnc_getMarkerType.sqf
 * all credits for orignal author and ACE team. And i take all responsibility if this is not working because i modified it.
 *
 * Arguments:
 * 0: Group <GROUP>
 *
 * Return Value:
 * Marker Type <STRING>
 *
 * Example:
 * ["GROUP"] call Tun_startmarkers_fnc_squadIcon
 */
#include "script_component.hpp"

params ["_group"];

private _leader = leader _group;
private _vehicle = vehicle _leader;
private _side = side _leader;

private _groupID = groupId _group;

private _isHQ = {
    private _return = _x in _groupID;
    if (_return) exitWith {
        true
    };
    false
} forEach (GVAR(commandElementID) splitString ",");

if ( _isHQ ) exitWith {
    ["n_hq", "b_hq", "o_hq"] select ((["GUER", "WEST", "EAST"] find str _side) max 0)
};  

if (_vehicle == _leader) exitWith {
    if (
        getNumber (configFile >> "CfgVehicles" >> typeOf _leader >> "detectSkill") > 20 ||
        getNumber (configFile >> "CfgVehicles" >> typeOf _leader >> "camouflage") < 1 ||
        getText   (configFile >> "CfgVehicles" >> typeOf _leader >> "textsingular") == "diver"
    ) then {
        ["n_recon", "b_recon", "o_recon"] select ((["GUER", "WEST", "EAST"] find str _side) max 0)
    } else {
        ["n_inf", "b_inf", "o_inf"] select ((["GUER", "WEST", "EAST"] find str _side) max 0)
    };
};

if (getNumber (configFile >> "CfgVehicles" >> typeOf _vehicle >> "attendant") == 1) exitWith {
    ["n_med", "b_med", "o_med"] select ((["GUER", "WEST", "EAST"] find str _side) max 0)
};

if (
    getNumber (configFile >> "CfgVehicles" >> typeOf _vehicle >> "transportRepair") > 0 ||
    getNumber (configFile >> "CfgVehicles" >> typeOf _vehicle >> "transportFuel") > 0 ||
    getNumber (configFile >> "CfgVehicles" >> typeOf _vehicle >> "transportAmmo") > 0 ||
    getNumber (configFile >> "CfgVehicles" >> typeOf _vehicle >> "ACE_canRepair") > 0 ||
    getNumber (configFile >> "CfgVehicles" >> typeOf _vehicle >> "ACE_fuelCapacityCargo") > 0
) exitWith {
    ["n_maint", "b_maint", "o_maint"] select ((["GUER", "WEST", "EAST"] find str _side) max 0)
};

if (_vehicle isKindOf "Plane") exitWith {
    ["n_plane", "b_plane", "o_plane"] select ((["GUER", "WEST", "EAST"] find str _side) max 0)
};

if (_vehicle isKindOf "Air") exitWith {
    ["n_air", "b_air", "o_air"] select ((["GUER", "WEST", "EAST"] find str _side) max 0)
};

if (_vehicle isKindOf "StaticMortar") exitWith {
    ["n_mortar", "b_mortar", "o_mortar"] select ((["GUER", "WEST", "EAST"] find str _side) max 0)
};

if (getNumber (configFile >> "CfgVehicles" >> typeOf _vehicle >> "artilleryScanner") == 1) exitWith {
    ["n_art", "b_art", "o_art"] select ((["GUER", "WEST", "EAST"] find str _side) max 0)
};

if (_vehicle isKindOf "Car") exitWith {
    ["n_motor_inf", "b_motor_inf", "o_motor_inf"] select ((["GUER", "WEST", "EAST"] find str _side) max 0)
};

if (_vehicle isKindOf "Tank") exitWith {
    if (getNumber (configFile >> "CfgVehicles" >> typeOf _vehicle >> "transportSoldier") > 0 && (count units _group) > 4) then {
        ["n_mech_inf", "b_mech_inf", "o_mech_inf"] select ((["GUER", "WEST", "EAST"] find str _side) max 0)
    } else {
        ["n_armor", "b_armor", "o_armor"] select ((["GUER", "WEST", "EAST"] find str _side) max 0)
    };
};

if (_vehicle isKindOf "Ship") exitWith {
    ["n_naval", "b_naval", "o_naval"] select ((["GUER", "WEST", "EAST"] find str _side) max 0)
};

// generic marker
["n_unknown", "b_unknown", "o_unknown"] select ((["GUER", "WEST", "EAST"] find str _side) max 0)