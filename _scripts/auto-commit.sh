#!/bin/bash

################################################################################
# Auto-Commit Script with Conventional Commits
#
# What?
# Automatically stages and commits changes every 5 minutes using conventional
# commit format with AI-generated semantic messages in English.
#
# For?
# - Maintain continuous version history during development sessions
# - Ensure work is never lost due to unexpected issues
# - Create meaningful commit history automatically
# - Follow conventional commits specification
#
# Impact?
# - Reduces risk of losing work
# - Maintains clean, semantic commit history
# - Enables easy rollback to any auto-saved state
# - Supports automated changelog generation
################################################################################

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
INTERVAL=300  # 5 minutes in seconds
REPO_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Conventional commit types
# feat: A new feature
# fix: A bug fix
# docs: Documentation only changes
# style: Changes that do not affect the meaning of the code
# refactor: A code change that neither fixes a bug nor adds a feature
# perf: A code change that improves performance
# test: Adding missing tests or correcting existing tests
# chore: Changes to the build process or auxiliary tools

################################################################################
# Function: Print colored message
################################################################################
print_message() {
    local color=$1
    local message=$2
    echo -e "${color}[$(date '+%Y-%m-%d %H:%M:%S')]${NC} ${message}"
}

################################################################################
# Function: Detect commit type based on changed files
#
# What?
# Analyzes the staged files to determine the appropriate conventional commit type
#
# For?
# Automatically categorize commits based on the nature of changes
#
# Impact?
# Creates semantically correct commit messages without manual intervention
################################################################################
detect_commit_type() {
    local files="$1"
    
    # Check for documentation changes
    if echo "$files" | grep -qE '\.md$|^_docs/'; then
        echo "docs"
        return
    fi
    
    # Check for test files
    if echo "$files" | grep -qE '_test\.dart$|test/'; then
        echo "test"
        return
    fi
    
    # Check for script changes
    if echo "$files" | grep -qE '\.sh$|^_scripts/'; then
        echo "chore"
        return
    fi
    
    # Check for asset changes
    if echo "$files" | grep -qE '^_assets/|\.svg$|\.png$|\.jpg$'; then
        echo "style"
        return
    fi
    
    # Check for configuration files
    if echo "$files" | grep -qE '\.yaml$|\.json$|\.gitignore$'; then
        echo "chore"
        return
    fi
    
    # Check for Dart/Flutter code
    if echo "$files" | grep -qE '\.dart$'; then
        # Default to feat for code changes (could be enhanced with content analysis)
        echo "feat"
        return
    fi
    
    # Default
    echo "chore"
}

################################################################################
# Function: Generate commit scope based on changed files
#
# What?
# Extracts a meaningful scope from the changed files path
#
# For?
# Provide context about which part of the project was modified
#
# Impact?
# Makes commit history more navigable and understandable
################################################################################
generate_scope() {
    local files="$1"
    
    # Check for week-specific changes
    if echo "$files" | grep -qE 'semana-[0-9]+'; then
        local week=$(echo "$files" | grep -oE 'semana-[0-9]+' | head -1)
        echo "$week"
        return
    fi
    
    # Check for specific folders
    if echo "$files" | grep -q '^_docs/'; then
        echo "docs"
        return
    fi
    
    if echo "$files" | grep -q '^_assets/'; then
        echo "assets"
        return
    fi
    
    if echo "$files" | grep -q '^_scripts/'; then
        echo "scripts"
        return
    fi
    
    if echo "$files" | grep -q '^\.github/'; then
        echo "ci"
        return
    fi
    
    # Check for root files
    if echo "$files" | grep -qE '^(README|LICENSE|\.gitignore)'; then
        echo "root"
        return
    fi
    
    # Default
    echo "general"
}

################################################################################
# Function: Generate commit description
#
# What?
# Creates a concise description of what changed
#
# For?
# Provide human-readable summary of the commit
#
# Impact?
# Makes git log readable and useful for understanding project evolution
################################################################################
generate_description() {
    local type="$1"
    local scope="$2"
    local files="$3"
    local file_count=$(echo "$files" | wc -l)
    
    case "$type" in
        docs)
            if [ $file_count -eq 1 ]; then
                echo "update documentation content"
            else
                echo "update multiple documentation files"
            fi
            ;;
        feat)
            echo "add new features and implementations"
            ;;
        fix)
            echo "resolve issues and bugs"
            ;;
        style)
            echo "update styling and visual assets"
            ;;
        refactor)
            echo "improve code structure"
            ;;
        test)
            echo "add or update tests"
            ;;
        chore)
            if echo "$files" | grep -q '\.sh$'; then
                echo "update automation scripts"
            elif echo "$files" | grep -qE '\.(yaml|json)$'; then
                echo "update configuration files"
            else
                echo "update project maintenance files"
            fi
            ;;
        *)
            echo "make general updates"
            ;;
    esac
}

################################################################################
# Function: Create commit message
#
# What?
# Assembles a complete conventional commit message with body
#
# For?
# Generate standardized, informative commit messages
#
# Impact?
# Ensures all commits follow the same format and include necessary context
################################################################################
create_commit_message() {
    local files="$1"
    
    local type=$(detect_commit_type "$files")
    local scope=$(generate_scope "$files")
    local description=$(generate_description "$type" "$scope" "$files")
    local file_count=$(echo "$files" | wc -l)
    
    # Create commit message
    local message="${type}(${scope}): ${description}"
    
    # Add body with additional context
    local body=""
    body="${body}What?\n"
    body="${body}${description^} in ${scope} section\n\n"
    body="${body}For?\n"
    body="${body}Maintain continuous development progress\n\n"
    body="${body}Impact?\n"
    body="${body}${file_count} file(s) modified - Auto-committed at $(date '+%H:%M:%S')"
    
    echo -e "${message}\n\n${body}"
}

################################################################################
# Function: Perform auto-commit
#
# What?
# Checks for changes and creates a commit if any exist
#
# For?
# Execute the main auto-commit workflow
#
# Impact?
# Preserves work automatically without manual intervention
################################################################################
perform_commit() {
    cd "$REPO_PATH" || exit 1
    
    # Check if there are any changes
    if [[ -z $(git status --porcelain) ]]; then
        print_message "$BLUE" "No changes detected. Skipping commit."
        return
    fi
    
    # Get list of changed files
    local changed_files=$(git status --porcelain | awk '{print $2}')
    
    print_message "$YELLOW" "Changes detected in $(echo "$changed_files" | wc -l) file(s)"
    
    # Stage all changes
    git add -A
    
    # Generate commit message
    local commit_msg=$(create_commit_message "$changed_files")
    
    # Commit changes
    if git commit -m "$commit_msg"; then
        print_message "$GREEN" "✓ Auto-commit successful"
        print_message "$GREEN" "  Type: $(echo "$commit_msg" | head -1)"
    else
        print_message "$RED" "✗ Auto-commit failed"
        return 1
    fi
}

################################################################################
# Function: Main loop
#
# What?
# Runs the auto-commit process continuously at specified intervals
#
# For?
# Provide automated, periodic version control
#
# Impact?
# Creates a safety net for development work
################################################################################
main() {
    print_message "$GREEN" "╔════════════════════════════════════════════════════════════╗"
    print_message "$GREEN" "║         Auto-Commit Script - Conventional Commits          ║"
    print_message "$GREEN" "╚════════════════════════════════════════════════════════════╝"
    print_message "$BLUE" ""
    print_message "$BLUE" "Repository: $REPO_PATH"
    print_message "$BLUE" "Interval: Every 5 minutes"
    print_message "$BLUE" "Commit Format: Conventional Commits (English)"
    print_message "$BLUE" ""
    print_message "$YELLOW" "Press Ctrl+C to stop"
    print_message "$BLUE" "────────────────────────────────────────────────────────────"
    echo ""
    
    # Initial check
    perform_commit
    
    # Main loop
    while true; do
        sleep $INTERVAL
        perform_commit
    done
}

################################################################################
# Script execution
################################################################################

# Check if git repository
if [ ! -d "$REPO_PATH/.git" ]; then
    print_message "$RED" "Error: Not a git repository"
    exit 1
fi

# Run main function
main
