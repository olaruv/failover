@echo off
setlocal

REM version 1.0, converted from powershell 
REM --- if ((Get-ClusterNode -Name $Env:computername).Status -eq 'Joining') { Stop-Service ClusSvc; net start clussvc /forcequorum } ---
set ServiceName=ClusSvc

REM --- Require admin: run this script elevated and C:\Temp\ is created ---
echo [%DATE% %TIME%] >C:\Temp\failover-workaround.log
cluster node %COMPUTERNAME% /status 2>nul | findstr /i "Joining" >nul 2>&1

if %ERRORLEVEL% EQU 0 (
    echo [%DATE% %TIME%] Node %COMPUTERNAME% is Joining. Restarting %ServiceName%...>>C:\Temp\failover-workaround.log
    net stop %ServiceName% >>C:\Temp\failover-workaround.log 2>&1
    net start %ServiceName% /forcequorum >>C:\Temp\failover-workaround.log 2>&1
    if %ERRORLEVEL% EQU 0 (
        echo [%DATE% %TIME%] Started %ServiceName% successfully.>>C:\Temp\failover-workaround.log
    ) else (
        echo [%DATE% %TIME%] net start returned an error. Attempting cluster force quorum as fallback...>>C:\Temp\failover-workaround.log
        cluster node %COMPUTERNAME% /forcequorum >>C:\Temp\failover-workaround.log 2>&1
    )
) 

endlocal
exit /b
