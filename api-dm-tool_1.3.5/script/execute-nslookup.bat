@echo off
rem ---------------------------------------------------------------------------
rem nslookup Script
rem
rem Environment Variable Prequisites
rem
rem   DOMAIN       Target for nslookup
rem
rem ---------------------------------------------------------------------------
set DOMAIN="scadev.ipaas.samsung.com"
set OPT=

if not "%1"=="" (
	set DOMAIN=%1
)

if not "%2"=="" (
	set OPT=%2
)
if not "%3"=="" (
	set OPT=%OPT% %3
)
if not "%4"=="" (
	set OPT=%OPT% %4
)
if not "%5"=="" (
	set OPT=%OPT% %5
)
if not "%6"=="" (
	set OPT=%OPT% %6
)
if not "%7"=="" (
	set OPT=%OPT% %7
)
if not "%8"=="" (
	set OPT=%OPT% %8
)
if not "%9"=="" (
	set OPT=%OPT% %9
)

echo nslookup %OPT% %DOMAIN%

nslookup %OPT% %DOMAIN%