#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# Antigravity Config Installer
# Copiază toate skill-urile, workflow-urile și configurările
# în locațiile corecte pe sistemul curent.
# ============================================================

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo ""
echo "🚀 Antigravity Config Installer"
echo "================================"
echo ""

# --- Skills ---
echo -e "${YELLOW}📦 Installing skills...${NC}"
SKILLS_DIR="$HOME/.agents/skills"
mkdir -p "$SKILLS_DIR"

for skill_dir in "$SCRIPT_DIR"/skills/*/; do
  skill_name=$(basename "$skill_dir")
  mkdir -p "$SKILLS_DIR/$skill_name"
  cp "$skill_dir"* "$SKILLS_DIR/$skill_name/"
  echo -e "  ${GREEN}✓${NC} $skill_name"
done

# --- Workflows ---
echo -e "${YELLOW}📋 Installing workflows...${NC}"
WORKFLOWS_DIR="$HOME/.agents/workflows"
mkdir -p "$WORKFLOWS_DIR"

for wf in "$SCRIPT_DIR"/workflows/*.md; do
  wf_name=$(basename "$wf")
  cp "$wf" "$WORKFLOWS_DIR/$wf_name"
  echo -e "  ${GREEN}✓${NC} $wf_name"
done

# --- MCP Config ---
echo -e "${YELLOW}⚙️  Installing MCP config...${NC}"
MCP_DIR="$HOME/.gemini/antigravity"
mkdir -p "$MCP_DIR"
cp "$SCRIPT_DIR/config/mcp_config.json" "$MCP_DIR/mcp_config.json"
echo -e "  ${GREEN}✓${NC} mcp_config.json → $MCP_DIR/"

# --- Scratch Space Protocol ---
cp "$SCRIPT_DIR/config/scratch-space-protocol.md" "$MCP_DIR/scratch-space-protocol.md"
echo -e "  ${GREEN}✓${NC} scratch-space-protocol.md → $MCP_DIR/"

# --- Workspace Settings ---
echo -e "${YELLOW}🏗️  Installing workspace settings...${NC}"
WS_DIR="$HOME/projects/antigravity_workspace/.gemini"
mkdir -p "$WS_DIR"
cp "$SCRIPT_DIR/config/settings.json" "$WS_DIR/settings.json"
echo -e "  ${GREEN}✓${NC} settings.json → $WS_DIR/"

# --- Knowledge Base ---
echo -e "${YELLOW}🧠 Installing knowledge base...${NC}"
KNOWLEDGE_DIR="$HOME/.gemini/antigravity/knowledge"
mkdir -p "$KNOWLEDGE_DIR"
cp -R "$SCRIPT_DIR/knowledge"/* "$KNOWLEDGE_DIR/" 2>/dev/null || true
echo -e "  ${GREEN}✓${NC} Knowledge base → $KNOWLEDGE_DIR/"

# --- Global GEMINI Rules ---
echo -e "${YELLOW}🌐 Installing global GEMINI.md rules...${NC}"
cp "$SCRIPT_DIR/config/GEMINI.md" "$HOME/.gemini/GEMINI.md" 2>/dev/null || true
echo -e "  ${GREEN}✓${NC} GEMINI.md → $HOME/.gemini/"

# --- Create scratch directory ---
SCRATCH_DIR="$HOME/.gemini/antigravity/scratch"
mkdir -p "$SCRATCH_DIR"

# --- Create workspace scratch ---
mkdir -p "$HOME/projects/antigravity_workspace/scratch"

echo ""
echo "================================"
echo -e "${GREEN}✅ DONE — All optimizations installed!${NC}"
echo ""
echo "📍 Skills:     $SKILLS_DIR/"
echo "📍 Workflows:  $WORKFLOWS_DIR/"
echo "📍 MCP Config: $MCP_DIR/mcp_config.json"
echo "📍 Settings:   $WS_DIR/settings.json"
echo ""
echo "💡 Restart Antigravity to pick up the new configurations."
echo ""
