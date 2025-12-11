# ROS wrapper for OpenNI2 using LIPSedge™ camera T235

We have tested LIPSedge™ T235 camera in [ros1 noetic](https://hub.docker.com/r/osrf/ros/tags?name=noetic) docker container.
For other distro, we are not sure, if you have any request or need any support. Please mail [LIPS](https://www.lips-hci.com/contact) us.

1. [Installation](#installation)
2. [Get wrapper source](#get-wrapper-source)
3. [Build and run driver](#build-and-run-driver)
4. [Launch rqt viewer](#launch-rqt-viewer)
5. [Troubleshooting](Troubleshooting.md)

## Installation

#### dependent packages

 * Install openni2 packages
 ```
 $ sudo apt-get install libopenni2-0 libopenni2-dev
 ```
 
#### LIPSedge™ camera T235 SDK

[Download](https://www.lips-hci.com/lipssdk) latest LIPSedge™ T235 SDK and install it.
```
for example,
$ chmod +x LIPSedge-T225-RGBD-SDK-Linux-amd64-2.4.4.3_v0.9.6.2.xz.run
$ ./LIPSedge-T225-RGBD-SDK-Linux-amd64-2.4.4.3_v0.9.6.2.xz.run
```

Follow steps on screen to finish installation or run below command to install SDK again.
```
$ cd LIPSedge-T225-RGBD-SDK-Linux-amd64-2.4.4.3_v0.9.6.2
$ sudo ./install.sh
```

## Get wrapper source

Clone this repository and build it in ROS environment

```
$ mkdir -p ~/LIPSedge_ws/src
$ cd ~/LIPSedge_ws/src
$ catkin_init_workspace
$ git clone https://github.com/lips-hci/LIPSedge-ros1
```

#### Setup OpenNI Dev Environment

Before running ros launch script, you have to deploy LIPSedge™ camera driver to system.
```
$ cd LIPSedge-T225-RGBD-SDK-Linux-amd64-2.4.4.3_v0.9.6.2
$ source OpenNIDevEnvironment
```

Run helper script in ros workspace source.
```
$ cd ~/LIPSedge_ws/src
$ ./scripts/install_ros_T235_ubuntu20_x64.sh
SDK path found: /home/chengt/test/LIPSedge-T225-RGBD-SDK-Linux-amd64-2.4.4.3_v0.9.6.2/Redist
Creating lib,calib,OpenNI2 links in /lib/x86_64-linux-gnu
Finished.
```

Make sure LIPSedge™ T235 driver library has been installed to OpenNI2 Drivers repo in the system, you can see virtual link created for LIPSedge™ camera driver lib.
```
# ls -l /lib/x86_64-linux-gnu/OpenNI2/Drivers/
```
<img src="check_link_in_openni2_driver_repo.png" width="800">

## Build and run driver

```
$ cd ~/LIPSedge_ws
$ catkin_make
$ source ./devel/setup.bash
$ roslaunch openni2_launch lips_T235.launch
```

## Launch rqt viewer

Connect LIPSedge camera to your host PC and use rqt to view stream topics.
```
$ cd ~/LIPSToF_ws
$ rqt_image_view
```

* Select topic */camera/depth/image* in rqt
<img src="Screenshot_rqt_depth_image.png" width="300">

* Select topic */camera/rgb/image_raw* in rqt
<img src="Screenshot_rqt_rgb_image_raw.png" width="300">

#### OR you can try image_view if you got problem with running rqt.

* View Depth image
```
$ rosrun image_view image_view image:=/camera/depth/image
```
* View IR image
```
$ rosrun image_view image_view image:=/camera/ir/image
```
* View RGB image
```
$ rosrun image_view image_view image:=/camera/rgb/image_raw
```
