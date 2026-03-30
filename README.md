# OpenBB MCP for Claude Code — Equity Research Workstation

Connect Claude to OpenBB's financial data platform. Claude gets access to hundreds of financial data tools — stock prices, fundamentals, estimates, SEC filings, economic indicators, news — through a single MCP connector.

No servers to manage. No venvs. Just clone, add API keys, and go.

## Quick Start

### Option A: Claude Code (Terminal)

```bash
git clone https://github.com/ethanhammett0/openbb_agent_configuration.git
cd openbb_agent_configuration
bash setup.sh   # installs uv if needed, verifies OpenBB MCP works
```

Add at least one API key to `~/.openbb_platform/user_settings.json`:

```json
{
  "credentials": {
    "fmp_api_key": "YOUR_KEY_HERE"
  }
}
```

Then just:

```bash
claude
```

### Option B: Claude Desktop / Web / Mobile (Custom Connector)

For Claude's desktop app, web app, or your MD's phone — run the server in HTTP mode:

```bash
bash start_server.sh
```

This starts the OpenBB MCP server and prints a URL. Paste it into Claude:

1. Go to **Customize > Connectors > +**
2. Name: `OpenBB`
3. URL: `http://localhost:8001/mcp/`
4. Click **Add**

**For remote access (MD's phone):** Use a tunnel to expose the server:

```bash
# In one terminal:
bash start_server.sh

# In another terminal:
ngrok http 8001
# Copy the https URL, append /mcp/
# e.g. https://abc123.ngrok-free.app/mcp/
```

Paste the ngrok URL into Claude's custom connector dialog on any device.

Claude auto-discovers the OpenBB MCP server via `.mcp.json` and has access to all financial data tools. That's it.

## How It Works

```
You (terminal / web / phone)
    │
    ▼
Claude Code
    │
    ▼ MCP (stdio)
    │
OpenBB MCP Server  ← launched automatically by uvx, zero install
    │
    ▼
25+ Data Providers (FMP, Polygon, FRED, SEC, Yahoo Finance, etc.)
```

The `.mcp.json` file tells Claude Code to run `uvx --from openbb-mcp-server openbb-mcp` on startup. `uvx` handles all Python dependencies automatically — no virtualenv, no pip install, no maintenance.

## What You Can Do

| Category | Examples |
|----------|----------|
| **Equity** | Quotes, historical prices, fundamentals, estimates, filings, screeners |
| **Economy** | GDP, CPI, employment, Fed data, leading indicators |
| **Fixed Income** | Treasury yields, yield curves, corporate bonds, spreads |
| **News** | Financial news from multiple sources |
| **ETF/Index** | ETF holdings, sector breakdown, index constituents |
| **Options** | Options chains, implied volatility, greeks |
| **Crypto** | Cryptocurrency prices and market data |
| **Currency** | FX rates, crosses, historical data |

## Pre-Built Research Workflows

Ask Claude naturally — these prompts are loaded from `config/server_prompts.json`:

| Just say... | What it does |
|-------------|-------------|
| "Give me a snapshot of AAPL" | `company_snapshot` — quick executive briefing |
| "Full equity report on NVDA, peers AVGO AMD INTC" | `full_equity_report` — institutional-quality report |
| "Earnings preview for MSFT" | `earnings_preview` — estimates, beat history, implied move |
| "Compare CRM vs NOW vs WDAY" | `peer_comparison` — side-by-side comp table |
| "Macro dashboard, focus on tech" | `macro_dashboard` — rates, inflation, employment |
| "Screen healthcare above 10B by growth" | `sector_screen` — stock screener |
| "Ownership picture for TSLA" | `ownership_analysis` — institutions, insiders, short interest |
| "Fixed income overview" | `fixed_income_overview` — yield curves, spreads |
| "Morning briefing" | `morning_briefing` — overnight markets, data, earnings |
| "DCF inputs for MSFT" | `dcf_inputs` — everything for a DCF model |

## For the MD (Phone)

Your MD opens Claude Code (web or mobile), navigates to this project, and talks to Claude like a junior analyst:

- *"What's AAPL trading at and what do estimates look like?"*
- *"Compare the big 4 banks on valuation"*
- *"What happened in markets overnight?"*
- *"Pull me the financials for the last 3 years on JPM"*

Claude pulls live data from OpenBB and formats it clean.

> **Mobile/web access:** Run `bash start_server.sh` on any machine, expose with ngrok, and paste the URL into Claude's custom connector. Your MD gets OpenBB on his phone in under a minute.

## API Keys

The more providers you enable, the more data coverage you get. Add keys to `~/.openbb_platform/user_settings.json`:

| Provider | Cost | Best for | Sign up |
|----------|------|----------|---------|
| FMP | Free tier | Fundamentals, estimates, filings | financialmodelingprep.com |
| Polygon | Free tier | Real-time and historical prices | polygon.io |
| FRED | Free | Economic indicators | fred.stlouisfed.org |
| Tiingo | Free tier | Historical prices, news | tiingo.com |
| Alpha Vantage | Free tier | Prices, fundamentals | alphavantage.co |
| Intrinio | Paid | Institutional-grade data | intrinio.com |
| Benzinga | Paid | News, analyst ratings | benzinga.com |

## Customization

- **Research workflows**: Edit `config/server_prompts.json` to add your team's templates
- **System prompt**: Edit `config/system_prompt.txt` to adjust Claude's research personality
- **Tool categories**: Change `--default-categories` in `.mcp.json` to restrict which tools Claude can access

## Project Structure

```
openbb_agent_configuration/
├── .mcp.json                    # MCP connector config (the important file)
├── CLAUDE.md                    # Instructions Claude reads on startup
├── setup.sh                     # One-command setup (installs uv if needed)
├── start_server.sh              # Start HTTP server for Claude Desktop/Web/Mobile
├── .env.example                 # API key reference
├── config/
│   ├── mcp_settings.json        # OpenBB MCP server settings
│   ├── system_prompt.txt        # Equity research system prompt
│   └── server_prompts.json      # Pre-built research workflow prompts
└── README.md
```

## Requirements

- Python 3.10+
- [uv](https://docs.astral.sh/uv/) (setup.sh installs this automatically)
- Claude Code
- At least one data provider API key (FMP free tier recommended to start)
