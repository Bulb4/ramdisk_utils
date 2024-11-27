#### Creates RAM Disk. Very fast to read. Data get's lost on shutdown.
- Disk's letter, size, label and icon are configurable
- Safely backups `links_list.txt` directories by renaming
- Copies them to RAM Disk, creates `Directory Junction` in old place ( `mklink /?` )

#### Installation
- install imdisk
  + [github](https://github.com/LTRData/ImDisk),
  + [download](https://ltr-data.se/opencode.html#ImDisk)
- download this repo
- configure [disk_config.bat](./disk_config.bat)
- configure dirs to be cached in [links_list.txt](./links_list.txt), pick the ones that are read oftenly, e.g. `Includes`, but not `Libraries`
- for big ones enable ntfs compression, the folder is gonna be decompressed on copy:
  + Properties->General->Advanced-> # Compress contents to save disk space
  + or `compact /c /s"C:\Program Files (x86)\Windows Kits\10\Include"`
- Setup a task:
  + Win+R `taskschd.msc` (Task Scheduler)
  + Create New Task
  + General -> `# Run with highest privileges`
  + Triggers -> At logon
  + Actions -> Set full path to [mount_ramdisk.bat](./mount_ramdisk.bat)

#### Visual Studio .vs database cache relocation
|`[ Tools ] > [ Options ] > [ Text Editor \ C/C++ \ Advanced ]`||
-|-
**Browsing Database Fallback**
Always Use Fallback Location|True
Do Not Warn If Fallback Location Used|True
Fallback Location|`Z:\vs_databases`
