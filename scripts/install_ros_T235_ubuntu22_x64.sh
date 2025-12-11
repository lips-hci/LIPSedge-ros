#!/bin/bash
#
#/****************************************************************************
#*                                                                           *
#*  Helper script to install LIPSedge camera driver to ros2 system path      *
#*                                                                           *
#*  Copyright (C) 2025 LIPS Corporation                                      *
#*                                                                           *
#****************************************************************************/
#
# Usage: install_ros_{camera}_{ubuntu distro}_{arch}.sh <option:LIPSedge SDK path>
#
# camera: [M3.DL|L210|AE430.AE470|AE00.AE450|T225|T235]
# ubuntu distro: [ubuntu22|ubuntu24]
# arch: [x64|arm64]
#
# LIPSedge SDK path: path to your LIPSedge SDK folder, e.g. LIPSedge-T225-RGBD-SDK-Linux-amd64-2.4.4.3_v0.9.6

# Check if user is root/running with sudo
if [ "`whoami`" != root ]; then
    echo ""
    echo Need sudo permission to continue installation:
    sudo "$0" "$@"
    exit $?
fi

#SCRIPT_PATH=`pwd`
#cd `dirname $0`
#SDK_ROOT=`pwd`
#cd $SCRIPT_PATH

function show_usage() {
  printf "\nUsage: $(basename $0) <option:LIPSedge SDK path>\n"
  exit 1
}

# case 1: if NO user input, determine SDK path from env variable: OPENNI2_REDIST
# -> if OPENNI2_REDIST cannot be read, prompt user to remember to source the file OpenNIDevEnvironment in SDK -> exit
#
# case 2: if user input arg, use it as LIPSedge SDK path
#
if [ ! -z "$1" ] && [ -e "$1" ] && [ -d "$1/Redist" ]; then
  SDK_ROOT="$1/Redist"
  #printf "With arg1\n"
elif [ -z "$1" ] && [ ! -z "${OPENNI2_REDIST}" ]; then
  SDK_ROOT="${OPENNI2_REDIST}"
  #printf "Wihtout arg\n"
elif [ -z "$SDK_ROOT" ]; then
  printf "Cannot find env variable 'OPENNI2_REDIST'. Please source the file OpenNIDevEnvironment in LIPSedge SDK"
  show_usage
else
  show_usage
fi

printf "SDK path found: ${SDK_ROOT}\n"

# Declare camera string
DEVICE=T225-RGBD
DEVICE_STRING=T225-RGBD

LIB_LD=/lib/x86_64-linux-gnu
if [ -e $LIB_LD ] && [ ! -d "$LIB_LD/OpenNI2/Drivers" ]; then
  printf "Cannot find OpenNI2 Drivers in /lib, maybe you can run 'apt install libopenni2-0 libopenni2-dev' to install missing packages."
  exit 1
fi

# Install drivers for ROS environment
function main() {
  #install driver to /usr/lib/OpenNI2/Drivers if found
  if [ -d $LIB_LD/OpenNI2/Drivers ]; then
    [ -e $USR_LIB/OpenNI2/Drivers/libLIPSedge-${DEVICE}.so.0 ] && rm -f $USR_LIB/OpenNI2/Drivers/libLIPSedge-${DEVICE}.so.0
    ln -sf $SDK_ROOT/OpenNI2/Drivers/libLIPSedge-${DEVICE}.so $LIB_LD/OpenNI2/Drivers/libLIPSedge-${DEVICE}.so.0
    # No links to OpenNI2/Drivers or calib/ after SDK v0.9.6.2
    #ln -sf $SDK_ROOT/OpenNI2 OpenNI2
    #ln -sf $SDK_ROOT/calib calib
    printf "Creating lib,calib,OpenNI2 links in $LIB_LD"
  fi
}

if [ "`uname -s`" != "Darwin" ]; then
  main
  printf "\nFinished.\n"
  exit 0
fi