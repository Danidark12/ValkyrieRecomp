# ValkyrieRecomp

<p align="center">
  <img src="docs/valkyrie-recomp-logo.png" alt="ValkyrieRecomp" width="900">
</p>

![Gameplay](docs/preview.png)

A native PC recompilation project for **Valkyrie Profile (PlayStation, USA)**,
built with [PSXRecomp](https://github.com/mstan/psxrecomp) and
[recomp-ui](https://github.com/mstan/recomp-ui).

> **Status:** Work in progress / compatibility testing.

## Esta versão (fork pt-BR)

Este fork, mantido por [Danidark12](https://github.com/Danidark12), adiciona ao
[ValkyrieRecomp original (Ed1z19)](https://github.com/Ed1z19/ValkyrieRecomp):

- **Launcher em português do Brasil ou inglês**: botão **Language / Idioma** no
  topo do launcher (o padrão é inglês). A escolha é salva em
  `launcher_language.txt`, ao lado do executável.
- **Aceita a versão USA original e Undubs com o mesmo tamanho do disco
  original** (o hash pode ser diferente; o launcher avisa no log).
- **"Otimizar reprodução de FMV" funcionando no Windows**: o projeto agora
  liga o PGO de verdade na compilação (`-DPSX_PGO=generate|use`), e o treino
  fecha o jogo do jeito certo. O treino dura 6 minutos numa rodada só: durante
  ele, abra a abertura em anime pelo menu do jogo.
- Botões e dicas que não cortam textos longos.

Os submódulos apontam para os forks com as mudanças (branch `ptbr`):
[Danidark12/psxrecomp](https://github.com/Danidark12/psxrecomp/tree/ptbr) e
[Danidark12/recomp-ui](https://github.com/Danidark12/recomp-ui/tree/ptbr).

Como no projeto original, **o jogo não está incluído**: cada pessoa usa os
próprios discos, e o jogo é montado no PC dela pelo "Generate & rebuild".
Projeto sem fins comerciais (o psxrecomp usa a licença PolyForm Noncommercial).

## Features

- Native Windows executable
- Multi-disc support for Disc 1 and Disc 2
- 4:3 original aspect ratio and optional 16:9 widescreen
- OpenGL and software rendering options
- Controller support
- Memory card support
- Launcher-based disc selection
- OpenBIOS support through PSXRecomp

## Supported game

| | |
|---|---|
| Game | Valkyrie Profile |
| Region | USA / NTSC-U |
| Players | 1 |
| Disc 1 serial | SLUS-01156 |
| Disc 2 serial | SLUS-01179 |
| Original publisher | Enix |
| Original release | 2000 |

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

The project expects the two USA discs at these relative locations when building
or testing locally:

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
- **16:9** — optional widescreen mode

## Known issues

- Compatibility and performance testing across different PCs is still ongoing.
- Some framework/runtime behavior may differ depending on hardware and drivers.
- Mid-session disc swapping may still depend on the current PSXRecomp runtime
  implementation; disc selection between runs is supported by the launcher.

## Releases

Prebuilt binaries are distributed through the repository's **Releases** page.
Build directories and executables generated locally are not stored in the main
source tree.

## Framework

This project uses the following repositories as Git submodules:

- [mstan/psxrecomp](https://github.com/mstan/psxrecomp)
- [mstan/recomp-ui](https://github.com/mstan/recomp-ui)

Keep the pinned submodule revisions when creating reproducible releases.
