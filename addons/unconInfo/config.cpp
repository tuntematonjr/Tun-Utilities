#include "script_component.hpp"

class CfgPatches
{
    class Tun_unconInfo
    {
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_xeh","cba_settings"};
        author = "Tuntematon";
        authorUrl = "https://github.com/tuntematonjr/Tun-Utilities";
    };
};

class Extended_PostInit_EventHandlers {
    class Tun_unconInfo {
        init = QUOTE(call COMPILE_FILE(XEH_postInit));
    };
};

class Extended_PreInit_EventHandlers {
    class Tun_unconInfo {
        init = QUOTE( call COMPILE_FILE(XEH_preInit) );
    };
};