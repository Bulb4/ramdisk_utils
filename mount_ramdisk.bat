@echo off

cd /d "%~dp0"
set need_pause=

set "links=.\links_list.txt"
call ".\disk_config.bat"

set disk=%disk_letter%:

where imdisk && imdisk -a -s %disk_size% -m %disk%\ -p "/fs:NTFS /q /y /v:%disk_label%"

if not "%errorlevel%"=="0" if exist "%spare_path%" ^
subst %disk% "%spare_path%"

if exist "%links%" ^
for /f "delims=" %%a in (%links%) do ^
call :make_ram_link "%%~a" || set need_pause=1

pushd %disk%\ || ( echo no disk & goto :end )

echo explorer.exe "%~dp0" ^& echo. >.\open_parent_dir.bat
popd

:end

if not "%errorlevel%"=="0" (
	echo errorlevel: %errorlevel%
	set need_pause=1
)

if not %need_pause%=="" pause

exit /b 0

:make_ram_link
echo making link: "%~1"

pushd "%~dp1"
set "wd=%~nx1"
set "wd_backup=%wd%_backup"

::only works on links / empty dirs
rmdir "%wd%"
rename "%wd_backup%" "%wd%"
rename "%wd%" "%wd_backup%" || goto :ram_link_end

set "ram_dir=%disk%%~pnx1"

robocopy "%wd_backup%" "%ram_dir%" /mir /nfl /ndl
if %errorlevel% geq 8 del 2>nul & goto :ram_link_end

mklink /j "%wd%" "%ram_dir%" || goto :ram_link_end

:ram_link_end
set "el=%errorlevel%"
popd
exit /b %el%
