# Claude Code Setup

Replicates my personal Claude Code environment across machines.

## Quick Start

```bash
bash <(curl -s https://raw.githubusercontent.com/gfu-cc/claude-code-setup/main/setup.sh)
```

Or follow the manual steps below.

---

## 1. Add Extra Marketplaces

```bash
claude plugin marketplace add thedotmack/claude-mem
claude plugin marketplace add mksglu/context-mode
```

---

## 2. Install Plugins

```bash
claude plugin install superpowers
claude plugin install code-simplifier
claude plugin install claude-md-management
claude plugin install frontend-design
claude plugin install context7
claude plugin install code-review
claude plugin install github
claude plugin install telegram
claude plugin install notion
claude plugin install context-mode
claude plugin install claude-mem
```

Then reload inside a Claude Code session:
```
/reload-plugins
```

---

## 3. Add MCP Servers

```bash
claude mcp add --transport http Notion https://mcp.notion.com/mcp
claude mcp add --transport http Gmail https://gmail.mcp.claude.com/mcp
claude mcp add --transport http Google-Calendar https://gcal.mcp.claude.com/mcp
claude mcp add --transport http Zapier https://mcp.zapier.com/api/mcp/a/YOUR_ZAPIER_ACCOUNT_ID/mcp
claude mcp add --transport http Hugging-Face "https://huggingface.co/mcp?login&gradio=none"
```

Verify:
```bash
claude mcp list
```

> **Note:** Notion, Gmail, Google Calendar, Zapier, and Hugging Face all require OAuth re-authentication after adding. The Zapier URL contains a personal account ID — re-authorization may be needed on a new machine.

---

## 4. Apply Settings

Merge the following into `~/.claude/settings.json`:

```json
{
  "permissions": {
    "allow": ["Bash(*)", "mcp__playwright"],
    "deny": []
  },
  "alwaysThinkingEnabled": true,
  "model": "opusplan"
}
```

See [`settings.json`](./settings.json) for the full reference config (without personal tokens or paths).

---

## Plugin Summary

| Plugin | Marketplace |
|--------|-------------|
| `superpowers` | claude-plugins-official |
| `code-simplifier` | claude-plugins-official |
| `claude-md-management` | claude-plugins-official |
| `frontend-design` | claude-plugins-official |
| `context7` | claude-plugins-official |
| `code-review` | claude-plugins-official |
| `github` | claude-plugins-official |
| `telegram` | claude-plugins-official |
| `notion` | claude-plugins-official |
| `context-mode` | mksglu/context-mode |
| `claude-mem` | thedotmack/claude-mem |

---

## MCP Server Summary

| Name | Transport | URL |
|------|-----------|-----|
| Notion | HTTP | https://mcp.notion.com/mcp |
| Gmail | HTTP | https://gmail.mcp.claude.com/mcp |
| Google-Calendar | HTTP | https://gcal.mcp.claude.com/mcp |
| Zapier | HTTP | https://mcp.zapier.com/api/mcp/a/YOUR_ZAPIER_ACCOUNT_ID/mcp |
| Hugging-Face | HTTP | https://huggingface.co/mcp?login&gradio=none |

---

## Post-Install Checklist

- [ ] Run `/reload-plugins` in Claude Code
- [ ] Authenticate Notion (OAuth)
- [ ] Authenticate Gmail (OAuth)
- [ ] Authenticate Google Calendar (OAuth)
- [ ] Authenticate Zapier (may need new personal URL)
- [ ] Authenticate Hugging Face
- [ ] Configure GitHub plugin (token required)
- [ ] Configure Telegram plugin (bot token required)
