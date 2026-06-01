#!/bin/bash

BROWSER_CLASS="app.zen_browser.zen"

ncat -U "$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do
  if [[ "$line" == openwindow\>\>*"$BROWSER_CLASS"* ]]; then
    # Extract the window address from the event
    addr="${line#openwindow>>}" # Prefix stripping
    addr="${addr%%,*}"          # Longest suffix stripping (%% is longest, % is shortest) - removes everything after the first comma

    # Focus the newly opened browser window, then resize its column
    hyprctl eval "hl.dsp.focus({ window = 'address:0x${addr}' }); hl.dsp.layoutmsg('colresize 1.0')"
  fi
done
