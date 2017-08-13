!include MUI2.nsh

!define PRODUCT_NAME "Winmp"
!define PRODUCT_VERSION "1.0.0.0"
!define PRODUCT_PUBLISHER "Baiyangliu"
!define PRODUCT_WEB_SITE "https://github.com/baiyangliu/winmp"


!define REG_ROOT_KEY "HKLM"
!define REG_APP_KEY "SOFTWARE\${PRODUCT_NAME}"
!define REG_INSTALL_PATH_KEY "InstallPath"
!define REG_WORKING_DIRECTORY_KEY "WorkingDirectory"
!define REG_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"



VIProductVersion "${PRODUCT_VERSION}"
VIAddVersionKey FileDescription "${PRODUCT_NAME}"
VIAddVersionKey FileVersion "${PRODUCT_VERSION}"
VIAddVersionKey ProductName "${PRODUCT_NAME}"
VIAddVersionKey ProductVersion "${PRODUCT_VERSION}" ;


; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "favicon.ico"
!define MUI_UNICON "favicon.ico"
;!define MUI_WELCOMEFINISHPAGE_BITMAP "welcome.bmp"


!define MUI_LANGDLL_REGISTRY_ROOT "${REG_ROOT_KEY}"
!define MUI_LANGDLL_REGISTRY_KEY "${REG_UNINST_KEY}"
!define MUI_LANGDLL_REGISTRY_VALUENAME "NSIS:Language"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_UNPAGE_INSTFILES



!insertmacro MUI_LANGUAGE "SimpChinese"



Name "${PRODUCT_NAME}"
OutFile "bin\${PRODUCT_NAME}_${PRODUCT_VERSION}.exe"
InstallDir "$PROGRAMFILES32\${PRODUCT_NAME}"
InstallDirRegKey "${REG_ROOT_KEY}" "${REG_UNINST_KEY}" "UninstallString"
ShowInstDetails show
ShowUninstDetails show
BrandingText "${PRODUCT_NAME}"


Function .onInit
    ReadRegStr $R0 HKLM \
    "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" \
    "UninstallString"
    StrCmp $R0 "" done
 
    MessageBox MB_YESNO \
    "您已安装 ${PRODUCT_NAME} ，安装之前需要卸载旧版本，是否继续？" \
    IDYES uninst
    Abort
 
    ;Run the uninstaller
uninst:
    ClearErrors
    ExecWait '$R0 /S _?=$INSTDIR' $0
 
    ${If} $0 <> 0
        Abort
    ${EndIf}
    IfErrors no_remove_uninstaller reboot
    ;You can either use Delete /REBOOTOK in the uninstaller or add some code
    ;here to remove the uninstaller. Use a registry key to check
    ;whether the user has chosen to uninstall. If you are using an uninstaller
    ;components page, make sure all sections are uninstalled.
    no_remove_uninstaller:

reboot:
    ;Reboot
done:

    !insertmacro MUI_LANGDLL_DISPLAY
FunctionEnd

Section -
    SectionIn RO
	SetOutPath "$INSTDIR"
	SetOverwrite ifdiff


    File "src\nssm.exe"
SectionEnd

Section "OpenResty"
	SetOutPath "$INSTDIR\openresty"
	SetOverwrite ifdiff


    File /r "src\openresty\*"


    FileOpen  $9 "$INSTDIR\openresty\conf\conf.d\default_php.location" w
    FileWrite $9 "location ~ \.php$ {$\r$\n"
    FileWrite $9 '    root           "$INSTDIR\openresty\html";$\r$\n'
    FileWrite $9 "    fastcgi_pass   127.0.0.1:9000;$\r$\n"
    FileWrite $9 "    fastcgi_index  index.php;$\r$\n"
    FileWrite $9 "    fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;$\r$\n"
    FileWrite $9 "    include        fastcgi_params;$\r$\n"
    FileWrite $9 "    fastcgi_hide_header X-Powered-By;$\r$\n"
    FileWrite $9 "}$\r$\n"
    FileClose $9

    ExecWait '$INSTDIR\nssm.exe install Nginx "$INSTDIR\openresty\nginx.exe"'
    ExecWait '$INSTDIR\nssm.exe start Nginx'
SectionEnd


Section "MySQL"
	SetOutPath "$INSTDIR\mysql"
	SetOverwrite ifdiff


    File /r "src\mysql\*"

    ExecWait "$INSTDIR\mysql\bin\mysqld.exe --install MySQL"
    ExecWait "$INSTDIR\mysql\bin\mysqld.exe --initialize-insecure"
    ExecWait "net start MySQL"
SectionEnd


Section "PHP"
	SetOutPath "$INSTDIR\php"
	SetOverwrite ifdiff


    File /r "src\php\*"

    ExecWait '$INSTDIR\nssm.exe install PHP-CGI "$INSTDIR\php\php-cgi.exe" -b 127.0.0.1:9000 -q'
    ExecWait '$INSTDIR\nssm.exe start PHP-CGI'
SectionEnd


Section Uninstall
    SetAutoClose true

    ExecWait '$INSTDIR\nssm.exe stop Nginx'
    ExecWait '$INSTDIR\nssm.exe remove Nginx confirm'

    ExecWait '$INSTDIR\nssm.exe stop PHP-CGI'
    ExecWait '$INSTDIR\nssm.exe remove PHP-CGI confirm'

    ExecWait 'net stop MySQL'
    ExecWait '$INSTDIR\mysql\bin\mysqld.exe --remove'

    DeleteRegKey ${REG_ROOT_KEY} "${REG_APP_KEY}"
    DeleteRegKey ${REG_ROOT_KEY} "${REG_UNINST_KEY}"

    Delete "$INSTDIR\uninst.exe"
    RMDir /r "$INSTDIR"
SectionEnd

Section -Post
    WriteUninstaller "$INSTDIR\uninst.exe"
    WriteRegStr ${REG_ROOT_KEY} "${REG_UNINST_KEY}" "Install Directory" "$INSTDIR"
    WriteRegStr ${REG_ROOT_KEY} "${REG_UNINST_KEY}" "DisplayName" "$(^Name)"
    WriteRegStr ${REG_ROOT_KEY} "${REG_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
    WriteRegStr ${REG_ROOT_KEY} "${REG_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
    WriteRegStr ${REG_ROOT_KEY} "${REG_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
    WriteRegStr ${REG_ROOT_KEY} "${REG_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd

Function un.onUninstSuccess
    HideWindow
FunctionEnd

Function un.onInit
    !insertmacro MUI_UNGETLANGUAGE
    MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "您确定要卸载 $(^Name) ，及其所有组件吗？" IDYES +2
    Abort
FunctionEnd