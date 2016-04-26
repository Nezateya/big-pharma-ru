@echo off

reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" /v "Identifier" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT
echo Detected %OS% operating system.
@echo off
set REGKEY="HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 344850"
if "%OS%" == "32BIT" (
	set REGKEY="HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 344850"
)
set REGVAL=InstallLocation

reg query %REGKEY% /v %REGVAL% 2>nul || (echo No game found! & exit /b 1)

set INSTALL_PATH=
for /f "tokens=2,*" %%a in ('reg query %REGKEY% /v %REGVAL% ^| findstr %REGVAL%') do (
    set INSTALL_PATH=%%b
)

if not defined INSTALL_PATH (echo Game path not found! & exit /b 1)

REM replace any spaces with +
set INSTALL_PATH=%INSTALL_PATH%\Big Pharma_Data\GameData
copy /Y drugNames-ru.data "%INSTALL_PATH%\drugNames-ru.data"
copy /Y names-ru.data "%INSTALL_PATH%\names-ru.data"
copy /Y strings-ru.data "%INSTALL_PATH%\strings-ru.data"
copy /Y MM\strings-ru.data "%INSTALL_PATH%\MM\strings-ru.data"
echo Install complete.
pause
