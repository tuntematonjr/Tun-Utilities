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
private _module = param [0,objNull,[objNull]];
private _markerPreFix = _module getVariable ["markerPreFix", ""];
private _markerCount = _module getVariable ["markerCount", 0];
private _updateInterval= _module getVariable ["updateInterval", ""];
//private _sound = _module getVariable ["sound", ""];
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

[{ !isNull player && ( !isNull findDisplay 52 || !isNull findDisplay 53 || !isNull findDisplay 12 )}, {
	_this params ["_sides", "_markerPrefix", "_markerCount", "_updateInterval", "_hintText"];
	if (playerSide in _sides && isNil QGVAR(borderPolygon)) then {
		GVAR(borderPolygon) = [];
		for "_i" from 1 to _markerCount do {
			GVAR(borderPolygon) pushBack (getMarkerPos (format ["%2_%1", _i,_markerPrefix]));
		};

		if (isNull findDisplay 12) then {
			private _displayIDD = TUNUTI_FIND_MAPDISPLAY;
			findDisplay _displayIDD displayCtrl 51 ctrlAddEventHandler ["Draw", {
				_this select 0 drawPolygon [GVAR(borderPolygon), [1,0,0,1]];
			}];
			LOG("Create combatzone for briefing screen");
		};

		[{ controlNull isNotEqualTo (findDisplay 12 displayCtrl 51) }, {
				_this params ["_updateInterval", "_hintText"];
				findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw", {
					_this select 0 drawPolygon [GVAR(borderPolygon), [1,0,0,1]];
				}];
				LOG("Create combatzone for main screen");
			_handle = [{
				_args params ["_hintText"];
				if ( ace_player isKindOf "man" && {alive ace_player} && {!(ace_player isKindOf "ace_spectator_virtual")} && {playerSide in [west,east,resistance,civilian]} && {!(vehicle ace_player isKindOf "air")} && {!(ace_player getVariable ["tunres_Respawn_isWaitingRespawn", false])} ) then {
					private _player_pos = getPos ace_player;
					if !( _player_pos inPolygon GVAR(borderPolygon)) then {
						[(format["<t color='#ff0000' size = '.8'>%1</t>",_hintText]),-1,-1,4,1,0,789] spawn BIS_fnc_dynamicText;
						if (IS_ADMIN) then {
							ace_player sideChat "You are admin, hope you are not crossing the AO line without reason. Please turn back.";
						} else {
						switch (ceil random 3) do {
								case 1: { 
									playSound3D ['a3\dubbing_f_epa\zone_restriction\A_Warn_No_Leader\zone_restriction_a_warn_no_leader_KER_0.ogg', ace_player];
									[[profileName, "Where the hell am I? I should check my map.", 0]] spawn BIS_fnc_EXP_camp_playSubtitles;
								};
								case 2: { 
									playSound3D ['a3\dubbing_f_epa\zone_restriction\A_Warn_No_Leader\zone_restriction_a_warn_no_leader_KER_1.ogg', ace_player];
									[[profileName, "This doesn't look right at all. Where am I?", 0]] spawn BIS_fnc_EXP_camp_playSubtitles;
								};
								case 3: { 
									playSound3D ['a3\dubbing_f_epa\zone_restriction\A_Warn_No_Leader\zone_restriction_a_warn_no_leader_KER_2.ogg', ace_player];
									[[profileName, "Wow, I must be way off course. Better check my map.", 0]] spawn BIS_fnc_EXP_camp_playSubtitles;
								};
							};
						};
						LOG("player out of AO");
					};
				};
			}, _updateInterval, [_hintText]] call CBA_fnc_addPerFrameHandler;
		}, [_updateInterval, _hintText]] call CBA_fnc_waitUntilAndExecute;
	};
}, [_sides, _markerPrefix, _markerCount, _updateInterval, _hintText]] call CBA_fnc_waitUntilAndExecute;