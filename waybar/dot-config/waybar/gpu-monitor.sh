#!/bin/bash

if omarchy-cmd-present supergfxctl; then
  mode=$(supergfxctl --get)
  status=$(supergfxctl --status)
  case "$mode:$status" in
  Integrated:off) echo " " ;;
  Integrated:*) echo " " ;;
  Hybrid:active) echo " " ;;
  Hybrid:suspended) echo "💤" ;;
  *) echo "🌀" ;;
  esac
else
  echo "🤷‍♀"
fi
