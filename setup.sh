#!/usr/bin/env bash
set -euo pipefail

# OpenBB MCP Server Setup for Claude Code
# Installs the OpenBB platform with MCP server and equity research providers

echo "=== OpenBB MCP Server Setup for Equity Research ==="
echo ""

# Check Python version
python_version=$(python3 --version 2>/dev/null | cut -d' ' -f2 | cut -d'.' -f1,2)
if [[ -z "$python_version" ]]; then
    echo "ERROR: Python 3.10+ is required. Please install Python first."
    exit 1
fi

echo "Using Python $python_version"

# Create virtual environment if it doesn't exist
if [[ ! -d ".venv" ]]; then
    echo "Creating virtual environment..."
    python3 -m venv .venv
fi

source .venv/bin/activate
echo "Virtual environment activated."

# Install OpenBB with MCP server
echo ""
echo "Installing OpenBB platform with MCP server..."
pip install --upgrade pip
pip install "openbb[all]" openbb-mcp-server

# Copy config to OpenBB platform directory
OPENBB_DIR="$HOME/.openbb_platform"
mkdir -p "$OPENBB_DIR"

if [[ -f "config/mcp_settings.json" ]]; then
    cp config/mcp_settings.json "$OPENBB_DIR/mcp_settings.json"
    echo "MCP settings installed to $OPENBB_DIR/mcp_settings.json"
fi

# Prompt for API keys
echo ""
echo "=== API Key Configuration ==="
echo "OpenBB works best with data provider API keys."
echo "You can configure them in: $OPENBB_DIR/user_settings.json"
echo ""
echo "Recommended free-tier providers for equity research:"
echo "  - FMP (Financial Modeling Prep): https://financialmodelingprep.com/developer"
echo "  - Polygon: https://polygon.io/"
echo "  - Tiingo: https://www.tiingo.com/"
echo "  - Alpha Vantage: https://www.alphavantage.co/"
echo "  - FRED: https://fred.stlouisfed.org/docs/api/api_key.html"
echo ""

# Create user_settings.json template if it doesn't exist
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
    echo "Template created at $OPENBB_DIR/user_settings.json"
    echo "Edit this file to add your API keys."
fi

echo ""
echo "=== Setup Complete ==="
echo ""
echo "To start the MCP server manually:"
echo "  source .venv/bin/activate"
echo "  openbb-mcp --transport stdio"
echo ""
echo "Claude Code will start it automatically via .mcp.json."
echo "Run 'claude' in this directory to get started."
