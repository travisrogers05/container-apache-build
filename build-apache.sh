#!/bin/bash

#
# Example command to build the container:
#   podman build -t example/apache-builder:1 .
#
# Example command to run the container:
#   podman run --rm -it -v /tmpdir:/tmp/output:z example/apache-builder:1
#
# Where /tmpdir is a host directory mounted to /tmp/output within the container.
# The :z at the end of the container mount path is for SElinux host systems.

# Retrieve the latest Apache HTTPd source code and compile it
CURVERSION=`curl -s http://httpd.apache.org/download.cgi | grep '(released ' | egrep -o "[0-9]+\.[0-9]+\.[0-9]+"`
ARCHIVE=httpd-$CURVERSION.tar.gz
SHORTARCHIVE=httpd-$CURVERSION
DOWNLOADURL=https://downloads.apache.org/httpd
echo "*** Downloading $DOWNLOADURL/$ARCHIVE ***"
wget -q $DOWNLOADURL/$ARCHIVE
echo "*** Expanding $ARCHIVE ***"
tar xvzf $ARCHIVE
cd $SHORTARCHIVE
echo "*** Running configure script ***"
./configure
echo "*** Running make ***"
make
sha256sum ./httpd > /tmp/output/SHA256
cat /tmp/output/SHA256
cp ./httpd /tmp/output
touch /tmp/output/RELEASE-$SHORTARCHIVE
echo "*** Built $SHORTARCHIVE successfully ***"
