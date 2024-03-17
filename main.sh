#! /bin/bash

DEBIAN_FRONTEND=noninteractive

# Clone Upstream
git clone -b egismoc-0587 https://gitlab.freedesktop.org/thameruddin/libfprint ./libfprintd-2-2
cp -rvf ./debian ./libfprintd-2-2/
cd ./libfprintd-2-2/

for i in $(cat ../patches/series | grep -v '^#') ; do echo "Applying Patch: $i" && patch -Np1 -i ../patches/$i || bash -c "echo "Applying Patch $i Failed!" && exit 2"; done

# Get build deps
apt-get build-dep ./ -y

# Build package
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
