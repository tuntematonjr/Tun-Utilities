#include "\z\ace\addons\main\script_macros.hpp"

#ifdef DISABLE_COMPILE_CACHE
    #undef PREP
    #define PREP(fncName) DFUNC(fncName) = compile preprocessFileLineNumbers QPATHTOF(functions\DOUBLES(fnc,fncName).sqf)
#else
    #undef PREP
    #define PREP(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction
#endif

#define TUNUTI_FIND_MAPDISPLAY ([53, 52, 37, 12, nil] select ([53, 52, 37, 12] findIf {!isNull findDisplay _x}))

#define TUN_UTILITY_GITHUBLINK "https://github.com/tuntematonjr/Tun-Utilities"