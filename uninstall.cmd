@echo off
setlocal

net session >nul 2>&1
if %errorlevel% == 0 (
    echo 已是系統管理員，繼續執行...
) else (
    echo 需要系統管理員權限，正在重新啟動...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

echo 移除「Open with VSCode」右鍵選單中...

:: 刪除檔案右鍵選單
reg delete "HKEY_CLASSES_ROOT\*\shell\Open with VSCode" /f

:: 刪除資料夾右鍵選單
reg delete "HKEY_CLASSES_ROOT\Directory\shell\Open with VSCode" /f

echo 已成功移除 VSCode 右鍵選單
pause