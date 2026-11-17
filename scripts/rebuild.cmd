@echo off
rem Incremental rebuild of the runtime after changing psxrecomp / recomp-ui
rem sources. Run it from the repository root (or double-click it in scripts\).
rem If the launcher's own "Generate & rebuild" removed the build files, this
rem re-runs the full configure the same way the launcher does, without
rem pruning anything afterwards.
setlocal EnableExtensions
title ValkyrieRecomp - rebuild
set "ROOT=%~dp0.."
for %%I in ("%ROOT%") do set "ROOT=%%~fI"
set "BUILD_DIR=%ROOT%\build-release"
set "TC=%USERPROFILE%\.local\share\retcomm\toolchains\cmake-clang-v1\latest"
set "TC_BIN=%TC%\bin"
set "PYTHON=%TC%\python\python.exe"
set "CLI=%ROOT%\psxrecomp\psxrecomp_cli.py"
set "PATH=%TC_BIN%;%PATH%"
echo Close ValkyrieRecomp before continuing.
pause
echo.
cd /d "%ROOT%"
if exist "%BUILD_DIR%\CMakeCache.txt" goto incremental

echo The build files are missing (the launcher prunes them after its own rebuild).
echo Running the full configure - this takes longer; later rebuilds are fast again...
"%PYTHON%" "%CLI%" rebuild --project-root "%ROOT%" --config "%ROOT%\game.toml" --build-dir "%BUILD_DIR%" --target psx-runtime --exe-basename ValkyrieRecomp --no-pgo
if errorlevel 1 goto fail
goto done

:incremental
echo Rebuilding changed files only...
"%TC_BIN%\cmake.exe" --build "%BUILD_DIR%" --parallel --target psx-runtime
if errorlevel 1 goto fail

:done
echo.
echo Done. Starting the game...
start "" /D "%ROOT%" "%BUILD_DIR%\ValkyrieRecomp.exe" --launcher
endlocal
exit /b 0

:fail
echo.
echo The build failed. Copy the text above when reporting the problem.
pause
exit /b 1
