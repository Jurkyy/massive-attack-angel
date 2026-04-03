#!/bin/bash
set -e

echo "=== TidalCycles Setup (Arch Linux) ==="

echo ""
echo "--- Installing system packages ---"
sudo pacman -S --needed haskell-tidal sc3-plugins

echo ""
echo "--- Installing SuperDirt quark ---"
SCLANG_CMD="sclang"
if command -v pw-jack &>/dev/null; then
    echo "PipeWire detected, using pw-jack for sclang"
    SCLANG_CMD="pw-jack sclang"
fi
echo "Installing SuperDirt quark (this downloads ~200MB of samples)..."
echo "Run this manually if it fails:"
echo "  pw-jack sclang"
echo '  Quarks.install("SuperDirt", "v1.7.3");'
echo "  0.exit;"
echo ""
$SCLANG_CMD <<'SCLANG_EOF'
Quarks.install("SuperDirt", "v1.7.3");
SCLANG_EOF

echo ""
echo "--- Locating BootTidal.hs ---"
BOOT_TIDAL=$(find /usr -name "BootTidal.hs" -path "*/tidal/*" 2>/dev/null)
if [ -n "$BOOT_TIDAL" ]; then
    echo "Found: $BOOT_TIDAL"
else
    echo "WARNING: BootTidal.hs not found under /usr"
fi

echo ""
echo "--- Checking PipeWire status ---"
if systemctl --user is-active pipewire; then
    echo "PipeWire is running"
else
    echo "WARNING: PipeWire is not active"
fi

echo ""
echo "=== Setup complete ==="
echo "Next steps:"
echo "  1. Start SuperDirt:  pw-jack sclang superdirt-startup.scd"
echo "  2. Start TidalCycles in your editor"
