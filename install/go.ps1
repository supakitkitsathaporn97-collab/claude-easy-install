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
Write-Step "Step 1/3: Checking Claude Code... / Kiem tra Claude Code..."

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
Write-Step "Step 2/3: Adding the starter marketplace... / Them kho plugin..."

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
Write-Step "Step 3/3: Installing the starter plugin... / Cai plugin khoi dong..."

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
Write-Host "  3. Type:  /onboard"
Write-Host "     to create your own personal AI assistant."
Write-Host "     de tao tro ly AI ca nhan cua rieng ban."
Write-Host ""
Write-Host "  Tip: if `claude` is not recognized in a new window, log out"
Write-Host "  and back in to Windows once so PATH refreshes."
Write-Host "  Meo: neu cua so moi khong nhan lenh `claude`, dang xuat"
Write-Host "  Windows roi dang nhap lai mot lan de PATH cap nhat."
Write-Host ""
