#include "script_component.hpp"

class CfgPatches
{
    class Tun_Briefingtime
    {
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_main","cba_xeh","cba_settings","ace_common","ace_interaction","ace_interact_menu"};
        author = "Tuntematon";
        authorUrl = "https://github.com/tuntematonjr/Tun-Utilities";
    };
};

class Extended_PostInit_EventHandlers {
    class Tun_Briefingtime {
        init = QUOTE(call COMPILE_FILE(XEH_postInit));
    };
};

class Extended_PreInit_EventHandlers {
    class Tun_Briefingtime {
        init = QUOTE( call COMPILE_FILE(XEH_preInit) );
    };
};

#include "briafingTime.hpp"