/*
 * Author: [Tuntematon]
 * Forces players into map view during load to reduce desync
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call tunuti_utilities_fnc_loadScreen
 */

 
#include "script_component.hpp"
INFO("Called desync load screen");
if (!isMultiplayer) exitWith { LOG("Skip desync load screen in SP"); }; // skip if singleplayer

[{!isNull player && !isNull findDisplay 12 && !isNil QGVAR(runLoadScreen)}, {
	if (!GVAR(runLoadScreen)) exitWith { INFO("Desync load screen disabled"); };
	private _allPlayers = count(call BIS_fnc_listPlayers);
	if (_allPlayers < 10) exitWith { INFO("Desync load disabled under 10 players"); };
	if !(playerSide in [west, east, resistance, civilian]) exitWith { INFO("Not in right side, so skip desync load screen"); };
	if (10*60 < cba_missiontime) exitWith { INFO("Mission has started already"); };
	INFO("Start desync load screen");
	GVAR(loadScreenTimer) = GVAR(loadScreenTime);

	if (cba_missiontime > GVAR(loadScreenTime)) then {
		GVAR(loadScreenTimer) = (GVAR(loadScreenTime) / 2);
	};

	GVAR(loadscreenDone) = false;
	player enableSimulationGlobal false;
	
	private _camera = "camera" camCreate [(getPos player select 0),(getPos player select 1),100];
	_camera cameraEffect ["internal","back"];
	_camera camSetFov 0.700;
	_camera camSetTarget player;
	_camera camCommit 0;
	openMap [true, true];
	//Run loadscreen text loop
	private _debugText = format ["Desync load screen start time: %1", cba_missiontime]; 
	INFO(_debugText);
	
	[{
		params ["_args", "_handle"];
		if (GVAR(loadScreenTimer) <= 0) then {
			titleText [GVAR(loadScreenText), "PLAIN", 5, true];
			titleFadeOut 5;
			[_handle] call CBA_fnc_removePerFrameHandler;
			GVAR(loadscreenDone) = true;
		} else {
			titleText [format ["%2\n%1", GVAR(loadScreenTimer), GVAR(loadScreenText)], "PLAIN", 1, true];
			titleFadeOut 5;
			GVAR(loadScreenTimer) = GVAR(loadScreenTimer) - 1;
		};
	}, 1] call CBA_fnc_addPerFrameHandler;

	// Destroy camera after loadtime is done
	[{GVAR(loadscreenDone)}, {
		private _camera = _this;
		player cameraEffect ["terminate","back"];
		camDestroy _camera;
		titleText ["", "PLAIN"];
		openMap [false, false];
		if (GVAR(rulesHintEnable)) then {
			GVAR(rulesTitleText) hintC GVAR(rulesMessageText);
		};
		
		player enableSimulationGlobal true;
		private _debugText = format ["Desync load screen end time: %1", cba_missiontime]; 
		INFO(_debugText);
	}, _camera] call CBA_fnc_waitUntilAndExecute;

}] call CBA_fnc_waitUntilAndExecute;
