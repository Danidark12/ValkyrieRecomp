# ValkyrieRecomp

<p align="center">
  <img src="docs/valkyrie-recomp-logo.png" alt="ValkyrieRecomp" width="900">
</p>

![Gameplay](docs/preview.png)

<p align="center">
  <a href="https://recomplauncher.com"><picture><source media="(prefers-color-scheme: dark)" srcset="https://recomplauncher.com/assets/press/launcher/badge-light.svg"><img src="https://recomplauncher.com/assets/press/launcher/badge-dark.svg" alt="Get it on RecompLauncher" height="48"></picture></a>
</p>

A native PC recompilation project for **Valkyrie Profile (PlayStation, USA)**,
built with [PSXRecomp](https://github.com/mstan/psxrecomp) and
[recomp-ui](https://github.com/mstan/recomp-ui).

> **This fork is focused on running the Valkyrie Profile Undub** (the USA
> release with the original Japanese voice acting). The original USA discs
> work as well.
>
> **Status:** Work in progress / compatibility testing.

## How to play

1. Download the latest zip from the [Releases](https://github.com/Danidark12/ValkyrieRecomp/releases)
   page and extract it (or install it with RecompLauncher).
2. Open `ValkyrieRecomp.exe` and pick your Disc 1 (Undub or USA). Disc 2 is
   found automatically when it sits next to it with "(Disc 2)" in its name.
3. Run **Generate & rebuild** once: the game is built on your PC from your own
   discs (a few minutes). Later starts go straight to the launcher.
4. Press **Play**. In game, **F4** opens the options menu.

## About this fork

This fork, maintained by [Danidark12](https://github.com/Danidark12), builds on
the [original ValkyrieRecomp (Ed1z19)](https://github.com/Ed1z19/ValkyrieRecomp).
Its main goal is to play the **Undub** comfortably: the launcher accepts Undub
images, the two discs are swapped for you, and most quality-of-life options can
be changed without leaving the game.

The submodules point to the forks that carry the changes (branch `ptbr`):
[Danidark12/psxrecomp](https://github.com/Danidark12/psxrecomp/tree/ptbr) and
[Danidark12/recomp-ui](https://github.com/Danidark12/recomp-ui/tree/ptbr).

As in the original project, **the game is not included**: you use your own
discs, and the game is built on your PC by the launcher's "Generate & rebuild".
Non-commercial project (psxrecomp uses the PolyForm Noncommercial license).

## Using the Undub

- Any Undub whose disc images are **the same size as the retail USA discs** is
  accepted. Its hash differs from the retail one; the launcher only notes that
  in its log. Plain `.bin` images can be selected directly; no `.cue` is
  needed.
- **Disc paths are remembered** (`discs.cfg`, next to the executable), so you
  pick them once. When you choose Disc 1, the launcher also finds Disc 2 by
  itself if it sits next to it with the usual "(Disc 2)" name.
- **Automatic disc swap:** when the game asks for the other disc, the runtime
  opens the virtual lid and inserts it. You can also swap by hand with
  **CHANGE DISC** in the in-game options menu (F4).
- Disc 2 saves can be loaded from the title screen of Disc 1; the swap to
  Disc 2 happens automatically.

## What this fork adds

**Launcher**
- English, Portuguese (Brazil) and Spanish (**Language** button at the top);
  the choice is saved in `launcher_language.txt`. Mod names and cheat
  descriptions are translated too.
- "Optimize FMV playback" (PGO) actually works on Windows.
- The Shortcuts page lists every hotkey, and shows/edits the same keys the
  Settings page uses.

**In-game options menu (F4 / Select+Square)**
- Aspect ratio: 4:3, 16:9 or 21:9, without stretching the image.
- Texture filtering, smoothing, and screen filters (OpenGL): LCD grid, LCD RGB,
  CRT and soft CRT.
- Scanlines on/off, separate from the screen filters (also F6).
- **FRAME**: cycles the bezel artwork through your own images (see
  [`molduras/README.txt`](molduras/README.txt)), then off. Needs the
  *Bezel Artwork* mod.
- Change disc, and return to the launcher.

**Cheats** (launcher Cheats tab, or in game with F5 / Select+L3), listed in
[`cheats.txt`](cheats.txt) with names and descriptions in the three languages.

**Hotkeys**

| Action | Keyboard | Controller |
|---|---|---|
| Quick save / quick load | F2 / F3 | Select+R2 / Select+L2 |
| Save states menu | F7 | |
| Fast-forward (hold) | Tab | Select+L1 |
| Fast-forward speed down / up | F10 / F11 | Select+Left / Select+Right |
| Options menu | F4 | Select+Square |
| Cheats menu | F5 | Select+L3 |
| Scanlines | F6 | |

**Fixes**
- Battle freeze fixed (GPU drawing is now paced like the real rasteriser).
- No more black wedges on the world map with *perspective texturing* on, or
  in 16:9 / 21:9 (terrain chunks next to the 4:3 view are kept).
- The bezel frame stays visible on blank screens (BIOS intro, loads, battle
  transitions), and FMVs are centered inside it.
- A hitch recorder writes the slowest frames of each session to
  `psx_last_run_report.json` when the game closes, to track down stutters that
  only happen on some PCs.

### Rebuilding after source changes

[`scripts/rebuild.cmd`](scripts/rebuild.cmd) rebuilds only what changed and
starts the launcher. If the launcher's own rebuild pruned the build files, it
re-runs the full configure first.

## AI Usage Notice

This project may use AI-assisted tools for development, documentation, artwork, or other supporting materials.

All AI-assisted content is reviewed before inclusion.

## Legal

This repository **does not include the original game disc images** or a retail
PlayStation BIOS. You must provide your own legally obtained copy of the game.

No ownership claim is made over the original Valkyrie Profile game or its copyrighted assets.

Disc images, saves, local BIOS files and build outputs are excluded by
`.gitignore` and must not be committed to this repository.

## Getting the source

Clone the repository with its submodules:

```bash
git clone --recursive <repository-url>
cd ValkyrieRecomp
```

If you already cloned it without submodules:

```bash
git submodule update --init --recursive
```

## Disc setup

The launcher lets you pick the discs anywhere on your PC (Undub or USA). For
command-line builds and local testing the project expects them here:

```text
disc/Disc1/Valkyrie Profile (USA) (Disc 1).cue
disc/Disc2/Valkyrie Profile (USA) (Disc 2).cue
```

The `disc/` directory is intentionally ignored by Git.

## Building

A typical Release build uses CMake and Ninja:

```bash
./psxrecomp/tools/ci/build_emitters.sh
python3 psxrecomp/psxrecomp_cli.py generate \
  --config game.toml --project-root . \
  --disc "disc/Disc1/Valkyrie Profile (USA) (Disc 1).cue"
cmake -S . -B build-release -G Ninja -DCMAKE_BUILD_TYPE=Release
cmake --build build-release --target psx-runtime
```

On Windows, use an environment with the required compiler/toolchain and
PowerShell 7 where required by the project scripts.

## Widescreen

The launcher currently offers:

- **4:3** — original aspect ratio
- **16:9** and **21:9** — widescreen modes (also selectable in game, F4)

## Known issues

- Compatibility and performance testing across different PCs is still ongoing.
- Some framework/runtime behavior may differ depending on hardware and drivers.
- Loading a save sometimes fails with "An error occurred while accessing
  MEMORY CARD data". It is a timing race between the game and the memory card
  emulation (it happens with OpenBIOS and with the Sony BIOS). Press X and load
  again; the next attempt usually works.
- Some players see short stutters when flipping cards in the Voice Collection,
  near save crystals and on stairs. Not reproduced yet; the hitch recorder is
  there to find it.
- The world map runs at 30 fps, like the original game.

## Releases

Prebuilt binaries are distributed through the repository's **Releases** page.
Build directories and executables generated locally are not stored in the main
source tree.

## Framework

This project uses the following repositories as Git submodules (forks of
[mstan/psxrecomp](https://github.com/mstan/psxrecomp) and
[mstan/recomp-ui](https://github.com/mstan/recomp-ui)):

- [Danidark12/psxrecomp](https://github.com/Danidark12/psxrecomp/tree/ptbr) (branch `ptbr`)
- [Danidark12/recomp-ui](https://github.com/Danidark12/recomp-ui/tree/ptbr) (branch `ptbr`)

Keep the pinned submodule revisions when creating reproducible releases.
