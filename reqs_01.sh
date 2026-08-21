#!/usr/bin/env bash

set -euo pipefail

AI_HOME="$HOME/AI"
BASHRC="$HOME/.bashrc"

# Create AI directory structure
mkdir -p \
    "$AI_HOME/cache" \
    "$AI_HOME/datasets" \
    "$AI_HOME/llama" \
    "$AI_HOME/logs" \
    "$AI_HOME/models/fishspeech" \
    "$AI_HOME/models/huggingface" \
    "$AI_HOME/models/llama" \
    "$AI_HOME/models/onnx" \
    "$AI_HOME/models/torch" \
    "$AI_HOME/models/whisper" \
    "$AI_HOME/output" \
    "$AI_HOME/projects" \
    "$AI_HOME/temp" \
    "$AI_HOME/voices"

# Environment variables to add.
declare -A AI_ENV_VARS=(
    [AI_HOME]='export AI_HOME="$HOME/AI"'
    [HF_HOME]='export HF_HOME="$AI_HOME/models/huggingface"'
    [TORCH_HOME]='export TORCH_HOME="$AI_HOME/models/torch"'
    [AI_MODELS]='export AI_MODELS="$AI_HOME/models"'
    [AI_VOICES]='export AI_VOICES="$AI_HOME/voices"'
    [AI_OUTPUT]='export AI_OUTPUT="$AI_HOME/output"'
    [AI_CACHE]='export AI_CACHE="$AI_HOME/cache"'
)

# Add only environment variables that are not already defined in .bashrc.
env_block=""

for var in "${!AI_ENV_VARS[@]}"; do
    if ! grep -Eq "^[[:space:]]*(export[[:space:]]+)?${var}=" "$BASHRC" 2>/dev/null; then
        env_block+="${AI_ENV_VARS[$var]}"$'\n'
    fi
done

if [[ -n "$env_block" ]]; then
    {
        printf '\n# AI Environment\n'
        printf '%s' "$env_block"
    } >> "$BASHRC"

    echo "AI environment variables added to $BASHRC."
else
    echo "AI environment variables already exist in $BASHRC; nothing added."
fi

echo "AI directory structure created at: $AI_HOME"
echo
echo "Run the following to activate changes in the current shell:"
echo "source \"$BASHRC\""

