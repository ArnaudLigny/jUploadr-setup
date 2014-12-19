# jUploadr Setup : english strings
# Created with EclipseNSIS and NSIS
# @version 2007-04-26
# @author Arnaud Ligny <arnaud@ligny.org>

# Caption
LangString ^Caption "${LANG_ENGLISH}" "$(^Name) ${VERSION} Setup"
# Branding
LangString ^BrandingText "${LANG_ENGLISH}" "Setup created with NSIS ${NSIS_VERSION}"
# Readme link
LangString ^ReadmeLink "${LANG_ENGLISH}" "Read me"
# Launch link
LangString ^LanchLink "${LANG_ENGLISH}" "Run"
# Web site
LangString ^WebSiteName "${LANG_ENGLISH}" "$(^Name) web site"
# Web links
LangString ^WebLinks "${LANG_ENGLISH}" "Links"
# Uninstall link name
LangString ^UninstallLink "${LANG_ENGLISH}" "Uninstall $(^Name)"
# Add shortcuts
LangString ^AddShortcutsHeader "${LANG_ENGLISH}" "Define shortcuts"
LangString ^AddShortcutsSubtitle "${LANG_ENGLISH}" "Create programm shortcuts"
LangString ^AddShortcuts "${LANG_FRENCH}" "Create shortcuts for $(^Name) :"
LangString ^AddStartMenuShortcut "${LANG_ENGLISH}" "In the « Start menu » folder"
LangString ^AddDesktopShortcut "${LANG_ENGLISH}" "On the desktop"
LangString ^AddQuickLaunchShortcut "${LANG_ENGLISH}" "In the « Quick launch bar »"
# Delete preferences
LangString ^DelPrefMsg "${LANG_ENGLISH}" "Do you want to delete your preferences too ?"
# Downloading
LangString ^DLMsgDownloading "${LANG_ENGLISH}" "Downloading %s"
LangString ^DLMsgConnecting "${LANG_ENGLISH}" "Connecting..."
LangString ^DLMsgSecond "${LANG_ENGLISH}" "second"
LangString ^DLMsgMinute "${LANG_ENGLISH}" "minute"
LangString ^DLMsgHour "${LANG_ENGLISH}" "hour"
LangString ^DLMsgPlural "${LANG_ENGLISH}" "s"
LangString ^DLMsgProgress "${LANG_ENGLISH}" "%dkB (%d%%) of %dkB @ %d.%01dkB/s "
LangString ^DLMsgRemaining "${LANG_ENGLISH}" "(%d %s%s remaining)"
# JRE
LangString ^JREMsgProcessing "${LANG_ENGLISH}" "Java processing..."
LangString ^JREMsgInstallRequired "${LANG_ENGLISH}" "Status : Java Runtime Environment installation is required !"
LangString ^JREMsgQuitSure "${LANG_ENGLISH}" "Really exit installation ?"
LangString ^JREMsgInstallAlreadyOK "${LANG_ENGLISH}" "Status : Java Runtime Environment is already installed !"
LangString ^JREMsgPreInstall "${LANG_ENGLISH}" "uses Java Runtime Environment ${JRE_VERSION}$\nWould you download and install it ?"
LangString ^JREMsgDownloadError "${LANG_ENGLISH}" "Download failed !"
LangString ^JREMsgInstallManualRequired "${LANG_ENGLISH}" "Manual installation required !"
# Reinstall
LangString ^ReinstallNewversionField1 "${LANG_ENGLISH}" "An older version of $(^Name) is installed on your system. It's recommended that you uninstall the current version before installing. Select the operation you want to perform and click Next to continue."
LangString ^ReinstallNewversionField2 "${LANG_ENGLISH}" "Uninstall before installing"
LangString ^ReinstallNewversionField3 "${LANG_ENGLISH}" "Do not uninstall"
LangString ^ReinstallNewversionHeader "${LANG_ENGLISH}" "Already Installed"
LangString ^ReinstallNewversionSubtitle "${LANG_ENGLISH}" "Choose how you want to install $(^Name)."
LangString ^ReinstallOldversionField1 "${LANG_ENGLISH}" "A newer version of $(^Name) is already installed ! It is not recommended that you install an older version. If you really want to install this older version, it's better to uninstall the current version first. Select the operation you want to perform and click Next to continue."
LangString ^ReinstallOldversionField2 "${LANG_ENGLISH}" "Uninstall before installing"
LangString ^ReinstallOldversionField3 "${LANG_ENGLISH}" "Do not uninstall"
LangString ^ReinstallOldversionHeader "${LANG_ENGLISH}" "Already Installed"
LangString ^ReinstallOldversionSubtitle "${LANG_ENGLISH}" "Choose how you want to install $(^Name)."
LangString ^ReinstallSameversionField1 "${LANG_ENGLISH}" "$(^Name) ${VERSION} is already installed. Select the operation you want to perform and click Next to continue."
LangString ^ReinstallSameversionField2 "${LANG_ENGLISH}" "Reinstall $(^Name)"
LangString ^ReinstallSameversionField3 "${LANG_ENGLISH}" "Uninstall $(^Name)"
LangString ^ReinstallSameversionHeader "${LANG_ENGLISH}" "Already Installed"
LangString ^ReinstallSameversionSubtitle "${LANG_ENGLISH}" "Choose the maintenance option to perform."
