/*
 * Author: [Tuntematon]
 * Creates briefing diary entries for start markers and BFT
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call tunuti_startmarkers_fnc_createDiaryRecord
 */

#include "script_component.hpp"

private _text = "<font face='PuristaBold' size='15'>This missions uses automatic startpositions markers.</font><br/>";

if (GVAR(enableBFT)) then {
	_text = _text + "<br/>BFT is enabled in this mission. Same settings apply for it.";
	if (GVAR(enableDeleteMarker)) then {
		private _deleteMarkerTime = [GVAR(deleteMarkerTime), "M:SS"] call CBA_fnc_formatElapsedTime;
		private _lostContactTime = [GVAR(lostContactTime), "M:SS"] call CBA_fnc_formatElapsedTime;
		_text = _text + format["<br/>- If squad leader dies or vehicle gets destroyed, they will become semi transparrent after %1min and they will be deleted from map after %2min",_lostContactTime, _deleteMarkerTime];
	};
} else {
	_text = _text + "<br/>The markers are hidden after the safe start is over.<br/>You can bring them up again through the settings menu.";
};

_text = _text + "<br/><br/><font size=20><execute expression=' [true] call "+ QFUNC(settingsDisplay) +"'>Open Settings</execute>
</font>";

player createDiarySubject [QGVAR(briefing),"Startpositions & BFT"];
player createDiaryRecord [QGVAR(briefing), ["Startpositions & BFT",_text]];
player createDiaryRecord ["diary", ["Startpositions & BFT",_text]];
