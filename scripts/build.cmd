@echo off
setlocal enabledelayedexpansion

echo Building Rojo projects...

set "BUILD_DIR=dist"
set "OUTPUT_NAME=Satchel"
set "ROJO_PROJECT=package.project.json"

REM Setup build directory
echo Cleaning up build directory...
if exist "%BUILD_DIR%" rmdir /s /q "%BUILD_DIR%"
mkdir "%BUILD_DIR%"
cd "%BUILD_DIR%"

REM Build .rbxm file
rojo build ..\%ROJO_PROJECT% --output "%OUTPUT_NAME%.rbxm"

REM Build .rbxmx file
rojo build ..\%ROJO_PROJECT% --output "%OUTPUT_NAME%.rbxmx"

echo Build completed successfully!
cd ..
