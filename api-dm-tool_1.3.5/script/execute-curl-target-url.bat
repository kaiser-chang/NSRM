@echo off
rem ---------------------------------------------------------------------------
rem curl ipconfig.me Script
rem
rem   TARGET       Target URL for curl
rem
rem ---------------------------------------------------------------------------
set TARGET="ifconfig.me"
if not "%1"=="" (
	set TARGET=%1
)
echo curl %TARGET%

curl %TARGET%