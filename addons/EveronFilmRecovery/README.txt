Everon NATO filming layout recovery, 8 October 2026

Recovered 27 logged player-spawned entities: seven vehicles, fifteen US troops,
and five Move markers, at their original recorded positions. Prefabs retain their
native equipment and functionality. This is reconstruction from logs, not an
exact live-state export: rotations, later position edits, crew seating, groups
and waypoint assignments were not recorded and require review.

VERIFIED RESULT
All five script configurations and packing passed. The replacement reached GAME
with Game Master persistence enabled. The named manual checkpoint completed,
appeared in the Load game menu, and wrote metadata plus a 75,724-byte WorldState
file. A fresh client loaded its UUID, reported Session restored, and found all
27 entities with no position discrepancy above 0.02 metres. Save/load controls
are visible. Vehicle movement, seating and order completion were not tested.
Native resource/UI/pathfinding errors remain in the full logs; this is not a
clean gameplay or shutdown claim.

Save name: Everon NATO Film Start - Recovered 2026-10-08
Save UUID: 6053554c-4a8d-4a41-934f-123679362923
The verified starting checkpoint and full evidence are also backed up locally.

PLAYER HANDOFF
The new recovered client is open, paused and untimed. The original unsaved player
client is still open separately, unchanged. Use the new window with visible
folder and floppy-disk controls; the old window lacks them.
Review vehicle headings, put drivers/crews into the vehicles, and assign Move
commands to their actual AI groups. Loose Move markers do not order a driver.
Then Save As a new named starting setup before pressing the top play control.
Ctrl+Shift+S is the installed Save As binding; I hides/shows the camera UI.

RELAUNCH
After closing only the recovered client normally, run from the workspace:
  powershell -File tools/everon-film-recovered.ps1 -LoadStart
This loads the backed-up named starting checkpoint in the isolated profile.
Omit -LoadStart to start a new playthrough from the authored recovered layout.
The helper refuses a duplicate recovered client and does not touch the original.
Keep this addon and the five installed NATO packages mounted when loading it.

The launch uses ArmaReforgerSteamDiag.exe and its supported worldSystemsConfig
parameter to load GameMasterSystems.conf. A scenario header is included for the
normal Scenarios workflow too, but that workflow has not been live-tested.
Without the persistence systems, a raw world launch will again lack saving.

Current logs: D:/ReforgerAgentRuns/everon-nato-film-recovered-v3-20261008/logs
Private evidence: .cache/cinematic-player/everon-nato-20261008/recovery
Frozen pack: .cache/cinematic-player/everon-nato-20261008/recovered-addons-v3
Convoy development and the previous valley cinematic remain stopped.
