#include "script_component.hpp"

if (hasInterface) then {
	[] call FUNC(initSpectatorStats);
	[] call FUNC(loadScreen);

	//Add uncon info EH
	private _id = ["ace_unconscious", {
		_this params ["_unit", "_state"];

		if ( _state || { _unit isEqualTo player} ) then {
			_handle = [{
				LOG("Uncon pfh");
				if (!(player getVariable ["ACE_isUnconscious", false]) || {!alive player}) exitWith {
					cutText ["", "PLAIN NOFADE", -1, false, true];
					[_handle] call CBA_fnc_removePerFrameHandler; 
				};

				[] call FUNC(unconInfo);

			}, 5] call CBA_fnc_addPerFrameHandler;
		};
	}] call CBA_fnc_addEventHandler;
};

if (isServer) then {
	private _units = ([switchableUnits, playableUnits] select isMultiplayer);
	GVAR(spectatorInitCountWest) = west countSide _units;
	GVAR(spectatorInitCountEast) = east countSide _units;
	GVAR(spectatorInitCountIndependent) = independent countSide _units;

	publicVariable QGVAR(spectatorInitCountWest);
	publicVariable QGVAR(spectatorInitCountEast);
	publicVariable QGVAR(spectatorInitCountIndependent);
};