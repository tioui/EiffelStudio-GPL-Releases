@echo off

rem Update ew_eweasel.e to list the latest revision of eweasel.

del/q ew_eweasel.new

setlocal enabledelayedexpansion

set new_rev=000000
rem Replace current revision number with the computed one.
	"%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\sed" -b "s/revision := ""\$Revision.*\$""/revision := ""\$Revision: %new_rev% \$""/" < ew_eweasel.e > ew_eweasel.new

rem Update Eiffel source file with the new one.
	if exist ew_eweasel.new move/y ew_eweasel.new ew_eweasel.e
