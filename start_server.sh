#!/usr/bin/env bash
set -euo pipefail

# Start OpenBB MCP server in remote/HTTP mode for Claude Desktop/Web/Mobile connectors
# This gives you a URL to paste into Claude's "Add custom connector" dialog

HOST="${1:-0.0.0.0}"
PORT="${2:-8001}"

echo "=== Starting OpenBB MCP Server (HTTP mode) ==="
echo ""

# Check for uv/uvx
if ! command -v uvx &>/dev/null; then
    echo "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="$HOME/.local/bin:$PATH"
fi

echo "Starting server on $HOST:$PORT..."
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "  Your MCP connector URL (paste into Claude):"
echo ""
echo "    http://localhost:$PORT/mcp/"
echo ""
echo "  For remote access (MD's phone), use a tunnel:"
echo "    ngrok http $PORT"
echo "    Then use the ngrok https URL + /mcp/"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

uvx --from openbb-mcp-server --with "openbb[all]" openbb-mcp \
    --transport streamable-http \
    --host "$HOST" \
    --port "$PORT" \
    --system-prompt "$SCRIPT_DIR/config/system_prompt.txt" \
    --server-prompts "$SCRIPT_DIR/config/server_prompts.json" \
    --default-categories all
