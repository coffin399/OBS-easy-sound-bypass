@echo off
setlocal

set BUILD_DIR=%~dp0build
if not exist "%BUILD_DIR%" mkdir "%BUILD_DIR%"

cd /d "%BUILD_DIR%"

cmake -G "Visual Studio 17 2022" ..
if errorlevel 1 goto :error

cmake --build . --config Release
if errorlevel 1 goto :error

echo.
echo Build finished. If successful, place cable-router.dll into your OBS obs-plugins\\64bit folder.
goto :end

:error
echo Build failed.
:end

endlocal
