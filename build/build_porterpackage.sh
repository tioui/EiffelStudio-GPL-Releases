#!/bin/bash
# EiffelStudio Community releases
# Copyright (C) 2021  Louis M
# 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA



export EIFFEL_HOME=/home/eiffel

export ISE_EIFFEL=$EIFFEL_HOME/Eiffel

export EIFFEL_SOURCE=$EIFFEL_HOME/Src

export DELIV_OUTPUT=/home/eiffel/Output

export UNIX_SCRIPT=$EIFFEL_HOME/unix_scripts

if [ ! -f $ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin/ecb -o ! -d $EIFFEL_SOURCE/Src/Delivery/scripts/unix ]; then
	echo "EiffelStudio or Eiffel Source code not found."
else
	export ISE_LIBRARY=$ISE_EIFFEL
	export PATH=$PATH:$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin:$ISE_EIFFEL/tools/spec/$ISE_PLATFORM/bin:$ISE_EIFFEL/library/gobo/spec/$ISE_PLATFORM/bin:$ISE_EIFFEL/esbuilder/spec/$ISE_PLATFORM/bin
	echo ONLY_PORTERPACKAGE=$ONLY_PORTERPACKAGE
	
	export DELIV_LOGDIR=$DELIV_OUTPUT/logs/
	if [ -d "$DELIV_LOGDIR" ]; then
		\rm -rf "$DELIV_LOGDIR"
	fi
	mkdir -p "$DELIV_LOGDIR"

	STUDIO_PORTERPACKAGE_TAR=$DELIV_OUTPUT/PorterPackage.tar.bz2
	if [ -f "$STUDIO_PORTERPACKAGE_TAR" ]; then
		rm $STUDIO_PORTERPACKAGE_TAR
	fi
	if [ -d "PorterPackage" ]; then
		rm -rf PorterPackage
	fi
	cp -rp $EIFFEL_SOURCE/Src/Delivery/scripts/unix $UNIX_SCRIPT
	cp -p $EIFFEL_HOME/vision2_demo/retrieve_build_files $EIFFEL_SOURCE/Src/examples/vision2/widget_test/
	cd $UNIX_SCRIPT
	cp -p $EIFFEL_HOME/build_script/* ./
	./make_delivery
	cp ./*.log $DELIV_LOGDIR/.
	if [ -d "PorterPackage" ]; then
		if [ ! -f "$STUDIO_PORTERPACKAGE_TAR" ]; then
			echo Create tar archive $STUDIO_PORTERPACKAGE_TAR .
			tar cvfj $STUDIO_PORTERPACKAGE_TAR PorterPackage
		fi
		if [ "$ONLY_PORTERPACKAGE" == "true" ]; then
			echo PorterPackage is ready: $STUDIO_PORTERPACKAGE_TAR
		else
			cd PorterPackage
			echo Use PorterPackage with ISE_PLATFORM=$ISE_PLATFORM ...
			./compile_exes $ISE_PLATFORM
			./make_images $ISE_PLATFORM
			cp compile.log $DELIV_LOGDIR/.
			mv Eiffel*.tar.bz2 $DELIV_OUTPUT/.
		fi
	else
		echo Missing PorterPackage!
	fi

fi

