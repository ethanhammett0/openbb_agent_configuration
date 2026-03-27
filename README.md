# OpenBB MCP for Claude Code — Equity Research Workstation

Turn Claude into a Bloomberg-like equity research assistant by connecting it to OpenBB's financial data platform via MCP.

Your team gets access to hundreds of financial data endpoints — stock prices, fundamentals, estimates, SEC filings, economic indicators, news — all available through natural conversation in Claude Code (terminal, web, or mobile).

## Quick Start

### 1. Clone and setup

```bash
git clone https://github.com/ethanhammett0/openbb_agent_configuration.git
cd openbb_agent_configuration
bash setup.sh
```

This installs the OpenBB platform with MCP server and all data providers into a virtual environment.

### 2. Add your API keys

Edit `~/.openbb_platform/user_settings.json` with your data provider keys:

```json
{
  "credentials": {
    "fmp_api_key": "YOUR_KEY_HERE",
    "polygon_api_key": "YOUR_KEY_HERE",
    "fred_api_key": "YOUR_KEY_HERE"
  }
}
```

**Free providers to start with:**
- [FMP](https://financialmodelingprep.com/developer) — fundamentals, estimates, filings
- [Polygon](https://polygon.io/) — real-time and historical prices
- [FRED](https://fred.stlouisfed.org/docs/api/api_key.html) — economic indicators
- [Tiingo](https://www.tiingo.com/) — historical prices, news
- [Alpha Vantage](https://www.alphavantage.co/) — prices, fundamentals

### 3. Launch Claude Code

```bash
cd openbb_agent_configuration
claude
```

Claude automatically discovers the OpenBB MCP server via `.mcp.json` and has access to all financial data tools.

## How It Works

```
┌─────────────────────────────────────────────────────┐
│  Claude Code (Terminal / Web / Mobile)               │
│  Your equity research analyst interface              │
├─────────────────────────────────────────────────────┤
│  MCP Protocol (stdio)                                │
├─────────────────────────────────────────────────────┤
│  OpenBB MCP Server                                   │
│  Converts OpenBB tools into MCP-compatible endpoints │
├─────────────────────────────────────────────────────┤
│  OpenBB Platform                                     │
│  Unified API across 25+ financial data providers     │
├─────────────────────────────────────────────────────┤
│  Data Providers                                      │
│  FMP · Polygon · FRED · SEC · Yahoo Finance · etc.  │
└─────────────────────────────────────────────────────┘
```

The `.mcp.json` file tells Claude Code to launch the OpenBB MCP server on startup. Claude then has access to tools for:

| Category | Examples |
|----------|----------|
| **Equity** | Quotes, historical prices, fundamentals, estimates, filings, screeners |
| **Economy** | GDP, CPI, employment, Fed data, leading indicators |
| **Fixed Income** | Treasury yields, yield curves, corporate bonds, spreads |
| **News** | Financial news from multiple sources, sentiment |
| **ETF/Index** | ETF holdings, sector breakdown, index constituents |
| **Options** | Options chains, implied volatility, greeks |
| **Crypto** | Cryptocurrency prices and market data |
| **Currency** | FX rates, crosses, historical data |

## Pre-Built Research Workflows

The server comes with research-oriented prompt templates in `config/server_prompts.json`:

- **`company_snapshot`** — Quick executive briefing on any ticker
- **`full_equity_report`** — Comprehensive institutional-quality research report
- **`earnings_preview`** — Pre-earnings analysis with estimates and beat history
- **`peer_comparison`** — Side-by-side comp table
- **`macro_dashboard`** — Rates, inflation, employment, market indicators
- **`sector_screen`** — Screen stocks by sector and financial criteria
- **`ownership_analysis`** — Institutional ownership and insider activity
- **`fixed_income_overview`** — Yield curves, spreads, rate environment
- **`morning_briefing`** — Daily market briefing
- **`dcf_inputs`** — Gather all inputs for a DCF model

## For the Managing Director (Mobile)

Your MD can open the **Claude app on their phone** and use this the same way:

1. Open Claude Code (web at claude.ai/code or the Claude mobile app)
2. Navigate to this project directory
3. Ask questions naturally:
   - *"What's AAPL trading at?"*
   - *"Compare the big 4 banks on valuation"*
   - *"Give me a full report on NVDA"*
   - *"What happened in markets today?"*

Claude pulls live data from OpenBB and presents it in clean, readable format.

> **Note for mobile/web access:** The OpenBB MCP server needs to be running on a machine your Claude session can reach. For the simplest setup, run Claude Code on a shared workstation or cloud instance that the team can SSH into. Alternatively, run the MCP server with `--transport streamable-http` and configure the remote URL.

## Customization

### Adding research workflows

Edit `config/server_prompts.json` to add your team's specific research templates. Each prompt has:
- `name` — identifier
- `description` — what it does
- `content` — the template with `{placeholders}`
- `arguments` — parameters the user provides

### Changing the system prompt

Edit `config/system_prompt.txt` to adjust Claude's research personality, output format preferences, or your team's specific conventions.

### Restricting tool categories

In `.mcp.json`, change `--default-categories` to limit which OpenBB tools Claude can access (e.g., only `equity,economy` for a focused setup).

## Project Structure

```
openbb_agent_configuration/
├── .mcp.json                    # Claude Code MCP server config
├── CLAUDE.md                    # Project instructions Claude reads
├── setup.sh                     # One-command installation
├── .env.example                 # API key template
├── .gitignore
├── config/
│   ├── mcp_settings.json        # OpenBB MCP server settings
│   ├── system_prompt.txt        # Equity research system prompt
│   └── server_prompts.json      # Pre-built research workflows
└── README.md
```

## Requirements

- Python 3.10+
- Claude Code CLI (`npm install -g @anthropic-ai/claude-code`)
- At least one data provider API key (FMP recommended as starting point)
