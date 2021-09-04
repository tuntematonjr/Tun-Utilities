/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call tun_startmarkers_fnc_imanexample
 */
#include "script_component.hpp"

[{diag_tickTime > _this || is3DENPreview}, {
	[] call FUNC(updateData);
}, (diag_tickTime + 10)] call CBA_fnc_waitUntilAndExecute;