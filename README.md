# Macropad3x3

ZMK firmware for a hand-wired 3x3 macropad on a **nice!nano v2**.

## Keymap

Viewed from the top (keycaps facing you).

**Layer 0 — default**

```
┌───────┬───────┬───────┐
│   1   │   2   │   3   │
├───────┼───────┼───────┤
│   4   │   5   │   6   │
├───────┼───────┼───────┤
│   7   │   8   │  Fn   │
└───────┴───────┴───────┘
```

**Layer 1 — Fn (hold bottom-right key)**

```
┌───────┬───────┬───────┐
│  BT0  │  BT1  │  BT2  │
├───────┼───────┼───────┤
│ BOOT  │   ·   │  OFF  │
├───────┼───────┼───────┤
│BT CLR │   ·   │ (held)│
└───────┴───────┴───────┘
```

- `BT0`–`BT2` — switch Bluetooth profile (paired device).
- `BT CLR` — forget the pairing of the current profile.
- `BOOT` — reboot into the bootloader (`NICENANO` drive appears), no reset button needed.
- `OFF` — hold 2 s to power off. Any key turns it back on.
- `·` — transparent, falls through to layer 0.

## Wiring

Matrix `col2row`, diodes 1N4148 with the stripe toward the row wire.

| Wire  | Role    | nice!nano pins            |
|-------|---------|---------------------------|
| black | rows    | D5, D6, D7 (top → bottom) |
| red   | columns | D4, D3, D2 (left → right) |

## Power

After 15 minutes without key presses the board goes into deep sleep. Any key
wakes it and reconnects to the last used Bluetooth device (the wake-up press
itself is not typed). Timeout: `CONFIG_ZMK_IDLE_SLEEP_TIMEOUT` in
`config/macropad.conf`.

Manual power-off: `Fn` + `OFF` held for 2 s. Wakes on any key, same as sleep.

Battery level is reported over Bluetooth — macOS shows it in Control Center →
Bluetooth and in System Settings → Bluetooth.

## Build and flash

1. Push to GitHub — Actions builds the firmware (`.github/workflows/build.yml`).
2. Download the `firmware` artifact from the workflow run.
3. Press `Fn` + `BOOT` (or double-tap reset on the nice!nano) — the `NICENANO` drive appears.
4. Copy `macropad-nice_nano_v2-zmk.uf2` onto it. The board reboots on its own.

## Files

| File | What |
|------|------|
| `boards/shields/macropad/macropad.keymap` | Layers and keys |
| `boards/shields/macropad/macropad.overlay` | Matrix pins |
| `boards/shields/macropad/Kconfig.defconfig` | Bluetooth name (`Macropad3x3`) |
| `config/macropad.conf` | Sleep, soft off, battery reporting |
| `build.yaml` | Board + shield for CI |
