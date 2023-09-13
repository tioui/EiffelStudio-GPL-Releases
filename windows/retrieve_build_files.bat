@echo off
if .%1. == .. (
set SVN_URL=https://svn.origo.ethz.ch/eiffelstudio/trunk
) else (
set SVN_URL=%*
)

REM Check out bitmaps from Build delivery
md Delivery
md Delivery\esbuilder
echo xcopy %EIFFEL_SOURCE%\Src\Delivery\esbuilder\bitmaps Delivery\esbuilder\bitmaps /E /I /Y 
xcopy %EIFFEL_SOURCE%\Src\Delivery\esbuilder\bitmaps Delivery\esbuilder\bitmaps /E /I /Y < NUL

REM Check out files from vision2_demo
echo xcopy %EIFFEL_SOURCE%\Src\Delivery\vision2_demo Delivery\vision2_demo /E /I /Y
xcopy %EIFFEL_SOURCE%\Src\Delivery\vision2_demo Delivery\vision2_demo /E /I /Y > NUL

REM Copy template files
XCOPY /Y /E /I Delivery\vision2_demo\templates .\templates

REM Copy icons for different widget types across. The /E option moves the whole directory structure.
XCOPY /Y /E /I Delivery\esbuilder\bitmaps .\bitmaps

REM Copy icons for standard buttons.
XCOPY /Y Delivery\vision2_demo\bitmaps\ico\documentation.ico .\bitmaps\ico\
XCOPY /Y Delivery\vision2_demo\bitmaps\ico\testing.ico .\bitmaps\ico\
XCOPY /Y Delivery\vision2_demo\bitmaps\ico\properties.ico .\bitmaps\ico\
XCOPY /Y Delivery\vision2_demo\bitmaps\ico\size_down.ico .\bitmaps\ico\
XCOPY /Y Delivery\vision2_demo\bitmaps\ico\size_up.ico .\bitmaps\ico\
XCOPY /Y Delivery\vision2_demo\bitmaps\png\image1.png .\bitmaps\png\
XCOPY /Y Delivery\vision2_demo\bitmaps\png\image2.png .\bitmaps\png\

REM Copy image used for executable icon.

XCOPY /Y %EIFFEL_SRC%\library\vision2\Clib\default_vision2_icon.ico .
ren default_vision2_icon.ico vision2_demo.ico


REM Remove all temporary checked out files.
rd /Q /S Delivery
