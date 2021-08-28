#include "script_component.hpp"

class CfgPatches
{
    class Tun_Utilities
    {
        units[] = {};
        weapons[] = {};
        requiredVersion = 2.04;
        requiredAddons[] = {"cba_main","cba_xeh","cba_settings"};
        author = "Tuntematon";
        authorUrl = "https://github.com/tuntematonjr/Tun-Utilities";
    };
};

class Extended_PostInit_EventHandlers {
    class Tun_Utilities {
        init = QUOTE(call COMPILE_FILE(XEH_postInit));
    };
};

class Extended_PreInit_EventHandlers {
    class Tun_Utilities {
        init = QUOTE( call COMPILE_FILE(XEH_preInit) );
    };
};

#include "spectatorStats.hpp"