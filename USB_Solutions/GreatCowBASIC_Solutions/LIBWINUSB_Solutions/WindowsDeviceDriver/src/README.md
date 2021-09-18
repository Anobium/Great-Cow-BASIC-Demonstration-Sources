# Driver Source Code Description

This section contains the source code and all the needed files to build the setup.


# Installer Project
the installer project file (Installer.iip) it’s made in Install Creator Pro 2, url provided (But it’s not mandated, it can be packed in any installer, 
even in a self-extract exe) It only extracts the file in C:\Drivers\ add a windows registry key and executes the Unsigned.exe binary.

the registry key:

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce]
"DriverInstall"="C:\\Drivers\\DrvSetup.exe"

# Build directory
Where the final output is compiled.

# Drivers directory
Contains the drivers files and the two binaries that do the hard work (those are the contents used for the installer project
and will be extracted on C:\Drivers\ and deleted upon finishing.

# Unsigned_c# directory
visual studio project for the Unsigned.exe binary, its executed as administrator after the extraction; checks if secure boot is enabled in the
computer and selects the best way to change to disable driver signature enforcement mode, then restarts the system. written in c# .netF 3.0

# DrvSetup_c# directory
visual studio project for the DrvSetup.exe binary, its executed as administrator after restart by windows because of the registry key (RunOnce);
reverts to normal mode for the next reboot, install the driver, deletes the contents of C:\Drivers\ and then restarts the system finishing the 
installation. written in c# .netF 3.0


#Change log.
1.  First release.
