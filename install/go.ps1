# =====================================================================
#  Claude Code Easy Install — Windows bootstrap
#  Cai dat Claude Code + tro ly AI ca nhan chi voi 1 lenh
#
#  Usage (paste into PowerShell):
#    irm https://raw.githubusercontent.com/supakitkitsathaporn97-collab/claude-easy-install/main/install/go.ps1 | iex
#
#  What this script does / Script nay lam gi:
#    1. Installs Claude Code using Anthropic's OFFICIAL installer
#       (we never re-host their binary — we call https://claude.ai/install.ps1)
#    2. Adds this repo as a plugin marketplace
#    3. Installs the "nick-starter" plugin (the /onboard interview + core skills)
#    4. OPTIONAL EXTRA: tries to add smart memory (Node.js LTS + the open-source
#       agentmemory plugin). If anything fails it is skipped — never blocks.
#    5. OPTIONAL EXTRA: tries to install the free Obsidian note app for your
#       second brain. Also skipped gracefully on any failure.
#
#  Requirements / Yeu cau:
#    - Windows 10 1809+ , internet
#    - A paid Claude plan (Pro/Max/Team) for the login step afterwards
#    - No admin rights needed / Khong can quyen admin
#
#  Safe to re-run at any time. / Chay lai bao nhieu lan cung an toan.
#  PowerShell 5.1 compatible.
# =====================================================================

$ErrorActionPreference = 'Stop'

# The GitHub account that hosts this marketplace.
# Replaced with the real account name at publish time.
$RepoOwner = 'supakitkitsathaporn97-collab'
$MarketplaceRepo = "$RepoOwner/claude-easy-install"
$MarketplaceName = 'claude-easy-install'
$PluginName = 'nick-starter'

function Write-Step($msg) { Write-Host ""; Write-Host "==> $msg" -ForegroundColor Cyan }
function Write-Ok($msg)   { Write-Host "    OK: $msg" -ForegroundColor Green }
function Write-Note($msg) { Write-Host "    $msg" -ForegroundColor Yellow }

Write-Host ""
Write-Host "=====================================================" -ForegroundColor Magenta
Write-Host "  Claude Code Easy Install"                             -ForegroundColor Magenta
Write-Host "  Cai dat Claude Code de dang - chi 1 lenh"             -ForegroundColor Magenta
Write-Host "=====================================================" -ForegroundColor Magenta

# ---------------------------------------------------------------
# Step 1 — Claude Code itself (official Anthropic installer)
# ---------------------------------------------------------------
Write-Step "Step 1/5: Checking Claude Code... / Kiem tra Claude Code..."

function Test-ClaudeInstalled {
    $cmd = Get-Command claude -ErrorAction SilentlyContinue
    if ($null -ne $cmd) { return $true }
    # Fresh installs land here before PATH is refreshed:
    $native = Join-Path $env:USERPROFILE '.local\bin\claude.exe'
    return (Test-Path $native)
}

if (Test-ClaudeInstalled) {
    Write-Ok "Claude Code is already installed. / Claude Code da duoc cai dat."
} else {
    Write-Note "Not found - installing via the official Anthropic installer..."
    Write-Note "Chua co - dang cai dat bang trinh cai dat chinh thuc cua Anthropic..."
    # Official installer. We call it; we do not copy or re-host it.
    Invoke-Expression (Invoke-RestMethod -Uri 'https://claude.ai/install.ps1')
    Write-Ok "Official installer finished. / Trinh cai dat chinh thuc da chay xong."
}

# Refresh PATH for THIS session so `claude` resolves immediately.
$localBin = Join-Path $env:USERPROFILE '.local\bin'
if ($env:Path -notlike "*$localBin*") {
    $env:Path = "$localBin;$env:Path"
}

$claudeCmd = Get-Command claude -ErrorAction SilentlyContinue
if ($null -eq $claudeCmd) {
    Write-Host ""
    Write-Host "  Claude Code was installed but this window cannot see it yet."   -ForegroundColor Red
    Write-Host "  Claude Code da cai xong nhung cua so nay chua nhan ra no."      -ForegroundColor Red
    Write-Host ""
    Write-Host "  FIX / CACH SUA:"
    Write-Host "   1. Close this PowerShell window and open a NEW one."
    Write-Host "      Dong cua so PowerShell nay va mo mot cua so MOI."
    Write-Host "   2. Paste the same install command again - it is safe to re-run."
    Write-Host "      Dan lai dung lenh cai dat do - chay lai hoan toan an toan."
    return
}
Write-Ok ("claude found at: " + $claudeCmd.Source)

# ---------------------------------------------------------------
# Step 2 — Add the plugin marketplace (idempotent)
# ---------------------------------------------------------------
Write-Step "Step 2/5: Adding the starter marketplace... / Them kho plugin..."

# `marketplace add` fails politely if it already exists -> then just update it.
claude plugin marketplace add $MarketplaceRepo 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Ok "Marketplace added. / Da them kho plugin."
} else {
    claude plugin marketplace update $MarketplaceName 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Ok "Marketplace already present - refreshed. / Kho plugin da co san - da cap nhat."
    } else {
        Write-Note "Could not add or update the marketplace. Check your internet connection and that the repo exists:"
        Write-Note "Khong them duoc kho plugin. Kiem tra mang va repo:"
        Write-Note "  https://github.com/$MarketplaceRepo"
        return
    }
}

# ---------------------------------------------------------------
# Step 3 — Install the starter plugin (idempotent)
# ---------------------------------------------------------------
Write-Step "Step 3/5: Installing the starter plugin... / Cai plugin khoi dong..."

claude plugin install "$PluginName@$MarketplaceName" 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Ok "Plugin '$PluginName' installed. / Da cai plugin '$PluginName'."
} else {
    # Most common benign cause: already installed.
    claude plugin update $PluginName 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Ok "Plugin already installed - updated instead. / Plugin da co - da cap nhat."
    } else {
        Write-Note "Plugin install failed. Try manually inside Claude Code:"
        Write-Note "Cai plugin that bai. Thu chay thu cong trong Claude Code:"
        Write-Note "  /plugin install $PluginName@$MarketplaceName"
    }
}

# ---------------------------------------------------------------
# Step 4 — OPTIONAL: smart memory (agentmemory). Fully automatic,
# fully non-blocking: any failure = one friendly line, keep going.
# ---------------------------------------------------------------
Write-Step "Step 4/5: Smart memory (optional extra)... / Bo nho thong minh (tuy chon)..."

$prevEAP = $ErrorActionPreference
$ErrorActionPreference = 'Continue'   # optional extras must never hard-stop
$memOk = $false
try {
    # agentmemory (Apache-2.0, github.com/rohitg00/agentmemory) needs Node 20+.
    function Get-NodeMajor {
        $n = Get-Command node -ErrorAction SilentlyContinue
        if ($null -eq $n) { return 0 }
        try { return [int](((node -v) -replace '^v','') -split '\.')[0] } catch { return 0 }
    }
    $nodeMajor = Get-NodeMajor
    if ($nodeMajor -lt 20) {
        $wingetCmd = Get-Command winget -ErrorAction SilentlyContinue
        if ($null -ne $wingetCmd) {
            Write-Note "Adding Node.js LTS (needed for smart memory)... / Dang cai Node.js LTS..."
            winget install --id OpenJS.NodeJS.LTS -e --silent --accept-package-agreements --accept-source-agreements | Out-Null
            # Make node visible in THIS session.
            $nodeDir = Join-Path $env:ProgramFiles 'nodejs'
            if ((Test-Path $nodeDir) -and ($env:Path -notlike "*$nodeDir*")) {
                $env:Path = "$nodeDir;$env:Path"
            }
            $nodeMajor = Get-NodeMajor
        }
    }
    if ($nodeMajor -ge 20) {
        # agentmemory writes its data store relative to the CURRENT directory —
        # run the install from a stable home dir so memories survive restarts.
        $memHome = Join-Path $env:USERPROFILE '.agentmemory'
        New-Item -ItemType Directory -Force -Path $memHome | Out-Null
        Push-Location $memHome
        try {
            claude plugin marketplace add rohitg00/agentmemory 2>$null
            claude plugin install agentmemory 2>$null
            if ($LASTEXITCODE -eq 0) { $memOk = $true }
            else {
                claude plugin install agentmemory@agentmemory 2>$null
                if ($LASTEXITCODE -eq 0) { $memOk = $true }
            }
        } finally { Pop-Location }
    }
} catch { $memOk = $false }
$ErrorActionPreference = $prevEAP

if ($memOk) {
    Write-Ok "Smart memory installed. / Da cai bo nho thong minh."
} else {
    Write-Note "Smart memory skipped - your assistant still remembers everything via files."
    Write-Note "Bo qua bo nho thong minh - tro ly van ghi nho day du bang file."
}

# ---------------------------------------------------------------
# Step 5 — OPTIONAL: Obsidian note app (for the second brain).
# Same rule: automatic, never blocks, friendly skip on failure.
# ---------------------------------------------------------------
Write-Step "Step 5/5: Obsidian note app (optional extra)... / Ung dung ghi chu Obsidian (tuy chon)..."

$prevEAP = $ErrorActionPreference
$ErrorActionPreference = 'Continue'
$obsOk = $false
try {
    $obsExe = Join-Path $env:LOCALAPPDATA 'Programs\Obsidian\Obsidian.exe'
    if (Test-Path $obsExe) {
        $obsOk = $true
        Write-Ok "Obsidian already installed. / Obsidian da co san."
    } else {
        $wingetCmd = Get-Command winget -ErrorAction SilentlyContinue
        if ($null -ne $wingetCmd) {
            winget install --id Obsidian.Obsidian -e --silent --accept-package-agreements --accept-source-agreements | Out-Null
            if (Test-Path $obsExe) {
                $obsOk = $true
                Write-Ok "Obsidian installed. / Da cai Obsidian."
            }
        }
    }
} catch { $obsOk = $false }
$ErrorActionPreference = $prevEAP

if (-not $obsOk) {
    Write-Note "Obsidian skipped - your notes still work as plain files. Get it anytime at obsidian.md"
    Write-Note "Bo qua Obsidian - ghi chu van hoat dong dang file. Tai sau tai obsidian.md"
}

# ---------------------------------------------------------------
# Done — tell the user the 3 human steps that remain
# ---------------------------------------------------------------
Write-Host ""
Write-Host "=====================================================" -ForegroundColor Green
Write-Host "  DONE! / XONG!"                                        -ForegroundColor Green
Write-Host "=====================================================" -ForegroundColor Green
Write-Host ""
Write-Host "  NEXT STEPS / BUOC TIEP THEO:" -ForegroundColor Cyan
Write-Host ""
Write-Host "  1. Type:  claude        (then press Enter)"
Write-Host "     Go:    claude        (roi nhan Enter)"
Write-Host ""
Write-Host "  2. Log in when the browser opens."
Write-Host "     (A paid Claude plan - Pro or Max - is required.)"
Write-Host "     Dang nhap khi trinh duyet mo ra."
Write-Host "     (Can tai khoan Claude tra phi - Pro hoac Max.)"
Write-Host ""

# Referral shown ONLY when no Claude login is detected on this machine.
$claudeCreds = Join-Path $env:USERPROFILE '.claude\.credentials.json'
if (-not (Test-Path $claudeCreds)) {
    Write-Host "     Don't have a paid Claude plan yet? Start with a free 7-day Pro trial:" -ForegroundColor Yellow
    Write-Host "     https://claude.ai/referral/QbA1I722cA" -ForegroundColor Yellow
    Write-Host "     (referral link - supports this project / link gioi thieu - ung ho du an nay)"
    Write-Host ""
}
Write-Host "  3. Type:  /onboard"
Write-Host "     to create your own personal AI assistant."
Write-Host "     de tao tro ly AI ca nhan cua rieng ban."
Write-Host ""
Write-Host "  Tip: if `claude` is not recognized in a new window, log out"
Write-Host "  and back in to Windows once so PATH refreshes."
Write-Host "  Meo: neu cua so moi khong nhan lenh `claude`, dang xuat"
Write-Host "  Windows roi dang nhap lai mot lan de PATH cap nhat."
Write-Host ""
