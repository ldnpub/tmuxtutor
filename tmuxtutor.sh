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

# Wait for ENTER or Down Arrow
wait_for_next() {
    while true; do
        # -s: silent, -n 1: one character, -t 1: timeout 1s to allow loop validation
        read -rsn1 -t 1 key
        if [ $? -eq 0 ]; then
            if [[ "$key" == "" ]]; then return 0; fi # ENTER
            if [[ "$key" == $'\x1b' ]]; then # Escape sequence
                read -rsn2 -t 0.1 key
                if [[ "$key" == "[B" ]]; then return 0; fi # Down Arrow
            fi
        fi
        # If a validator is passed, check it
        if [ ! -z "$1" ] && [ "$1" != "none" ]; then
            if $1; then return 1; fi # Goal reached automatically
        fi
    done
}

# Find the best tool to display Markdown
...
run_tutorial() {
    for entry in "${LESSONS[@]}"; do
        IFS=':' read -r filename validator <<< "$entry"
        
        show_lesson "$filename"
        
        if [ "$validator" != "none" ]; then
            if [ "$USER_LANG" == "fr" ]; then
                echo -e "\n\033[1;34m🎯 OBJECTIF :\033[0m Suivez les instructions à droite."
                echo -e "Réussissez l'action OU appuyez sur \033[1;33mENTRÉE/↓\033[0m pour passer.\n"
            else
                echo -e "\n\033[1;34m🎯 GOAL:\033[0m Follow the instructions on the right."
                echo -e "Complete the action OR press \033[1;33mENTER/↓\033[0m to skip.\n"
            fi

            # Wait for validation OR manual skip
            wait_for_next "$validator"
            res=$?
            
            # Brief success message if validated automatically
            if [ $res -eq 1 ]; then
                if [ "$USER_LANG" == "fr" ]; then
                    echo -e "\033[1;32m✅ Objectif atteint !\033[0m"
                else
                    echo -e "\033[1;32m✅ Goal reached!\033[0m"
                fi
                sleep 2
            fi
        else
            # Manual skip for info-only lessons
            if [ "$USER_LANG" == "fr" ]; then
                echo -e "\n\033[1;33m--- Appuyez sur ENTRÉE ou ↓ pour continuer ---\033[0m"
            else
                echo -e "\n\033[1;33m--- Press ENTER or ↓ to continue ---\033[0m"
            fi
            wait_for_next "none"
        fi
    done
    
    clear
    if [ "$USER_LANG" == "fr" ]; then
        echo "🎉 Félicitations ! Vous avez terminé tmuxtutor."
        echo "Vous pouvez quitter avec : Ctrl-b d"
    else
        echo "🎉 Congratulations! You have finished tmuxtutor."
        echo "You can exit with: Ctrl-b d"
    fi
    # Keep the pane open
    read -r
}

# --- Execution ---

if [ "$1" == "--internal-loop" ]; then
    USER_LANG=$2
    run_tutorial
    exit 0
fi

if [ -z "$TMUX" ]; then
    # Cleanup previous session if it exists
    tmux kill-session -t "$SESSION_NAME" 2>/dev/null
    
    echo "Starting tmuxtutor session..."
    
    # Start tmux with no user config to ensure consistent tutorial experience
    tmux -f /dev/null new-session -d -s "$SESSION_NAME" -n "Tutorial"
    # Enable mouse mode for easier navigation
    tmux -f /dev/null set-option -t "$SESSION_NAME" mouse on
    
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
    
    # Launch the tutorial loop directly in the first pane
    tmux -f /dev/null send-keys -t "$SESSION_NAME:0.0" "./tmuxtutor.sh --internal-loop $USER_LANG" C-m
    
    tmux -f /dev/null select-pane -t "$SESSION_NAME:0.0"
    tmux -f /dev/null attach-session -t "$SESSION_NAME"
else
    echo "Please run tmuxtutor.sh from a regular terminal (outside tmux)."
    exit 1
fi
