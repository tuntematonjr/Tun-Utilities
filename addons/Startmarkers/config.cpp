#include "script_component.hpp"

class CfgPatches
{
    class Tun_Startmarkers
    {
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_main","cba_xeh","cba_settings"};
        author = "Tuntematon";
        authorUrl = "https://github.com/tuntematonjr/Tun-Utilities";
    };
};

class Extended_PostInit_EventHandlers {
    class Tun_Startmarkers {
        init = QUOTE(call COMPILE_FILE(XEH_postInit));
    };
};

class Extended_PreInit_EventHandlers {
    class Tun_Startmarkers {
        init = QUOTE( call COMPILE_FILE(XEH_preInit) );
    };
};

#include "startmarkersSettings.hpp"

class Cfg3DEN
{
    // Configuration of all objects
    class Object
    {
        // Categories collapsible in "Edit Attributes" window
        class AttributeCategories
        {
            // Category class, can be anything
            class Tun_startmarkers
            {
                displayName = "Tun Utilities - Starmarkers & BFT"; // Category name visible in Edit Attributes window
                collapsed = 1; // When 1, the category is collapsed by default
                class Attributes
                {

                    class Tun_startmarkers_enable_marker_inf
                    {
                        displayName = "Enable startpos and BFT";
                        tooltip = "Enables start position marker and BFT for this group";
                        property = "Tun_startmarkers_enable_marker_inf";
                        control = "Checkbox";
                        expression = "(group _this) setVariable ['Tun_startmarkers_enableMarker', _value, true];";
                        defaultValue = "true";
                        unique = 0;
                        condition = "objectBrain";
                    };

                    class Tun_startmarkers_enable_marker_vehicle: Tun_startmarkers_enable_marker_inf
                    {
                        property = "Tun_startmarkers_enable_marker_vehicle";
                        expression = "_this setVariable ['Tun_startmarkers_enable_marker', _value, true];";
                        condition =  "objectHasInventoryCargo + objectVehicle";
                    };


                    class Tun_startmarkers_startPosName: Tun_startmarkers_enable_marker_inf
                    {
                        displayName = "Custon vehicle text";
                        tooltip = "You can change the default startpos marker name shown at brieffing to a different one. Names shorter than 2 characters wont be set.";
                        property = "Tun_startmarkers_startPosName";
                        control = "EditShort";
                        expression = "if (count _value > 1) then { _this setVariable ['displayName', str _value,true]};";
                        defaultValue = "''";
                        condition = "objectHasInventoryCargo + objectVehicle";
                    };
                    class Tun_startmarkers_vehicle_side_west: Tun_startmarkers_enable_marker_inf
                    {
                        displayName = "Show this to West";
                        tooltip = "Chose side to show this vehicle. Only pick one side per object.";
                        property = "Tun_startmarkers_vehicle_side_west";
                        control = "Checkbox";
                        expression = "if (_value) then {_this setVariable ['Tun_startmarkers_vehilce_side', west,true]};";
                        defaultValue = "false";
                        condition = "objectHasInventoryCargo + objectVehicle";
                    };
                    class Tun_startmarkers_vehicle_side_east: Tun_startmarkers_vehicle_side_west
                    {
                        displayName = "Show this to East";
                        property = "Tun_startmarkers_vehicle_side_east";
                        expression = "if (_value) then {_this setVariable ['Tun_startmarkers_vehilce_side', east,true]};";

                    };
                    class Tun_startmarkers_vehicle_side_ind: Tun_startmarkers_vehicle_side_west
                    {
                        displayName = "Show this to Independent";
                        property = "Tun_startmarkers_vehicle_side_ind";
                        expression = "if (_value) then {_this setVariable ['Tun_startmarkers_vehilce_side', resistance,true]};";


                    };
                    class Tun_startmarkers_vehicle_side_civ: Tun_startmarkers_vehicle_side_west
                    {
                        displayName = "Show this to Civilian";
                        property = "Tun_startmarkers_vehicle_side_civ";
                        expression = "if (_value) then { _this setVariable ['Tun_startmarkers_vehilce_side', civilian, true] };";

                    };
                };
            };
        };
    };
};