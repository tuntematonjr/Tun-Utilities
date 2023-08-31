/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * None
 *
 * Return Value:
 * The return value <BOOL>
 *
 * Example:
 * [] call tun_startmarkers_fnc_createDiaryRecord
 */
#include "script_component.hpp"

private _text = "<font face='PuristaBold' size='15'>This missions uses automatic startpositions markers.</font>
<br/>The markers are hidden after the safe start is over.
<br/>You can bring them up again through the settings menu.";

if (GVAR(enableBFT)) then {
	_text = _text + "<br/>This mission uses BFT, same settings apply for it.";
	if (GVAR(enableDeleteMarker)) then {
		_text = _text + format["<br/>- If squad leader dies or vehicle gets destroyed, they will become semi transparrent after %1 min and they will be deleted from map after %2m",GVAR(lostContactTime), GVAR(deleteMarkerTime)];
	};
};

_text = _text + "<br/><br/><font size=20><execute expression=' [true] call "+ QFUNC(settingsDisplay) +"'>Open Settings</execute>
</font>";

player createDiarySubject [QGVAR(briefing),"Startpositions & BFT"];
player createDiaryRecord [QGVAR(briefing), ["Startpositions & BFT",_text]];
player createDiaryRecord ["diary", ["Startpositions & BFT",_text]];