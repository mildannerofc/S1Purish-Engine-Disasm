@ECHO OFF
echo ==========================================
echo Sonic 1 - Purish Engine is building...
echo ==========================================

REM // This file has been gutted and replaced with the Lua build script.
REM // It has been kept around for ease-of-use for Windows users.
"build_tools/Lua/lua.exe" build.lua || pause REM // Pause on Lua parse failure so that the user can read the error message.
