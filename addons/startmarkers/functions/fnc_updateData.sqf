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
 * [] call tunuti_startmarkers_fnc_updateData
 */
#include "script_component.hpp"

LOG("Runned update data");

#define CHECKGPS(GPSITEMS,UNITITEMS,UNIT)	((GPSITEMS findIf {_x in UNITITEMS} ) isNotEqualTo -1 || (getNumber (configOf vehicle UNIT >> "enableGPS") isEqualTo 1))

private _westSquadHash = GVAR(squadMarkersWestData);
private _eastSquadHash = GVAR(squadMarkersEastData);
private _resistanceSquadHash = GVAR(squadMarkersIndependentData);
private _civilianSquadHash = GVAR(squadMarkersCivilianData);

private _westVehicleHash = GVAR(vehicleMarkersWestData);
private _eastVehicleHash = GVAR(vehicleMarkersEastData);
private _resistanceVehicleHash = GVAR(vehicleMarkersIndependentData);
private _civilianVehicleHash = GVAR(vehicleMarkersCivilianData);

private _westOtherHash = GVAR(otherMarkersWestData);
private _eastOtherHash =  GVAR(otherMarkersEastData);
private _resistanceOthereHash = GVAR(otherMarkersIndependentData);
private _civilianOtherHash = GVAR(otherMarkersCivilianData);

private _colorWEST = "ColorWEST";
private _colorEAST = "ColorEAST";
private _colorINDEPENDENT = "ColorGUER";
private _colorCIVILIAN = "ColorCIV";
private _time = cba_missiontime;
private _updateTime = _time;

private _allowedSide = GVAR(allowedSidesStarmarker);
private _bftAlwaysOn = GVAR(bftAlwaysOn);
private _gpsItems = GVAR(bftItems);

if (!isServer || (_time > 0) && GVAR(enableBFT)) then {
	_allowedSide = GVAR(allowedSidesBFT);
};

if (_time < 1) then {
	_updateTime = -1;
};

{
	private _group = _x;
	private _side = side _group;
	if (_side in _allowedSide) then {
		private _leader = leader _group;
		private _hasGPS = true; //True to make sure data is collected at briefing
		private _units = (units _group);

		if (count _units isEqualTo 0) exitWith { }; //Skip empty squads

		if (_time > 0) then {
			{
				private _unit = _x;
				//skip units in respawn
				if !(_unit getVariable ["tunres_Respawn_isWaitingRespawn", false]) then { continue };
				private _items = assignedItems _unit + items _unit;
				MAP(_items,toLower _x);
				_hasGPS = CHECKGPS(_gpsItems,_items,_unit);
				if (_hasGPS) exitWith {
					_leader = _unit;
				};
			} forEach _units;
		};

		if (_group getVariable [QGVAR(enableMarker), true] && {_hasGPS || _bftAlwaysOn}) then {
			
			private _hide = vehicle _leader isNotEqualTo _leader;
			private _icon = [_group] call FUNC(squadIcon);
			private _pos = getPosWorld _leader;
			private _name = groupId _group;
			switch (_side) do {
				case west: { 
					_westSquadHash set [hashValue _group, [_icon, _pos, _colorWEST, _group, _name, _updateTime, _hide]];
				};
				case east: { 
					_eastSquadHash set [hashValue _group, [_icon, _pos, _colorEAST, _group, _name, _updateTime, _hide]];
				};
				case independent: { 
					_resistanceSquadHash set [hashValue _group, [_icon, _pos, _colorINDEPENDENT, _group, _name, _updateTime, _hide]];
				};
				default { 
					_civilianSquadHash set [hashValue _group, [_icon, _pos, _colorCIVILIAN, _group, _name, _updateTime, _hide]];
				};
			};
		};
	};
} forEach allGroups; 

private _vehiclesToCreateMarkers = [];
private _playableUnits = playableUnits + switchableUnits;
private _showUnmanned = GVAR(showUnmanned);
//Collect vehicles
{
	private _vehicle = _x; 
	private _side = _vehicle getVariable [QGVAR(vehicleSide), (_vehicle getVariable ["Tun_startmarkers_vehicleSide", sideLogic])]; // "tunuti_startmarkers_vehicleSide"
	if ( _vehicle getVariable [QGVAR(enableMarker), true] && { _side in _allowedSide } && { alive _vehicle } && {!(_vehicle getVariable ["tunres_MSP_isMSP", false])}) then {

		private _pos = getPosWorld _vehicle;
		private _direction = getDir _vehicle;
		private _classname = typeOf _vehicle;
		private _text = "";
		private _text1 = "";
		_text = _vehicle getVariable ["displayName", getText (configOf _vehicle >> "displayName")];
		private _isThing = _vehicle isKindOf "thing";

		if (!_isThing && {!(_vehicle isKindOf "uav")}) then {
			private _vehicleCrew = crew _vehicle;
			if (count _vehicleCrew > 0) then {
				private _groups = [];
				private _groupsText = [];
				{
					_groups pushBackUnique group _x;
				} forEach _vehicleCrew;

				{
					private _group = _x;
					private _groupID = groupId _group;
					if (GVAR(showAI) && { units _group findIf {_x in _playableUnits} isEqualTo -1 }) then {
						_groupsText pushBackUnique format["%1 (AI)", _groupID];
					} else {
						_groupsText pushBackUnique _groupID;
					};
				} forEach _groups;

				_text1 = _groupsText joinString ", ";

			} else {
				if (_showUnmanned) then {
					_text1 = "Unmanned";
				};
			};
		};

		private _color = [[0,0.3,0.6,1], [0.5,0,0,1], [0,0.5,0,1], [0.4,0,0.5,1]] select( [west, east, resistance, civilian] findIf {_x isEqualTo _side});
		private _data = [hashValue _vehicle, [_classname, [_text, _text1], _pos, _direction, _color, _updateTime]];

		switch (_side) do {
			case west: {
				private _hash = [_westVehicleHash,_westOtherHash] select _isThing;
				_hash set _data;
			};
			case east: { 
				private _hash = [_eastVehicleHash,_eastOtherHash] select _isThing;
				_hash set _data;
			};
			case independent: {
				private _hash = [_resistanceVehicleHash,_resistanceOthereHash] select _isThing;
				_hash set _data;
			};
			default {
				private _hash = [_civilianVehicleHash,_civilianOtherHash] select _isThing;
				_hash set _data;
			};
		};
	};
} forEach vehicles;

GVAR(lastDataUpdate) = _time;

if (isServer) then {
	publicVariable QGVAR(squadMarkersWestData);
	publicVariable QGVAR(squadMarkersEastData);
	publicVariable QGVAR(squadMarkersIndependentData);
	publicVariable QGVAR(squadMarkersCivilianData);

	publicVariable QGVAR(vehicleMarkersWestData);
	publicVariable QGVAR(vehicleMarkersEastData);
	publicVariable QGVAR(vehicleMarkersIndependentData);
	publicVariable QGVAR(vehicleMarkersCivilianData);

	publicVariable QGVAR(otherMarkersWestData);
	publicVariable QGVAR(otherMarkersEastData);
	publicVariable QGVAR(otherMarkersIndependentData);
	publicVariable QGVAR(otherMarkersCivilianData);

	publicVariable QGVAR(lastDataUpdate);

	GVAR(serverDone) = true;
	publicVariable QGVAR(serverDone);
};
