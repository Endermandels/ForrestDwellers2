# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Forrest Dwellers 2 is a turn-based RPG built in Godot 4.5. The player collects animal companions and battles enemies, progressing toward a final dragon boss.

## Running the Game

Run and test through the Godot Editor (F5). There are no CLI build or test commands.

## Core Architectural Patterns

### Resource / Runtime Split

Every game entity has two counterparts:

- **Resource** (`scripts/resources/`) — a Godot `Resource` subclass holding static, serializable data. Saved as `.tres` files in `resources/`. Edited in the Godot Inspector.
- **Runtime** (`scripts/runtime/`) — a `Node` subclass instantiated from its Resource at game start, holding mutable state for the duration of a session.

When adding a new entity type, always create both. The Resource defines the "template"; the Runtime defines the "live instance."

Effects follow the same split: e.g. `DMGEffectResource` / `DMGEffectRuntime`. The Runtime's `init(res)` hook receives the Resource for any extra initialization beyond the base class.

### State Machine

Battle (and future systems) use a generic `StateMachine` component (`scripts/components/`). States communicate via a shared `data: Dictionary` passed through every `enter` / `step` / `exit` call. `step()` returns the next `State`, or `null` to stay in the current state.

Keep state logic self-contained. Cross-state communication goes through `data`, not direct references between state nodes.

### Autoloads

Three singletons are always available — do not instantiate these manually:

- `GameState` — persistent player data across scenes (`player`, `player_units`)
- `Helper` — small pure utility functions
- `Constants` — shared enums (`Trigger`, `TargetRule`)

### Naming Conventions

- State classes: `State` prefix (e.g. `StateTurnStart`)
- Resource/Runtime pairs share a base name with their suffix (e.g. `UnitResource` / `UnitRuntime`)
- Effect subclasses follow the same rule: `DMGEffectResource` / `DMGEffectRuntime`
