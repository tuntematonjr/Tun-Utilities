/*
 * Author: [Tuntematon]
 * Monitors player position and warns when outside the designated combat zone.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call tunuti_combazone_fnc_combatZone
 */

 
#include "script_component.hpp"
if (isServer && !hasInterface) exitWith {};

if 	(ace_player isKindOf "CAManBase" &&
	{alive ace_player} &&
	{!(ace_player isKindOf "ace_spectator_virtual")} &&
	{playerSide in [west,east,resistance,civilian]} &&
	{!(vehicle ace_player isKindOf "air")} &&
	{!(ace_player getVariable ["tunres_Respawn_isWaitingRespawn", false])}
) then {
	if !([] call FUNC(combatZoneCheck)) then {
		if (IS_ADMIN) then {
			ace_player sideChat "You are admin, hope you are not crossing the AO line without reason.";
		} else {
			[(format["<t color='#ff0000' size = '.8'>%1</t>", GVAR(hintText)]),-1,-1,4,1,0,789] spawn BIS_fnc_dynamicText;

			if (GVAR(enableVoiceEffect)) then {
				switch (ceil random 3) do {
					case 1: { 
						playSound3D ['a3\dubbing_f_epa\zone_restriction\A_Warn_No_Leader\zone_restriction_a_warn_no_leader_KER_0.ogg', ace_player];
						[[profileName, "Where the hell am I? I should check my map.", 0]] spawn BIS_fnc_EXP_camp_playSubtitles;
					};
					case 2: { 
						playSound3D ['a3\dubbing_f_epa\zone_restriction\A_Warn_No_Leader\zone_restriction_a_warn_no_leader_KER_1.ogg', ace_player];
						[[profileName, "This doesn't look right at all. Where am I?", 0]] spawn BIS_fnc_EXP_camp_playSubtitles;
					};
					case 3: { 
						playSound3D ['a3\dubbing_f_epa\zone_restriction\A_Warn_No_Leader\zone_restriction_a_warn_no_leader_KER_2.ogg', ace_player];
						[[profileName, "Wow, I must be way off course. Better check my map.", 0]] spawn BIS_fnc_EXP_camp_playSubtitles;
					};
				};
			};
		};
		INFO("player out of AO");
	};
};
