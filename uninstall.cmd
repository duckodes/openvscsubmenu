@echo off
setlocal

net session >nul 2>&1
if %errorlevel% == 0 (
    echo �w�O�t�κ޲z���A�~�����...
) else (
    echo �ݭn�t�κ޲z���v���A���b���s�Ұ�...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

echo �����uOpen with VSCode�v�k���椤...

:: �R���ɮץk����
reg delete "HKEY_CLASSES_ROOT\*\shell\Open with VSCode" /f

:: �R����Ƨ��k����
reg delete "HKEY_CLASSES_ROOT\Directory\shell\Open with VSCode" /f

echo �w���\���� VSCode �k����
pause