#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_prep.hpp"
PREP_RECOMPILE_END;

GVAR(allowedSidesStarmarker) = [];
GVAR(allowedSidesBFT) = [];
GVAR(squadMarkers) = [];
GVAR(vehicleMarkers) = [];
GVAR(otherMarkers) = [];

[
	QGVAR(enable), // Unique setting name. Matches resulting variable name <STRING>
	"CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
	["Enable startmakers", "Enable whole system"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
	"Tun Utilities - Startmakers & BFT", // Category for the settings menu + optional sub-category <STRING, ARRAY>
	true, // Extra properties of the setting depending of _settingType.
	1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
	{}, // Script to execute when setting is changed. (optional) <CODE>
	true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;

[
	QGVAR(showAI), 
	"CHECKBOX", 
	["Add tag if vehicle crew or squad is AI", "Add tag for squad where is only AI units and vehicles which crew is only AI."], 
	"Tun Utilities - Startmakers & BFT", 
	true,
	1,
	{},
	true
] call CBA_fnc_addSetting;

[
	QGVAR(showUnmanned), 
	"CHECKBOX", 
	"Add tag if vehicle is unmanned", 
	"Tun Utilities - Startmakers & BFT", 
	false,
	1,
	{},
	true
] call CBA_fnc_addSetting;

[
	QGVAR(commandElementID), 
	"EDITBOX", 
	["Command element ID", "If this is found in names of squads, squad marker will be HQ. There can be multiple, seperate by comas"], 
	"Tun Utilities - Startmakers & BFT", 
	"10",
	1,
	{},
	true
] call CBA_fnc_addSetting;

////////////////
//StartMarkers//
////////////////

[
	QGVAR(prepTimeSetting), 
	"TIME", 
	["Preparation time (minutes)", "After this time is passed, all markers are auto hidden. You can bring them up again through the settings menu."], 
	["Tun Utilities - Startmakers & BFT","Startposition"], 
	[1, 60*60, 15*60],
	1,
	{ 
		params ["_value"];
		_value = round _value;
		GVAR(prepTimeSetting) = _value;
		GVAR(prepTime) = (["Afi_safeStart_duration", _value ] call BIS_fnc_getParamValue); 
	},
	true
] call CBA_fnc_addSetting;

[
	QGVAR(allowMarkersWest), 
	"CHECKBOX", 
	["Allow Startposition Blufor", "Allow Startposition for this side"], 
	["Tun Utilities - Startmakers & BFT","Startposition"], 
	true,
	1,
	{
		params ["_value"];
		if (_value) then {
			GVAR(allowedSidesStarmarker) pushBack west;
		};
	},
	true
] call CBA_fnc_addSetting;

[
	QGVAR(allowMarkerEast), 
	"CHECKBOX", 
	["Allow Startposition Opfor", "Allow Startposition for this side"], 
	["Tun Utilities - Startmakers & BFT","Startposition"], 
	true,
	1,
	{
		params ["_value"];
		if (_value) then {
			GVAR(allowedSidesStarmarker) pushBack east;
		};
	},
	true
] call CBA_fnc_addSetting;

[
	QGVAR(allowMarkerInd), 
	"CHECKBOX", 
	["Allow Startposition Indfor", "Allow Startposition for this side"], 
	["Tun Utilities - Startmakers & BFT","Startposition"], 
	true,
	1,
	{
		params ["_value"];
		if (_value) then {
			GVAR(allowedSidesStarmarker) pushBack resistance;
		};
	},
	true
] call CBA_fnc_addSetting;

[
	QGVAR(allowMarkerCivilian), 
	"CHECKBOX", 
	["Allow Startposition Civilian", "Allow Startposition for this side"], 
	["Tun Utilities - Startmakers & BFT","Startposition"], 
	true,
	1,
	{
		params ["_value"];
		if (_value) then {
			GVAR(allowedSidesStarmarker) pushBack civilian;
		};
	},
	true
] call CBA_fnc_addSetting;

///////
//BFT//
///////
[
	QGVAR(enableBFT), 
	"CHECKBOX", 
	["Blue Force Tracking", "Enable BFT"], 
	["Tun Utilities - Startmakers & BFT","BFT"], 
	false,
	1,
	{},
	true
] call CBA_fnc_addSetting;

[
	QGVAR(bftAlwaysOn), 
	"CHECKBOX", 
	["BFT always on", "Enable BFT for everyone. No item requirements"], 
	["Tun Utilities - Startmakers & BFT","BFT"], 
	false,
	1,
	{},
	true
] call CBA_fnc_addSetting;

[
	QGVAR(addAllVehicles), 
	"CHECKBOX", 
	["Add all vehicles", "Add all vehicles. Even if created after mission start. If vehicle side is not defined. First unit who get in vehicle will specify it."], 
	["Tun Utilities - Startmakers & BFT","BFT"], 
	false,
	1,
	{},
	true
] call CBA_fnc_addSetting;

[
	QGVAR(updateInterval), 
	"TIME", 
	["BFT update interval", "Time between updates"], 
	["Tun Utilities - Startmakers & BFT","BFT"], 
	[1, 60, 5],
	1,
	{
		params ["_value"];
		GVAR(updateInterval) = round _value;
	},
	true
] call CBA_fnc_addSetting;

[
	QGVAR(bftItemsSettings), 
	"EDITBOX", 
	["Required item", "List of item classnames to allow BFT. Seperate by comas"], 
	["Tun Utilities - Startmakers & BFT","BFT"], 
	'"ACE_microDAGR", "ItemGPS"',
	1,
	{ 
		params ["_value"];
		_value = _value splitString """, """;
		MAP(_value,toLower _x);
		GVAR(bftItems) = _value;
	},
	true
] call CBA_fnc_addSetting;

[
	QGVAR(allowBftWest), 
	"CHECKBOX", 
	["Allow BFT Blufor", "Allow BFT for this side"], 
	["Tun Utilities - Startmakers & BFT","BFT"], 
	true,
	1,
	{
		params ["_value"];
		if (_value) then {
			GVAR(allowedSidesBFT) pushBack west;
		};
	},
	true
] call CBA_fnc_addSetting;

[
	QGVAR(allowBftEast), 
	"CHECKBOX", 
	["Allow BFT Opfor", "Allow BFT for this side"], 
	["Tun Utilities - Startmakers & BFT","BFT"], 
	true,
	1,
	{
		params ["_value"];
		if (_value) then {
			GVAR(allowedSidesBFT) pushBack east;
		};
	},
	true
] call CBA_fnc_addSetting;

[
	QGVAR(allowBftInd), 
	"CHECKBOX", 
	["Allow BFT Indfor", "Allow BFT for this side"], 
	["Tun Utilities - Startmakers & BFT","BFT"], 
	true,
	1,
	{
		params ["_value"];
		if (_value) then {
			GVAR(allowedSidesBFT) pushBack resistance;
		};
	},
	true
] call CBA_fnc_addSetting;

[
	QGVAR(allowBftCivilian), 
	"CHECKBOX", 
	["Allow BFT Civilian", "Allow BFT for this side"], 
	["Tun Utilities - Startmakers & BFT","BFT"], 
	true,
	1,
	{
		params ["_value"];
		if (_value) then {
			GVAR(allowedSidesBFT) pushBack civilian;
		};
	},
	true
] call CBA_fnc_addSetting;

[
	QGVAR(lostContactTime), 
	"TIME", 
	["Lost contact time", "After this time is passed without update for marker data, marker alpha will be set to 0.5."], 
	["Tun Utilities - Startmakers & BFT","BFT"], 
	[1, 60*60, 5*60],
	1,
	{
		params ["_value"];
		GVAR(lostContactTime) = round _value;
	},
	true
] call CBA_fnc_addSetting;

[
	QGVAR(enableDeleteMarker), 
	"CHECKBOX", 
	["Enable delete non updated markers", "Enable system to delete unupdated markers"], 
	["Tun Utilities - Startmakers & BFT","BFT"], 
	true,
	1,
	{},
	true
] call CBA_fnc_addSetting;

[
	QGVAR(deleteMarkerTime), 
	"TIME", 
	["Delete marker without update time", "After this time is passed without update for marker data, it will be deleted."], 
	["Tun Utilities - Startmakers & BFT","BFT"], 
	[1, 60*60, 15*60],
	1,
	{
		params ["_value"];
		GVAR(deleteMarkerTime) = round _value;
	},
	true
] call CBA_fnc_addSetting;

["hint", {
	hint (_this select 0);
}, "all"] call CBA_fnc_registerChatCommand;
ADDON = true;
