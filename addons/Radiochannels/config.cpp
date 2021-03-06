#include "script_component.hpp"

class CfgPatches
{
    class Tun_Radiochannels
    {
        units[] = {};
        weapons[] = {};
        requiredVersion = 2.04;
        requiredAddons[] = {"cba_main","cba_xeh","cba_settings","ace_common","ace_interaction","ace_interact_menu"};
        author = "Tuntematon";
        authorUrl = "https://github.com/tuntematonjr/Tun-Utilities";
    };
};

class Extended_PostInit_EventHandlers {
    class Tun_Radiochannels {
        init = QUOTE(call COMPILE_FILE(XEH_postInit));
    };
};

class Extended_PreInit_EventHandlers {
    class Tun_Radiochannels {
        init = QUOTE( call COMPILE_FILE(XEH_preInit) );
    };
};