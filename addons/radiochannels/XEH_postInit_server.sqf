#include "script_component.hpp"

if (GVAR(enable)) then {
	[{!isNil "TFAR_defaultFrequencies_sr_west" && 
	!isNil "TFAR_defaultFrequencies_sr_east" && 
	!isNil "TFAR_defaultFrequencies_sr_independent" &&  
	!isNil "TFAR_defaultFrequencies_lr_west" && 
	!isNil "TFAR_defaultFrequencies_lr_east" && 
	!isNil "TFAR_defaultFrequencies_lr_independent" && 
	ADDON &&
	!isNil "cba_missiontime" }, {
		[] call FUNC(serverInit);
	}, (diag_tickTime + 10)] call CBA_fnc_waitUntilAndExecute;
};
