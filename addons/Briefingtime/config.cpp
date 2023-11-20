#include "script_component.hpp"

// information on this addon specifically
class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"ace_interaction","ace_interact_menu","tunuti_main"};
        author = "Tuntematon"; 
        authorUrl = TUN_UTILITY_GITHUBLINK;
        VERSION_CONFIG;
    };
};

// configs go here
class  RscButton;
class  RscText;
class  RscXSliderH;
#include "CfgEventHandlers.hpp"
#include "briafingTime.hpp"