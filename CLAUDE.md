# OpenBB Equity Research Platform

This project configures Claude Code as an equity research workstation powered by OpenBB's financial data platform via MCP (Model Context Protocol).

## What This Does

Claude has access to the **OpenBB MCP server** which provides hundreds of financial data tools:
- Real-time and historical stock prices, fundamentals, and estimates
- SEC filings, institutional ownership, insider transactions
- Economic indicators (FRED, BLS, OECD, ECB)
- Financial news from multiple sources
- Options/derivatives data, ETF holdings, fixed income data

## Available Research Workflows

Use these pre-built prompts by asking Claude naturally:

| Prompt | Description |
|--------|-------------|
| `company_snapshot` | Quick executive briefing on any ticker |
| `full_equity_report` | Full institutional-quality research report |
| `earnings_preview` | Pre-earnings analysis with estimates and history |
| `peer_comparison` | Side-by-side comp table across fundamentals |
| `macro_dashboard` | Macro overview: rates, inflation, employment |
| `sector_screen` | Screen stocks by sector and financial criteria |
| `ownership_analysis` | Institutional ownership and insider activity deep dive |
| `fixed_income_overview` | Yield curves, spreads, and rate environment |
| `morning_briefing` | Daily market briefing for the morning meeting |
| `dcf_inputs` | Gather all inputs for a DCF valuation model |

## Example Queries

- "Give me a snapshot of AAPL"
- "Build a full equity research report on NVDA with peers AVGO,AMD,INTC"
- "Show me the macro dashboard focused on Technology"
- "Screen healthcare stocks above 10B market cap sorted by revenue growth"
- "Pull the DCF inputs for MSFT"
- "What does the ownership picture look like for TSLA?"
- "Morning briefing please"

## For the MD

Open Claude on your phone and ask questions like you would a junior analyst:
- "What's AAPL trading at and what do estimates look like?"
- "Compare CRM vs NOW vs WDAY on valuation and growth"
- "What happened in markets overnight?"
- "Pull me the financials for the last 3 years on JPM"

Claude will pull the data from OpenBB and format it for you.

## Data Providers

API keys are configured in `~/.openbb_platform/user_settings.json`. The more providers you enable, the more data coverage you get. See `.env.example` for the full list.
