#!/usr/bin/env bash
# =============================================================================
#  update-lib.sh
#  Pushes a mission's lib/ folder back into this repo, replacing the repo's
#  lib/. Use after you've iterated on functions inside a mission and want
#  the changes to become the new canonical library.
#
#  Usage:
#      scripts/update-lib.sh                 # source = ./lib   (current dir)
#      scripts/update-lib.sh <mission-dir>   # source = <mission-dir>/lib
#      scripts/update-lib.sh <mission-dir> -y   # skip confirmation prompt
#
#  Safety:
#    - Verifies source has functions.hpp + constants.hpp (basic sanity check).
#    - Prompts before wiping the repo's lib/ (skip with -y / --yes).
#    - Since the repo is tracked in git, run `git diff` / `git restore lib/`
#      afterwards to review or revert.
# =============================================================================

set -euo pipefail

# --- args --------------------------------------------------------------------
ASSUME_YES=0
MISSION_DIR="."

for arg in "$@"; do
    case "$arg" in
        -y|--yes) ASSUME_YES=1 ;;
        -*)       echo "ERROR: unknown option '$arg'" >&2; exit 2 ;;
        *)        MISSION_DIR="$arg" ;;
    esac
done

# --- paths -------------------------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
REPO_LIB="$REPO_ROOT/lib"

[[ -d "$MISSION_DIR" ]] || { echo "ERROR: mission dir not found: $MISSION_DIR" >&2; exit 1; }
MISSION_DIR="$(cd "$MISSION_DIR" && pwd)"
SRC_LIB="$MISSION_DIR/lib"

# --- sanity checks -----------------------------------------------------------
[[ -d "$SRC_LIB" ]] || { echo "ERROR: source lib not found at $SRC_LIB" >&2; exit 1; }

for required in functions.hpp constants.hpp; do
    if [[ ! -f "$SRC_LIB/$required" ]]; then
        echo "ERROR: $SRC_LIB is missing $required — refusing to sync." >&2
        exit 1
    fi
done

# Prevent self-copy (mission dir points at the repo itself).
if [[ "$SRC_LIB" == "$REPO_LIB" ]]; then
    echo "ERROR: source and destination are the same folder." >&2
    exit 1
fi

echo "Source lib:      $SRC_LIB"
echo "Destination lib: $REPO_LIB"

# --- confirm -----------------------------------------------------------------
if [[ $ASSUME_YES -eq 0 ]]; then
    read -r -p "This will DELETE and REPLACE the repo's lib/. Continue? [y/N] " ans
    [[ "$ans" =~ ^[Yy]$ ]] || { echo "Aborted."; exit 0; }
fi

# --- replace -----------------------------------------------------------------
rm -rf "$REPO_LIB"
cp -R "$SRC_LIB" "$REPO_LIB"

echo "Done. Review with:  git -C '$REPO_ROOT' diff -- lib"
