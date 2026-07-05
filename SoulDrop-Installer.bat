@echo off
rem =====================================================================
rem  SoulDrop - one-click installer for Windows
rem  Double-click this file. No typing, no PowerShell knowledge needed.
rem  Nhay dup vao file nay. Khong can go lenh, khong can biet PowerShell.
rem
rem  It simply runs the same official install script:
rem    https://raw.githubusercontent.com/supakitkitsathaporn97-collab/souldrop/main/install/go.ps1
rem  (read it yourself anytime - it only calls official installers).
rem
rem  Windows SmartScreen may warn because this file came from the
rem  internet: click "More info" then "Run anyway". That is normal for
rem  any downloaded .bat file - see the README for an honest explanation.
rem =====================================================================
title SoulDrop Installer
echo.
echo  =====================================================
echo    SoulDrop - one-click install / cai dat mot cham
echo  =====================================================
echo.
echo  Starting... / Dang bat dau...
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/supakitkitsathaporn97-collab/souldrop/main/install/go.ps1 | iex"
echo.
echo  =====================================================
echo   You can close this window now. / Ban co the dong cua so nay.
echo  =====================================================
echo.
pause
