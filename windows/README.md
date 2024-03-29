EiffelStudio community Releases for Windows
===========================================

Needed files
------------

Programs to install:

- VC++ toolset 2015 (Installable via Visual Studio 2017 installer): https://my.visualstudio.com/Downloads?q=visual%20studio%202017
- Windows 10 SDK (Installable via Visual Studio 2017 installer)
- .NET framework 3.5 development tools (Installable via Visual Studio 2017 installer)
- Visual Studio 2013 express edition: https://my.visualstudio.com/Downloads?q=visual%20studio%202013
- MinGW ou MinGW 64 avec le répertoire bin ajouté au PATH: http://mingw-w64.org/doku.php/download (Prendre le MingW-W64-builds)
- JPsoft 4NT: https://jpsoft.com/
- Mysql server (just for the header files): https://dev.mysql.com/downloads/installer/
- Oracle Database Express Edition (see note) : https://www.oracle.com/database/technologies/xe-downloads.html
- Win-Bash : https://sourceforge.net/projects/win-bash/files/shell-complete/latest/
- EiffelStudio (the same version you are installing): https://sourceforge.net/projects/eiffelstudio/files/
- 7zip avec le répertoire d'installation ajouté au PATH: https://www.7-zip.org/

----------------------------------------------------------------------------------------------------------
Note: For Oracle Database Express Edition to compile using MinGW compiler, you need to change the file
app\oracle\product\11.2.0\server\oci\include\oratypes.h inside the Oracle Database installation directory like this:

Adding the include file (line 9):

#include <inttypes.h>

Also, modify the lines 236 and 237 from:

typedef unsigned _int64 ubig_ora;     
typedef   signed _int64 sbig_ora; 

to:

typedef uint64_t ubig_ora;
typedef int64_t sbig_ora;
----------------------------------------------------------------------------------------------------------

Other file needed:

- gdiplus.lib (Not sure if it is really usefull since it seems to be only for Visual Studio 2012 and less; but just to be sure)

Execution
---------

You have to set the environment variables:

- ISE_C_COMPILER_VER=VC120
- ISE_C_COMPILER=msc
- ISE_VC_MSC=VC120
- ISE_VC_MSC_VC140=VC140
- EIFFEL_SOURCE=Directory of the EiffelStudio source code (the complete GIT, not the Src directory)
- EIFFEL_OUTPUT=Directory that will be used to generate the build
- ORACLE_HOME=Directory of the server directory in the Oracle Database Express installation directory
- MYSQL=The Mysql server installation directory
- WIN_BASH=The Win Bash installation directory

To execute:

- Copy every files in the current directory (containing this README.md) some place (not in the %EIFFEL_SOURCE% or %EIFFEL_OUTPUT% sub directory)
- Copy the gdiplus.dll (if you did get it) in the same delivery scripts directory that you created before
- Start an EiffelStudio command prompt (Be sure, from the first line in the command prompt, that EiffelStudio uses msc and not mingw. If it is mingw, you will have to modify the Windows Registry. See: https://www.eiffel.org/doc/eiffelstudio/Supported_C_compilers)
- From the EiffelStudio command prompt, start 4nt
- From 4nt, set the environment variables
- From 4nt, go into the Delivery Scripts directory that you create before
- Execute `call make_delivery.btm no_msi`
- Hope for the best!

For example, here is the command I used to generate the Windows Released (from an EiffelStudio prompt):

```dos
"C:\program\4nt\4nt.exe"
cd C:\install\windows
set ISE_VC_MSC=VC120
set ISE_VC_MSC_VC140=VC140
set ISE_C_COMPILER=msc
set ISE_C_COMPILER_VER=VC120
set EIFFEL_SOURCE=C:\install\Src
set EIFFEL_OUTPUT=C:\install\Output
set ERROR_LOG=%EIFFEL_OUTPUT%\error.log
set INSTALL_LOG=%EIFFEL_OUTPUT%\install.log
set ORACLE_HOME=C:\program\oraclexe\app\oracle\product\11.2.0\server
set MYSQL=C:\program\mysql
set WIN_BASH=C:\program\shell
set PATH=%PATH%;C:\Program Files\7-Zip
call make_delivery.btm no_msi
```

Note that you can une the "es.patch" file to remove unwanted functionnality
(Cloud and Update). You have to use it on the %EIFFEL_SOURCE% directory
before calling the "call make_delivery.btm no_msi".
