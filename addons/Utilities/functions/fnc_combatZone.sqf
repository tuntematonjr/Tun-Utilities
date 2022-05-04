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
 * [] call tun_utilities_fnc_combatZone
 */
#include "script_component.hpp"
private _module = param [0,objNull,[objNull]];
private _markerPreFix = _module getVariable ["markerPreFix", ""];
private _markerCount = _module getVariable ["markerCount", 0];
private _updateInterval= _module getVariable ["updateInterval", ""];
private _sound = _module getVariable ["sound", ""];
private _hintText = _module getVariable ["hintText", ""];
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

private _debugText = format ["init combatzone for: %1", _sides];
LOG(_debugText);

[{ !isNull player && ( !isnull findDisplay 52 || !isnull findDisplay 53 || !isnull findDisplay 12 )}, {
	_this params ["_sides", "_markerPrefix", "_markerCount", "_updateInterval", "_hintText", "_sound"];
    if (playerside in _sides && isNil QGVAR(borderPolygon)) then {
        GVAR(borderPolygon) = [];
        for "_i" from 1 to _markerCount do {
            GVAR(borderPolygon) pushBack (getMarkerPos (format ["%2_%1", _i,_markerPrefix]));
        };

        if (isNull findDisplay 12) then {
            private _displayIDD = [53, 52] select !isNull findDisplay 52;
            findDisplay _displayIDD displayCtrl 51 ctrlAddEventHandler ["Draw", {
                _this select 0 drawPolygon [GVAR(borderPolygon), [1,0,0,1]];
            }];
            LOG("Create combatzone for briefing screen");
        };

        [{ controlNull isNotEqualTo (findDisplay 12 displayCtrl 51) }, {
                _this params ["_updateInterval", "_hintText", "_sound"];
                diag_log "combatzone";
                findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw", {
                    _this select 0 drawPolygon [GVAR(borderPolygon), [1,0,0,1]];
                }];
                LOG("Create combatzone for main screen");
            _handle = [{
                _args params ["_hintText", "_sound"];
                if ( player isKindOf "man" && {alive player} && {!(player isKindOf "ace_spectator_virtual")} && {playerSide in [west,east,resistance,civilian]} && {!(vehicle player isKindOf "air")} && {!(player getVariable ["tun_respawn_waiting_respawn", false])} ) then {
                    private _player_pos = getpos player;
                    if !( _player_pos inPolygon GVAR(borderPolygon)) then {
                        [(format["<t color='#ff0000' size = '.8'>%1</t>",_hintText]),-1,-1,4,1,0,789] spawn BIS_fnc_dynamicText;
                        playSound _sound;
                        LOG("player out of AO");
                    };
                };
            }, _updateInterval, [_hintText, _sound]] call CBA_fnc_addPerFrameHandler;
        }, [_updateInterval, _hintText, _sound]] call CBA_fnc_waitUntilAndExecute;
    };
}, [_sides, _markerPrefix, _markerCount, _updateInterval, _hintText, _sound]] call CBA_fnc_waitUntilAndExecute;