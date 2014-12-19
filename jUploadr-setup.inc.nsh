# jUploadr Setup : functions & macros
# Created with EclipseNSIS and NSIS
# @version 2007-04-15
# @author Arnaud Ligny <arnaud@ligny.org>

# Launch jUploadr with his link
Function LaunchjUploadr
    ExecShell "" "$SMPROGRAMS\$StartMenuGroup\jUploadr.lnk"
FunctionEnd

# Store jUploadr pref language
Function StorejUploadrLanguage
    Var /GLOBAL jUploadrLanguage
    StrCmp $LANGUAGE ${LANG_ENGLISH} 0 +2
        StrCpy $jUploadrLanguage "en"
    StrCmp $LANGUAGE ${LANG_FRENCH} 0 +2
        StrCpy $jUploadrLanguage "fr"
    WriteRegStr HKCU "Software\JavaSoft\Prefs\org\scohen\juploadr\prefs" "language" "$jUploadrLanguage"
FunctionEnd

# Detect JRE
Function DetectJRE
    ReadRegStr $2 HKLM "SOFTWARE\JavaSoft\Java Runtime Environment" "CurrentVersion" ; JRE ?
    StrCmp $2 "" 0 +2
    ReadRegStr $2 HKLM "SOFTWARE\JavaSoft\Java Development Kit" "CurrentVersion" ; JDK ?
    
    Push ${JRE_VERSION} ; min/require version
    Push $2             ; actual version
    Call VersionCheck
    Pop $0
    StrCmp $0 "0" JREInstallOK ;if it is the same verion
    StrCmp $0 "1" JREInstallRequired ;if number 1 is newer
    StrCmp $0 "2" JREInstallOK ;if number 2 is newer
    
    JREInstallRequired:
        DetailPrint "$(^JREMsgInstallRequired)"
        MessageBox MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON1 "$(^Name) $(^JREMsgPreInstall)" IDYES 0 IDNO DetectJREDone
        Call GetJRE
        Goto DetectJREDone
    JREInstallOK:
        DetailPrint "$(^JREMsgInstallAlreadyOK)"
    DetectJREDone:
FunctionEnd

# Get JRE
Function GetJRE
    StrCpy $2 "$TEMP\Java Runtime Environment.exe"
    NSISdl::download /TRANSLATE "$(^DLMsgDownloading)" "$(^DLMsgConnecting)" "$(^DLMsgSecond)" "$(^DLMsgMinute)" "$(^DLMsgHour)" "$(^DLMsgPlural)" "$(^DLMsgProgress)" "$(^DLMsgRemaining)" /TIMEOUT=30000 "${JRE_URL}" "$2"
    Pop $R0
    StrCmp $R0 "success" JREDownloadOK JREDownloadError
    JREDownloadError:
        MessageBox MB_OK "$(^JREMsgDownloadError) : $R0"
    JREInstallManual:
        MessageBox MB_OKCANCEL "$(^JREMsgInstallManualRequired)" 0 GetJREDone
        DetailPrint "$(^JREMsgInstallManualRequired)"
        ExecShell "open" ${JRE_DL_PAGE} ; open browser
        Goto GetJREDone
    JREDownloadOK:
        ExecWait $2 $0
        StrCmp $0 "0" 0 JREInstallManual ; autoinstall ok or manual ?
        Delete $2
    GetJREDone:
FunctionEnd

# Version check
Function VersionCheck
  Exch $0 ;second versionnumber
  Exch
  Exch $1 ;first versionnumber
  Push $R0 ;counter for $0
  Push $R1 ;counter for $1
  Push $3 ;temp char
  Push $4 ;temp string for $0
  Push $5 ;temp string for $1
  StrCpy $R0 "-1"
  StrCpy $R1 "-1"
  Start:
  StrCpy $4 ""
  DotLoop0:
  IntOp $R0 $R0 + 1
  StrCpy $3 $0 1 $R0
  StrCmp $3 "" DotFound0
  StrCmp $3 "." DotFound0
  StrCpy $4 $4$3
  Goto DotLoop0
  DotFound0:
  StrCpy $5 ""
  DotLoop1:
  IntOp $R1 $R1 + 1
  StrCpy $3 $1 1 $R1
  StrCmp $3 "" DotFound1
  StrCmp $3 "." DotFound1
  StrCpy $5 $5$3
  Goto DotLoop1
  DotFound1:
  Strcmp $4 "" 0 Not4
    StrCmp $5 "" Equal
    Goto Ver2Less
  Not4:
  StrCmp $5 "" Ver2More
  IntCmp $4 $5 Start Ver2Less Ver2More
  Equal:
  StrCpy $0 "0"
  Goto Finish
  Ver2Less:
  StrCpy $0 "1"
  Goto Finish
  Ver2More:
  StrCpy $0 "2"
  Finish:
  Pop $5
  Pop $4
  Pop $3
  Pop $R1
  Pop $R0
  Pop $1
  Exch $0
FunctionEnd

# regestry key exist ?
!macro IfKeyExists ROOT MAIN_KEY KEY
    push $R0
    push $R1
    !define Index 'Line${__LINE__}'
    StrCpy $R1 "0"
    "${Index}-Loop:"
    ; Check for Key
    EnumRegKey $R0 ${ROOT} "${MAIN_KEY}" "$R1"
    StrCmp $R0 "" "${Index}-False"
    IntOp $R1 $R1 + 1
    StrCmp $R0 "${KEY}" "${Index}-True" "${Index}-Loop"
    "${Index}-True:"
        ;Return 1 if found
        push "1"
        goto "${Index}-End"
    "${Index}-False:"
        ;Return 0 if not found
        push "0"
        goto "${Index}-End"
    "${Index}-End:"
        !undef Index
        exch 2
        pop $R0
        pop $R1
!macroend