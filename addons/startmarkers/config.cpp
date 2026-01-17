#include "script_component.hpp"

// information on this addon specifically
class CfgPatches {
	class ADDON {
		name = COMPONENT_NAME;
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {QGVARMAIN(main)};
		author = "Tuntematon";
		authorUrl = GITHUBLINK;
		VERSION_CONFIG;
	};
};

// configs go here
class   RscButton;
class   RscText;
class   RscCheckBox;
#include "CfgEventHandlers.hpp"
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
			class ADDON
			{
				displayName = "Tun Utilities - Starmarkers & BFT"; // Category name visible in Edit Attributes window
				collapsed = 1; // When 1, the category is collapsed by default
				class Attributes
				{
					class tunuti_startmarkers_enable_marker_inf
					{
						displayName = "Enable startpos and BFT for squad";
						tooltip = "Enables start position marker and BFT for this group. To disable, toggle it from group leaders attributes";
						property = "tunuti_startmarkers_enable_marker_inf";
						control = "Checkbox";
						expression = QUOTE((group _this) setVariable [ARR_3(QQGVAR(enableMarker),_value,true)]);
						defaultValue = "true";
						unique = 0;
						condition = "objectBrain";
					};

					class tunuti_startmarkers_enable_marker_vehicle: tunuti_startmarkers_enable_marker_inf
					{
						displayName = "Enable startpos and BFT for vehicle";
						tooltip = "Enables start position marker and BFT for this group.";
						property = "tunuti_startmarkers_enable_marker_vehicle";
						expression = QUOTE(_this setVariable [ARR_3(QQGVAR(enableMarker),_value,true)]);
						condition =  "objectHasInventoryCargo + objectVehicle";
					};

					class tunuti_startmarkers_startPosName: tunuti_startmarkers_enable_marker_inf
					{
						displayName = "Custon vehicle text";
						tooltip = "You can change the default startpos marker name shown at brieffing to a different one. Names shorter than 2 characters wont be set.";
						property = "tunuti_startmarkers_startPosName";
						control = "EditShort";
						expression = "if (count _value > 1) then { _this setVariable ['displayName', _value,true]};";
						defaultValue = "''";
						condition = "objectHasInventoryCargo + objectVehicle";
					};

					class tunuti_startmarkers_vehicle_side: tunuti_startmarkers_enable_marker_inf
					{
						displayName = "Vehicle Side";
						tooltip = "Select which side this vehicle is shown.";
						property = QGVAR(vehicle_side_west);
						control = "combo";
						expression = QUOTE(if (_value isNotEqualTo -1) then {private _side = [ARR_4(west,east,resistance,civilian)] select _value; _this setVariable [ARR_3(QQGVAR(vehicleSide),_side,true)]});
						defaultValue = -1;
						condition = "objectHasInventoryCargo + objectVehicle";
						typeName = "NUMBER";

						class Values {
							class none
							{
								name = "None";
								value = -1;
							};

							class west
							{
								name = "West";
								value = 0;
								pictureRight = "a3\ui_f\data\map\diary\icons\playerwest_ca.paa";
							};

							class east
							{
								name = "East";
								value = 1;
								pictureRight = "a3\ui_f\data\map\diary\icons\playereast_ca.paa";
							};

							class resistance
							{
								name = "Resistance";
								value = 2;
								pictureRight = "a3\ui_f\data\map\diary\icons\playerguer_ca.paa";
							};

							class civilian
							{
								name = "Civilian";
								value = 3;
								pictureRight = "a3\ui_f\data\map\diary\icons\playerciv_ca.paa";
							};
						};
					};
				};
			};
		};
	};
};
