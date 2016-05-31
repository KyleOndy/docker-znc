#! /usr/bin/env sh

# Options.
DATA_DIR=${ZNC_DATA_DIR:=/znc-data}
echo "DATA_DIR=$DATA_DIR"

# Build modules from source.
MODULES_DIR=${ZNC_MODULES_DIR:=${DATA_DIR}/modules}
echo "MODULES_DIR=$MODULES_DIR"
if [ -d "${MODULES_DIR}" ]; then
  # Store current directory.
  cwd="$(pwd)"

  # Find module sources.
  modules=$(find "${MODULES_DIR}" -name "*.cpp")

  # Build modules.
  for module in $modules; do
    cd "$(dirname "$module")"
    znc-buildmod "$module"
  done

  # Go back to original directory.
  cd "$cwd"
fi

# Create default config if it doesn't exist
CONFIG_DIR=${ZNC_CONFIG_DIR:=${DATA_DIR}/configs}
echo "CONFIG_DIR=$CONFIG_DIR"
if [ ! -f "${CONFIG_DIR}/znc.conf" ]; then
  mkdir -p "${CONFIG_DIR}"
  cp /znc.conf.default "${CONFIG_DIR}/znc.conf"
fi

# Make sure $DATA_DIR is owned by znc user. This effects ownership of the
# mounted directory on the host machine too.
chown -R znc:znc "$DATA_DIR"

# Start ZNC.
exec znc --allow-root --foreground --datadir="$DATA_DIR" $@
