@echo off
cd /d "%~dp0"
title Digital Twin Campus - Local Server

echo.
echo  ============================================
echo    Digital Twin Campus - Local Server
echo  ============================================
echo.

set "PORT=8899"
set "PYEXE="

REM --- Locate python.exe ---
if not defined PYEXE if exist "%LOCALAPPDATA%\Programs\Python\Python313\python.exe" set "PYEXE=%LOCALAPPDATA%\Programs\Python\Python313\python.exe"
if not defined PYEXE if exist "%LOCALAPPDATA%\Programs\Python\Python312\python.exe" set "PYEXE=%LOCALAPPDATA%\Programs\Python\Python312\python.exe"
if not defined PYEXE for %%P in (python.exe) do if exist "%%~$PATH:P" set "PYEXE=%%~$PATH:P"
if not defined PYEXE if exist "%USERPROFILE%\.workbuddy\binaries\python\versions\3.13.12\python.exe" set "PYEXE=%USERPROFILE%\.workbuddy\binaries\python\versions\3.13.12\python.exe"

if not defined PYEXE (
  echo  [ERROR] python.exe not found.
  echo  Install Python from https://www.python.org/downloads/
  echo  and tick "Add Python to PATH" during setup.
  echo.
  pause
  exit /b 1
)

echo  [1/2] Python : %PYEXE%
echo  [2/2] Port   : %PORT%
echo.
echo  Starting server. Browser opens in about 2 seconds.
echo.

start "" /min "%PYEXE%" -m http.server %PORT% --bind 127.0.0.1
timeout /t 2 /nobreak >nul
start "" "http://127.0.0.1:%PORT%/index.html"

echo  ============================================
echo   The 3D campus is open in your browser.
echo.
echo   Keep this window open while viewing.
echo   Closing this window stops the server.
echo  ============================================
echo.
pause >nul
