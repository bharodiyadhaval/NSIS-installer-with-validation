

;--------------------------------
  !include "MUI2.nsh"
  !include "x64.nsh"
  !include zipdll.nsh
  !include nsDialogs.nsh
  !include LogicLib.nsh

;--------------------------------
;General

  ;Name and file
  Name "Animation_Game_DHAVAL_SHALIN_PRAKASH"
  OutFile "project03.exe"
  XPStyle on

	!define WELCOME_TITLE 'Welcome to the Animation Game Installation Setup. \
	Created by Dhaval, Shalin and Prakash'
  
	!define UNWELCOME_TITLE 'Welcome to the Animation Game Uninstallation Setup. \
	Created by Dhaval, Shalin and Prakash'
	
	!define FINISH_TITLE 'Finished to the Animation Game Installation Setup. \
	Created by Dhaval, Shalin and Prakash'
	
	!define UNFINISH_TITLE 'Finished to the Animation Game Uninstallation Setup. \
	Created by Dhaval, Shalin and Prakash'
	
  ;Default installation folder
  InstallDir C:\cnd\DHAVAL_SHALIN_PRAKASH\project03
 
  
  
  RequestExecutionLevel admin
;--------------------------------


;Interface Settings

  !define MUI_ABORTWARNING

;--------------------------------
;Pages

  !define MUI_WELCOMEPAGE_TITLE '${WELCOME_TITLE}'
  !define MUI_WELCOMEPAGE_TITLE_3LINES
  !insertmacro MUI_PAGE_WELCOME
  Page custom LicenseValidation ValidationLeave
  !define MUI_PAGE_FUNCTION_ABORTWARNING License_Cancel
  !define MUI_PAGE_CUSTOMFUNCTION_SHOW BackButtonDisable
  !define MUI_LICENSEPAGE_CHECKBOX
  !insertmacro MUI_PAGE_LICENSE "License.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  !define MUI_FINISHPAGE_TITLE '${FINISH_TITLE}'
  !define MUI_FINISHPAGE_TITLE_3LINES
  !insertmacro MUI_PAGE_FINISH

  
  !define MUI_WELCOMEPAGE_TITLE  '${UNWELCOME_TITLE}'
  !define MUI_WELCOMEPAGE_TITLE_3LINES
  !insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  !define MUI_FINISHPAGE_TITLE '${UNFINISH_TITLE}'
  !define MUI_FINISHPAGE_TITLE_3LINES
  !insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Languages

  !insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Installer Sections

Var email
Var pass
Var Dialog
Var LicenseString

Function .oninit

	StrCpy $LicenseString " CNDP3DHAVAL_BHARODIYA_SHALIN_MOMIN_PRAKASH_MAKHIJANI"
	
FunctionEnd 


Function LicenseValidation


	!insertmacro MUI_HEADER_TEXT "Enter Username && Password" "Enter your username and password to continue."
	
	nsDialogs::Create 1018
	Pop $Dialog

	${If} $Dialog == error
		Abort
	${EndIf}

	${NSD_CreateLabel} 0 0 50u 12u "UserName:"
	Pop $0 

	${NSD_CreateText} 70 0 100u 12u ""
	Pop $0 
	
	${NSD_CreateLabel} 0 -120u 50u 12u "Password:"
	Pop $1

	${NSD_CreateText} 70 -120u 100u 12u ""
	Pop $1 
	
	nsDialogs::Show

FunctionEnd

Function ValidationLeave

	 ${NSD_GetText} $0 $email 
	 ${NSD_GetText} $1 $Pass
	 MessageBox MB_OK "Your user name is:$email  and $\n password is:$pass"

FunctionEnd


Function BackButtonDisable

 ## Disable the Back button
 GetDlgItem $R0 $HWNDPARENT 3
 EnableWindow $R0 0

FunctionEnd

Function License_Cancel

	MessageBox MB_OK "For the continue process, the acceptation of the License is must be! "

FunctionEnd


Section "extra_assets" SecExtra_asserts
	
	;CreateDirectory $INSTDIR
	SetOutPath $INSTDIR
	
    InitPluginsDir
	
	File "FINAL.zip"
	
	ZipDLL::extractfile  "FINAL.zip" $INSTDIR extra_assets\sea_bk.JPG
	ZipDLL::extractfile  "FINAL.zip" $INSTDIR extra_assets\sea_dn.JPG
	ZipDLL::extractfile  "FINAL.zip" $INSTDIR extra_assets\sea_ft.JPG
	ZipDLL::extractfile  "FINAL.zip" $INSTDIR extra_assets\sea_lf.JPG
	ZipDLL::extractfile  "FINAL.zip" $INSTDIR extra_assets\sea_rt.JPG
	ZipDLL::extractfile  "FINAL.zip" $INSTDIR extra_assets\sea_up.JPG
	Delete $INSTDIR\FINAL.zip
	
SectionEnd

Section 
	
	;CreateDirectory $INSTDIR
	
	SetOutPath $INSTDIR
	
	File "FINAL.zip"
	
	ZipDLL::extractall "FINAL.zip" $INSTDIR 
	;Delete $INSTDIR\extra_assets\.*
	RMDir /r $INSTDIR\extra_assets
	;File License.txt
	
  Delete $INSTDIR\FINAL.zip
  
	;Create start menu shortcut
	CreateShortCut "$SMPROGRAMS\FirstOpenGL.lnk" "$INSTDIR\FirstOpenGL.exe"

	;set registry for 64 and 32
	${If} ${RunningX64}

	SetRegView 64
	WriteRegStr HKLM "Software\CND\info6025\DHAVAL_SHALIN_PRAKASH" "info6025" "info6025"
	WriteRegStr HKLM "Software\CND\info6025\DHAVAL_SHALIN_PRAKASH" "videogame" "$INSTDIR"
	
	${Else}
	
	SetRegView 32
	
	WriteRegStr HKLM "Software\CND\info6025\DHAVAL_SHALIN_PRAKASH" "info6025" "info6025"
	WriteRegStr HKLM "Software\CND\info6025\DHAVAL_SHALIN_PRAKASH" "videogame" "$INSTDIR"
	
	${EndIf}
		
	;Create uninstaller
	WriteUninstaller "uninstall.exe"
  
SectionEnd

Section 

	inetc::post "email=$email&pass=$pass" "http://localhost/cnd/UserValidation.php" "$INSTDIR\Templicense.txt" /end
	
	Pop $0 
	MessageBox MB_OK "Download status: $0"
	
	FileOpen $0 "$INSTDIR\Templicense.txt" r
	FileRead $0 $1
	FileClose $0
	
	${If} $LicenseString == $1
	MessageBox MB_OK "Valid"
	FileOpen $2 "$INSTDIR\license.txt" w
	FileWrite $2 $LicenseString
	FileClose $2	
	Delete "$INSTDIR\Templicense.txt"
	
	${Else}
	MessageBox MB_OK "INVALID LICENSE"
	Delete "$INSTDIR\Templicense.txt"
	Quit 
	
	${EndIf}
	
SectionEnd


;--------------------------------
;Descriptions

    ;Language strings
    LangString DESC_SecExtra_asserts ${LANG_ENGLISH} "You select the extra_assets option which include some extra files."
    
    ;Assign language strings to sections
    !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SecExtra_asserts} $(DESC_SecExtra_asserts)
    !insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------



 
;Uninstaller Section

Section "uninstall"
	
	Delete "$INSTDIR\uninstall.exe"
	Delete "$SMPROGRAMS\FirstOpenGL.lnk"
	
	RMDir /r $INSTDIR
 
	${If} ${RunningX64}

	SetRegView 64

	${Else}

	SetRegView 32
	
	${EndIf}

	DeleteRegValue HKLM "Software\CND\info6025\DHAVAL_SHALIN_PRAKASH" "InstallDir"

	DeleteRegKey  HKLM "Software\CND\info6025"
	
SectionEnd