#!/bin/bash

# ============================================================
#  GitHub Activity Bot - auto_commit.sh
#  Appends a random line to a text file and pushes to GitHub
# ============================================================

# --- Config (edit these) ------------------------------------
REPO_DIR="$HOME/github-activity-bot"
TEXT_FILE="$REPO_DIR/activity.txt"
BRANCH="main"
# ------------------------------------------------------------

cd "$REPO_DIR" || { echo "[ERROR] Cannot cd into $REPO_DIR"; exit 1; }

# Random sentences pool
SENTENCES=(
    "The quick brown fox jumps over the lazy dog"
    "Every passing minute is a chance to turn it all around"
    "In the middle of difficulty lies opportunity"
    "The only way to do great work is to love what you do"
    "Life is what happens when you're busy making other plans"
    "Keep it simple, stupid"
    "Done is better than perfect"
    "First, solve the problem. Then, write the code"
    "Simplicity is the soul of efficiency"
    "Make it work, make it right, make it fast"
    "Talk is cheap. Show me the code"
    "Any fool can write code that a computer can understand"
    "Experience is the name everyone gives to their mistakes"
    "It works on my machine"
    "There are only two hard things in computer science"
)

# Build the random line
RANDOM_SENTENCE="${SENTENCES[$RANDOM % ${#SENTENCES[@]}]}"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
RANDOM_NUM=$((RANDOM % 9000 + 1000))
RANDOM_EMOJI=("🚀" "✨" "🔥" "💡" "⚡" "🎯" "🛠️" "📌")
EMOJI="${RANDOM_EMOJI[$RANDOM % ${#RANDOM_EMOJI[@]}]}"

LINE="[$TIMESTAMP] (#$RANDOM_NUM) $EMOJI $RANDOM_SENTENCE"

# Append to file
echo "$LINE" >> "$TEXT_FILE"
echo "[INFO] Appended: $LINE"

# Git
git add "$TEXT_FILE"
git commit -m "chore: auto update [$TIMESTAMP]"
git push origin "$BRANCH"

echo "[INFO] Pushed successfully."
