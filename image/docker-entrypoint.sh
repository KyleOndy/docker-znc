#! /usr/bin/env sh
set -euo pipefail

# Options.
DATA_DIR=${ZNC_DATA_DIR:=/znc-data}
printf "ZNC_DATA_DIR: %s\n" "$DATA_DIR"

# Build modules from source.
MODULES_DIR=${ZNC_MODULES_DIR:=${DATA_DIR}/modules}
printf "MODULES_DIR: %s\n" "$MODULES_DIR"
if [ -d "${MODULES_DIR}" ]; then
  # Store current directory.
  cwd="$(pwd)"

  # Find module sources.
  modules=$(find "${MODULES_DIR}" -name "*.cpp")

  # Build modules.
  for module in $modules; do
    cd "$(dirname "$module")" || exit 1
    znc-buildmod "$module"
  done

  # Go back to original directory.
  cd "$cwd" || exit 1
fi

# Create default config if it doesn't exist
CONFIG_DIR=${ZNC_CONFIG_DIR:=${DATA_DIR}/configs}
printf "CONFIG_DIR: %s\n" "$CONFIG_DIR"
if [ ! -f "${CONFIG_DIR}/znc.conf" ]; then
  mkdir -p "${CONFIG_DIR}"
  printf "Exisitng config not found. Using default config\n"
  cp /znc.conf.default "${CONFIG_DIR}/znc.conf"
fi

# Make sure $DATA_DIR is owned by znc user. This effects ownership of the
# mounted directory on the host machine too.
chown -R znc:znc "$DATA_DIR"

# Start ZNC.
printf "Starting znc\n"
exec znc --allow-root --foreground --datadir="$DATA_DIR" "$@"
