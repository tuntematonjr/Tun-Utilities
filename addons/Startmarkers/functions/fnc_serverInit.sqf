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

[] call FUNC(updateData);

GVAR(serverDone) = true;
publicVariable QGVAR(serverDone);