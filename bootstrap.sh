#!/usr/bin/env bash
set -e

echo "== Claude Code dev environment bootstrap =="

if [ ! -f ~/.ssh/id_ed25519 ]; then
  echo "No SSH key found, generating..."
  ssh-keygen -t ed25519 -C "oussama@vettedai" -f ~/.ssh/id_ed25519 -N ""
  echo ">> Add this to https://github.com/settings/keys :"
  cat ~/.ssh/id_ed25519.pub
  read -p "Press enter once added to GitHub..."
else
  echo "SSH key already exists, skipping."
fi

if [ ! -f .env ]; then
  echo "Creating .env — paste your DeepSeek key when prompted."
  read -p "DeepSeek API key: " DSKEY
  cat > .env << ENVEOF
ANTHROPIC_BASE_URL=https://api.deepseek.com/anthropic
ANTHROPIC_AUTH_TOKEN=${DSKEY}
ANTHROPIC_MODEL=deepseek-v4-pro[1m]
ANTHROPIC_DEFAULT_OPUS_MODEL=deepseek-v4-pro[1m]
ANTHROPIC_DEFAULT_SONNET_MODEL=deepseek-v4-pro[1m]
ANTHROPIC_DEFAULT_HAIKU_MODEL=deepseek-v4-flash
ENVEOF
  echo ".env" >> .gitignore
else
  echo ".env already exists, skipping."
fi

docker compose build
echo "Done. Run: docker compose run --rm claude-dev bash"
