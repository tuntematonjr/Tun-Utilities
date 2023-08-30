/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [] call tun_startmarkers_fnc_sortAllowedSides
 */
#include "script_component.hpp"

private _playerSide = playerSide;
if (_playerSide isNotEqualTo civilian) then {
	LOG("Briefing player init: Normal");
	REM(GVAR(allowedSidesBFT), civilian);
	REM(GVAR(allowedSidesStarmarker), civilian);
	{
		private _side = _x;
		if (_side in GVAR(allowedSidesBFT) && { [_side, _playerSide] call BIS_fnc_sideIsEnemy }) then {
			REM(GVAR(allowedSidesBFT),_side);
		};
		
		if (_side in GVAR(allowedSidesStarmarker) && { [_side, _playerSide] call BIS_fnc_sideIsEnemy }) then {
			REM(GVAR(allowedSidesStarmarker),_side);
		};
	} forEach [west,east,resistance];
} else {
	if (_playerSide isEqualTo civilian) then {
		LOG("Briefing player init: Civilian");
		GVAR(allowedSidesBFT) = [civilian];
		GVAR(allowedSidesStarmarker) = [civilian];
	} else {
		LOG("Briefing player init: Outsider");
		GVAR(allowedSidesBFT) = [];
		GVAR(allowedSidesStarmarker) = [west,east,resistance,civilian];
	};
};