# jUploadr Setup
# Created with EclipseNSIS and NSIS
# @version 2007-09-05
# @author Arnaud Ligny <arnaud@ligny.org>

# Product name
Name "jUploadr"

# Instaler branding text
BrandingText "$(^BrandingText)"

# Compression method
SetCompressor /SOLID lzma

# Web install : comment for classic install
!define WEBINSTALL

# Defines
!ifdef WEBINSTALL
    !define VERSION "web"
!else
    !define VER_MAJOR 1
    !define VER_MINOR 2
    !define VER_REVISION 1
    !define VER_BUILD 0
    !define VERSION "${VER_MAJOR}.${VER_MINOR}.${VER_REVISION}"
!endif
!define BETA "-beta"
!ifndef BETA
    !define BETA ""
!endif
# Output
!define OUTFILE "jUploadr-${VERSION}-setup${BETA}.exe"
!define REGKEY "SOFTWARE\$(^Name)"
!define COMPANY "Steve Cohen"
!define URL "http://juploadr.org"

# jUploadr ZIP
!define JUPLOADR_ZIP_NAME "jUploadr-1.2alpha1-win32_x86"
!define JUPLOADR_ZIP_URL "http://downloads.sourceforge.net/juploadr/${JUPLOADR_ZIP_NAME}.zip"
;!define JUPLOADR_ZIP_URL "http://juploadr.org/download_windows.php"

# JRE defines
!define JRE_VERSION "1.5"
!define JRE_URL "http://dlc.sun.com/jdk/jre-1_5_0_01-windows-i586-p.exe"
!define JRE_DL_PAGE "http://www.java.com/download/"

# Core
!include jUploadr-setup-core.nsh