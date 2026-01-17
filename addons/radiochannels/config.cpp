#include "script_component.hpp"

// information on this addon specifically
class CfgPatches {
	class ADDON {
		name = COMPONENT_NAME;
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {"ace_interaction","ace_interact_menu","tfar_core",QGVARMAIN(main)};
		author = "Tuntematon";
		authorUrl = GITHUBLINK;
		VERSION_CONFIG;
		skipWhenMissingDependencies = 1;
	};
};

// configs go here
#include "CfgEventHandlers.hpp"

class Cfg3DEN
{
	// Configuration of all objects
	class Object
	{
		// Categories collapsible in "Edit Attributes" window
		class AttributeCategories
		{
			// Category class, can be anything
			class ADDON
			{
				displayName = "Tun Utilities - Radiochannels"; // Category name visible in Edit Attributes window
				collapsed = 1; // When 1, the category is collapsed by default
				class Attributes
				{

					class GVAR(skipSquad)
					{
						displayName = "Skip radiochannel";
						tooltip = "When true, does not create any channels for this squad. Only group leaders setting has effect";
						property = QGVAR(skipSquadRadiochannel);
						control = "Checkbox";
						expression = QUOTE(if(leader group _this isEqualTo _this) then {(group _this) setVariable [ARR_3(QQGVAR(skipSquad),_value,true)]});
						defaultValue = "false";
						unique = 0;
						condition = "objectBrain";
					};
				};
			};
		};
	};
};
