# Working with Windows

Windows in tmux are like tabs in a web browser. You can have many of them within a single session.

## Creating and Switching Windows

* **Current Window**: You are likely in window 0.
* **Create a New Window**: Press `PREFIX` + `c`.
* **Switch by Number**: Press `PREFIX` + `number` (e.g., `0`, `1`, etc.).
* **Switch Interactively**: Press `PREFIX` + `w` to choose from a list.
* **Prompt for Number**: Press `PREFIX` + `'` (single quote) to enter a specific window index.
* **Last Window**: Press `PREFIX` + `l` to jump to the last active window.
* **Next/Previous**: Press `PREFIX` + `n` (next) or `PREFIX` + `p` (previous).

## Managing Windows

### Reordering Windows
To move a window to a new index:
Press `PREFIX` + `.` (dot), then enter the new position. The target index must be free.

### Swapping Windows
To swap the current window with another:
* `PREFIX` + `:swap-window -t -1` (move left)
* `PREFIX` + `:swap-window -t +1` (move right)

### Naming Windows
Give your windows meaningful titles to stay organized:
Press `PREFIX` + `,` (comma) and type the name.

**Tip**: If you don't name a window, tmux automatically names it after the running process (e.g., `bash`, `vim`, `sleep`).

## Monitoring Activity

You can let tmux notify you when something happens in another window.
1. Go to another window and run: `sleep 10`
2. Enable monitoring: `PREFIX` + `:set -g monitor-activity on`
3. Switch back to this window.
4. When `sleep` finishes, you'll see a highlight in the status bar!

## Closing Windows

* **Exit Shell**: Type `exit` or press `CTRL-d`.
* **Kill Command**: Press `PREFIX` + `&` (requires confirmation).
