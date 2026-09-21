@echo off
title AudioBridge - установка на телефон
cd /d "%~dp0"
echo Подключи телефон по USB (USB-отладка включена), разблокируй экран.
echo.
"%~dp0platform-tools\adb.exe" install -r "%~dp0..\apk\audioBridge.apk"
echo.
echo Если вверху написано Success - на телефоне появилось приложение AudioBridge.
pause