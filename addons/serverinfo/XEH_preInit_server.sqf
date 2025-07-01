#include "script_component.hpp"

["CBA_SettingsInitialized", {
	if (GVAR(enableServerInfo)) then {
		private _serverInfo = getServerInfo;
		private _battleEye = _serverInfo get "battlEye";
		private _hostname = _serverInfo get "hostname";
		private _maxDesync = _serverInfo get "maxDesync";
		private _maxPacketLoss = _serverInfo get "maxPacketLoss";
		private _maxPing = _serverInfo get "maxPing";
		private _verifySignatures= _serverInfo get "verifySignatures";

		[QGVAR(createServerInfoEvent),[_battleEye,_hostname,_maxDesync,_maxPacketLoss,_maxPing,_verifySignatures]] call CBA_fnc_globalEventJIP;
	};
}] call CBA_fnc_addEventHandler;
