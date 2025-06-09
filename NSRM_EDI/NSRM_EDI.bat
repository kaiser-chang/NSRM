@echo off
rem ---------------------------------------------------------------------------
rem Main Script for API-DM-TOOL
rem ---------------------------------------------------------------------------
CALL ".\java_env.bat"

set SERVER_PORT=7093
set MIN_MEM=512m
set MAX_MEM=1024m
set PROFILE=production
set CURRENT_JAR=lynxlib-api-dm-tool-application
set UPDATE_JAR=lynxlib-api-dm-tool-application-update
set BACKUP_JAR=lynxlib-api-dm-tool-application-backup

echo %PROFILE% profile

echo JAVA_HOME environment variable is set to %JAVA_HOME%.
if not exist "%JAVA%" goto noJavaHome

goto checkUpdate

:noJavaHome
echo You must set the JAVA_HOME variable before running API-DM-TOOL.
goto end

:checkUpdate
echo Checking update version...
if not exist ".\%UPDATE_JAR%.jar" (
	echo The current jar is the latest version.
	goto checkServerPort
)
echo %UPDATE_JAR%.jar was found.
move /Y %CURRENT_JAR%.jar   %BACKUP_JAR%.jar
echo "%CURRENT_JAR%.jar  -> %BACKUP_JAR%.jar"

move /Y %UPDATE_JAR%.jar   %CURRENT_JAR%.jar
echo "%UPDATE_JAR%.jar ->  %CURRENT_JAR%.jar"

goto checkServerPort

:checkServerPort
if not "%1"=="" (
	set SERVER_PORT=%1
)
if not "%2"=="" (
	set MIN_MEM=%2
)
if not "%3"=="" (
	set MAX_MEM=%3
)
echo Application port is %SERVER_PORT%.

goto copyApplication

:copyApplication
copy /Y %CURRENT_JAR%.jar %CURRENT_JAR%-%PROFILE%-%SERVER_PORT%.jar
echo "%CURRENT_JAR%.jar -> %CURRENT_JAR%-%PROFILE%-%SERVER_PORT%.jar"
goto runApplication

:runApplication
echo ./%CURRENT_JAR%-%SERVER_PORT%.jar is being starting!
echo Memory -Xms%MIN_MEM% -Xmx%MAX_MEM%.
%JAVA% -Dfile.encoding=UTF-8 -jar -Xms%MIN_MEM% -Xmx%MAX_MEM% ./%CURRENT_JAR%-%PROFILE%-%SERVER_PORT%.jar --spring.profiles.active=%PROFILE% --server.port=%SERVER_PORT%

:end

:END