# zmk-build-arm:3.5 matches ZMK v0.3 (Zephyr 3.5) pinned in config/west.yml
FROM zmkfirmware/zmk-build-arm:3.5
COPY scripts/build.sh /usr/local/bin/build-firmware
ENTRYPOINT ["build-firmware"]
