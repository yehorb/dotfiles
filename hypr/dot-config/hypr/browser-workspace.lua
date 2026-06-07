hl.workspace_rule({ workspace = "1", layout = "scrolling" })
hl.window_rule({
  match = { class = "app.zen_browser.zen" },
  workspace = "1",
})
hl.config({
  scrolling = {
    explicit_column_widths = "0.5,1.0",
  },
})
hl.bind("SUPER + SHIFT + T", hl.dsp.layout("colresize +conf"), { description = "Toggle window column width" })
