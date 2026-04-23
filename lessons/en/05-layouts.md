# Pane Layouts

Instead of manually resizing panes, you can use built-in layouts to quickly organize your window.

## Experimenting with Layouts

To see these in action, let's create three panes:
1. Open a new vertical pane: `PREFIX` + `%`
2. Split that new pane horizontally: `PREFIX` + `"`

Now, try the five main tmux layouts:

* **Even Horizontal**: `PREFIX` + `Meta` + `1`
  (All panes side-by-side, equal width)
* **Even Vertical**: `PREFIX` + `Meta` + `2`
  (All panes stacked vertically, equal height)
* **Main Horizontal**: `PREFIX` + `Meta` + `3`
  (One large pane on top, others split below)
* **Main Vertical**: `PREFIX` + `Meta` + `4`
  (One large pane on the left, others split on the right)
* **Tiled**: `PREFIX` + `Meta` + `5`
  (Panes arranged in a grid)

### Cycle Layouts
You can also cycle through all available layouts by pressing:
`PREFIX` + `Space`

Try adding more panes and cycling through the layouts to see how tmux handles them!
