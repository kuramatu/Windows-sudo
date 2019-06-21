@rem ------------------------------------------------------------------
@rem 
@rem sudo (RunWithAdministratorAuthority)
@rem This tool launches the application with administrator authority.
@rem 
@rem Usage: sudo [ApplicationName]
@rem 
@rem Example:
@rem   sudo cmd          Start command prompt with administrator authority.
@rem   sudo powershell   Start PowerShell with administrator authority.
@rem 
@rem ------------------------------------------------------------------

@echo off
setlocal enabledelayedexpansion
:main
set SUDO_HOME=%~dp0
set CALL_APPLICATION_NAME=%~1
set USER_INPUT_ARGUMENTS=%~2
call :isApplicationNameEmpty
if "%ERRORLEVEL%"=="1" (
  exit /b
)
call :getApplicationArguments
powershell Start-Process -FilePath "%CALL_APPLICATION_NAME%" !ARGUMENTS!
exit /b


:isApplicationNameEmpty
set IS_APPLICATION_NAME_EMPTY=0
if "%CALL_APPLICATION_NAME%"=="" (
  set IS_APPLICATION_NAME_EMPTY=1
  echo "Please input call application name"
  pause
)
exit /b !IS_APPLICATION_NAME_EMPTY!


:getApplicationArguments
if "%CALL_APPLICATION_NAME%"=="cmd" (
  set ARGUMENTS=-ArgumentList '/k cd /d "%CD%"' -Verb RunAs
  exit /b
)
if "%CALL_APPLICATION_NAME%"=="powershell" (
  set ARGUMENTS=-ArgumentList '-NoExit -Command Set-Location "%CD%"' -Verb RunAs
  exit /b
)
if "%USER_INPUT_ARGUMENTS%"=="" (
  set ARGUMENTS=-Verb RunAs
)
set ARGUMENTS=-ArgumentList "%USER_INPUT_ARGUMENTS%" -Verb RunAs
exit /b

endlocal