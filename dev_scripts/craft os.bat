
del %appdata%\CraftOS-PC\computers\0\* /s /q
xcopy /s /e /h /y ..\src\* %appdata%\CraftOS-PC\computers\0\*
start CraftOS-PC.exe
cls
echo press enter to delete the files from emulated computer with ID 0
pause>nul
del %appdata%\CraftOS-PC\computers\0\* /s /q