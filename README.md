# Massive Attack "Angel" — TidalCycles Recreation

A trip-hop composition inspired by Massive Attack's "Angel", programmed in Haskell using [TidalCycles](https://tidalcycles.org/).

~80 BPM | Heavy sub-bass | Breakbeat drums | Atmospheric buildup

## Quick Start

```bash
# 1. Install dependencies (Arch Linux)
./setup.sh

# 2. Test the audio chain
./test-audio-chain.sh

# 3. Start SuperDirt (audio engine) — keep this running
pw-jack sclang superdirt-startup.scd

# 4. In another terminal, start TidalCycles
ghci -ghci-script BootTidal.hs

# 5. Evaluate the tempo, then song sections from angel.tidal
```

## Prerequisites

- Arch Linux (or derivative) with PipeWire
- Audio output (speakers/headphones)

## Installation

Run the setup script:

```bash
chmod +x setup.sh test-audio-chain.sh
./setup.sh
```

This installs:
- `haskell-tidal` — TidalCycles + GHC + all Haskell deps
- `sc3-plugins` — SuperCollider + extra UGens
- SuperDirt quark — sample library and synth engine

## Usage

TidalCycles is a live-coding environment. You evaluate code blocks in your editor and hear the results immediately.

### Editor Setup

**Vim**: Install [vim-tidal](https://github.com/tidalcycles/vim-tidal)
**VS Code**: Install the [TidalCycles extension](https://marketplace.visualstudio.com/items?itemName=tidalcycles.vscode-tidalcycles)
**Emacs**: Install [tidal-mode](https://github.com/tidalcycles/Tidal/blob/main/tidal.el)

### Running Without an Editor Plugin

You can also paste code directly into the `ghci` REPL:

```bash
pw-jack sclang superdirt-startup.scd  # Terminal 1
ghci -ghci-script BootTidal.hs        # Terminal 2
# Then paste lines from angel.tidal into Terminal 2
```

## Song Structure

The composition in `angel.tidal` has 5 sections:

| # | Section | Description | Channels |
|---|---------|-------------|----------|
| 1 | **Intro** | Sub-bass drone, distant atmosphere | d1, d4 |
| 2 | **Verse** | Bassline enters, breakbeat drums | d1, d2, d4 |
| 3 | **Main** | Full intensity — drums, bass, stabs | d1–d5 |
| 4 | **Breakdown** | Strip back to bass + atmosphere | d1, d4, d5 |
| 5 | **Final Build** | Everything returns, noise riser | d1–d6 |

Evaluate each section's `d` blocks to transition between parts. Use `hush` to silence everything.

## Customization

### Tempo
```haskell
setcps (80/60/4)  -- 80 BPM
setcps (70/60/4)  -- Slower, more spacious
setcps (90/60/4)  -- Faster, more energetic
```

### Custom Samples
Place `.wav` files in `samples/your-sample-name/` and load them in `superdirt-startup.scd`:
```supercollider
~dirt.loadSoundFiles("/path/to/massive-attack-angel/samples/*");
```

## Troubleshooting

| Problem | Solution |
|---------|----------|
| No sound | Ensure `pw-jack` is used: `pw-jack sclang superdirt-startup.scd` |
| "Could not connect to SuperCollider" | Start SuperDirt first, wait for "SuperDirt started" message |
| GHCi module errors | Verify: `pacman -Q haskell-tidal` |
| Crackling/latency | Adjust PipeWire quantum: `pw-metadata -n settings 0 clock.force-quantum 256` |
| SuperDirt won't install | Manual: `cd ~/.local/share/SuperCollider/downloaded-quarks && git clone https://github.com/musikinformatik/SuperDirt.git` |
