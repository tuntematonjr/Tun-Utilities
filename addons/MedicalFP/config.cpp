#include "script_component.hpp"
class CfgPatches {
    class MedicalFP {
        name = "Tun Medical FP";
        units[] = {QGVAR(vitalItem)};
        weapons[] = {QGVAR(vital)};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"ace_medical_treatment", "ace_zeus", "cba_main","cba_xeh","cba_settings"};
        author = "diwako, tuntematon";
        authorUrl = "";
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"
#include "CfgWeapons.hpp"
#include "ACE_Medical_Treatment.hpp"
#include "ACE_Medical_Treatment_Actions.hpp"

