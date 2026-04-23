# Welcome to tmuxtutor!

This tutorial will guide you through the basics of **tmux**, a powerful terminal multiplexer.

## Requirements

* **tmux** installed on your system.
* Basic knowledge of navigating a `man` page or `less` command.
* Knowledge of what the **Meta** (or **Alt**) key is.

## Interactive Experience

This tutorial is designed for a **split-screen interactive experience**. You are likely reading this in one pane while performing actions in another.

The HTML version is also available at: [https://perlpunk.github.io/tmuxtutor/](https://perlpunk.github.io/tmuxtutor/)

Most lessons are started with a command like:

```bash
tmux new-session -s demo "man man/01.basics.man"
```

This starts a new tmux session called `demo` and runs the `man` command. If you exit `man` with `q`, the tmux window (and session, if it's the only window) will close.

### Practice Session

If you want to experiment freely, start your own named session:

```bash
tmux new-session -s play
```

## Configuration

This tutorial assumes a default `~/.tmux.conf`. If you have already customized your configuration, some behaviors or visuals might differ.

## Ready to Start?

Exit this introduction by pressing `q`, then proceed to the next lesson:

```bash
./01.basics.sh
```
