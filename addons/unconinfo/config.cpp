#include "script_component.hpp"

// information on this addon specifically
class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"tunuti_main"};
        author = "Tuntematon";
        authorUrl = TUN_UTILITY_GITHUBLINK;
        //VERSION_CONFIG;
    };
};

// configs go here
#include "CfgEventHandlers.hpp"