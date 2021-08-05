#!/bin/sh
# EiffelStudio Community releases
# Copyright (C) 2021 Eiffel Software and Louis M
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


# set version number in $3 to the latest SVN repository version number.
# $1 = SVN repository
# $2 = pattern to transform
# $3 = file to process if any, otherwise display version on output

computed_revision=`grep "ISE_BUILD_LATEST="  $EIFFEL_SOURCE/Src/web/eiffel-org/www-setup/install.sh | sed -e "s/^.*ISE_BUILD_LATEST=//"`
if [ "$2" = "" -o "$3" = "" ]; then
        echo $computed_revision
else
        sed -e "s/$2/$computed_revision/" $3 > tmp
        mv tmp $3
fi
