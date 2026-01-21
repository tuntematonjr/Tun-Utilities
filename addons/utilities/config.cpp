#include "script_component.hpp"

// information on this addon specifically
class CfgPatches {
	class ADDON {
		name = COMPONENT_NAME;
		units[] = { QGVAR(combatZoneModule)};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {QGVARMAIN(combatZone),QGVARMAIN(main)};
		author = "Tuntematon";
		authorUrl = GITHUBLINK;
		VERSION_CONFIG;
	};
};
// configs go here
#include "CfgEventHandlers.hpp"
class  RscPictureKeepAspect;
class  RscButton;
class  RscText;
#include "biggerImage.hpp"
#include "spectatorStats.hpp"

class CfgVehicles {
	class EGVAR(combatZone,combatZoneModule);

	class GVAR(combatZoneModule): EGVAR(combatZone,combatZoneModule) {
		displayName = "Deprecated - But works";
		scope = 1;// Editor visibility; 2 will show it in the menu, 1 will hide it.
	};
};
