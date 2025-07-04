#!/bin/bash
# Setup script for git hooks in the Alliance .github repository

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Setting up git hooks for the Alliance .github repository...${NC}"

# Get the repository root directory
REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)

if [ -z "$REPO_ROOT" ]; then
    echo "Error: Not in a git repository"
    exit 1
fi

# Configure git to use the .githooks directory
git config core.hooksPath .githooks

echo -e "${GREEN}✓ Git hooks configured successfully!${NC}"
echo ""
echo "The following protections are now active:"
echo "  • Pre-commit hook prevents committing sensitive files (.env, .pem, .key, etc.)"
echo "  • Pre-commit hook scans for sensitive content (API keys, tokens, private keys)"
echo ""
echo "To disable hooks temporarily (not recommended):"
echo "  git commit --no-verify"
echo ""
echo "To disable hooks permanently (not recommended):"
echo "  git config --unset core.hooksPath"