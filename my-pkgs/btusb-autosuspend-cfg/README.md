# btusb-autosuspend-cfg

Stops the kernel from putting the Bluetooth chip to sleep when it's idle (USB
autosuspend). Without this, Bluetooth on this laptop can die until an ASUS EC
reset.

## The problem it prevents

The Wi-Fi/Bluetooth card is a MediaTek MT7921. Wi-Fi uses PCIe; Bluetooth is
a USB device (`13d3:3563`, bus 1 port 4).

On 2026-11-17 Bluetooth vanished mid-session while the laptop was running with
the lid closed. It wasn't suspended: `logind-lid-cfg` ignores the lid. The
Bluetooth chip stopped answering on USB:

    usb 1-4: device descriptor read/64, error -110
    usb usb1-port4: unable to enumerate USB device

After that, `hci0` was gone and `bluetoothctl show` reported "No default
controller available".

- **Likely trigger:** `btusb` lets the kernel suspend the idle chip after 2 s.
  One wake-up failed and hung the chip's Bluetooth side. This is the most
  likely cause, not a proven one.
- **Reboot and `systemctl poweroff` didn't help.** Soft-off keeps standby power
  on, so the hung state survived.
- **Side effect: slow boot.** Every boot stalled about a minute. The dead
  device ties up USB setup on bus 1, so the Corne keyboard (used for the LUKS
  passphrase) showed up late.

## What it does

- Installs `/usr/lib/modprobe.d/btusb-no-autosuspend.conf`
  (`options btusb enable_autosuspend=0`). It takes effect the next time
  `btusb` loads.
- The install hook sets `power/control=on` on devices `btusb` already drives,
  so the change is live without a reboot. Removing the package sets it back
  to `auto`.
- Cost: slightly higher idle power, because the Bluetooth chip stays awake.

Verify (the first check needs a reboot after install):

    cat /sys/module/btusb/parameters/enable_autosuspend   # N
    cat /sys/bus/usb/devices/1-4/power/control            # on

## If Bluetooth dies anyway

If it happens with this package installed, autosuspend wasn't (only) the
cause. Look at kernel/firmware regressions, or hardware.

Rebooting won't fix it. Do an ASUS EC reset
(https://www.asus.com/support/faq/1050239/):

1. Unplug peripherals and shut down.
2. Keep the charger connected.
3. Hold the power button for 40 s.
4. Boot.
