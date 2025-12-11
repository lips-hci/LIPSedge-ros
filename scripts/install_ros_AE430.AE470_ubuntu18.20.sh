#!/bin/bash
#
#/****************************************************************************
#*                                                                           *
#*  LIPSedge SDK commandline installer for Linux                             *
#*                                                                           *
#*  Copyright (C) 2023 LIPS Corporation                                      *
#*                                                                           *
#****************************************************************************/
#LIPSedge-AE430_AE470-SDK-Linux-amd64-2.4.4.2_v1.3.3

# Check if user is root/running with sudo
if [ "`whoami`" != root ]; then
    echo ""
    echo Need sudo permission to continue installation:
    sudo "$0" "$@"
    exit $?
fi

ORIG_PATH=`pwd`
cd `dirname $0`
SDK_ROOT=`pwd`
cd $ORIG_PATH

# Declare camera string
DEVICE=AE430_AE470
DEVICE_STRING=AE430/AE470

function show_welcome() {
    read whiptail <<< "$(which whiptail dialog 2> /dev/null)"

    # exit if none found
    [[ "$whiptail" ]] || {
        echo ""
        echo "Bye bye. (you can run install.sh to launch installation)."
        echo ""
        exit 0
    }

    # use whiptail to create yes/no dialog to prompt user for installation
    if ("$whiptail" \
        --title "Setup - LIPSedge $DEVICE_STRING SDK for Linux" \
        --yesno --yes-button "Install" --no-button "Cancel" \
        "Ready to extract SDK on your computer and run installation.\n(operation requires superuser privilege)" 8 78); then
        "$whiptail" --title "Release Notes" \
        --ok-button "Next" --textbox ReleaseNotes.txt 30 78
        echo ""
        echo "Continue to install SDK ..."
        echo ""
    fi

    # TODO: dialog version
    #"$dialog" --msgbox "Message displayed with $dialog" 0 0
}

usage="
Usage: $0 [OPTIONS]
Installs OpenNI to current machine.

-i,--install
    Installs OpenNI (default mode)
-u,--uninstall
    Uninstalls OpenNI.
-h,--help
    Shows this help screen.
"
# parse command line
while [ "$1" ]; do
    case $1 in
    -i|--install)
        install=yes
        ;;
    -u|--uninstall)
        uninstall=yes
        ;;
    -h|--help)
        echo "$usage"
        exit 0
        ;;
    *)
        echo "Unrecognized option $1"
        exit 1
    esac
    shift
done
# default mode is install
if [ ! "$install" = yes ] && [ ! "$uninstall" = yes ]; then
    install=yes
fi

# validity check
if [ "$install" = yes ] && [ "$uninstall" = yes ]; then
    echo "-i and -u flags cannot be used together!"
    exit 1
fi

# Declare dependent package
DEB_PKG=lipsedge-sdk-0_1.1.1_amd64.deb
PKG_NAME=lipsedge-sdk-0

function pre-install {
    sudo apt-get install whiptail -y
}

function install_deb-0 {
    # Install UDEV rules for USB device and auto fix broken packages for us
    sudo apt -f install ./bin/$DEB_PKG -y
}

function install_ros2 {
    USR_LIB=$rootfs/usr/lib
    USR_LOCAL=$rootfs/usr/local
    # Install drivers for ROS environment
    if [ -d $USR_LIB/OpenNI2/Drivers ]; then
        #install driver to /usr/lib/OpenNI2/Drivers if found
        [ -e $USR_LIB/OpenNI2/Drivers/libLIPSedge-${DEVICE}.so ] && rm -f $USR_LIB/OpenNI2/Drivers/libLIPSedge-${DEVICE}.so
        cp -pf $SDK_ROOT/Redist/OpenNI2/Drivers/libLIPSedge-${DEVICE}.so $USR_LIB/OpenNI2/Drivers/libLIPSedge-${DEVICE}.so.0
        cp -pf $SDK_ROOT/Redist/OpenNI2/Drivers/network.json $USR_LIB/OpenNI2/Drivers/network.json
        cp -pf $SDK_ROOT/Redist/OpenNI2/Drivers/librealsense2z.so.2.43.0 $USR_LIB/OpenNI2/Drivers/librealsense2z.so.2.43.0
        cd $USR_LIB/OpenNI2/Drivers
        ln -sf libLIPSedge-${DEVICE}.so.0 libLIPSedge-${DEVICE}.so
        ln -sf librealsense2z.so.2.43.0 librealsense2z.so.2.43
        ln -sf librealsense2z.so.2.43 librealsense2z.so
        cd - > /dev/null

        #install OpenNI.ini to /usr/lib/
        [ -f $SDK_ROOT/Redist/OpenNI.ini ] && cp $SDK_ROOT/Redist/OpenNI.ini $USR_LIB/
        printf "install driver for ROS package OpenNI2 - OK\n"
    fi
}

if [ "$install" = yes ]; then

    if [ "`uname -s`" != "Darwin" ]; then
        pre-install
    fi

    # depends to whiptail package, so install_deb-0 requires to run FIRST!
    show_welcome

    if [ "`uname -s`" != "Darwin" ]; then
        install_deb-0
        install_ros2
        printf "install udev rule - OK\n"
        if [ "$ros" = yes ]; then
            install_ros2
        fi
    fi

    printf "\nLIPSedge-${DEVICE} SDK is extracted to '$(basename $SDK_ROOT)'\n"

    OUT_FILE="$SDK_ROOT/OpenNIDevEnvironment"
    echo "export OPENNI2_INCLUDE=$SDK_ROOT/Include" > $OUT_FILE
    echo "export OPENNI2_REDIST=$SDK_ROOT/Redist" >> $OUT_FILE
    chmod a+r $OUT_FILE
    printf "\nTips: source OpenNIDevEnvironment to get OPENNI2 include/lib path for development\n"
    printf "\nDONE!\n"
fi

if [ "$uninstall" = yes ]; then
    sudo dpkg -r $PKG_NAME
    printf "\nuninstall udev rule - OK\n"
    printf "\nDONE!\n"
fi
