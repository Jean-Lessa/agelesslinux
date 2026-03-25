#!/bin/bash
# test-distros.sh — run become-ageless.sh tests across multiple distros
#
# Usage: bash test/test-distros.sh [distro...]
#
# Examples:
#   bash test/test-distros.sh              # run all distros
#   bash test/test-distros.sh debian       # run just debian
#   bash test/test-distros.sh arch artix   # run arch and artix

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

# ── Distro definitions ───────────────────────────────────────────────────────
# Format: name:image

ALL_DISTROS=(
    "debian:debian:bookworm"
    "ubuntu:ubuntu:24.04"
    "arch:archlinux:latest"
    "fedora:fedora:latest"
    "artix:artixlinux/artixlinux:latest"
)

# ── Parse args ───────────────────────────────────────────────────────────────

SELECTED=()
if [[ $# -gt 0 ]]; then
    for arg in "$@"; do
        for entry in "${ALL_DISTROS[@]}"; do
            name="${entry%%:*}"
            if [[ "$name" == "$arg" ]]; then
                SELECTED+=("$entry")
            fi
        done
    done
    if [[ ${#SELECTED[@]} -eq 0 ]]; then
        echo "No matching distros found. Available:"
        for entry in "${ALL_DISTROS[@]}"; do
            echo "  ${entry%%:*}"
        done
        exit 1
    fi
else
    SELECTED=("${ALL_DISTROS[@]}")
fi

# ── Ensure script is built ───────────────────────────────────────────────────

if [[ ! -f "$REPO_DIR/become-ageless.sh" ]]; then
    echo "Building become-ageless.sh..."
    bash "$REPO_DIR/build.sh"
fi

# ── Run tests ────────────────────────────────────────────────────────────────

TOTAL=0
PASSED=0
FAILED=0
ERRORS=()

for entry in "${SELECTED[@]}"; do
    name="${entry%%:*}"
    image="${entry#*:}"

    echo ""
    echo "================================================================"
    echo "  TESTING: $name ($image)"
    echo "================================================================"

    TOTAL=$((TOTAL + 1))

    if docker run --rm \
        -v "$REPO_DIR:/src:ro" \
        "$image" \
        bash /src/test/run-in-container.sh; then
        PASSED=$((PASSED + 1))
    else
        FAILED=$((FAILED + 1))
        ERRORS+=("$name")
    fi
done

# ── Summary ──────────────────────────────────────────────────────────────────

echo ""
echo "================================================================"
echo "  SUMMARY"
echo "================================================================"
echo ""
echo "  Tested: $TOTAL distros"
echo "  Passed: $PASSED"
echo "  Failed: $FAILED"

if [[ $FAILED -gt 0 ]]; then
    echo ""
    echo "  Failed distros:"
    for e in "${ERRORS[@]}"; do
        echo "    - $e"
    done
    echo ""
    exit 1
else
    echo ""
    echo "  All distros passed."
    echo ""
fi
