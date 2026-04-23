#!/usr/bin/env bash

# tmuxtutor.sh - Modern & Interactive tmux tutorial
# Forked from perlpunk/tmuxtutor

# --- Configuration ---
SESSION_NAME="tmuxtutor"
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LESSONS_DIR="$BASE_DIR/lessons"

# --- Language Detection ---
if [[ "$LANG" == fr* ]]; then
    DEFAULT_LANG="fr"
else
    DEFAULT_LANG="en"
fi
USER_LANG=${1:-$DEFAULT_LANG}

# Check if language directory exists, fallback to English
if [ ! -d "$LESSONS_DIR/$USER_LANG" ]; then
    USER_LANG="en"
fi

# --- Lessons Definition ---
# format: "filename:validation_function"
LESSONS=(
    "00-intro.md:none"
    "01-basics.md:check_clock"
    "02-prefix.md:none"
    "03-windows.md:check_window"
    "04-panes.md:check_panes"
    "05-layouts.md:none"
    "06-synchronize.md:none"
)

# --- Validation Functions ---

check_clock() {
    # Check if any pane is in clock-mode
    tmux -f /dev/null list-panes -s -t "$SESSION_NAME" -F "#{pane_in_mode} #{pane_mode}" | grep -q "1 clock-mode"
}

check_window() {
    # Check if there's more than 1 window
    local win_count=$(tmux -f /dev/null list-windows -t "$SESSION_NAME" | wc -l)
    [ "$win_count" -gt 1 ]
}

check_panes() {
    # Check if there's more than 1 pane in the first window
    local pane_count=$(tmux -f /dev/null list-panes -t "$SESSION_NAME:0" 2>/dev/null | wc -l)
    # We started with 2 panes (instruction + practice). 
    # So if we have > 2, it means the user created a split.
    [ "$pane_count" -gt 2 ]
}

# --- Helper Functions ---

# Find the best tool to display Markdown
get_display_cmd() {
    if command -v batcat >/dev/null 2>&1; then
        echo "batcat --style=plain --paging=never"
    elif command -v bat >/dev/null 2>&1; then
        echo "bat --style=plain --paging=never"
    else
        echo "cat"
    fi
}

DISPLAY_CMD=$(get_display_cmd)

show_lesson() {
    local lesson_file="$LESSONS_DIR/$USER_LANG/$1"
    if [ -f "$lesson_file" ]; then
        tmux -f /dev/null send-keys -t "$SESSION_NAME:0.0" "clear" C-m
        tmux -f /dev/null send-keys -t "$SESSION_NAME:0.0" "$DISPLAY_CMD '$lesson_file'" C-m
        if [ "$USER_LANG" == "fr" ]; then
            tmux -f /dev/null send-keys -t "$SESSION_NAME:0.0" "echo -e '\n\n--- Appuyez sur ENTRÉE dans ce pane pour passer à la suite ---'" C-m
        else
            tmux -f /dev/null send-keys -t "$SESSION_NAME:0.0" "echo -e '\n\n--- Press ENTER in this pane to continue ---'" C-m
        fi
    fi
}

# --- Main Tutorial Loop ---

run_tutorial() {
    for entry in "${LESSONS[@]}"; do
        IFS=':' read -r filename validator <<< "$entry"
        
        show_lesson "$filename"
        
        if [ "$validator" != "none" ]; then
            # Wait for validation
            while ! $validator; do
                sleep 1
            done
            
            # Brief success message
            tmux -f /dev/null send-keys -t "$SESSION_NAME:0.0" "clear" C-m
            if [ "$USER_LANG" == "fr" ]; then
                tmux -f /dev/null send-keys -t "$SESSION_NAME:0.0" "echo '✅ Objectif atteint ! Passage à la leçon suivante...'" C-m
            else
                tmux -f /dev/null send-keys -t "$SESSION_NAME:0.0" "echo '✅ Goal reached! Moving to next lesson...'" C-m
            fi
            sleep 2
        else
            # Manual skip for info-only lessons
            # We wait for the user to press Enter in the instruction pane
            # This is tricky without a dedicated TUI, so we'll just wait a bit or use a prompt
            # Instead of a complex read, we'll just wait for the user to type something in pane 0.0
            # or simply wait for a fixed time for info slides.
            sleep 10
        fi
    done
    
    tmux -f /dev/null send-keys -t "$SESSION_NAME:0.0" "clear" C-m
    if [ "$USER_LANG" == "fr" ]; then
        tmux -f /dev/null send-keys -t "$SESSION_NAME:0.0" "echo 'Félicitations ! Vous avez terminé tmuxtutor.'" C-m
    else
        tmux -f /dev/null send-keys -t "$SESSION_NAME:0.0" "echo 'Congratulations! You have finished tmuxtutor.'" C-m
    fi
}

# --- Execution ---

if [ -z "$TMUX" ]; then
    # Cleanup previous session if it exists
    tmux kill-session -t "$SESSION_NAME" 2>/dev/null
    
    echo "Starting tmuxtutor session..."
    
    # Start tmux with no user config to ensure consistent tutorial experience
    tmux -f /dev/null new-session -d -s "$SESSION_NAME" -n "Tutorial"
    
    # Wait for the session to be truly available
    max_retries=5
    count=0
    while ! tmux has-session -t "$SESSION_NAME" 2>/dev/null; do
        sleep 0.5
        ((count++))
        if [ $count -ge $max_retries ]; then
            echo "Error: Could not start tmux session."
            exit 1
        fi
    done

    # Split horizontally (left/right). Instructions on the left (30%)
    tmux -f /dev/null split-window -h -p 70 -t "$SESSION_NAME"
    # Note: split-window -h -p 70 means the NEW pane (right) will take 70%
    # So the original pane (left) keeps 30%.
    
    tmux -f /dev/null select-pane -t "$SESSION_NAME:0.0"
    
    # Run the logic in a background subshell
    (
        sleep 1 # Let the split finish
        run_tutorial
    ) &
    
    tmux -f /dev/null attach-session -t "$SESSION_NAME"
else
    echo "Please run tmuxtutor.sh from a regular terminal (outside tmux)."
    exit 1
fi
