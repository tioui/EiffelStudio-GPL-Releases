EiffelStudio GPL Releases
===============================

This project is used to generate Releases of the GPL licensed EiffelStudio
community edition.

Please note that the source code has been modified to optimise privacy.
The cloud functionnality and the in-app update indicator has been
suppressed.

If you want an untouched version of EiffelStudio, please use the official
EiffelStudio released. You can find them there: https://account.eiffel.com/downloads

Also, if you want to donate for the project, I encourage you to buy an
EiffelStudio license from Eiffel Software. You can buy a license here:
https://www.eiffel.com/eiffelstudio/buy/

Using the script
----------------

```bash
pushd build
cp -rp /usr/local/Eiffel_22.05/ Eiffel
git clone https://github.com/tioui/EiffelStudio.git Src
pushd Src
git checkout <commit>
popd
popd
sudo docker build -f targets/dockerfile_x64 -t "porterpackage_build" .
sudo docker run --name PorterPackage_Build --volume `pwd`/Output:/home/eiffel/Output porterpackage_build
sudo docker container rm PorterPackage_Build
sudo docker image rm porterpackage_build
```

The "es.patch" file can be used to remove unwanted functionnality (Cloud and Update). It will not
necessary work on any commit, so modification may be necessary. You have to use it before building the
docker image (just after the "git checkout <commit>").

```bash
patch -ruN -d build -p0 < es.patch
```

The Output directory now contain the PorterPackage (and the release if you
select "ENV ONLY_PORTERPACKAGE=true" in the dockerfile) is in the Output
directory.

License
-------

    EiffelStudio GPL releases
    Copyright (C) 2023  Louis M

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA


