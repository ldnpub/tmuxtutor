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
    tmux list-panes -s -t "$SESSION_NAME" -F "#{pane_in_mode} #{pane_mode}" | grep -q "1 clock-mode"
}

check_window() {
    # Check if there's more than 1 window
    local win_count=$(tmux list-windows -t "$SESSION_NAME" | wc -l)
    [ "$win_count" -gt 1 ]
}

check_panes() {
    # Check if there's more than 2 panes in the practice window
    local pane_count=$(tmux list-panes -t "$SESSION_NAME:0.1" 2>/dev/null | wc -l)
    [ "$pane_count" -gt 1 ]
}

# --- Helper Functions ---

show_lesson() {
    local lesson_file="$LESSONS_DIR/$USER_LANG/$1"
    if [ -f "$lesson_file" ]; then
        tmux send-keys -t "$SESSION_NAME:0.0" "clear" C-m
        # We use 'cat' for simple display, but 'less' or a md viewer would be better
        tmux send-keys -t "$SESSION_NAME:0.0" "cat '$lesson_file'" C-m
        if [ "$USER_LANG" == "fr" ]; then
            tmux send-keys -t "$SESSION_NAME:0.0" "echo -e '\n\n--- Appuyez sur ENTRÉE dans ce pane pour passer à la suite ---'" C-m
        else
            tmux send-keys -t "$SESSION_NAME:0.0" "echo -e '\n\n--- Press ENTER in this pane to continue ---'" C-m
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
            tmux send-keys -t "$SESSION_NAME:0.0" "clear" C-m
            if [ "$USER_LANG" == "fr" ]; then
                tmux send-keys -t "$SESSION_NAME:0.0" "echo '✅ Objectif atteint ! Passage à la leçon suivante...'" C-m
            else
                tmux send-keys -t "$SESSION_NAME:0.0" "echo '✅ Goal reached! Moving to next lesson...'" C-m
            fi
            sleep 2
        else
            # Manual skip for info-only lessons
            # We wait for the user to press Enter in the instruction pane
            # This is tricky without a dedicated TUI, so we'll just wait a bit or use a prompt
            read -p "" # This won't work easily across panes, so we'll use a simpler approach
            sleep 5
        fi
    done
    
    tmux send-keys -t "$SESSION_NAME:0.0" "clear" C-m
    if [ "$USER_LANG" == "fr" ]; then
        tmux send-keys -t "$SESSION_NAME:0.0" "echo 'Félicitations ! Vous avez terminé tmuxtutor.'" C-m
    else
        tmux send-keys -t "$SESSION_NAME:0.0" "echo 'Congratulations! You have finished tmuxtutor.'" C-m
    fi
}

# --- Execution ---

if [ -z "$TMUX" ]; then
    tmux new-session -d -s "$SESSION_NAME" -n "Tutorial"
    tmux split-window -v -p 40 -t "$SESSION_NAME" # 40% for instructions
    
    # Run the logic in a background subshell that will interact with the session
    (
        run_tutorial
    ) &
    
    tmux attach-session -t "$SESSION_NAME"
else
    echo "Please run tmuxtutor.sh from a regular terminal (outside tmux)."
    exit 1
fi
