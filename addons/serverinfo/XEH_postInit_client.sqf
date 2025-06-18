#include "script_component.hpp"

private _id = [QGVAR(createServerInfoEvent), {
	_params params [["_battleEye", false],["_hostname", "No name set"],["_maxDesync", -1],["_maxPacketLoss", -1],["_maxPing", -1],["_verifySignatures", -1]];
	player createDiarySubject ["Server info","Server info"];

	private _text = format ["Basic server info<br/><br/>Server Name: %1
	<br/><br/>Is battleEye enabled: %2
	<br/><br/>Signature verification for addons: %3
	<br/><br/>MaxPing: %4
	<br/>//Max ping value until server kick the user.
	<br/><br/>MaxPacketLoss: %5
	<br/>//Max packetloss value until server kick the user.
	<br/><br/>MaxDesync: %6
	<br/>//Max desync value until server kick the user.
	",_hostname, _battleEye, (_verifySignatures > 0),_maxPing,_maxPacketLoss,_maxDesync];

	player createDiaryRecord ["Server info",["Server info",_text]];
}] call CBA_fnc_addEventHandler;