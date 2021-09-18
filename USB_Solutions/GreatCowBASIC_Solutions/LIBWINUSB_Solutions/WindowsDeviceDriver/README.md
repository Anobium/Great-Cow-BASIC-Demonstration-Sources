# Great-Cow-BASIC USB Driver Setup

This section contains the latest build of the driver setup, md5 & sha1 hash.
Same installer for x86 and x64.

# Tested on (but not limited to)
Windows 11 pro x64 secureboot disabled, os build Dev 21H2 22000.194

Windows 11 pro x64 secureboot enabled, os build Dev rs_prerelease 22458.1000

Windows 10 pro x64 secureboot disabled, os build stable 20H2 19042.867

Windows 7 pro x86 secureboot disabled, os service pack 1 build 6.1.7601


# Requires:
.Net Framework 3.0 (most probably, you already have)

User admin privileges

---------------------------------------------------------------

Fully automated without Secure Boot (just allow the driver installation), if secure boot enabled, you will
be carried to select a boot option to disable driver signature enforcement and then the setup will continue.

# Uses:
USB_VID 0x1209

USB_PID 0x2006

USB_REV 0x0000

(For others, need to modify and recompile)

USB_PRODUCT_NAME and USB_VENDOR_NAME can change without problem (windows device manager will show the name reported by the hardware not the driver)

# Change log.
1.  First release.
