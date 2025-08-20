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

:: 建立暫存 reg 檔案
set "regfile=%temp%\add_vscode_context.reg"
> "%regfile%" echo Windows Registry Editor Version 5.00
>> "%regfile%" echo.
>> "%regfile%" echo [HKEY_CLASSES_ROOT\*\shell\Open with VSCode]
>> "%regfile%" echo @="Open with VSCode"
>> "%regfile%" echo "Icon"="\"D:\\Microsoft VS Code\\Microsoft VS Code\\Code.exe\",0"
>> "%regfile%" echo.
>> "%regfile%" echo [HKEY_CLASSES_ROOT\*\shell\Open with VSCode\command]
>> "%regfile%" echo @="\"D:\\Microsoft VS Code\\Microsoft VS Code\\Code.exe\" \"%%1\""
>> "%regfile%" echo.
>> "%regfile%" echo [HKEY_CLASSES_ROOT\Directory\shell\Open with VSCode]
>> "%regfile%" echo @="Open with VSCode"
>> "%regfile%" echo "Icon"="\"D:\\Microsoft VS Code\\Microsoft VS Code\\Code.exe\",0"
>> "%regfile%" echo.
>> "%regfile%" echo [HKEY_CLASSES_ROOT\Directory\shell\Open with VSCode\command]
>> "%regfile%" echo @="\"D:\\Microsoft VS Code\\Microsoft VS Code\\Code.exe\" \"%%1\""

:: 匯入登錄檔
reg import "%regfile%"

:: 清理
del "%regfile%"

echo 已成功加入右鍵選單：使用 VSCode 開啟
pause