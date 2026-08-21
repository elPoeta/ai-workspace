#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════
#  llama-server launch script
# ═══════════════════════════════════════════════════════════════
set -euo pipefail

# CTX
#  ["256k"]=262144
#  ["200k"]=200000
#  ["192k"]=196608
#  ["128k"]=131072
#  ["64k"]=65536
#  ["48k"]=49152
#  ["32k"]=32768
#  ["16k"]=16384
#  ["12k"]=12288
#  ["8k"]=8192
#  ["4k"]=4096

LLAMA_BIN="$AI_HOME/llama/llama.cpp/build/bin/llama-server"
PRESETS="$AI_HOME/models/llama/models.ini"

HOST="127.0.0.1"
PORT=8088

exec "$LLAMA_BIN" \
     --models-preset "$PRESETS" \
     --models-max 1 \
     --models-autoload \
     --host "$HOST" \
     --port "$PORT"



