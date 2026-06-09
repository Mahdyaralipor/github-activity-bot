#!/bin/bash

# ============================================================
#  GitHub Activity Bot - setup.sh
#  Interactive setup: configures auto_commit.sh + cron job
# ============================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AUTO_COMMIT="$SCRIPT_DIR/auto_commit.sh"
CRON_LOG="/tmp/github_activity_bot.log"

echo ""
echo "========================================"
echo "   GitHub Activity Bot - Setup"
echo "========================================"
echo ""

# --- Step 1: Check git
if ! command -v git &>/dev/null; then
    echo "[ERROR] git is not installed. Run: sudo apt install git"
    exit 1
fi
echo "[✓] git is installed"

# --- Step 2: Check SSH or ask for token
echo ""
echo "[?] How do you authenticate with GitHub?"
echo "    1) SSH key (recommended)"
echo "    2) Personal Access Token (HTTPS)"
read -rp "    Choice [1/2]: " AUTH_CHOICE

if [[ "$AUTH_CHOICE" == "2" ]]; then
    read -rp "    GitHub username: " GH_USER
    read -rsp "    Personal Access Token: " GH_TOKEN
    echo ""
    REMOTE_URL="https://${GH_USER}:${GH_TOKEN}@github.com/${GH_USER}/$(basename "$SCRIPT_DIR").git"
    git -C "$SCRIPT_DIR" remote set-url origin "$REMOTE_URL"
    echo "[✓] Remote URL updated with token"
else
    echo "[i] Make sure your SSH key is added to GitHub."
    echo "    If not, run: ssh-keygen -t ed25519 -C 'your@email.com'"
    echo "    Then add ~/.ssh/id_ed25519.pub to GitHub → Settings → SSH keys"
fi

# --- Step 3: Set repo path in auto_commit.sh
sed -i "s|REPO_DIR=.*|REPO_DIR=\"$SCRIPT_DIR\"|" "$AUTO_COMMIT"
echo "[✓] REPO_DIR set to: $SCRIPT_DIR"

# --- Step 4: Make executable
chmod +x "$AUTO_COMMIT"
echo "[✓] auto_commit.sh is now executable"

# --- Step 5: Ask for cron interval
echo ""
echo "[?] How often should it commit?"
echo "    1) Every hour"
echo "    2) Every 2 hours"
echo "    3) Every 6 hours"
echo "    4) Custom (you enter the cron expression)"
read -rp "    Choice [1-4]: " INTERVAL_CHOICE

case "$INTERVAL_CHOICE" in
    1) CRON_EXPR="0 * * * *" ;;
    2) CRON_EXPR="0 */2 * * *" ;;
    3) CRON_EXPR="0 */6 * * *" ;;
    4)
        read -rp "    Enter cron expression: " CRON_EXPR
        ;;
    *) CRON_EXPR="0 * * * *" ;;
esac

# --- Step 6: Install cron job
CRON_JOB="$CRON_EXPR $AUTO_COMMIT >> $CRON_LOG 2>&1"

# Remove old entry if exists
(crontab -l 2>/dev/null | grep -v "auto_commit.sh") | crontab -

# Add new entry
(crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -

echo "[✓] Cron job installed: $CRON_JOB"

# --- Done
echo ""
echo "========================================"
echo "   Setup complete!"
echo "========================================"
echo ""
echo "   Cron schedule : $CRON_EXPR"
echo "   Log file      : $CRON_LOG"
echo "   Script        : $AUTO_COMMIT"
echo ""
echo "   To test manually:"
echo "   bash $AUTO_COMMIT"
echo ""
echo "   To view cron jobs:"
echo "   crontab -l"
echo ""
echo "   To remove the cron job:"
echo "   crontab -e"
echo ""
