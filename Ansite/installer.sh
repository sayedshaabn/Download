#!/bin/sh
# ###########################################
# SCRIPT : DOWNLOAD AND INSTALL ANSITE
# ###########################################
#
# Command: wget https://raw.githubusercontent.com/MOHAMED19OS/Download/main/Ansite/installer.sh -qO - | /bin/sh
#
# ###########################################

###########################################
# Configure where we can find things here #
TMPDIR='/tmp'
PACKAGE='enigma2-plugin-extensions-ansite'
MY_URL='https://raw.githubusercontent.com/MOHAMED19OS/Download/main/Ansite/'

####################
#  Image Checking  #

if which opkg > /dev/null 2>&1; then
    STATUS='/var/lib/opkg/status'
    OSTYPE='Opensource'
    OPKG='opkg update'
    OPKGINSTAL='opkg install'
    OPKGREMOV='opkg remove --force-depends'
fi

if python --version 2>&1 | grep -q '^Python 3\.'; then
    echo "You have Python3 image"
    sleep 1; clear
    VERSION='1.4'
else
    echo "You have Python2 image"
    sleep 1; clear
    VERSION='1.3'
fi

##################################
# Remove previous files (if any) #
rm -rf $TMPDIR/${PACKAGE}*

######################
#  Remove Old Plugin #
if grep -qs "Package: $PACKAGE" $STATUS ; then
    echo "Remove old version..."
    $OPKGREMOV $PACKAGE
    sleep 1; clear
else
    echo "No older version was found on the device... "
    sleep 1; clear
fi

echo "Opkg Update ..."
$OPKG > /dev/null 2>&1

###################
#  Install Plugin #
if python --version 2>&1 | grep -q '^Python 3\.'; then
    echo "Downloading And Insallling Ansite plugin Please Wait ......"
    wget $MY_URL/${PACKAGE}_${VERSION}_all.ipk -qP $TMPDIR
    $OPKGINSTAL $TMPDIR/${PACKAGE}_${VERSION}_all.ipk
else
    echo "Downloading And Insallling Ansite plugin Please Wait ......"
    wget $MY_URL/${PACKAGE}_${VERSION}_all.ipk -qP $TMPDIR
    $OPKGINSTAL $TMPDIR/${PACKAGE}_${VERSION}_all.ipk
fi

#########################
# Remove files (if any) #
rm -rf $TMPDIR/${PACKAGE}*


sleep 2; clear
echo ""
echo "***********************************************************************"
echo "**                                                                    *"
echo "**                       Ansite     : $VERSION                             *"
echo "**                       Uploaded by: MOHAMED_OS                      *"
echo "**                       Develop by : aime_jeux                       *"
echo "**  Support    : https://www.tunisia-sat.com/forums/threads/4209147/  *"
echo "**                                                                    *"
echo "***********************************************************************"
echo ""

exit 0
