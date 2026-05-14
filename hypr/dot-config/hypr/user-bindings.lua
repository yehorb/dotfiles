-- Trivia:
--   `bindd` is actually `bind[d]` - `bind` command with `d` flag.
--   `d` flag will allow you to write a description for your bind.

hl.unbind("SUPER + SHIFT + B")
hl.bind(
  "SUPER + SHIFT + B",
  hl.dsp.exec_cmd("setsid uwsm-app -- flatpak run app.zen_browser.zen"),
  { description = "Browser" }
)
hl.unbind("SUPER + SHIFT + ALT + B")
hl.bind(
  "SUPER + SHIFT + ALT + B",
  hl.dsp.exec_cmd("setsid uwsm-app -- flatpak run app.zen_browser.zen --private-window"),
  { description = "Browser (private)" }
)

-- Swaps the two halves of the split - both horizontal and *vertical*
-- To swap left-to-right focus the "bigger" window first
hl.bind("SUPER + SHIFT + J", hl.dsp.layout("swapsplit"), { description = "Swap split" })

-- Open terminal in a floating window
-- `--app-id=org.omarchy.terminal` is automagically tagged as `tag +floating-window` in `$OMARCHY_PATH/default/hypr/apps/system.conf`
-- The same file governs appearance of floating windows.
-- My initial approach was to use "Executing with rules" approach, however reuseing exisiting Omarchy machinery looks cleaner
--   ..., exec, [float; rules...] uwsm-app -- xdg-terminal-exec ...
hl.unbind("SUPER + SHIFT + RETURN")
hl.bind(
  "SUPER + SHIFT + RETURN",
  hl.dsp.exec_cmd('uwsm-app -- xdg-terminal-exec --app-id=org.omarchy.terminal --dir="$(omarchy-cmd-terminal-cwd)"'),
  { description = "Terminal (floating)" }
)
-- Always open Tmux
hl.unbind("SUPER + RETURN")
hl.bind(
  "SUPER + RETURN",
  hl.dsp.exec_cmd(
    'uwsm-app -- xdg-terminal-exec --dir="$(omarchy-cmd-terminal-cwd)" tmux new-session \\; set detach-on-destroy on'
  ),
  { description = "Tmux" }
)
-- Except when you don't want Tmux
hl.unbind("SUPER + ALT + RETURN")
hl.bind(
  "SUPER + ALT + RETURN",
  hl.dsp.exec_cmd('uwsm-app -- xdg-terminal-exec --dir="$(omarchy-cmd-terminal-cwd)"'),
  { description = "Terminal" }
)
-- Horizontal mouse scroll wheel to move focus
-- Inverted to make sense "physically", as it is somewhat inverted by default
-- Scrolling "clockwise" is "mouse_right"
-- Scrolling "ccw" is "mouse_left"
hl.bind("mouse_right", hl.dsp.focus({ direction = "left" }), { description = "Move window focus left" })
hl.bind("mouse_left", hl.dsp.focus({ direction = "right" }), { description = "Move window focus right" })
-- Captures
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("omarchy capture screenshot"), { description = "Screenshot" })
