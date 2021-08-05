EiffelStudio community Releases for Windows
===========================================

Needed files
------------

Programs to install:

- Visual Studio 2015 community edition (Installable via Visual Studio 2017 installer): https://my.visualstudio.com/Downloads?q=visual%20studio%202017
- Visual Studio 2013 express edition: https://my.visualstudio.com/Downloads?q=visual%20studio%202013
- MinGW ou MinGW 64 with the bin directory added to PATH: http://mingw-w64.org/doku.php/download (Prendre le MingW-W64-builds)
- JPsoft 4NT: https://jpsoft.com/
- Mysql server (just for the header files): https://dev.mysql.com/downloads/installer/
- Oracle Database Express Edition (see note) : https://www.oracle.com/database/technologies/xe-downloads.html
- Win-Bash : https://sourceforge.net/projects/win-bash/files/shell-complete/latest/
- EiffelStudio (the same version you are installing): https://sourceforge.net/projects/eiffelstudio/files/
- 7zip with the installation directory added to PATH: https://www.7-zip.org/

----------------------------------------------------------------------------------------------------------
Note: For Oracle Database Express Edition to compile using MinGW compiler, you need to change the file
app\oracle\product\11.2.0\server\oci\include inside the Oracle Database installation directory like this:

Adding the include file (line 9):

#include <inttypes.h>

Also, modify the lines 136 and 137 from:

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
- EIFFEL_SOURCE=Directory of the EiffelStudio source code (the complete GIT, not the Src directory)
- EIFFEL_OUTPUT=Directory that will be used to generate the build
- ORACLE_HOME=Directory of the server directory in the Oracle Database Express installation directory
- MYSQL=The Mysql server installation directory
- WIN_BASH=The Win Bash installation directory

To execute:

- Copy The %EIFFEL_SOURCE%\Src\Delivery\scripts\Windows directory some place (not in the %EIFFEL_SOURCE% or %EIFFEL_OUTPUT% sub directory)
- Copy every files in the current directory (containing this README.md) to the directory that you create before (it will overrite some file, that is normal)
- Copy the gdiplus.dll (if you did get it) in the same delivery scripts directory that you created before
- Start an EiffelStudio command prompt (Be sure, from the first line in the command prompt, that EiffelStudio uses msc and not mingw. If it is mingw, you will have to modify the Windows Registry. See: https://www.eiffel.org/doc/eiffelstudio/Supported_C_compilers)
- From the EiffelStudio command prompt, start 4nt
- From 4nt, set the environment variables
- From 4nt, go into the Delivery Scripts directory that you create before
- Execute `call make_delivery.btm`
- Hope for the best!

For example, here is the command I used to generate the Windows Released (from an EiffelStudio prompt):

```dos
"C:\Program Files (x86)\JPSoft\4NT8\4nt.exe"
cd \Porter_Windows\windows_scripts
set ISE_C_COMPILER_VER=VC120
set EIFFEL_SOURCE=C:\Porter_Windows\EiffelStudio_19.12
set EIFFEL_OUTPUT=C:\Porter_Windows\Output
set ORACLE_HOME=C:\oraclexe64\app\oracle\product\11.2.0\server
set MYSQL=C:\mysql
set WIN_BASH=C:\win-bash
set PATH=%PATH%;C:\7-Zip;C:\mingw-w64\mingw32\bin
call make_delivery.btm
```
