#!/usr/bin/env bash
# =====================================================================
#  SoulDrop — macOS / Linux bootstrap
#  Drop a soul into any machine — your personal AI assistant, fully automatic.
#  Tha mot linh hon vao bat ky may nao — tro ly AI ca nhan, tu dong hoan toan.
#
#  Usage:
#    curl -fsSL https://raw.githubusercontent.com/kkitkai/souldrop/main/install/go.sh | bash
#
#  What it does / Script nay lam gi:
#    1. Detects the best AI engine for you — automatically:
#       - Claude Code already installed?  -> Pro engine (best, needs a paid plan)
#       - Otherwise ONE question: Free (runs on your computer, no account)
#         or Pro (smarter, needs a Claude subscription).
#    2. PRO  = installs Claude Code via Anthropic's OFFICIAL installer
#       (we call https://claude.ai/install.sh — never re-host it), adds this
#       repo as a plugin marketplace, installs the "souldrop" plugin
#       (/onboard interview + core skills), plus optional non-blocking extras.
#    3. FREE = installs Ollama via its official channel (Homebrew / official
#       install.sh), picks an AI model sized to your RAM, downloads it, and
#       installs the `souldrop` chat launcher.
#
#  Requirements: macOS 13+ / Ubuntu 20.04+, internet.
#  PRO only: a paid Claude plan (Pro/Max) for the login step afterwards.
#  Safe to re-run. / Chay lai bao nhieu lan cung an toan.
# =====================================================================
set -u

REPO_OWNER="kkitkai"
MARKETPLACE_REPO="$REPO_OWNER/souldrop"
MARKETPLACE_NAME="souldrop"
PLUGIN_NAME="souldrop"
RAW_BASE="https://raw.githubusercontent.com/$REPO_OWNER/souldrop/main"
REFERRAL_URL="https://claude.ai/referral/QbA1I722cA"

step() { printf '\n\033[36m==> %s\033[0m\n' "$1"; }
ok()   { printf '\033[32m    OK: %s\033[0m\n' "$1"; }
note() { printf '\033[33m    %s\033[0m\n' "$1"; }

printf '\n\033[35m=====================================================\n'
printf '  SoulDrop\n'
printf '  Drop a soul into any machine.\n'
printf '  Tha mot linh hon vao bat ky may nao.\n'
printf '=====================================================\033[0m\n'

claude_installed() {
  command -v claude >/dev/null 2>&1 || [ -x "$HOME/.local/bin/claude" ]
}

referral_line() {
  printf '\033[33m     Dont have a paid Claude plan yet? Start with a free 7-day Pro trial:\n'
  printf '     %s\033[0m\n' "$REFERRAL_URL"
  printf '     (referral link - supports this project / link gioi thieu - ung ho du an nay)\n\n'
}

# =====================================================================
#  PRO ENGINE — Claude Code (the richest tier: skills + auto-forge)
# =====================================================================
install_claude_engine() {

  # ---------------------------------------------------------------
  # Step 1 — Claude Code itself (official Anthropic installer)
  # ---------------------------------------------------------------
  step "Step 1/5: Checking Claude Code... / Kiem tra Claude Code..."

  if claude_installed; then
    ok "Claude Code is already installed. / Claude Code da duoc cai dat."
  else
    note "Not found - installing via the official Anthropic installer..."
    note "Chua co - dang cai bang trinh cai dat chinh thuc cua Anthropic..."
    # Official installer. We call it; we do not copy or re-host it.
    # Only report success if it actually succeeded (v0.4.1 bug: we used to
    # print OK even when the installer failed).
    if curl -fsSL https://claude.ai/install.sh | bash; then
      ok "Official installer finished. / Trinh cai dat chinh thuc da chay xong."
    else
      note "The official installer did not finish. It can fail on low memory (it needs ~512 MB free RAM)."
      note "Trinh cai dat chua xong - co the thieu RAM (can ~512MB trong). Mo terminal MOI va chay lai lenh cai dat."
    fi
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
  step "Step 2/5: Adding the SoulDrop marketplace... / Them kho plugin SoulDrop..."

  # `marketplace add` clones this repo with git — beginners should never have
  # to install git themselves. Auto-install where we safely can; never block.
  have_git() {
    # On macOS a git *stub* exists even without Command Line Tools and pops a
    # GUI dialog when called — only count git as real if CLT is installed.
    command -v git >/dev/null 2>&1 || return 1
    [ "$(uname -s)" != "Darwin" ] || xcode-select -p >/dev/null 2>&1
  }
  if ! have_git; then
    note "Adding a small helper tool (git - needed to fetch the plugin)... / Dang cai mot cong cu nho (git - can de tai plugin)..."
    if [ "$(uname -s)" = "Darwin" ]; then
      if command -v brew >/dev/null 2>&1; then
        brew install git >/dev/null 2>&1 || true
      else
        # No Homebrew: ask Apple's Command Line Tools installer (GUI dialog).
        xcode-select --install >/dev/null 2>&1 || true
        note "If a macOS dialog appeared, click Install, wait for it, then re-run this command."
        note "Neu macOS hien hop thoai, bam Install, doi xong, roi chay lai lenh nay."
      fi
    else
      # Linux: we never sudo-install automatically — one friendly hint instead.
      note "Please run:  sudo apt-get install -y git   (then re-run this command)"
      note "Hay chay:    sudo apt-get install -y git   (roi chay lai lenh nay)"
    fi
  fi

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
  # Step 3 — Install the SoulDrop plugin (idempotent)
  # ---------------------------------------------------------------
  step "Step 3/5: Installing the SoulDrop plugin... / Cai plugin SoulDrop..."

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
    referral_line
  fi
  printf '  3. Type:  /onboard\n'
  printf '     to create your own personal AI assistant.\n'
  printf '     de tao tro ly AI ca nhan cua rieng ban.\n\n'
}

# =====================================================================
#  FREE ENGINE — Ollama (local, no account, runs on your own computer)
# =====================================================================
install_ollama_engine() {

  free_fallback() {
    note "$1"
    note "You can always use the Pro engine instead (smarter, needs a Claude plan):"
    note "Ban van co the dung ban Pro (thong minh hon, can tai khoan Claude):"
    note "  Re-run this installer and choose 2. / Chay lai trinh cai dat va chon 2."
    referral_line
  }

  # ---------------------------------------------------------------
  # Step 1 — Ollama itself (official channels only)
  # ---------------------------------------------------------------
  step "Step 1/4: Checking the free AI engine (Ollama)... / Kiem tra dong co AI mien phi (Ollama)..."

  if command -v ollama >/dev/null 2>&1; then
    ok "Ollama is already installed. / Ollama da duoc cai dat."
  else
    OS_NAME="$(uname -s)"
    if [ "$OS_NAME" = "Darwin" ] && command -v brew >/dev/null 2>&1; then
      note "Installing Ollama via Homebrew... / Dang cai Ollama qua Homebrew..."
      brew install ollama >/dev/null 2>&1 || true
    elif [ "$OS_NAME" = "Linux" ]; then
      note "Installing Ollama via its official installer... / Dang cai Ollama (trinh cai chinh thuc)..."
      # Official installer from ollama.com — we call it, never re-host it.
      curl -fsSL https://ollama.com/install.sh | sh || true
    fi
    if ! command -v ollama >/dev/null 2>&1; then
      free_fallback "Could not auto-install Ollama. Get it manually at ollama.com/download. / Khong tu cai duoc Ollama. Tai thu cong tai ollama.com/download."
      return 0
    fi
    ok "Ollama installed. / Da cai Ollama."
  fi

  # ---------------------------------------------------------------
  # Step 2 — Pick an AI model sized to this computer's RAM
  # ---------------------------------------------------------------
  step "Step 2/4: Choosing the right AI brain for this computer... / Chon bo nao AI phu hop voi may..."

  RAM_GB=8
  if [ "$(uname -s)" = "Darwin" ]; then
    RAM_GB="$(( $(sysctl -n hw.memsize 2>/dev/null || echo 8589934592) / 1073741824 ))"
  elif [ -r /proc/meminfo ]; then
    RAM_GB="$(awk '/MemTotal/{printf "%d", $2/1048576}' /proc/meminfo 2>/dev/null || echo 8)"
  fi

  if [ "$RAM_GB" -ge 16 ] 2>/dev/null; then
    MODEL="llama3.1:8b";  MODEL_NOTE="a strong all-round model (~4.9 GB download)"
  elif [ "$RAM_GB" -ge 8 ] 2>/dev/null; then
    MODEL="llama3.2:3b";  MODEL_NOTE="a good lightweight model (~2 GB download)"
  else
    MODEL="llama3.2:1b";  MODEL_NOTE="the smallest usable model (~1.3 GB). Honest note: it is basic - fine for simple chat, not for hard tasks."
  fi
  ok "This computer has ${RAM_GB} GB RAM -> model: $MODEL"
  note "$MODEL_NOTE"

  # ---------------------------------------------------------------
  # Step 3 — Start the engine and download the model (one time)
  # ---------------------------------------------------------------
  step "Step 3/4: Downloading your AI brain (one time only)... / Dang tai bo nao AI (chi mot lan)..."

  if ! curl -fsS --max-time 3 http://127.0.0.1:11434/api/version >/dev/null 2>&1; then
    nohup ollama serve >/dev/null 2>&1 &
    i=0
    while [ "$i" -lt 30 ]; do
      sleep 1
      if curl -fsS --max-time 2 http://127.0.0.1:11434/api/version >/dev/null 2>&1; then break; fi
      i=$((i + 1))
    done
  fi
  if ! curl -fsS --max-time 3 http://127.0.0.1:11434/api/version >/dev/null 2>&1; then
    free_fallback "The Ollama engine did not start. Try again in a new terminal. / Ollama chua khoi dong duoc. Thu lai trong terminal moi."
    return 0
  fi

  # Pull the model (ollama prints its own progress — let it show).
  if ! ollama pull "$MODEL"; then
    free_fallback "Model download failed (internet or disk space). Re-run to resume. / Tai model that bai (mang hoac o dia day). Chay lai de tiep tuc."
    return 0
  fi
  ok "AI brain ready. / Bo nao AI da san sang."

  # ---------------------------------------------------------------
  # Step 4 — Install the `souldrop` chat launcher
  # ---------------------------------------------------------------
  step "Step 4/4: Installing the SoulDrop launcher... / Cai trinh khoi dong SoulDrop..."

  SD_HOME="$HOME/.souldrop"
  mkdir -p "$SD_HOME" "$HOME/.local/bin"

  if ! curl -fsSL "$RAW_BASE/adapters/ollama/souldrop.sh" -o "$SD_HOME/souldrop.sh"; then
    free_fallback "Could not download the SoulDrop launcher (check internet). / Khong tai duoc trinh khoi dong SoulDrop (kiem tra mang)."
    return 0
  fi
  chmod +x "$SD_HOME/souldrop.sh"

  # Engine config the launcher reads (plain key=value — no parsing surprises).
  {
    echo "engine=ollama"
    echo "model=$MODEL"
  } > "$SD_HOME/config.txt"

  # `souldrop` command on PATH.
  ln -sf "$SD_HOME/souldrop.sh" "$HOME/.local/bin/souldrop"
  case ":$PATH:" in
    *":$HOME/.local/bin:"*) : ;;
    *)
      note "Adding ~/.local/bin to your PATH for future terminals..."
      for rc in "$HOME/.bashrc" "$HOME/.zshrc"; do
        if [ -f "$rc" ] && ! grep -q '\.local/bin' "$rc" 2>/dev/null; then
          printf '\nexport PATH="$HOME/.local/bin:$PATH"\n' >> "$rc"
        fi
      done
      PATH="$HOME/.local/bin:$PATH"; export PATH
      ;;
  esac

  # ---------------------------------------------------------------
  # Done
  # ---------------------------------------------------------------
  printf '\n\033[32m=====================================================\n'
  printf '  DONE! / XONG!\n'
  printf '=====================================================\033[0m\n\n'
  printf '  NEXT STEP / BUOC TIEP THEO:\n\n'
  printf '  Open a NEW terminal and type:  souldrop\n'
  printf '  Mo terminal MOI va go:         souldrop\n\n'
  printf '  Your assistant will introduce itself and ask a few friendly\n'
  printf '  questions (your name, your work, its name...) - no tech talk.\n'
  printf '  Tro ly se tu gioi thieu va hoi vai cau than thien\n'
  printf '  (ten ban, cong viec, ten cua no...) - khong hoi ky thuat.\n\n'
  printf '\033[32m  Everything runs on YOUR computer. No account. No cost.\n'
  printf '  Moi thu chay tren MAY CUA BAN. Khong tai khoan. Khong ton phi.\033[0m\n\n'
  printf '  Want a smarter assistant later? The Pro engine (Claude) is one re-run away:\n'
  printf '  Muon tro ly thong minh hon? Ban Pro (Claude) chi can chay lai installer:\n'
  printf '  %s  (free 7-day trial - referral link)\n\n' "$REFERRAL_URL"
}

# =====================================================================
#  ENGINE AUTO-DETECT — the only human decision in the whole install
# =====================================================================

if claude_installed; then
  # Claude Code already on this machine -> best engine, zero questions.
  printf '\n\033[32m  Claude Code detected - using the Pro engine. / Da co Claude Code - dung ban Pro.\033[0m\n'
  install_claude_engine
else
  printf '\n\033[36m  ONE question / MOT cau hoi duy nhat:\033[0m\n\n'
  printf '   [1] FREE - runs on your computer, no account, no cost\n'
  printf '       MIEN PHI - chay tren may cua ban, khong can tai khoan, khong ton phi\n\n'
  printf '   [2] PRO  - smarter (Claude), needs a paid Claude subscription\n'
  printf '       PRO  - thong minh hon (Claude), can tai khoan Claude tra phi\n\n'
  # When piped via `curl | bash`, stdin is the script — read from the terminal.
  ENGINE_CHOICE=""
  if [ -r /dev/tty ]; then
    printf '  Type 1 or 2 / Go 1 hoac 2 (Enter = 1): '
    # No usable tty (CI, some containers): stay quiet and default to Free.
    read -r ENGINE_CHOICE < /dev/tty 2>/dev/null || ENGINE_CHOICE=""
  fi
  if [ "$(printf '%s' "$ENGINE_CHOICE" | tr -d '[:space:]')" = "2" ]; then
    install_claude_engine
  else
    install_ollama_engine
  fi
fi
