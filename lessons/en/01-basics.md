# Basics of tmux

Welcome to the first lesson! Here you will learn the fundamental commands to navigate and interact with tmux.

## The Prefix Key

Every command in tmux begins with a **PREFIX**. By default, this is:
`CTRL-b`

### Essential Navigation

* To exit a tmux dialogue, display, or this tutorial: press `q` or `ESCAPE`.
* To see the last error messages (which often disappear quickly): press `PREFIX` + `~` (tilde).

## Basic Commands

Let's try some commands. Remember to press the **PREFIX** (`CTRL-b`) first, then the command key.

### Display Time
Press `PREFIX` + `t`. You should see a large clock. Press any key to dismiss it.

### List All Shortcuts
Press `PREFIX` + `?`. This shows all keys currently bound to commands. Use `q` to exit this list.

## Command Line Mode

While most common commands are mapped to keys, you can also enter commands manually.

### Enter Command Mode
Press `PREFIX` + `:`. You will see a prompt at the bottom.

### Try a Command
Type `clock-mode` and press `Enter`.
You can use **Tab completion**: type `:clo` then press `Tab`.

### Running tmux Commands from the Shell
You can also run commands from your regular shell prompt:
```bash
tmux clock-mode
```
If you are inside a tmux session, it will execute there. If not, it will target the most recently used session.

To target a specific pane:
```bash
tmux clock-mode -t play:0.1 # session 'play', window 0, pane 1
```

## Sessions

A tmux **session** can contain multiple **windows**, and each window can contain multiple **panes**.

This tutorial is running in a session named `demo` (visible in the status bar at the bottom).

### Detaching and Reattaching
* **Detach** from the current session: `PREFIX` + `d`. You will return to your normal shell.
* **Reattach** to the session:
  ```bash
  tmux attach -t demo
  ```
* **List all sessions**:
  ```bash
  tmux ls
  ```

Try detaching now and reattaching to see how it works!
