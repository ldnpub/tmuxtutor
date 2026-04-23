# Customizing the Prefix Key

You don't have to stick with the default `CTRL-b`. Many users prefer other combinations like `CTRL-a` (classic screen style) or `CTRL-space`.

## Why Change It?

* **Ergonomics**: Some keys are easier to reach than others.
* **Pair Programming**: If you're working with others, make sure everyone is comfortable with the chosen prefix.

## How to Change It

You can change the prefix in your `~/.tmux.conf` file. Here is an example of changing it to `CTRL-a`:

```tmux
# Change the default prefix key to CTRL-a
unbind-key C-b
set -g prefix C-a

# Allow sending a literal CTRL-a by pressing CTRL-a twice
# (Useful for going to the start of a line in the shell)
bind-key a send-prefix

# Alternatively, you can use CTRL-a CTRL-a:
# bind-key C-a send-prefix
```

After editing your configuration, you'll need to restart tmux or source the file for changes to take effect:
```bash
tmux source-file ~/.tmux.conf
```
