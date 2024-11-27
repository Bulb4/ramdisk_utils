set disk_letter=Z
set disk_label=Ramdisk
::1**32 * 2 + 4096 = 8gb
set disk_size=8589938688
              
set "pifmgr_icon_dll_path=%windir%\System32\pifmgr.dll"
if not exist "%pifmgr_icon_dll_path%" exit /b 0
set /a pifmgr_icon_idx=%random% %% 38
::set disk icon path via registry
set "disk_icon=%pifmgr_icon_dll_path%,%pifmgr_icon_idx%"
set "disk_icon_reg=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer"
set "disk_icon_reg=%disk_icon_reg%\DriveIcons\%disk_letter%\DefaultIcon"
reg add "%disk_icon_reg%" /ve /d "%disk_icon%" /f
