@echo off
setlocal

:: �إ߼Ȧs reg �ɮ�
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

:: �פJ�n����
reg import "%regfile%"

:: �M�z
del "%regfile%"

echo �w���\�[�J�k����G�ϥ� VSCode �}��
pause