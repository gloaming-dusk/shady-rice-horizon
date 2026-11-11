#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/env.sh"
cd "$ROOT"

if [[ ! -f build/libshady-plugin-afterglow.so ]]; then
  echo "Horizon: build/libshady-plugin-afterglow.so is missing. Build Shady in $ROOT (./tools/build.sh)." >&2
  exit 1
fi

export SHADY_ROOT="$ROOT"
export SHADY_LUA_INIT="$RICE/init.lua"
source "$AFTERGLOW/theme.sh"
export SHADY_SHELL_CONFIG="${SHADY_SHELL_CONFIG:-$RICE/shell.lua}"

if [[ $# -eq 0 ]]; then
  default_startup="'$SHADY_SHELL_BIN' & exec ${TERMINAL:-foot}"
  set -- -s "${SHADY_STARTUP:-$default_startup}"
fi

exec "$ROOT/tools/run-native.sh" \
  -c "$RICE/config.lua" \
  "$@"
