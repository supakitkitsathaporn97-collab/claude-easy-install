#!/usr/bin/env bash
# =====================================================================
#  Claude Code Easy Install — macOS / Linux bootstrap
#  Cai dat Claude Code + tro ly AI ca nhan chi voi 1 lenh
#
#  Usage:
#    curl -fsSL https://raw.githubusercontent.com/supakitkitsathaporn97-collab/claude-easy-install/main/install/go.sh | bash
#
#  What it does / Script nay lam gi:
#    1. Installs Claude Code via Anthropic's OFFICIAL installer
#       (we call https://claude.ai/install.sh — never re-host it)
#    2. Adds this repo as a plugin marketplace
#    3. Installs the "nick-starter" plugin (/onboard interview + core skills)
#    4. OPTIONAL EXTRA: tries to add smart memory (Node.js + the open-source
#       agentmemory plugin). Any failure = skipped with one friendly line.
#    5. OPTIONAL EXTRA: tries to install the free Obsidian note app (macOS,
#       via Homebrew). Also skipped gracefully — these extras never block.
#
#  Requirements: macOS 13+ / Ubuntu 20.04+, internet,
#  and a paid Claude plan (Pro/Max) for the login step afterwards.
#  Safe to re-run. / Chay lai bao nhieu lan cung an toan.
# =====================================================================
set -u

# Replaced with the real GitHub account at publish time.
REPO_OWNER="supakitkitsathaporn97-collab"
MARKETPLACE_REPO="$REPO_OWNER/claude-easy-install"
MARKETPLACE_NAME="claude-easy-install"
PLUGIN_NAME="nick-starter"

step() { printf '\n\033[36m==> %s\033[0m\n' "$1"; }
ok()   { printf '\033[32m    OK: %s\033[0m\n' "$1"; }
note() { printf '\033[33m    %s\033[0m\n' "$1"; }

printf '\n\033[35m=====================================================\n'
printf '  Claude Code Easy Install\n'
printf '  Cai dat Claude Code de dang - chi 1 lenh\n'
printf '=====================================================\033[0m\n'

# ---------------------------------------------------------------
# Step 1 — Claude Code itself (official Anthropic installer)
# ---------------------------------------------------------------
step "Step 1/5: Checking Claude Code... / Kiem tra Claude Code..."

if command -v claude >/dev/null 2>&1 || [ -x "$HOME/.local/bin/claude" ]; then
  ok "Claude Code is already installed. / Claude Code da duoc cai dat."
else
  note "Not found - installing via the official Anthropic installer..."
  note "Chua co - dang cai bang trinh cai dat chinh thuc cua Anthropic..."
  # Official installer. We call it; we do not copy or re-host it.
  curl -fsSL https://claude.ai/install.sh | bash
  ok "Official installer finished. / Trinh cai dat chinh thuc da chay xong."
fi

# Make `claude` visible in THIS shell session.
case ":$PATH:" in
  *":$HOME/.local/bin:"*) : ;;
  *) PATH="$HOME/.local/bin:$PATH" ;;
esac
export PATH

if ! command -v claude >/dev/null 2>&1; then
  printf '\n\033[31m  Claude Code installed but this shell cannot see it yet.\n'
  printf '  Claude Code da cai xong nhung shell nay chua nhan ra no.\033[0m\n\n'
  printf '  FIX / CACH SUA:\n'
  printf '   1. Open a NEW terminal window. / Mo cua so terminal MOI.\n'
  printf '   2. Re-run this same command - it is safe. / Chay lai dung lenh nay - an toan.\n'
  exit 1
fi
ok "claude found: $(command -v claude)"

# ---------------------------------------------------------------
# Step 2 — Add the plugin marketplace (idempotent)
# ---------------------------------------------------------------
step "Step 2/5: Adding the starter marketplace... / Them kho plugin..."

if claude plugin marketplace add "$MARKETPLACE_REPO" >/dev/null 2>&1; then
  ok "Marketplace added. / Da them kho plugin."
elif claude plugin marketplace update "$MARKETPLACE_NAME" >/dev/null 2>&1; then
  ok "Marketplace already present - refreshed. / Kho plugin da co - da cap nhat."
else
  note "Could not add or update the marketplace. Check internet + repo:"
  note "Khong them duoc kho plugin. Kiem tra mang va repo:"
  note "  https://github.com/$MARKETPLACE_REPO"
  exit 1
fi

# ---------------------------------------------------------------
# Step 3 — Install the starter plugin (idempotent)
# ---------------------------------------------------------------
step "Step 3/5: Installing the starter plugin... / Cai plugin khoi dong..."

if claude plugin install "$PLUGIN_NAME@$MARKETPLACE_NAME" >/dev/null 2>&1; then
  ok "Plugin '$PLUGIN_NAME' installed. / Da cai plugin '$PLUGIN_NAME'."
elif claude plugin update "$PLUGIN_NAME" >/dev/null 2>&1; then
  ok "Plugin already installed - updated. / Plugin da co - da cap nhat."
else
  note "Plugin install failed. Try manually inside Claude Code:"
  note "Cai plugin that bai. Thu thu cong trong Claude Code:"
  note "  /plugin install $PLUGIN_NAME@$MARKETPLACE_NAME"
fi

# ---------------------------------------------------------------
# Step 4 — OPTIONAL: smart memory (agentmemory). Fully automatic,
# fully non-blocking: any failure = one friendly line, keep going.
# ---------------------------------------------------------------
step "Step 4/5: Smart memory (optional extra)... / Bo nho thong minh (tuy chon)..."

node_major() {
  command -v node >/dev/null 2>&1 || { echo 0; return; }
  node -v 2>/dev/null | sed 's/^v//' | cut -d. -f1 | grep -E '^[0-9]+$' || echo 0
}

MEM_OK=0
NODE_MAJOR="$(node_major)"
# agentmemory (Apache-2.0, github.com/rohitg00/agentmemory) needs Node 20+.
if [ "$NODE_MAJOR" -lt 20 ] 2>/dev/null; then
  if [ "$(uname -s)" = "Darwin" ] && command -v brew >/dev/null 2>&1; then
    note "Adding Node.js (needed for smart memory)... / Dang cai Node.js..."
    brew install node >/dev/null 2>&1 || true
    NODE_MAJOR="$(node_major)"
  fi
  # On Linux we don't sudo-install anything automatically — skip instead.
fi
if [ "$NODE_MAJOR" -ge 20 ] 2>/dev/null; then
  # agentmemory writes its data store relative to the CURRENT directory —
  # run the install from a stable home dir so memories survive restarts.
  mkdir -p "$HOME/.agentmemory" 2>/dev/null || true
  if ( cd "$HOME/.agentmemory" 2>/dev/null && {
        claude plugin marketplace add rohitg00/agentmemory >/dev/null 2>&1 || true
        claude plugin install agentmemory >/dev/null 2>&1 \
          || claude plugin install agentmemory@agentmemory >/dev/null 2>&1
      } ); then
    MEM_OK=1
  fi
fi

if [ "$MEM_OK" -eq 1 ]; then
  ok "Smart memory installed. / Da cai bo nho thong minh."
else
  note "Smart memory skipped - your assistant still remembers everything via files."
  note "Bo qua bo nho thong minh - tro ly van ghi nho day du bang file."
fi

# ---------------------------------------------------------------
# Step 5 — OPTIONAL: Obsidian note app (for the second brain).
# Same rule: automatic, never blocks, friendly skip on failure.
# ---------------------------------------------------------------
step "Step 5/5: Obsidian note app (optional extra)... / Ung dung Obsidian (tuy chon)..."

OBS_OK=0
if [ "$(uname -s)" = "Darwin" ]; then
  if [ -d "/Applications/Obsidian.app" ]; then
    OBS_OK=1
    ok "Obsidian already installed. / Obsidian da co san."
  elif command -v brew >/dev/null 2>&1; then
    brew install --cask obsidian >/dev/null 2>&1 || true
    if [ -d "/Applications/Obsidian.app" ]; then
      OBS_OK=1
      ok "Obsidian installed. / Da cai Obsidian."
    fi
  fi
fi
# On Linux we don't auto-install desktop apps — the vault works as plain files.

if [ "$OBS_OK" -eq 0 ]; then
  note "Obsidian skipped - your notes still work as plain files. Get it anytime at obsidian.md"
  note "Bo qua Obsidian - ghi chu van hoat dong dang file. Tai sau tai obsidian.md"
fi

# ---------------------------------------------------------------
# Done
# ---------------------------------------------------------------
printf '\n\033[32m=====================================================\n'
printf '  DONE! / XONG!\n'
printf '=====================================================\033[0m\n\n'
printf '  NEXT STEPS / BUOC TIEP THEO:\n\n'
printf '  1. Type:  claude        (then press Enter)\n'
printf '     Go:    claude        (roi nhan Enter)\n\n'
printf '  2. Log in when the browser opens.\n'
printf '     (A paid Claude plan - Pro or Max - is required.)\n'
printf '     Dang nhap khi trinh duyet mo ra.\n'
printf '     (Can tai khoan Claude tra phi - Pro hoac Max.)\n\n'

# Referral shown ONLY when no Claude login is detected on this machine.
if [ ! -f "$HOME/.claude/.credentials.json" ] \
   && ! grep -q oauthAccount "$HOME/.claude.json" 2>/dev/null; then
  printf '\033[33m     Dont have a paid Claude plan yet? Start with a free 7-day Pro trial:\n'
  printf '     https://claude.ai/referral/QbA1I722cA\033[0m\n'
  printf '     (referral link - supports this project / link gioi thieu - ung ho du an nay)\n\n'
fi
printf '  3. Type:  /onboard\n'
printf '     to create your own personal AI assistant.\n'
printf '     de tao tro ly AI ca nhan cua rieng ban.\n\n'
