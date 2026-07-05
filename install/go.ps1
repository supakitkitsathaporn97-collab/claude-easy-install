# =====================================================================
#  SoulDrop - Windows bootstrap
#  Drop a soul into any machine - your personal AI assistant, fully automatic.
#  Tha mot linh hon vao bat ky may nao - tro ly AI ca nhan, tu dong hoan toan.
#
#  Usage (paste into PowerShell):
#    irm https://raw.githubusercontent.com/kkitkai/souldrop/main/install/go.ps1 | iex
#
#  What this script does / Script nay lam gi:
#    1. Detects the best AI engine for you - automatically:
#       - Claude Code already installed?  -> Pro engine (best, needs a paid plan)
#       - Otherwise ONE question: Free (runs on your computer, no account)
#         or Pro (smarter, needs a Claude subscription). That is the only
#         question - everything technical is automatic.
#    2. PRO  = installs Claude Code via Anthropic's OFFICIAL installer
#       (we never re-host their binary - we call https://claude.ai/install.ps1),
#       adds this repo as a plugin marketplace, installs the "souldrop" plugin
#       (/onboard interview + core skills), plus optional extras (documents
#       pack, browsing, smart memory, Obsidian) that never block on failure.
#    3. FREE = installs Ollama via its official winget package, picks an AI
#       model sized to your computer's RAM, downloads it, and installs the
#       `souldrop` chat launcher (Desktop shortcut + terminal command).
#
#  Requirements / Yeu cau:
#    - Windows 10 1809+ , internet
#    - PRO only: a paid Claude plan (Pro/Max/Team) for the login step
#    - No admin rights needed / Khong can quyen admin
#
#  Safe to re-run at any time. / Chay lai bao nhieu lan cung an toan.
#  PowerShell 5.1 compatible.
# =====================================================================

$ErrorActionPreference = 'Stop'

# The GitHub account that hosts this marketplace.
$RepoOwner       = 'kkitkai'
$MarketplaceRepo = "$RepoOwner/souldrop"
$MarketplaceName = 'souldrop'
$PluginName      = 'souldrop'
$RawBase         = "https://raw.githubusercontent.com/$RepoOwner/souldrop/main"
$ReferralUrl     = 'https://claude.ai/referral/QbA1I722cA'

function Write-Step($msg) { Write-Host ""; Write-Host "==> $msg" -ForegroundColor Cyan }
function Write-Ok($msg)   { Write-Host "    OK: $msg" -ForegroundColor Green }
function Write-Note($msg) { Write-Host "    $msg" -ForegroundColor Yellow }

Write-Host ""
Write-Host "=====================================================" -ForegroundColor Magenta
Write-Host "  SoulDrop"                                            -ForegroundColor Magenta
Write-Host "  Drop a soul into any machine."                       -ForegroundColor Magenta
Write-Host "  Tha mot linh hon vao bat ky may nao."                -ForegroundColor Magenta
Write-Host "=====================================================" -ForegroundColor Magenta

function Test-ClaudeInstalled {
    $cmd = Get-Command claude -ErrorAction SilentlyContinue
    if ($null -ne $cmd) { return $true }
    # Fresh installs land here before PATH is refreshed:
    $native = Join-Path $env:USERPROFILE '.local\bin\claude.exe'
    return (Test-Path $native)
}

function Get-NodeMajor {
    $n = Get-Command node -ErrorAction SilentlyContinue
    if ($null -eq $n) { return 0 }
    try { return [int](((node -v) -replace '^v','') -split '\.')[0] } catch { return 0 }
}

# Node 20+ powers two optional extras (browsing + smart memory). Install it
# once via winget when missing; return the major version either way.
function Ensure-NodeLts {
    $nodeMajor = Get-NodeMajor
    if ($nodeMajor -lt 20) {
        $wingetCmd = Get-Command winget -ErrorAction SilentlyContinue
        if ($null -ne $wingetCmd) {
            Write-Note "Adding Node.js LTS (a helper tool)... / Dang cai Node.js LTS (cong cu ho tro)..."
            try {
                winget install --id OpenJS.NodeJS.LTS -e --silent --accept-package-agreements --accept-source-agreements | Out-Null
            } catch { }
            # Make node visible in THIS session.
            $nodeDir = Join-Path $env:ProgramFiles 'nodejs'
            if ((Test-Path $nodeDir) -and ($env:Path -notlike "*$nodeDir*")) {
                $env:Path = "$nodeDir;$env:Path"
            }
            $nodeMajor = Get-NodeMajor
        }
    }
    return $nodeMajor
}

# chrome-devtools drives the user's REAL Chrome - it never downloads one.
# So we only offer it when Chrome is actually installed.
function Test-ChromeInstalled {
    foreach ($hive in 'HKLM:', 'HKCU:') {
        if (Test-Path "$hive\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe") { return $true }
    }
    foreach ($d in @($env:ProgramFiles, ${env:ProgramFiles(x86)}, $env:LOCALAPPDATA)) {
        if ($d -and (Test-Path (Join-Path $d 'Google\Chrome\Application\chrome.exe'))) { return $true }
    }
    return $false
}

function Show-ReferralLine {
    Write-Host ""
    Write-Host "     Don't have a paid Claude plan yet? Start with a free 7-day Pro trial:" -ForegroundColor Yellow
    Write-Host "     $ReferralUrl" -ForegroundColor Yellow
    Write-Host "     (referral link - supports this project / link gioi thieu - ung ho du an nay)"
    Write-Host ""
}

# =====================================================================
#  PRO ENGINE - Claude Code (the richest tier: skills + auto-forge)
# =====================================================================
function Install-ClaudeEngine {

    # ---------------------------------------------------------------
    # Step 1 - Claude Code itself (official Anthropic installer)
    # ---------------------------------------------------------------
    Write-Step "Step 1/6: Checking Claude Code... / Kiem tra Claude Code..."

    if (Test-ClaudeInstalled) {
        Write-Ok "Claude Code is already installed. / Claude Code da duoc cai dat."
    } else {
        Write-Note "Not found - installing via the official Anthropic installer..."
        Write-Note "Chua co - dang cai dat bang trinh cai dat chinh thuc cua Anthropic..."
        # Official installer. We call it; we do not copy or re-host it.
        # Only report success if it actually succeeded (v0.4.1 bug: we used to
        # print OK even when the installer failed).
        $installerFailed = $false
        try {
            Invoke-Expression (Invoke-RestMethod -Uri 'https://claude.ai/install.ps1')
            if ($LASTEXITCODE -is [int] -and $LASTEXITCODE -ne 0) { $installerFailed = $true }
        } catch { $installerFailed = $true }
        if ((-not $installerFailed) -and (Test-ClaudeInstalled)) {
            Write-Ok "Official installer finished. / Trinh cai dat chinh thuc da chay xong."
        } else {
            Write-Note "The official installer did not finish. It can fail on low memory (it needs ~512 MB free RAM)."
            Write-Note "Trinh cai dat chua xong - co the thieu RAM (can ~512MB trong). Mo mot terminal MOI va chay lai lenh cai dat."
        }
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
    # Step 2 - Add the plugin marketplace (idempotent)
    # ---------------------------------------------------------------
    Write-Step "Step 2/6: Adding the SoulDrop marketplace... / Them kho plugin SoulDrop..."

    # `marketplace add` clones this repo with git - many fresh Windows machines
    # don't have git, and beginners should never have to install it themselves.
    # Auto-install silently; never block on failure (same rule as the extras).
    $gitCmd = Get-Command git -ErrorAction SilentlyContinue
    if ($null -eq $gitCmd) {
        $gitExe = Join-Path $env:ProgramFiles 'Git\cmd\git.exe'
        if (-not (Test-Path $gitExe)) {
            $wingetCmd = Get-Command winget -ErrorAction SilentlyContinue
            if ($null -ne $wingetCmd) {
                Write-Note "Adding a small helper tool (git - needed to fetch the plugin)... / Dang cai mot cong cu nho (git - can de tai plugin)..."
                $prevGitEAP = $ErrorActionPreference
                $ErrorActionPreference = 'Continue'
                try {
                    winget install --id Git.Git -e --silent --accept-package-agreements --accept-source-agreements | Out-Null
                } catch { }
                $ErrorActionPreference = $prevGitEAP
            }
        }
        # Make git visible in THIS session (fresh installs land in Program Files).
        $gitDir = Join-Path $env:ProgramFiles 'Git\cmd'
        if ((Test-Path $gitDir) -and ($env:Path -notlike "*$gitDir*")) {
            $env:Path = "$gitDir;$env:Path"
        }
    }

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
    # Step 3 - Install the SoulDrop plugin (idempotent)
    # ---------------------------------------------------------------
    Write-Step "Step 3/6: Installing the SoulDrop plugin... / Cai plugin SoulDrop..."

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
    # Step 4 - OPTIONAL: everyday superpowers (documents + browsing).
    # Fully automatic, fully non-blocking: any failure = one friendly
    # line, keep going. The user never installs anything themselves.
    # ---------------------------------------------------------------
    Write-Step "Step 4/6: Everyday superpowers (documents + browsing)... / Sieu nang luc hang ngay (tai lieu + luot web)..."

    $prevEAP = $ErrorActionPreference
    $ErrorActionPreference = 'Continue'   # optional extras must never hard-stop

    # 4a. Anthropic document skills - real Word/Excel/PowerPoint/PDF files.
    # Installed from Anthropic's OWN marketplace, never vendored (their
    # document skills are source-available; install-only is the legal path).
    $docsOk = $false
    try {
        claude plugin marketplace add anthropics/skills 2>$null
        if ($LASTEXITCODE -ne 0) { claude plugin marketplace update anthropic-agent-skills 2>$null }
        claude plugin install document-skills@anthropic-agent-skills 2>$null
        if ($LASTEXITCODE -eq 0) { $docsOk = $true }
        else {
            claude plugin update document-skills 2>$null
            if ($LASTEXITCODE -eq 0) { $docsOk = $true }
        }
        # Creative extras (posters/graphics, incl. canvas-design; Apache-2.0).
        claude plugin install example-skills@anthropic-agent-skills 2>$null
        if ($LASTEXITCODE -ne 0) { claude plugin update example-skills 2>$null }
    } catch { $docsOk = $false }
    if ($docsOk) {
        Write-Ok "Documents pack ready - your assistant can make real Word/Excel/PowerPoint/PDF files."
        Write-Ok "Goi tai lieu san sang - tro ly lam duoc file Word/Excel/PowerPoint/PDF that."
    } else {
        Write-Note "Documents pack skipped - your assistant still reads PDFs and writes text just fine."
        Write-Note "Bo qua goi tai lieu - tro ly van doc PDF va viet van ban binh thuong."
    }

    # 4b. Browsing power (chrome-devtools MCP, by Google - no account, no
    # key). Only when Chrome is already installed; needs Node 20+ (npx).
    $chromeOk = $false
    if (Test-ChromeInstalled) {
        try {
            # Already registered on a previous run? Then we're done.
            claude mcp get chrome-devtools 2>$null | Out-Null
            if ($LASTEXITCODE -eq 0) {
                $chromeOk = $true
            } elseif ((Ensure-NodeLts) -ge 20) {
                claude mcp add chrome-devtools --scope user -- npx chrome-devtools-mcp@latest 2>$null
                if ($LASTEXITCODE -eq 0) { $chromeOk = $true }
            }
        } catch { $chromeOk = $false }
        if ($chromeOk) {
            Write-Ok "Browsing ready - your assistant can use Chrome with you (only when you ask)."
            Write-Ok "Luot web san sang - tro ly dung duoc Chrome cung ban (chi khi ban yeu cau)."
        } else {
            Write-Note "Browsing power skipped - everything else still works. / Bo qua luot web - moi thu khac van chay."
        }
    } else {
        Write-Note "Chrome not found - skipped browsing power. Install Chrome anytime to unlock it."
        Write-Note "Khong thay Chrome - bo qua luot web. Cai Chrome bat cu luc nao de mo khoa."
    }
    $ErrorActionPreference = $prevEAP

    # ---------------------------------------------------------------
    # Step 5 - OPTIONAL: smart memory (agentmemory). Fully automatic,
    # fully non-blocking: any failure = one friendly line, keep going.
    # ---------------------------------------------------------------
    Write-Step "Step 5/6: Smart memory (optional extra)... / Bo nho thong minh (tuy chon)..."

    $prevEAP = $ErrorActionPreference
    $ErrorActionPreference = 'Continue'   # optional extras must never hard-stop
    $memOk = $false
    try {
        # agentmemory (Apache-2.0, github.com/rohitg00/agentmemory) needs Node 20+.
        if ((Ensure-NodeLts) -ge 20) {
            # agentmemory writes its data store relative to the CURRENT directory -
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
    # Step 6 - OPTIONAL: Obsidian note app (for the second brain).
    # Same rule: automatic, never blocks, friendly skip on failure.
    # ---------------------------------------------------------------
    Write-Step "Step 6/6: Obsidian note app (optional extra)... / Ung dung ghi chu Obsidian (tuy chon)..."

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
    # Done - tell the user the 3 human steps that remain
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
        Show-ReferralLine
    }
    Write-Host "  3. Type:  /onboard"
    Write-Host "     to create your own personal AI assistant."
    Write-Host "     de tao tro ly AI ca nhan cua rieng ban."
    Write-Host ""
    Write-Host "  Then try: drop a PDF on it, or say 'make me an Excel file' - it can." -ForegroundColor Green
    Write-Host "  Sau do thu: gui file PDF cho no, hoac noi 'lam cho toi file Excel' - no lam duoc." -ForegroundColor Green
    Write-Host ""
    Write-Host "  Tip: if `claude` is not recognized in a new window, log out"
    Write-Host "  and back in to Windows once so PATH refreshes."
    Write-Host "  Meo: neu cua so moi khong nhan lenh `claude`, dang xuat"
    Write-Host "  Windows roi dang nhap lai mot lan de PATH cap nhat."
    Write-Host ""
}

# =====================================================================
#  FREE ENGINE - Ollama (local, no account, runs on your own computer)
# =====================================================================
function Install-OllamaEngine {

    # Any failure on this path = friendly line + pointer to the Pro path.
    function Show-FreeFallback($what) {
        Write-Note $what
        Write-Note "You can always use the Pro engine instead (smarter, needs a Claude plan):"
        Write-Note "Ban van co the dung ban Pro (thong minh hon, can tai khoan Claude):"
        Write-Note "  Re-run this installer and choose 2. / Chay lai trinh cai dat va chon 2."
        Show-ReferralLine
    }

    # ---------------------------------------------------------------
    # Step 1 - Ollama itself (official winget package)
    # ---------------------------------------------------------------
    Write-Step "Step 1/4: Checking the free AI engine (Ollama)... / Kiem tra dong co AI mien phi (Ollama)..."

    function Find-Ollama {
        $cmd = Get-Command ollama -ErrorAction SilentlyContinue
        if ($null -ne $cmd) { return $cmd.Source }
        $exe = Join-Path $env:LOCALAPPDATA 'Programs\Ollama\ollama.exe'
        if (Test-Path $exe) { return $exe }
        return $null
    }

    $ollamaExe = Find-Ollama
    if ($null -ne $ollamaExe) {
        Write-Ok "Ollama is already installed. / Ollama da duoc cai dat."
    } else {
        $wingetCmd = Get-Command winget -ErrorAction SilentlyContinue
        if ($null -eq $wingetCmd) {
            Show-FreeFallback "winget is not available on this Windows - cannot auto-install Ollama. Get it manually at ollama.com. / May nay khong co winget - tai Ollama thu cong tai ollama.com."
            return
        }
        Write-Note "Installing Ollama (official package)... / Dang cai Ollama (goi chinh thuc)..."
        winget install --id Ollama.Ollama -e --silent --accept-package-agreements --accept-source-agreements | Out-Null
        $ollamaExe = Find-Ollama
        if ($null -eq $ollamaExe) {
            Show-FreeFallback "Ollama install did not complete. / Cai Ollama chua thanh cong."
            return
        }
        Write-Ok "Ollama installed. / Da cai Ollama."
    }
    # Make ollama visible in THIS session.
    $ollamaDir = Split-Path $ollamaExe -Parent
    if ($env:Path -notlike "*$ollamaDir*") { $env:Path = "$ollamaDir;$env:Path" }

    # ---------------------------------------------------------------
    # Step 2 - Pick an AI model sized to this computer's RAM
    # ---------------------------------------------------------------
    Write-Step "Step 2/4: Choosing the right AI brain for this computer... / Chon bo nao AI phu hop voi may..."

    $ramGb = 8
    try {
        $ramGb = [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB)
    } catch { }

    if ($ramGb -ge 16) {
        $Model = 'llama3.1:8b';  $ModelNote = "a strong all-round model (~4.9 GB download)"
    } elseif ($ramGb -ge 8) {
        $Model = 'llama3.2:3b';  $ModelNote = "a good lightweight model (~2 GB download)"
    } else {
        $Model = 'llama3.2:1b';  $ModelNote = "the smallest usable model (~1.3 GB). Honest note: it is basic - fine for simple chat, not for hard tasks."
    }
    Write-Ok "This computer has ${ramGb} GB RAM -> model: $Model"
    Write-Note $ModelNote

    # ---------------------------------------------------------------
    # Step 3 - Start the engine and download the model (one time)
    # ---------------------------------------------------------------
    Write-Step "Step 3/4: Downloading your AI brain (one time only)... / Dang tai bo nao AI (chi mot lan)..."

    # Make sure the Ollama server is running.
    $serverUp = $false
    try {
        Invoke-RestMethod -Uri 'http://127.0.0.1:11434/api/version' -TimeoutSec 3 | Out-Null
        $serverUp = $true
    } catch { }
    if (-not $serverUp) {
        try {
            Start-Process -FilePath $ollamaExe -ArgumentList 'serve' -WindowStyle Hidden
        } catch { }
        # Wait up to ~30s for the API to come up.
        for ($i = 0; $i -lt 30; $i++) {
            Start-Sleep -Seconds 1
            try {
                Invoke-RestMethod -Uri 'http://127.0.0.1:11434/api/version' -TimeoutSec 2 | Out-Null
                $serverUp = $true; break
            } catch { }
        }
    }
    if (-not $serverUp) {
        Show-FreeFallback "The Ollama engine did not start. Try restarting Windows, then re-run this installer. / Ollama chua khoi dong duoc. Khoi dong lai Windows roi chay lai."
        return
    }

    # Pull the model (ollama prints its own progress bar - let it show).
    & $ollamaExe pull $Model
    if ($LASTEXITCODE -ne 0) {
        Show-FreeFallback "Model download failed (internet or disk space). Re-run to resume. / Tai model that bai (mang hoac o dia day). Chay lai de tiep tuc."
        return
    }
    Write-Ok "AI brain ready. / Bo nao AI da san sang."

    # ---------------------------------------------------------------
    # Step 4 - Install the `souldrop` chat launcher
    # ---------------------------------------------------------------
    Write-Step "Step 4/4: Installing the SoulDrop launcher... / Cai trinh khoi dong SoulDrop..."

    $sdHome = Join-Path $env:USERPROFILE 'souldrop'
    New-Item -ItemType Directory -Force -Path $sdHome | Out-Null

    $launcher = Join-Path $sdHome 'souldrop.ps1'
    try {
        Invoke-WebRequest -Uri "$RawBase/adapters/ollama/souldrop.ps1" -OutFile $launcher -UseBasicParsing
    } catch {
        Show-FreeFallback "Could not download the SoulDrop launcher (check internet). / Khong tai duoc trinh khoi dong SoulDrop (kiem tra mang)."
        return
    }

    # Engine config the launcher reads (plain key=value - no parsing surprises).
    Set-Content -Path (Join-Path $sdHome 'config.txt') -Value @(
        "engine=ollama",
        "model=$Model"
    ) -Encoding Ascii

    # `souldrop` terminal command (shim) + add the folder to the user PATH.
    Set-Content -Path (Join-Path $sdHome 'souldrop.cmd') -Value '@powershell -NoLogo -ExecutionPolicy Bypass -File "%~dp0souldrop.ps1" %*' -Encoding Ascii
    try {
        $userPath = [Environment]::GetEnvironmentVariable('Path', 'User')
        if ($userPath -notlike "*$sdHome*") {
            [Environment]::SetEnvironmentVariable('Path', "$userPath;$sdHome", 'User')
        }
        if ($env:Path -notlike "*$sdHome*") { $env:Path = "$env:Path;$sdHome" }
    } catch { }

    # Desktop shortcut (double-click to chat).
    try {
        $wsh = New-Object -ComObject WScript.Shell
        $lnk = $wsh.CreateShortcut((Join-Path ([Environment]::GetFolderPath('Desktop')) 'SoulDrop.lnk'))
        $lnk.TargetPath = "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe"
        $lnk.Arguments  = "-NoLogo -NoExit -ExecutionPolicy Bypass -File `"$launcher`""
        $lnk.WorkingDirectory = $sdHome
        $lnk.Description = 'SoulDrop - your personal AI assistant'
        $lnk.Save()
        Write-Ok "Desktop shortcut created. / Da tao shortcut ngoai man hinh."
    } catch {
        Write-Note "Could not create a Desktop shortcut - the 'souldrop' command still works."
        Write-Note "Khong tao duoc shortcut - lenh 'souldrop' van dung duoc."
    }

    # ---------------------------------------------------------------
    # Done
    # ---------------------------------------------------------------
    Write-Host ""
    Write-Host "=====================================================" -ForegroundColor Green
    Write-Host "  DONE! / XONG!"                                        -ForegroundColor Green
    Write-Host "=====================================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "  NEXT STEP / BUOC TIEP THEO:" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  Double-click 'SoulDrop' on your Desktop,"
    Write-Host "  or open a NEW terminal and type:  souldrop"
    Write-Host ""
    Write-Host "  Nhan doi 'SoulDrop' ngoai man hinh,"
    Write-Host "  hoac mo terminal MOI va go:  souldrop"
    Write-Host ""
    Write-Host "  Your assistant will introduce itself and ask a few friendly"
    Write-Host "  questions (your name, your work, its name...) - no tech talk."
    Write-Host "  Tro ly se tu gioi thieu va hoi vai cau than thien"
    Write-Host "  (ten ban, cong viec, ten cua no...) - khong hoi ky thuat."
    Write-Host ""
    Write-Host "  Everything runs on YOUR computer. No account. No cost." -ForegroundColor Green
    Write-Host "  Moi thu chay tren MAY CUA BAN. Khong tai khoan. Khong ton phi." -ForegroundColor Green
    Write-Host ""
    Write-Host "  Want a smarter assistant later? The Pro engine (Claude) is one re-run away:"
    Write-Host "  Muon tro ly thong minh hon? Ban Pro (Claude) chi can chay lai installer:"
    Write-Host "  $ReferralUrl  (free 7-day trial - referral link)"
    Write-Host ""
}

# =====================================================================
#  ENGINE AUTO-DETECT - the only human decision in the whole install
# =====================================================================

if (Test-ClaudeInstalled) {
    # Claude Code already on this machine -> best engine, zero questions.
    Write-Host ""
    Write-Host "  Claude Code detected - using the Pro engine. / Da co Claude Code - dung ban Pro." -ForegroundColor Green
    Install-ClaudeEngine
} else {
    Write-Host ""
    Write-Host "  ONE question / MOT cau hoi duy nhat:" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "   [1] FREE - runs on your computer, no account, no cost"
    Write-Host "       MIEN PHI - chay tren may cua ban, khong can tai khoan, khong ton phi"
    Write-Host ""
    Write-Host "   [2] PRO  - smarter (Claude), needs a paid Claude subscription"
    Write-Host "       PRO  - thong minh hon (Claude), can tai khoan Claude tra phi"
    Write-Host ""
    $engineChoice = Read-Host "  Type 1 or 2 / Go 1 hoac 2 (Enter = 1)"
    if ("$engineChoice".Trim() -eq '2') {
        Install-ClaudeEngine
    } else {
        Install-OllamaEngine
    }
}
