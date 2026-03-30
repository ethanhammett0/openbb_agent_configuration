#!/usr/bin/env bash
set -euo pipefail

# OpenBB MCP Connector Setup for Claude Code
# Minimal setup — uvx handles OpenBB installation automatically

echo "=== OpenBB MCP Connector Setup ==="
echo ""

# Check for uv/uvx
if ! command -v uvx &>/dev/null; then
    echo "Installing uv (Python package runner)..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="$HOME/.local/bin:$PATH"
fi

echo "uvx found: $(uvx --version)"

# Verify the OpenBB MCP server can be resolved
echo "Verifying openbb-mcp-server package..."
uvx --from openbb-mcp-server openbb-mcp --help >/dev/null 2>&1 && echo "OpenBB MCP server OK" || {
    echo "ERROR: Could not resolve openbb-mcp-server. Check your Python/pip setup."
    exit 1
}

# Set up OpenBB API keys
OPENBB_DIR="$HOME/.openbb_platform"
mkdir -p "$OPENBB_DIR"

if [[ ! -f "$OPENBB_DIR/user_settings.json" ]]; then
    cat > "$OPENBB_DIR/user_settings.json" << 'SETTINGS'
{
  "credentials": {
    "fmp_api_key": "",
    "polygon_api_key": "",
    "tiingo_token": "",
    "alpha_vantage_api_key": "",
    "fred_api_key": "",
    "intrinio_api_key": "",
    "benzinga_api_key": "",
    "tradingeconomics_api_key": ""
  }
}
SETTINGS
    echo "API key template created at $OPENBB_DIR/user_settings.json"
fi

echo ""
echo "=== Setup Complete ==="
echo ""
echo "Next steps:"
echo "  1. Add API keys to $OPENBB_DIR/user_settings.json"
echo "     (FMP free tier is a great starting point: https://financialmodelingprep.com/developer)"
echo ""
echo "  2. Run 'claude' in this directory — OpenBB connects automatically via .mcp.json"
echo ""
echo "That's it. No venv, no pip install. uvx handles everything."
