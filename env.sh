# Sourced by run.sh, run-native.sh, capture.sh and the tests: where this
# rice, Shady and shady-shell are.
#
#   SHADY_ROOT       a built Shady checkout (default: ../shady next to this one)
#   SHADY_SHELL_BIN  shady-shell (default: ../shady-shell/build/shady-shell,
#                    else the one on PATH)
RICE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="${SHADY_ROOT:-$RICE/../shady}"
if [[ ! -d "$ROOT" ]]; then
  echo "Horizon: no Shady checkout at $ROOT. Set SHADY_ROOT to a built one." >&2
  exit 1
fi
ROOT="$(cd "$ROOT" && pwd)"
if [[ -z "${SHADY_SHELL_BIN:-}" ]]; then
  if [[ -x "$RICE/../shady-shell/build/shady-shell" ]]; then
    SHADY_SHELL_BIN="$(cd "$RICE/../shady-shell/build" && pwd)/shady-shell"
  else
    SHADY_SHELL_BIN="$(command -v shady-shell || true)"
  fi
fi
if [[ ! -x "$SHADY_SHELL_BIN" ]]; then
  echo "Horizon: no shady-shell. Build ../shady-shell or set SHADY_SHELL_BIN." >&2
  exit 1
fi
export SHADY_SHELL_BIN
# Afterglow, which Horizon is built on (shady.base("afterglow")).
AFTERGLOW="${SHADY_AFTERGLOW_DIR:-$RICE/../shady-rice-afterglow}"
if [[ ! -f "$AFTERGLOW/config.lua" ]]; then
  echo "Horizon: no Afterglow at $AFTERGLOW. Clone shady-rice-afterglow next to this, or set SHADY_AFTERGLOW_DIR." >&2
  exit 1
fi
AFTERGLOW="$(cd "$AFTERGLOW" && pwd)"
# Rices are looked up by name; these two under theirs.
SHADY_RICE_PATH="${XDG_RUNTIME_DIR:-${TMPDIR:-/tmp}}/shady-rices-$(id -u)"
mkdir -p "$SHADY_RICE_PATH"
ln -sfn "$RICE" "$SHADY_RICE_PATH/horizon"
ln -sfn "$AFTERGLOW" "$SHADY_RICE_PATH/afterglow"
export SHADY_RICE_PATH
