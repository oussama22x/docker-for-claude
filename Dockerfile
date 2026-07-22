FROM node:20-slim

RUN apt-get update && apt-get install -y \
    git curl ca-certificates ripgrep openssh-client \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g @anthropic-ai/claude-code \
    && npm install -g @anthropic-ai/claude-code-linux-x64 || true

WORKDIR /workspace
