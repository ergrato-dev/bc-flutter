#!/bin/bash

################################################################################
# Cron Setup Script for Auto-Commit
#
# What?
# Configures a cron job to run auto-commit.sh every 5 minutes
#
# For?
# Automate the execution of auto-commit without manual intervention
#
# Impact?
# Enables continuous automatic version control during work hours
################################################################################

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AUTO_COMMIT_SCRIPT="$SCRIPT_DIR/auto-commit.sh"
REPO_PATH="$(cd "$SCRIPT_DIR/.." && pwd)"

print_message() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

print_message "$BLUE" "╔════════════════════════════════════════════════════════════╗"
print_message "$BLUE" "║          Cron Setup for Auto-Commit (Fedora 43)           ║"
print_message "$BLUE" "╚════════════════════════════════════════════════════════════╝"
echo ""

# Check if script exists
if [ ! -f "$AUTO_COMMIT_SCRIPT" ]; then
    print_message "$RED" "✗ Error: auto-commit.sh not found at $AUTO_COMMIT_SCRIPT"
    exit 1
fi

# Make sure script is executable
chmod +x "$AUTO_COMMIT_SCRIPT"

# Create log directory
LOG_DIR="$HOME/.local/share/bc-flutter-autocommit"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/autocommit.log"
ERROR_LOG="$LOG_DIR/autocommit-error.log"

print_message "$YELLOW" "Configuration:"
echo "  Repository: $REPO_PATH"
echo "  Script: $AUTO_COMMIT_SCRIPT"
echo "  Log: $LOG_FILE"
echo "  Error Log: $ERROR_LOG"
echo ""

# Create cron job entry
CRON_JOB="*/5 * * * * cd $REPO_PATH && $AUTO_COMMIT_SCRIPT >> $LOG_FILE 2>> $ERROR_LOG"

# Check if cron job already exists
if crontab -l 2>/dev/null | grep -q "$AUTO_COMMIT_SCRIPT"; then
    print_message "$YELLOW" "⚠ Cron job already exists. Removing old entry..."
    crontab -l 2>/dev/null | grep -v "$AUTO_COMMIT_SCRIPT" | crontab -
fi

# Add new cron job
(crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -

if [ $? -eq 0 ]; then
    print_message "$GREEN" "✓ Cron job added successfully!"
    echo ""
    print_message "$BLUE" "Cron Entry:"
    echo "  $CRON_JOB"
    echo ""
    print_message "$GREEN" "Auto-commit will run every 5 minutes"
    echo ""
    print_message "$YELLOW" "Useful commands:"
    echo "  • View cron jobs:    crontab -l"
    echo "  • Edit cron jobs:    crontab -e"
    echo "  • Remove cron job:   crontab -l | grep -v 'auto-commit.sh' | crontab -"
    echo "  • View logs:         tail -f $LOG_FILE"
    echo "  • View errors:       tail -f $ERROR_LOG"
    echo "  • Check cron status: systemctl status crond"
else
    print_message "$RED" "✗ Failed to add cron job"
    exit 1
fi
