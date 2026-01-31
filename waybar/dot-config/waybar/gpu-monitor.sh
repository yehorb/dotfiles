#!/bin/bash

if omarchy-cmd-present supergfxctl; then
  mode=$(supergfxctl --get)
  status=$(supergfxctl --status)
  state="$mode:$status"
  template='{"text": "%s", "tooltip": "%s"}'
  case "$state" in
  Integrated:off) printf "$template" " " "$state" ;;
  Integrated:*) printf "$template" " " "$state" ;;
  Hybrid:active) printf "$template" " " "$state" ;;
  Hybrid:suspended) printf "$template" "💤" "$state" ;;
  *) printf "$template" "🌀" "$state" ;;
  esac
else
  printf "$template" "🤷‍♀" "supergfxctl is not available"
fi
