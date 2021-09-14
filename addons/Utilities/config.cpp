#include "script_component.hpp"

class CfgPatches
{
    class Tun_Utilities
    {
        units[] = { QGVAR(combatZoneModule) };
        weapons[] = {};
        requiredVersion = 2.04;
        requiredAddons[] = {"cba_main","cba_xeh","cba_settings","ace_modules"};
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

class CfgVehicles {
    class ACE_Module;
    class GVAR(combatZoneModule): ACE_Module {
        author = "Tuntematon";
        category = "Tun Utilities";
        displayName = "Tun Combat Zone";
        function = QFUNC(combatZone);
        scope = 2;// Editor visibility; 2 will show it in the menu, 1 will hide it.
        isGlobal = 1; // 0 for server only execution, 1 for global execution, 2 for persistent global execution
        isTriggerActivated = 0;
        isDisposable = 0; // 1 if modules is to be disabled once it's activated (i.e., repeated trigger activation won't work)
        //icon = QPATHTOF(UI\Icon_Module_Slideshow_ca.paa);
        class Arguments {
            class markerPreFix {
                displayName = "Marker prefix";
                //description = $STR_tun_firesupport_module_gun_class_description;
                typeName = "STRING";
                defaultValue = "B_Mortar_01_F";
            };
            
            class markerCount {
                displayName = "Marker Count";
                //description = $STR_tun_firesupport_module_gun_countDown_description;
                typeName = "NUMBER";
                defaultValue = 60;
            };
            
            class sideWest {
                displayName = "Enable West";
                //description = $STR_tun_firesupport_module_gun_markerToggle_description;
                typeName = "BOOL";
                defaultValue = false;
            };
            
            class sideEast {
                displayName = "Enable East";
                //description = $STR_tun_firesupport_module_gun_markerToggle_description;
                typeName = "BOOL";
                defaultValue = false;
            };
            
            class sideResistance {
                displayName = "Enable Resistance";
                //description = $STR_tun_firesupport_module_gun_markerToggle_description;
                typeName = "BOOL";
                defaultValue = false;
            };
            
            class sideCiv {
                displayName = "Enable Civilian";
                //description = $STR_tun_firesupport_module_gun_markerToggle_description;
                typeName = "BOOL";
                defaultValue = false;
            };

        };
    };
};