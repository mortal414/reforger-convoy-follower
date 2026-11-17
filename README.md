# Reforger Convoy Follower

An unfinished convoy-following experiment for Arma Reforger, with addon source, test scenes, radio assets, and local test tools.

**Paused. No Workshop release.** Repeatable one-, two-, and three-truck driving tests remain incomplete.

## Contents

- [Convoy Follower addon](addons/ConvoyFollower/README.md)
- [Map-maker setup](docs/convoy-mapmaker-quickstart.md)
- [Test scenarios and remaining checks](docs/convoy-automated-smoke.md)
- [Everon demo](docs/convoy-everon-demo.md)
- [Voice assets and provenance](docs/convoy-generated-voice.md)

This repo retains its original local harness. The reusable tooling now lives in [Reforger Agent Harness](https://github.com/mortal414/reforger-agent-harness).

## Development

Requires Node.js 24+ and Windows with Arma Reforger Tools.

1. Copy `reforger-agent.config.example.json` to `reforger-agent.config.json` and set local paths.
2. Run `npm ci`.
3. Run `npm run typecheck && npm test && npm run build`.

Start with the [harness handoff](docs/harness-handoff.md). [Local commands and test notes](docs/local-harness.md) cover setup and previous observations; the [operations playbook](docs/operations-playbook.md) covers Workbench and gameplay testing. Launchers dry-run unless `--execute` is supplied.

CI covers the TypeScript tools, not Enfusion validation or convoy driving.

## Licensing

No project-wide reuse license has been selected. Public source is not a general redistribution license. Voice dependencies have separate terms documented in the [voice notes](docs/convoy-generated-voice.md).
