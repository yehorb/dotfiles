hl.config({
  scrolling = {
    explicit_column_widths = "0.49, 0.99",
    follow_min_visible = 0.0,
  },
})
hl.workspace_rule({ workspace = "1", layout = "scrolling" })

hl.window_rule({
  match = { class = "app.zen_browser.zen" },
  workspace = "1",
  scrolling_width = 0.99,
})

hl.bind("SUPER + SHIFT + T", hl.dsp.layout("colresize +conf"), { description = "Toggle window column width" })
