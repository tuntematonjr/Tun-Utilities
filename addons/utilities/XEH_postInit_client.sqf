#include "script_component.hpp"

[] call FUNC(initSpectatorStats);
[] call FUNC(loadScreen);


//Gifted by Whale
//Removes aerobic energy reserves
[{
	ace_advanced_fatigue_ae1reserve = 4000000;
	ace_advanced_fatigue_ae2reserve = 84000;
	ace_advanced_fatigue_muscledamage = 0; 
},180] call CBA_fnc_addPerFrameHandler;