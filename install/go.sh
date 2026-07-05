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
step "Step 1/3: Checking Claude Code... / Kiem tra Claude Code..."

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
step "Step 2/3: Adding the starter marketplace... / Them kho plugin..."

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
step "Step 3/3: Installing the starter plugin... / Cai plugin khoi dong..."

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
printf '  3. Type:  /onboard\n'
printf '     to create your own personal AI assistant.\n'
printf '     de tao tro ly AI ca nhan cua rieng ban.\n\n'
