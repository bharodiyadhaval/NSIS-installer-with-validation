//////////////////////////////////
//////////////////////////////////
EMAIL:username
PASSWORD:password
//////////////////////////////////
//////////////////////////////////

Place provided php file under yourwebappfolder/cnd/UserValidation.php (i.e. c:/xampp/htdocs/cnd)

//////////////////////////////////
//////////////////////////////////

FOR THE NSIS INSTALLER:
SIMPLE COMPILE THE NSIS SCRIPT AND RUN THE INSTALLER(YOU MIGHT BE REQUIRED ZIP.DLL)
Inside the zip file there is a zipDll.zip file which may be require to run the nsis script. In that zip file, there is two type of file

1. (.dll)

2. (.nsh)

you have to copy this (.dll) in this loaction

(C:\Program Files (x86)\NSIS\Plugins\x86-ansi)

and

(C:\Program Files (x86)\NSIS\Plugins\x86-unicode)

For the (.nsh) file, you have to copy in this location

(C:\Program Files (x86)\NSIS\Include)


//////////////////////////////////
//////////////////////////////////

FOR THE VISUAL STUDIO PROJECT :: SIMPLY RUN THE PROJECT IN PLATEFORM X86 
