# ROS openni 2.0 wrapper for LIPSedge DL/M3 ToF cameras #

### 1. Install the pre-required ROS packages ###

* For Ubuntu 16.04 with ROS Kinetic
```
$ sudo apt-get install ros-kinetic-rgbd-launch
```
* For Ubuntu 14.04 with ROS Indigo
```
$ sudo apt-get install ros-indigo-rgbd-launch
```
### 2. Install openni2 packages for Ubuntu ###
Make sure you have openni2 package installed
```
$ sudo apt-get install libopenni2-0 libopenni2-dev
```
### 3. Download and install LIPS SDK with ROS support ###
Download SDK package (.deb format) from [LIPS SDK](https://www.lips-hci.com/downloads/category)
* Select your system: Ubuntu 14.04/16.04 (currently only 64bit version is supported)
* Select the Platform: ROS (openni2)

Then install it to your system.

For example:
```
$ sudo dpkg -i ROS-libmodule-lips2_1.5.0.7_amd64.deb
```
### 4. Download openni 2.0 wrapper source ###
This wrapper is modified to add support for video mode QQQVGA (80x60@30Hz).

You have to rebuild and install it on your ROS
```
$ mkdir -p ~/LIPSToF_ws/src
$ cd ~/LIPSToF_ws/src
$ catkin_init_workspace
$ git clone https://github.com/lips-hci/openni2_camera
```
### 5. Build and launch services ###
* For LIPSedge DL ToF camera
```
$ cd ~/LIPSToF_ws
$ ln -s src/openni2_camera/run_DL.sh .
$ ./run_DL.sh
```
* For LIPSedge M3 ToF camera
```
$ cd ~/LIPSToF_ws
$ ln -s src/openni2_camera/run_M3.sh .
$ ./run_M3.sh
```
### 6. Launch viewer to check depth/ir/rgb images ###
Make sure LIPSedge ToF camera is already connected to your host PC.
```
$ cd ~/LIPSToF_ws
$ ln -s src/openni2_camera/view.sh .
$ ./view.sh
```
