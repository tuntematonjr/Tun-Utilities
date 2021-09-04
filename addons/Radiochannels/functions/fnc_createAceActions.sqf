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
 * [] call tun_radiochannels_fnc_createAceActions
 */
#include "script_component.hpp"

//RADIO POHJAT
private _radioBase = ['RadioBase', "Radio Settings", QPATHTOF(kuvat\Radiot.paa), {}, {call TFAR_fnc_haveSWRadio || call TFAR_fnc_haveLRRadio}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _radioBase] call ace_interact_menu_fnc_addActionToObject;

private _SWradio= ['SR_Radio', "SR Radio", QPATHTOF(kuvat\SW_Radio.paa),{}, {call TFAR_fnc_haveSWRadio}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "RadioBase"], _SWradio] call ace_interact_menu_fnc_addActionToObject;

private _LRradio= ['LR_Radio', "LR Radio", QPATHTOF(kuvat\LR_Radio.paa), {},  {true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "RadioBase"], _LRradio] call ace_interact_menu_fnc_addActionToObject;

private _radioStereo = ['Stereo', "Stereo", QPATHTOF(kuvat\headset.paa), {},  {true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "RadioBase"], _radioStereo] call ace_interact_menu_fnc_addActionToObject;

private _srValues = [];
private _lrValues = [];
switch (playerSide) do {
	case west: { 
		_srValues = GVAR(srWEST);
		_lrValues =  GVAR(lrWEST);
	};
	case east: { 
		_srValues = GVAR(srEAST);
		_lrValues = GVAR(lrEAST);
	};
	case independent: { 
		_srValues = GVAR(srINDEPENDENT);
		_lrValues = GVAR(lrINDEPENDENT);
	};
};

private _lrStatement = {
	params ["_target", "_player", "_params"];
	_params call FUNC(setLRchannel);
};

private _swStatement = {
	params ["_target", "_player", "_params"];
	_params call FUNC(setSRchannel);
};

//LR things
{
	_x params ["_frequency", "_channel", "_name"];

	private _text = format["%1 [CH:%2 (%3)]",toUpper _name, _channel, _frequency];
	private _interactionBase = [_name, _text, "", {},  {true}] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions", "RadioBase", "LR_Radio"], _interactionBase] call ace_interact_menu_fnc_addActionToObject;

	private _interactionSetLR = ["set_lr", "Set LR", "", _lrStatement,  {true}, nil, [_channel, _frequency,  false]] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions", "RadioBase", "LR_Radio", _name], _interactionSetLR] call ace_interact_menu_fnc_addActionToObject;

	private _interactionSetLRAD = ["set_lr_add", "Set LR Additional", "", _lrStatement,  {true}, nil, [_channel, _frequency,  true]] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions", "RadioBase", "LR_Radio", _name], _interactionSetLRAD] call ace_interact_menu_fnc_addActionToObject;

	private _interactionSetSRAD = ["set_lr_sr_add", "Set SR Additional", "", _swStatement,  {true}, nil, [_channel, _frequency,  true]] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions", "RadioBase", "LR_Radio", _name], _interactionSetSRAD] call ace_interact_menu_fnc_addActionToObject;
} forEach _lrValues;

//SR things
{
	_x params ["_frequency", "_channel", "_name"];

	private _text = format["%1 [CH:%2 (%3)]",_name, _channel, _frequency];
	private _interactionBase = [_name, _text, "", {},  {true}] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions", "RadioBase", "SR_Radio"], _interactionBase] call ace_interact_menu_fnc_addActionToObject;

	private _interactionSetSW = ["set_sr", "Set SR", "", _swStatement,  {true}, nil, [_channel, _frequency,  false]] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions", "RadioBase", "SR_Radio", _name], _interactionSetSW] call ace_interact_menu_fnc_addActionToObject;

	private _interactionSetSRAD = ["set_sr_add", "Set SR Additional", "", _swStatement,  {true}, nil, [_channel, _frequency,  true]] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions", "RadioBase", "SR_Radio", _name], _interactionSetSRAD] call ace_interact_menu_fnc_addActionToObject;
} forEach _srValues;

//Team channels
private _teamStatement = {
	params ["_target", "_player", "_team"];
	private _values = ((group player) getVariable [QGVAR(radioValues), [[],[],[]]]) select 2;
	if (count _values > 0) then {
		_values = _values select _team;
		[8, _values, true] call FUNC(setSRchannel);
	};
};

private _interactionTeam = ["Team_channels", "Team Channels", "\z\ace\addons\interaction\UI\team\team_management_ca.paa", {},  {true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "RadioBase"], _interactionTeam] call ace_interact_menu_fnc_addActionToObject;

private _interactionTeamWhite = ["Team_channels", "White Team", "\z\ace\addons\interaction\UI\team\team_white_ca.paa", _teamStatement,  {true}, nil, 0] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "RadioBase", "Team_channels"], _interactionTeamWhite] call ace_interact_menu_fnc_addActionToObject;

private _interactionTeamRed = ["Team_channels", "Red Team", "\z\ace\addons\interaction\UI\team\team_red_ca.paa", _teamStatement,  {true}, nil, 1] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "RadioBase", "Team_channels"], _interactionTeamRed] call ace_interact_menu_fnc_addActionToObject;

private _interactionTeamBlue = ["Team_channels", "Blue Team", "\z\ace\addons\interaction\UI\team\team_blue_ca.paa", _teamStatement,  {true}, nil, 2] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "RadioBase", "Team_channels"], _interactionTeamBlue] call ace_interact_menu_fnc_addActionToObject;

private _interactionTeamGreen = ["Team_channels", " Green Team", "\z\ace\addons\interaction\UI\team\team_green_ca.paa", _teamStatement,  {true}, nil, 3] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "RadioBase", "Team_channels"], _interactionTeamGreen] call ace_interact_menu_fnc_addActionToObject;

private _interactionTeamYellow = ["Team_channels", "Yellow Team", "\z\ace\addons\interaction\UI\team\team_yellow_ca.paa", _teamStatement,  {true}, nil, 4] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "RadioBase", "Team_channels"], _interactionTeamYellow] call ace_interact_menu_fnc_addActionToObject;

//Stereo

private _stereoLRtatement = {
	params ["_target", "_player", "_params"];
	
	_params call FUNC(setLRstereo);	
};

private _stereoSRtatement = {
	params ["_target", "_player", "_params"];

	_params call FUNC(setSRstereo);	
};

//Stereo LR
private _interactionStereoLRbase= ["stereo_lr_base", "LR Stereo", QPATHTOF(kuvat\LR_Radio.paa), {},  {call TFAR_fnc_haveLRRadio}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "RadioBase", "Stereo"], _interactionStereoLRbase] call ace_interact_menu_fnc_addActionToObject;

private _interactionStereoLR= ["stereo_lr_set", "Stereo", QPATHTOF(kuvat\headset.paa), {},  {true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "RadioBase", "Stereo", "stereo_lr_base"], _interactionStereoLR] call ace_interact_menu_fnc_addActionToObject;

private _interactionStereoLRbadd= ["stereo_lr_set_add", "Stereo Additional", QPATHTOF(kuvat\headset_additional.paa), {},  {true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "RadioBase", "Stereo", "stereo_lr_base"], _interactionStereoLRbadd] call ace_interact_menu_fnc_addActionToObject;

private _forLoopThings = [[0,"Both"], [1,"Left"], [2,"Right"]];

{
	_x params ["_number", "_ear"];
	private _interaction = [_ear, _ear, "", _stereoLRtatement,  {true}, nil, [_number, false]] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions", "RadioBase", "Stereo", "stereo_lr_base", "stereo_lr_set"], _interaction] call ace_interact_menu_fnc_addActionToObject;
} forEach _forLoopThings;

{
	_x params ["_number", "_ear"];
	private _interaction = [_ear, _ear, "", _stereoLRtatement,  {true}, nil, [_number, true]] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions", "RadioBase", "Stereo", "stereo_lr_base", "stereo_lr_set_add"], _interaction] call ace_interact_menu_fnc_addActionToObject;
} forEach _forLoopThings;

//Stereo SR
private _interactionStereoSRbase= ["stereo_sr_base", "SR Stereo", QPATHTOF(kuvat\SW_Radio.paa), {},  {call TFAR_fnc_haveSWRadio}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "RadioBase", "Stereo"], _interactionStereoSRbase] call ace_interact_menu_fnc_addActionToObject;

private _interactionStereoSR= ["stereo_sr_set", "Stereo", QPATHTOF(kuvat\headset.paa), {},  {true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "RadioBase", "Stereo", "stereo_sr_base"], _interactionStereoSR] call ace_interact_menu_fnc_addActionToObject;

private _interactionStereoSRbadd= ["stereo_sr_set_add", "Stereo Additional", QPATHTOF(kuvat\headset_additional.paa), {},  {true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "RadioBase", "Stereo", "stereo_sr_base"], _interactionStereoSRbadd] call ace_interact_menu_fnc_addActionToObject;

private _forLoopThings = [[0,"Both"], [1,"Left"], [2,"Right"]];

{
	_x params ["_number", "_ear"];
	private _interaction = [_ear, _ear, "", _stereoSRtatement,  {true}, nil, [_number, false]] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions", "RadioBase", "Stereo", "stereo_sr_base", "stereo_sr_set"], _interaction] call ace_interact_menu_fnc_addActionToObject;
} forEach _forLoopThings;

{
	_x params ["_number", "_ear"];
	private _interaction = [_ear, _ear, "", _stereoSRtatement,  {true}, nil, [_number, true]] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions", "RadioBase", "Stereo", "stereo_sr_base", "stereo_sr_set_add"], _interaction] call ace_interact_menu_fnc_addActionToObject;
} forEach _forLoopThings;