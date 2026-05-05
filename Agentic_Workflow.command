#!/bin/bash
cd "$(dirname "$0")"

while true; do
    clear
    echo "=========================================================="
    echo "          Agentic Coding Workflow & Update Tool           "
    echo "=========================================================="
    echo "1. Start Agentic Coding (Auto-Routing based on API Tokens)"
    echo "2. Review & Push Updates (View changes and push to GitHub)"
    echo "3. Exit"
    echo "=========================================================="
    read -p "Choose an option (1-3): " option

    if [ "$option" == "1" ]; then
        echo ""
        echo "=========================================================="
        echo "           Smart Platform Routing Engine                  "
        echo "=========================================================="
        echo "Checking API Token Availability..."
        sleep 1
        
        # This is where the actual token-checking logic would hook into your APIs
        # For demonstration, we assume Codex has tokens available.
        # You can toggle these variables to test the fallback rules.
        CODEX_TOKENS=true
        ANTIGRAVITY_TOKENS=true
        
        if [ "$CODEX_TOKENS" = true ]; then
            echo "[✓] Codex tokens available."
            echo "-> Prioritizing Codex."
            PLATFORM="Codex"
        elif [ "$ANTIGRAVITY_TOKENS" = true ]; then
            echo "[X] Codex tokens depleted."
            echo "[✓] Antigravity tokens available."
            echo "-> Switching to Antigravity."
            PLATFORM="Antigravity"
        else
            echo "[X] Codex tokens depleted."
            echo "[X] Antigravity tokens depleted."
            echo "-> Fallback rule engaged."
            echo "-> Choosing alternative platforms (Cursor / GitHub Copilot / Devin)."
            PLATFORM="Cursor/Alternative"
        fi
        
        echo "----------------------------------------------------------"
        echo "Starting $PLATFORM..."
        
        if [[ "$PLATFORM" == *"Cursor"* ]]; then
            if command -v cursor &> /dev/null; then
                cursor .
                echo "Opened project in Cursor."
            else
                echo "Cursor not found in PATH. Opening folder instead."
                open .
            fi
        else
            open .
        fi
        echo "Workspace is ready. You can now modify the codebase."
        echo ""
        read -p "Press Enter to return to menu..."
        
    elif [ "$option" == "2" ]; then
        echo ""
        echo "=========================================================="
        echo "                 Reviewing Changes...                     "
        echo "=========================================================="
        # Show what the AI modified
        git diff
        
        echo ""
        echo "----------------------------------------------------------"
        echo "Current Status (including new files):"
        git status -s
        echo "----------------------------------------------------------"
        echo ""
        
        read -p "Do you want to confirm these changes and push to GitHub? (y/n): " confirm
        if [ "$confirm" == "y" ] || [ "$confirm" == "Y" ]; then
            echo "Adding changes..."
            git add .
            echo "Committing..."
            git commit -m "Agentic update - $(date +'%Y-%m-%d %H:%M:%S')"
            echo "Pushing to GitHub..."
            git push origin main
            echo ""
            echo "=========================================================="
            echo "                SUCCESS: Website updated!                 "
            echo "=========================================================="
        else
            echo ""
            echo "Push aborted. You can continue modifying."
        fi
        echo ""
        read -p "Press Enter to return to menu..."
        
    elif [ "$option" == "3" ]; then
        echo "Exiting..."
        exit 0
    fi
done
