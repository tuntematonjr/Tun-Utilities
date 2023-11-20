#include "script_component.hpp"

[{ADDON}, {
	if (GVAR(enableBriefingText)) then {
		player createDiarySubject ["Planning mode","Planning mode"];

		player createDiaryRecord ["Planning mode",["Player positions","When planning mode is active, there will be marker on each players position showing what direction it is looking and player name."]];

		player createDiaryRecord ["Planning mode",["LOS Check","When planning mode is active, clicking on the map and holding SHIFT, checks line of sight from your eye postion to clicked position at 1m height.<br/><br/>It also creates line between you and clicked position.<br/><font color='#00CC00'>Green line</font color> means you have LOS.<br/><font color='#D9D900'>Yellow line</font color> means that one ore more objeck is blocking LOS.<br/><font color='#E60000'>Red line</font color> meeans that ground is blocking your LOS.<br/><br/>There will also be blocked marker at position where blocking object is and blocked by ground marker where LOS is broken by ground.<br/><br/>Finaly there will be marker at end positon which tells you the distance in 2D and 3D."]];

		player createDiaryRecord ["Planning mode",["Teleporting","When planning mode is active, clicking on the map and holding ALT, teleports you to that location."]];

		player createDiaryRecord ["Planning mode",["Enable planning mode.","To enable planning mode, admin needs to write #planningmode to chat.<br/>That command is toggle and writing it again disables planning mode."]];
	};		
}] call CBA_fnc_waitUntilAndExecute;