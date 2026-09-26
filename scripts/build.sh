#!/bin/sh
# Runs inside the container. West workspace lives in .zmk/ (gitignored),
# firmware lands in builds/.
set -e

cd /cfg/.zmk
mkdir -p config
cp /cfg/config/west.yml config/west.yml
[ -d .west ] || west init -l config
west update
west zephyr-export

west build -p -s zmk/app -d build -b "$BOARD" -- \
  -DSHIELD="$SHIELD" \
  -DZMK_CONFIG=/cfg/config \
  -DZMK_EXTRA_MODULES=/cfg

mkdir -p /cfg/builds
cp build/zephyr/zmk.uf2 "/cfg/builds/$BOARD-$SHIELD-zmk.uf2"
echo "Firmware: builds/$BOARD-$SHIELD-zmk.uf2"
