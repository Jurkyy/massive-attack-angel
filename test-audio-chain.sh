#!/bin/bash
set -e

echo "=== TidalCycles Audio Chain Test ==="
echo ""

# 1. Check PipeWire
echo -n "[1/4] PipeWire: "
if systemctl --user is-active pipewire > /dev/null 2>&1; then
    echo "OK (running)"
else
    echo "FAIL - PipeWire not running"
    exit 1
fi

# 2. Check pw-jack
echo -n "[2/4] pw-jack: "
if command -v pw-jack > /dev/null 2>&1; then
    echo "OK ($(which pw-jack))"
else
    echo "FAIL - pw-jack not found. Install pipewire-jack"
    exit 1
fi

# 3. Check haskell-tidal
echo -n "[3/4] haskell-tidal: "
if pacman -Q haskell-tidal > /dev/null 2>&1; then
    echo "OK ($(pacman -Q haskell-tidal | awk '{print $2}'))"
else
    echo "FAIL - haskell-tidal not installed. Run: sudo pacman -S haskell-tidal"
    exit 1
fi

# 4. Check SuperCollider
echo -n "[4/4] SuperCollider: "
if command -v sclang > /dev/null 2>&1; then
    echo "OK ($(which sclang))"
else
    echo "FAIL - sclang not found. Install supercollider"
    exit 1
fi

echo ""
echo "=== All checks passed! ==="
echo ""
echo "Next steps:"
echo "  1. Start SuperDirt:  pw-jack sclang superdirt-startup.scd"
echo "  2. Start Tidal:      ghci -ghci-script BootTidal.hs"
echo "  3. Test with:        d1 \$ s \"bd\""
echo "  4. Load the song:    Evaluate blocks from angel.tidal"
