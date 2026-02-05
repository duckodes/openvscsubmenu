@echo off
setlocal

:: 檢查是否有管理員權限
net session >nul 2>&1
if %errorlevel% == 0 (
    echo 已是系統管理員，繼續執行...
) else (
    echo 需要系統管理員權限，正在重新啟動...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

:: 呼叫 PowerShell 開檔案選擇視窗，將結果寫到暫存檔
set "tmpfile=%temp%\vscodepath.txt"
powershell -command "Add-Type -AssemblyName System.Windows.Forms; $f = New-Object System.Windows.Forms.OpenFileDialog; $f.Filter = 'EXE Files (*.exe)|*.exe'; $f.Title = '請選擇 VS Code 的 Code.exe'; if($f.ShowDialog() -eq 'OK'){[Console]::WriteLine($f.FileName)}" > "%tmpfile%"

:: 讀取暫存檔
set /p vscodepath=<"%tmpfile%"
del "%tmpfile%"

if not defined vscodepath (
    echo 沒有選擇檔案，程式結束。
    pause
    exit /b
)

echo 已選擇 VS Code 路徑：%vscodepath%

:: 將路徑中的 \ 轉成 \\
set "escapedpath=%vscodepath:\=\\%"

:: 建立暫存 reg 檔案
set "regfile=%temp%\add_vscode_context.reg"
> "%regfile%" echo Windows Registry Editor Version 5.00
>> "%regfile%" echo.
>> "%regfile%" echo [HKEY_CLASSES_ROOT\*\shell\Open with VSCode]
>> "%regfile%" echo @="Open with VSCode"
>> "%regfile%" echo "Icon"="\"%escapedpath%\",0"
>> "%regfile%" echo.
>> "%regfile%" echo [HKEY_CLASSES_ROOT\*\shell\Open with VSCode\command]
>> "%regfile%" echo @="\"%escapedpath%\" \"%%1\""
>> "%regfile%" echo.
>> "%regfile%" echo [HKEY_CLASSES_ROOT\Directory\shell\Open with VSCode]
>> "%regfile%" echo @="Open with VSCode"
>> "%regfile%" echo "Icon"="\"%escapedpath%\",0"
>> "%regfile%" echo.
>> "%regfile%" echo [HKEY_CLASSES_ROOT\Directory\shell\Open with VSCode\command]
>> "%regfile%" echo @="\"%escapedpath%\" \"%%1\""

:: 匯入登錄檔
reg import "%regfile%"

:: 清理
del "%regfile%"

echo 已成功加入右鍵選單：使用 VSCode 開啟
pause