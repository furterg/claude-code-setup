#!/usr/bin/env bash
set -e

echo "==> Claude Code Setup"
echo ""

# 1. Marketplaces
echo "--- Adding marketplaces ---"
claude plugin marketplace add thedotmack/claude-mem
claude plugin marketplace add mksglu/context-mode

# 2. Plugins
echo ""
echo "--- Installing plugins ---"
plugins=(
  superpowers
  code-simplifier
  claude-md-management
  frontend-design
  context7
  code-review
  github
  telegram
  notion
  context-mode
  claude-mem
)
for plugin in "${plugins[@]}"; do
  claude plugin install "$plugin" && echo "  ✔ $plugin" || echo "  ✗ $plugin (already installed or failed)"
done

# 3. MCP Servers
echo ""
echo "--- Adding MCP servers ---"
claude mcp add --transport http Notion https://mcp.notion.com/mcp
claude mcp add --transport http Gmail https://gmail.mcp.claude.com/mcp
claude mcp add --transport http Google-Calendar https://gcal.mcp.claude.com/mcp
claude mcp add --transport http Zapier https://mcp.zapier.com/api/mcp/a/YOUR_ZAPIER_ACCOUNT_ID/mcp
claude mcp add --transport http Hugging-Face "https://huggingface.co/mcp?login&gradio=none"

# 4. Settings — merge permissions and model
echo ""
echo "--- Applying settings ---"
SETTINGS="$HOME/.claude/settings.json"

# Use node to merge if available, else print instructions
if command -v node &>/dev/null; then
  node - "$SETTINGS" <<'EOF'
const fs = require('fs');
const path = process.argv[2];
const existing = fs.existsSync(path) ? JSON.parse(fs.readFileSync(path, 'utf8')) : {};
const patch = {
  permissions: { allow: ["Bash(*)", "mcp__playwright"], deny: [] },
  alwaysThinkingEnabled: true,
  model: "opusplan"
};
// Deep merge permissions.allow
if (existing.permissions?.allow) {
  const merged = [...new Set([...existing.permissions.allow, ...patch.permissions.allow])];
  patch.permissions.allow = merged;
}
const result = { ...existing, ...patch, permissions: { ...existing.permissions, ...patch.permissions } };
fs.writeFileSync(path, JSON.stringify(result, null, 2) + '\n');
console.log('  ✔ settings.json updated');
EOF
else
  echo "  ! node not found — manually merge the following into ~/.claude/settings.json:"
  echo '    { "permissions": { "allow": ["Bash(*)", "mcp__playwright"], "deny": [] }, "alwaysThinkingEnabled": true, "model": "opusplan" }'
fi

echo ""
echo "==> Done! Run /reload-plugins inside Claude Code, then authenticate each MCP server."
