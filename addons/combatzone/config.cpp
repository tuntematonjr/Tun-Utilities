#include "script_component.hpp"

// information on this addon specifically
class CfgPatches {
	class ADDON {
		name = COMPONENT_NAME;
		units[] = { QGVAR(combatZoneModule), "tun_utilities_combatZoneModule" };
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {"ace_modules",QGVARMAIN(main)};
		author = "Tuntematon";
		authorUrl = GITHUBLINK;
		VERSION_CONFIG;
	};
};
// configs go here
#include "CfgEventHandlers.hpp"

class CfgFactionClasses
{
	class NO_CATEGORY;
	class GVAR(category) : NO_CATEGORY
	{
		displayName = "Tun Utilities";
	};
};

class CfgVehicles {
	class ACE_Module;
	class GVAR(combatZoneModule): ACE_Module {
		author = "Tuntematon";
		category = QGVAR(category);
		displayName = "Tun Combat Zone";
		function = QFUNC(combatZoneModule);
		scope = 2;// Editor visibility; 2 will show it in the menu, 1 will hide it.
		isGlobal = 1; // 0 for server only execution, 1 for global execution, 2 for persistent global execution
		isTriggerActivated = 0;
		isDisposable = 0; // 1 if modules is to be disabled once it's activated (i.e., repeated trigger activation won't work)
		//icon = QPATHTOF(UI\Icon_Module_Slideshow_ca.paa);
		class Arguments {
			class markerPrefix {
				displayName = "Marker prefix";
				//description = "";
				typeName = "STRING";
				defaultValue = "";
			};
			
			class markerCount {
				displayName = "Marker Count";
				//description = "";
				typeName = "NUMBER";
				defaultValue = 0;
			};

			class showMarkers {
				displayName = "Show Markers";
				//description = "";
				typeName = "BOOL";
				defaultValue = 1;
			};

			class sideWest {
				displayName = "Enable West";
				//description = "";
				typeName = "BOOL";
				defaultValue = 0;
			};
			
			class sideEast {
				displayName = "Enable East";
				//description = "";
				typeName = "BOOL";
				defaultValue = 0;
			};
			
			class sideResistance {
				displayName = "Enable Resistance";
				//description = "";
				typeName = "BOOL";
				defaultValue = 0;
			};
			
			class sideCiv {
				displayName = "Enable Civilian";
				//description = "";
				typeName = "BOOL";
				defaultValue = 0;
			};
		};
	};

	class tun_utilities_combatZoneModule : GVAR(combatZoneModule) {
		displayName = "Deprecated - But works";
		scope = 1;// Editor visibility; 2 will show it in the menu, 1 will hide it.
	};
};
