# Tun Utilities – CombatZone

Server-side safe-zone/area-of-operations enforcement with map polygons driven by editor markers or script calls.

## What it does
- Defines one or more combat polygons per side from map markers (or via script) and checks players on a per-frame handler.
- Warns players when they leave the allowed area (dynamic text + optional Arma voice lines). Admins only receive a sideChat reminder.
- Draws the polygons on the map (red outline) for clients; optionally shows the source markers.

## Prerequisites
- CBA_A3
- ACE3 (for the ACE module framework)

## Defining zones (Eden module)
Place the module **Tun Combat Zone** (category "Tun Utilities"). Arguments:
- **Marker prefix**: Prefix used for the polygon markers (e.g., `ao`). Markers must be named `ao_1`, `ao_2`, …
- **Marker Count**: How many vertices the polygon has (number of markers).
- **Show Markers**: Show/hide the source markers in-game.
- **Enable West/East/Resistance/Civilian**: Which sides this zone applies to. You can enable multiple.

## Defining zones (script API)
Call the function after mission start on each client (it exits on server headless):
```sqf
// Returns a hash key for later removal
private _hash = [[west, east], "ao", 5, false, true, false] call tunuti_combatZone_fnc_addCombatZone;
```
Parameters match the module fields plus:
1. Sides array
2. Marker prefix (string)
3. Marker count (number of vertices)
4. Reset zones before adding (bool)
5. Show markers (bool)
6. Hide markers when reset (bool)

Remove a zone by hash:
```sqf
[_hash] call tunuti_combatZone_fnc_removeCombatZone;
```

## Runtime behavior
- Starts once loading screen is done (client) and runs every `updateInterval` seconds.
- Ignores spectators, players in air vehicles, and those flagged `tunres_Respawn_isWaitingRespawn`.
- Admins are exempt from the teleport/voice effects (they only get a chat warning).
- Uses `GVAR(disableCombatZone)` (bool, per client) to temporarily stop checks if you need to pause enforcement.

## Visuals
- Polygons are drawn on the map (control 51) in red. Draw handlers are refreshed whenever zones are added/removed.
- Source markers can be shown/hidden via the module/param.

## CBA settings (per mission)
- **Enable CombatZone**: Master toggle (default: on).
- **CombatZone check interval**: Seconds between checks (default: 10s).
- **CombatZone hint text**: Text shown in the red on-screen warning.
- **CombatZone voice effect**: Play localized voice lines when leaving the zone (default: on).

## Tips
- Keep polygon vertices ordered (clockwise or counter-clockwise) to avoid self-intersections.
- Use at least 3 markers; more points give smoother boundaries.
- If you change markers mid-mission, call `tunuti_combatZone_fnc_updateCombatZonePolygon` to refresh the map overlay.
