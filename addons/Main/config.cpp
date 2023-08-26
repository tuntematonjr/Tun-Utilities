#include "script_component.hpp"

class CfgPatches
{
    class Tun_Utilities_Main
    {
        units[] = { };
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_main","cba_xeh","cba_settings"};
        author = "Tuntematon";
        authorUrl = "https://github.com/tuntematonjr/Tun-Utilities";
    };
};

// class Extended_PostInit_EventHandlers {
//     class Tun_Utilities_Main {
//         init = QUOTE(call COMPILE_FILE(XEH_postInit));
//     };
// };

// class Extended_PreInit_EventHandlers {
//     class Tun_Utilities_Main {
//         init = QUOTE( call COMPILE_FILE(XEH_preInit) );
//     };
// };