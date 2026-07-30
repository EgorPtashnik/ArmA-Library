#!/usr/bin/env bash
# =============================================================================
#  new-mission.sh
#  Scaffolds an ArmA mission folder using this repo's template/ and lib/.
#
#  Usage:
#      scripts/new-mission.sh                 # scaffold into current dir
#      scripts/new-mission.sh <target-dir>    # scaffold into <target-dir>
#
#  Won't overwrite existing files — safe to re-run.
# =============================================================================

set -euo pipefail

# --- paths -------------------------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
LIB_SRC="$REPO_ROOT/lib"
TEMPLATE_SRC="$REPO_ROOT/template"

TARGET="${1:-.}"
mkdir -p "$TARGET"
TARGET="$(cd "$TARGET" && pwd)"

echo "Scaffolding mission in: $TARGET"
echo "Using template from:    $TEMPLATE_SRC"
echo "Using lib from:         $LIB_SRC"

# --- sanity checks -----------------------------------------------------------
[[ -d "$LIB_SRC"      ]] || { echo "ERROR: lib source not found at $LIB_SRC"           >&2; exit 1; }
[[ -d "$TEMPLATE_SRC" ]] || { echo "ERROR: template source not found at $TEMPLATE_SRC" >&2; exit 1; }

# --- copy (no clobber) -------------------------------------------------------
# `cp -R -n` never overwrites existing files. Works on Linux, macOS, Git Bash.
cp -R -n "$TEMPLATE_SRC/." "$TARGET/"

if [[ -d "$TARGET/lib" ]]; then
    echo "  skip  $TARGET/lib (exists)"
else
    cp -R "$LIB_SRC" "$TARGET/lib"
    echo "  copy  $TARGET/lib"
fi

echo "Done."
