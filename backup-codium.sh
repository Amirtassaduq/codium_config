#!/bin/bash

# === CONFIG ===
REPO_DIR="$HOME/repos/codium_config"
VSCODIUM_CONFIG="$HOME/.config/VSCodium/User"
DATE=$(date '+%Y-%m-%d %H:%M:%S')
REMOTE_URL="https://github.com/Amirtassaduq/codium_config.git"

# Create destination if it doesn't exist
mkdir -p "$REPO_DIR"

# Copy config files
cp "$VSCODIUM_CONFIG/settings.json" "$REPO_DIR/settings.json"
cp "$VSCODIUM_CONFIG/keybindings.json" "$REPO_DIR/keybindings.json"

# Backup snippets
if [ -d "$VSCODIUM_CONFIG/snippets" ]; then
  mkdir -p "$REPO_DIR/snippets"
  cp "$VSCODIUM_CONFIG/snippets/"* "$REPO_DIR/snippets/"
fi

# Export installed extensions
codium --list-extensions > "$REPO_DIR/extensions.list"

# Go to repo directory
cd "$REPO_DIR" || exit

# === Git Init Logic ===
if [ ! -d ".git" ]; then
  echo "🧱 Initializing Git repository..."
  git init
  git branch -M main
  echo "# codium_config" > README.md
  git add README.md
  git remote add origin "$REMOTE_URL"
  git commit -m "📦 First commit: Initialized codium_config repo"
  git push -u origin main
fi

# === Regular commit ===
git add .
git commit -m "🧠 Backup VSCodium config: $DATE"
git push
