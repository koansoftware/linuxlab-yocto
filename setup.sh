#
# LinuxLAB setup
#
# Project link: https://github.com/koansoftware/linuxlab-yocto
#

WORKDIR="/workdir"
POKYDIR="/workdir/poky"
BUILDDIR="/workdir/poky/build"

echo " "
echo "---> Clone Poky from the Yocto Project"
cd ${WORKDIR}
git clone git://git.yoctoproject.org/poky -b sumo

echo " "
echo "---> Run the first environment setup"
cd ${POKYDIR}
source oe-init-build-env

echo " "
echo "---> Modify the existing default configuration"
cp ${WORKDIR}/linuxlab-yocto/linuxlab-koan-local.conf ${BUILDDIR}/conf/local.conf

echo " "
echo "---> Start the first (long) build"
cd ${POKYDIR}
bitbake -k core-image-minimal

echo " "
echo "---> Setup completed, see you soon!"


#EOF
