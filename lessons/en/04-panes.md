# Working with Panes

Panes allow you to split a single window into multiple sections. This is perfect for viewing log files, running tests, or managing git while you code.

## Splitting the Window

* **Vertical Split**: Press `PREFIX` + `%`
* **Horizontal Split**: Press `PREFIX` + `"` (double quote)

Try splitting your window now. The new pane will be automatically focused.

## Navigating Between Panes

* **Arrow Keys**: Press `PREFIX` + `Arrow Key` (Left, Right, Up, Down).
* **Last Pane**: Press `PREFIX` + `;` (semicolon) to jump back and forth between two panes.
* **Cycle Panes**: Press `PREFIX` + `o` to go to the next pane.
* **Identify Panes**: Press `PREFIX` + `q`. Numbers will appear briefly on each pane. Type the number to jump to that pane.

## Organizing Panes

### Moving Panes
* **Swap with Previous**: `PREFIX` + `{`
* **Swap with Next**: `PREFIX` + `}`

### Zooming
If you need more space temporarily:
* **Zoom In/Out**: `PREFIX` + `z`. This expands the current pane to fill the whole window. Press it again to return to the split view.

### Resizing
You can fine-tune the size of your panes:
* **Resize by 5 cells**: `PREFIX` + `Meta` + `Arrow Key`
* **Resize by 1 cell**: `PREFIX` + `Ctrl` + `Arrow Key`

## Closing Panes

* **Exit Shell**: Type `exit` or press `CTRL-d`.
* **Kill Pane**: Press `PREFIX` + `x` (requires confirmation).
