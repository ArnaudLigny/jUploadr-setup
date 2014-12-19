# jUploadr Setup : core
# Created with EclipseNSIS and NSIS
# @version 2007-04-27
# @author Arnaud Ligny <arnaud@ligny.org>

# MUI defines
;!define MUI_ICON "..\..\..\${JUPLOADR_ZIP_NAME}\juploadr_min.ico"
!define MUI_ICON ".\graphics\juploadr-install.ico"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_RIGHT
!define MUI_HEADERIMAGE_BITMAP ".\graphics\header_juploadr.bmp"
!define MUI_HEADERIMAGE_UNBITMAP ".\graphics\header-uninstall_juploadr.bmp"
!define MUI_WELCOMEFINISHPAGE_BITMAP ".\graphics\modern-wizard_juploadr.bmp"
!define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKLM"
!define MUI_STARTMENUPAGE_REGISTRY_KEY "${REGKEY}"
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "StartMenuGroup"
!define MUI_STARTMENUPAGE_DEFAULTFOLDER "jUploadr"
!define MUI_STARTMENUPAGE_NODISABLE
!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_TEXT "$(^LanchLink) jUploadr"
!define MUI_FINISHPAGE_RUN_FUNCTION "LaunchjUploadr"
!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\README.txt"
!define MUI_FINISHPAGE_SHOWREADME_NOTCHECKED
!define MUI_FINISHPAGE_LINK "$(^WebSiteName)"
!define MUI_FINISHPAGE_LINK_LOCATION "http://juploadr.org"
!define MUI_FINISHPAGE_NOAUTOCLOSE
!define MUI_FINISHPAGE_NOREBOOTSUPPORT
;!define MUI_ABORTWARNING
#
;!define MUI_UNICON "..\..\..\${JUPLOADR_ZIP_NAME}\juploadr_min.ico"
!define MUI_UNICON ".\graphics\juploadr-uninstall.ico"
!define MUI_UNWELCOMEFINISHPAGE_BITMAP ".\graphics\modern-wizard_juploadr.bmp"
!define MUI_UNFINISHPAGE_NOREBOOTSUPPORT
#
!define MUI_LANGDLL_REGISTRY_ROOT "HKLM"
!define MUI_LANGDLL_REGISTRY_KEY "${REGKEY}"
!define MUI_LANGDLL_REGISTRY_VALUENAME "InstallerLanguage"

# Included files
!include "Sections.nsh"
!include "MUI.nsh"
!ifdef WEBINSTALL
    !include "ZipDLL.nsh"
!endif

# Reserved Files
!insertmacro MUI_RESERVEFILE_LANGDLL
;ReserveFile "${NSISDIR}\Plugins\AdvSplash.dll"
ReserveFile "jUploadr-setup-reinstall.ini"
ReserveFile "jUploadr-setup-shortcuts.ini"
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS

# Variables
Var AddStartMenuShortcut
Var AddDesktopShortcut
Var AddQuickLaunchShortcut
Var StartMenuGroup

# Installer pages
!insertmacro MUI_PAGE_WELCOME
!ifdef VER_MAJOR & VER_MINOR & VER_REVISION & VER_BUILD
    Page custom PageReinstall PageLeaveReinstall
!endif
!insertmacro MUI_PAGE_DIRECTORY
Page custom PageShortcuts PageLeaveShortcuts
; Start Menu Folder Page Configuration
!define MUI_PAGE_CUSTOMFUNCTION_PRE preStartMenu
!insertmacro MUI_PAGE_STARTMENU "Application" "$StartMenuGroup"
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
#
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

# Installer languages
!insertmacro MUI_LANGUAGE "English"
!include "lng\jUploadr-setup-en.nsh"
!insertmacro MUI_LANGUAGE "French"
!include "lng\jUploadr-setup-fr.nsh"

# Functions
!include jUploadr-setup.inc.nsh

# Installer attributes
!ifdef VER_MAJOR & VER_MINOR & VER_REVISION & VER_BUILD
    Caption "$(^Caption)"
!endif
OutFile "${OUTFILE}"
InstallDir "$PROGRAMFILES\jUploadr"
InstallDirRegKey HKLM "${REGKEY}" ""
CRCCheck on
XPStyle on
ShowInstDetails hide
ShowUninstDetails hide
!ifdef VER_MAJOR & VER_MINOR & VER_REVISION & VER_BUILD
    VIProductVersion "${VER_MAJOR}.${VER_MINOR}.${VER_REVISION}.${VER_BUILD}"
    VIAddVersionKey "ProductName" "jUploadr"
    VIAddVersionKey "ProductVersion" "${VERSION}"
    VIAddVersionKey "CompanyName" "${COMPANY}"
    VIAddVersionKey "CompanyWebsite" "${URL}"
    VIAddVersionKey "FileVersion" "${VERSION}"
    VIAddVersionKey "FileDescription" "jUploadr is a java-based flickr uploader"
    VIAddVersionKey "Comments" "Setup created by Arnaud 'Narno' Ligny (www.narno.com)"
    VIAddVersionKey "LegalCopyright" "Steve Cohen & the jUploadr's development team"
!endif

# Installer sections
Section -jUploadr SEC0000
    SetDetailsPrint both ;none|listonly|textonly|both|lastused
    SetOutPath "$INSTDIR"
    SetOverwrite on
    # Web install
    !ifdef WEBINSTALL
        AddSize 4753
        ;StrCpy $2 "$TEMP\${JUPLOADR_ZIP_NAME}.zip"
        StrCpy $2 "$TEMP\$(^Name).zip"
        NSISdl::download /TRANSLATE "$(^DLMsgDownloading)" "$(^DLMsgConnecting)" "$(^DLMsgSecond)" "$(^DLMsgMinute)" "$(^DLMsgHour)" "$(^DLMsgPlural)" "$(^DLMsgProgress)" "$(^DLMsgRemaining)" /TIMEOUT=30000 "${JUPLOADR_ZIP_URL}" "$2"
        Pop $R0 ;Get the return value
        StrCmp $R0 "success" +3
            MessageBox MB_OK "Download failed: $R0"
            Quit
        ZipDLL::extractall "$2" "$INSTDIR"
        CopyFiles /SILENT "$INSTDIR\${JUPLOADR_ZIP_NAME}\*" "$INSTDIR"
        SetDetailsPrint none
        RmDir /r /REBOOTOK "$INSTDIR\${JUPLOADR_ZIP_NAME}"
        SetDetailsPrint lastused
        Pop $R0
        StrCmp $R0 "success" +2
            ;DetailPrint "$R0" ;print error message to log
            Delete /REBOOTOK $2
    # Classic install
    !else
        File "..\..\..\${JUPLOADR_ZIP_NAME}\CHANGES"
        File "..\..\..\${JUPLOADR_ZIP_NAME}\jUploadr.exe"
        File "..\..\..\${JUPLOADR_ZIP_NAME}\jUploadr.gif"
        File "..\..\..\${JUPLOADR_ZIP_NAME}\juploadr.ico"
        File "..\..\..\${JUPLOADR_ZIP_NAME}\juploadr_icon.png"
        File "..\..\..\${JUPLOADR_ZIP_NAME}\juploadr_min.ico"
        File "..\..\..\${JUPLOADR_ZIP_NAME}\README"
        SetOutPath "$INSTDIR\lib"
        File /r "..\..\..\${JUPLOADR_ZIP_NAME}\lib\*"
        SetOutPath "$INSTDIR\plugins"
        File /r "..\..\..\${JUPLOADR_ZIP_NAME}\plugins\*"
    !endif
    SetDetailsPrint none
    Rename /REBOOTOK "$INSTDIR\CHANGES" "$INSTDIR\CHANGES.txt"
    Rename /REBOOTOK "$INSTDIR\README" "$INSTDIR\README.txt"
    SetDetailsPrint lastused
    SetOutPath "$INSTDIR\"
    StrCmp $AddStartMenuShortcut "1" 0 +8
        CreateDirectory "$SMPROGRAMS\$StartMenuGroup"
        CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(^Name).lnk" "$INSTDIR\jUploadr.exe"
        CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(^WebSiteName).lnk" "http://juploadr.org"
        CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(^ReadmeLink).lnk" "$INSTDIR\README.txt"
        CreateDirectory "$SMPROGRAMS\$StartMenuGroup\$(^WebLinks)"
        CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(^WebLinks)\flickr.com.lnk" "http://www.flickr.com"
        CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(^WebLinks)\zooomr.com.lnk" "http://www.zooomr.com"
    StrCmp $AddDesktopShortcut "1" 0 +2
        CreateShortCut "$DESKTOP\$(^Name).lnk" "$INSTDIR\jUploadr.exe"
    StrCmp $AddQuickLaunchShortcut "1" 0 +2
        CreateShortCut "$QUICKLAUNCH\$(^Name).lnk" "$INSTDIR\jUploadr.exe"
    # store jUploadr component ID
    WriteRegStr HKLM "${REGKEY}\Components" "jUploadr" "1"
    # Store jUploadr pref language
    Call StorejUploadrLanguage
SectionEnd

Section -post SEC0001
    SetDetailsPrint textonly
    WriteRegStr HKLM "${REGKEY}" "" "$INSTDIR"
    !ifdef VER_MAJOR & VER_MINOR & VER_REVISION & VER_BUILD
        WriteRegDword HKLM "${REGKEY}" "VersionMajor" "${VER_MAJOR}"
        WriteRegDword HKLM "${REGKEY}" "VersionMinor" "${VER_MINOR}"
        WriteRegDword HKLM "${REGKEY}" "VersionRevision" "${VER_REVISION}"
        WriteRegDword HKLM "${REGKEY}" "VersionBuild" "${VER_BUILD}"
    !endif
    SetOutPath "$INSTDIR"
    WriteUninstaller "$INSTDIR\uninstall.exe"
    !insertmacro MUI_STARTMENU_WRITE_BEGIN "Application"
    SetOutPath "$SMPROGRAMS\$StartMenuGroup"
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\$(^UninstallLink).lnk" "$INSTDIR\uninstall.exe"
    !insertmacro MUI_STARTMENU_WRITE_END
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" "DisplayName" "$(^Name)"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" "DisplayVersion" "${VERSION}"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" "Publisher" "${COMPANY}"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" "URLInfoAbout" "${URL}"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" "URLInfoAbout" "${URL}"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" "HelpLink" "${URL}"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" "DisplayIcon" "$INSTDIR\uninstall.exe"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" "UninstallString" "$INSTDIR\uninstall.exe"
    WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" "NoModify" "1"
    WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" "NoRepair" "1"
SectionEnd

# JRE detection
Section -Post JRE
    DetailPrint "$(^JREMsgProcessing)"
    Call DetectJRE
SectionEnd

# Desktop shortcut
;Section -Post SHORTCUT
;    MessageBox MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2 "$(^AddShortcutDesktopMsg)" IDYES 0 IDNO NoShortcut
;    SetOutPath "$INSTDIR\"
;    CreateShortCut "$DESKTOP\$(^Name).lnk" "$INSTDIR\jUploadr.exe"
;    NoShortcut:
;SectionEnd

# Macro for selecting uninstaller sections
!macro SELECT_UNSECTION SECTION_NAME UNSECTION_ID
    Push $R0
    ReadRegStr $R0 HKLM "${REGKEY}\Components" "${SECTION_NAME}"
    StrCmp $R0 1 0 next${UNSECTION_ID}
    !insertmacro SelectSection "${UNSECTION_ID}"
    Goto done${UNSECTION_ID}
    next${UNSECTION_ID}:
        !insertmacro UnselectSection "${UNSECTION_ID}"
    done${UNSECTION_ID}:
        Pop $R0
!macroend

# Uninstaller sections
Section /o un.jUploadr UNSEC0000
    Delete /REBOOTOK "$QUICKLAUNCH\$(^Name).lnk"
    Delete /REBOOTOK "$DESKTOP\$(^Name).lnk"
    Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\$(^WebLinks)\zooomr.com.lnk"
    Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\$(^WebLinks)\flickr.com.lnk"
    RmDir /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\$(^WebLinks)"
    Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\$(^ReadmeLink).lnk"
    Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\$(^WebSiteName).lnk"
    Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\$(^Name).lnk"
    # Web install
    !ifdef WEBINSTALL
        RmDir /r /REBOOTOK "$INSTDIR"
    # Classic install
    !else
        RmDir /r /REBOOTOK "$INSTDIR\plugins"
        RmDir /r /REBOOTOK "$INSTDIR\lib"
        Delete /REBOOTOK "$INSTDIR\README.txt"
        Delete /REBOOTOK "$INSTDIR\juploadr_min.ico"
        Delete /REBOOTOK "$INSTDIR\juploadr_icon.png"
        Delete /REBOOTOK "$INSTDIR\juploadr.ico"
        Delete /REBOOTOK "$INSTDIR\jUploadr.gif"
        Delete /REBOOTOK "$INSTDIR\jUploadr.exe"
        Delete /REBOOTOK "$INSTDIR\CHANGES.txt"
    !endif
    DeleteRegValue HKLM "${REGKEY}\Components" "jUploadr"
SectionEnd

Section un.post UNSEC0001
    # delete preferences too ?
    !insertmacro IfKeyExists HKCU "Software\JavaSoft\Prefs\org\scohen" "juploadr"
    Pop $R0 ;$R0 contains 0 (not present) or 1 (present)
    StrCmp $R0 "1" 0 NoPref
        MessageBox MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2 "$(^DelPrefMsg)" IDYES 0 IDNO NoPref
        DeleteRegKey HKCU "Software\JavaSoft\Prefs\org\scohen\juploadr"
        DeleteRegKey /IfEmpty HKCU "Software\JavaSoft\Prefs\org\scohen"
        DeleteRegKey /IfEmpty HKCU "Software\JavaSoft\Prefs\org"
    NoPref:
    DeleteRegKey HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)"
    Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\$(^UninstallLink).lnk"
    Delete /REBOOTOK "$INSTDIR\uninstall.exe"
    DeleteRegValue HKLM "${REGKEY}" "StartMenuGroup"
    DeleteRegKey /IfEmpty HKLM "${REGKEY}\Components"
    DeleteRegValue HKLM "${REGKEY}" "VersionBuild"
    DeleteRegValue HKLM "${REGKEY}" "VersionRevision"
    DeleteRegValue HKLM "${REGKEY}" "VersionMinor"
    DeleteRegValue HKLM "${REGKEY}" "VersionMajor"
    DeleteRegKey /IfEmpty HKLM "${REGKEY}"
    RmDir /REBOOTOK "$SMPROGRAMS\$StartMenuGroup"
    RmDir /REBOOTOK "$INSTDIR"
SectionEnd

!ifdef VER_MAJOR & VER_MINOR & VER_REVISION & VER_BUILD
Function PageReinstall
    ReadRegStr $R0 HKLM "${REGKEY}" ""
    StrCmp $R0 "" 0 +2
    Abort
    # Detect version
    ReadRegDWORD $R0 HKLM "${REGKEY}" "VersionMajor"
    IntCmp $R0 ${VER_MAJOR} minor_check new_version older_version
    minor_check:
        ReadRegDWORD $R0 HKLM "${REGKEY}" "VersionMinor"
        IntCmp $R0 ${VER_MINOR} revision_check new_version older_version
    revision_check:
        ReadRegDWORD $R0 HKLM "${REGKEY}" "VersionRevision"
        IntCmp $R0 ${VER_REVISION} build_check new_version older_version
    build_check:
        ReadRegDWORD $R0 HKLM "${REGKEY}" "VersionBuild"
        IntCmp $R0 ${VER_BUILD} same_version new_version older_version
    new_version:
        !insertmacro MUI_HEADER_TEXT "$(^ReinstallNewversionHeader)" "$(^ReinstallNewversionSubtitle)"
        !insertmacro MUI_INSTALLOPTIONS_WRITE "jUploadr-setup-reinstall.ini" "Field 1" "Text" "$(^ReinstallNewversionField1)"
        !insertmacro MUI_INSTALLOPTIONS_WRITE "jUploadr-setup-reinstall.ini" "Field 2" "Text" "$(^ReinstallNewversionField2)"
        !insertmacro MUI_INSTALLOPTIONS_WRITE "jUploadr-setup-reinstall.ini" "Field 3" "Text" "$(^ReinstallNewversionField3)"
        StrCpy $R0 "1"
        Goto reinst_start
    older_version:
        !insertmacro MUI_HEADER_TEXT "$(^ReinstallOldversionHeader)" "$(^ReinstallOldversionSubtitle)"
        !insertmacro MUI_INSTALLOPTIONS_WRITE "jUploadr-setup-reinstall.ini" "Field 1" "Text" "$(^ReinstallOldversionField1)"
        !insertmacro MUI_INSTALLOPTIONS_WRITE "jUploadr-setup-reinstall.ini" "Field 2" "Text" "$(^ReinstallOldversionField2)"
        !insertmacro MUI_INSTALLOPTIONS_WRITE "jUploadr-setup-reinstall.ini" "Field 3" "Text" "$(^ReinstallOldversionField3)"
        StrCpy $R0 "1"
        Goto reinst_start
    same_version:
        !insertmacro MUI_HEADER_TEXT "$(^ReinstallSameversionHeader)" "$(^ReinstallSameversionSubtitle)"
        !insertmacro MUI_INSTALLOPTIONS_WRITE "jUploadr-setup-reinstall.ini" "Field 1" "Text" "$(^ReinstallSameversionField1)"
        !insertmacro MUI_INSTALLOPTIONS_WRITE "jUploadr-setup-reinstall.ini" "Field 2" "Text" "$(^ReinstallSameversionField2)"
        !insertmacro MUI_INSTALLOPTIONS_WRITE "jUploadr-setup-reinstall.ini" "Field 3" "Text" "$(^ReinstallSameversionField3)"
        StrCpy $R0 "2"
    reinst_start:
        !insertmacro MUI_INSTALLOPTIONS_DISPLAY "jUploadr-setup-reinstall.ini"
FunctionEnd
#
Function PageLeaveReinstall
    !insertmacro MUI_INSTALLOPTIONS_READ $R1 "jUploadr-setup-reinstall.ini" "Field 2" "State"
    StrCmp $R0 "1" 0 +2
    StrCmp $R1 "1" reinst_uninstall reinst_done
    StrCmp $R0 "2" 0 +3
    StrCmp $R1 "1" reinst_done reinst_uninstall
    reinst_uninstall:
        ReadRegStr $R1 HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" "UninstallString"
        # Run uninstaller
        HideWindow
        ClearErrors
        ExecWait '$R1 _?=$INSTDIR'
        ;Exec "$INSTDIR\uninstall.exe"
        IfErrors no_remove_uninstaller
        IfFileExists "$INSTDIR\jUploadr.exe" no_remove_uninstaller
        Delete /REBOOTOK $R1
        RmDir /REBOOTOK $INSTDIR
    no_remove_uninstaller:
        StrCmp $R0 "2" 0 +2
        Quit
        BringToFront
    reinst_done:
FunctionEnd
!endif # VER_MAJOR & VER_MINOR & VER_REVISION & VER_BUILD

# Add shortcuts page
Function PageShortcuts  
    !insertmacro MUI_HEADER_TEXT "$(^AddShortcutsHeader)" "$(^AddShortcutsSubtitle)"
    !insertmacro MUI_INSTALLOPTIONS_WRITE "jUploadr-setup-shortcuts.ini" "Field 1" "Text" "$(^AddShortcuts)"
    !insertmacro MUI_INSTALLOPTIONS_WRITE "jUploadr-setup-shortcuts.ini" "Field 2" "Text" "$(^AddStartMenuShortcut)"
    !insertmacro MUI_INSTALLOPTIONS_WRITE "jUploadr-setup-shortcuts.ini" "Field 3" "Text" "$(^AddDesktopShortcut)"
    !insertmacro MUI_INSTALLOPTIONS_WRITE "jUploadr-setup-shortcuts.ini" "Field 4" "Text" "$(^AddQuickLaunchShortcut)"
    !insertmacro MUI_INSTALLOPTIONS_DISPLAY "jUploadr-setup-shortcuts.ini"
FunctionEnd
#
Function PageLeaveShortcuts
    !insertmacro MUI_INSTALLOPTIONS_READ $AddStartMenuShortcut "jUploadr-setup-shortcuts.ini" "Field 2" "State"
    !insertmacro MUI_INSTALLOPTIONS_READ $AddDesktopShortcut "jUploadr-setup-shortcuts.ini" "Field 3" "State"
    !insertmacro MUI_INSTALLOPTIONS_READ $AddQuickLaunchShortcut "jUploadr-setup-shortcuts.ini" "Field 4" "State"
FunctionEnd
#
Function preStartMenu
    StrCmp $AddStartMenuShortcut "1" +2 0
        Abort
FunctionEnd

# Installer functions
Function .onInit
    InitPluginsDir
    # Spalsh Screen
    ;Push $R1
    ;File /oname=$PLUGINSDIR\spltmp.bmp graphics\jUploadr.bmp
    ;advsplash::show 1000 600 400 -1 $PLUGINSDIR\spltmp
    ;Pop $R1
    ;Pop $R1
    # Select language
    !insertmacro MUI_LANGDLL_DISPLAY
    # Custom Pages
    !insertmacro MUI_INSTALLOPTIONS_EXTRACT "jUploadr-setup-reinstall.ini"
    !insertmacro MUI_INSTALLOPTIONS_EXTRACT "jUploadr-setup-shortcuts.ini"
FunctionEnd

# Uninstaller functions
Function un.onInit
    ReadRegStr "$INSTDIR" HKLM "${REGKEY}" ""
    !insertmacro MUI_STARTMENU_GETFOLDER "Application" "$StartMenuGroup"
    !insertmacro MUI_UNGETLANGUAGE
    !insertmacro SELECT_UNSECTION jUploadr "${UNSEC0000}"
FunctionEnd