hl.config({
  scrolling = {
    explicit_column_widths = "0.5, 1.0",
    follow_min_visible = 0.1,
  },
})
hl.bind("SUPER + SHIFT + T", hl.dsp.layout("colresize +conf"), { description = "Toggle window column width" })
