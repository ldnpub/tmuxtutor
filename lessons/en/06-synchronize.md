# Synchronizing Panes

Synchronizing panes allows you to type the same command in all panes of a window simultaneously. This is incredibly useful for managing multiple servers or comparing different environment versions.

## How to Try Synchronization

To practice this while still reading these instructions, you should open a new window:
1. Create a new window: `PREFIX` + `c`
2. Split it into 4 panes (use `PREFIX` + `%` and `PREFIX` + `"`)
3. In each pane, set a different variable name:
   ```bash
   NAME=server1 # in pane 1
   NAME=server2 # in pane 2
   # ... and so on
   ```

### Activating Synchronization
Now, turn on synchronization:
`PREFIX` + `:set synchronize-panes on`

### Test it out
Type a command; it will appear in all panes at once:
```bash
echo "Hello from $NAME!"
```

### Deactivating
To stop synchronizing:
`PREFIX` + `:set synchronize-panes off`

**Tip**: You can toggle this option by omitting `on` or `off`: `PREFIX` + `:set synchronize-panes`. If you use this often, you might want to bind it to a key in your `~/.tmux.conf`.

## Scripting tmux

Synchronization is a perfect candidate for tmux scripting.

Check out the script in `examples/06a.synchronize-perlbrew.sh`. It uses `perlbrew` to compare four different Perl versions. You could adapt this for `pyenv`, `rbenv`, `nvm`, or any other tool!
