# ROS openni2 wrapper for LIPSedge™ DL/M3

In this page we provided examples using LIPSedge™ DL/M3 camera.

NOTE: if you are using ROS2, here is our ROS2 wrapper installation guide. [LIPSedge-ros2](https://github.com/lips-hci/LIPSedge-ros2)

1. [Install dependent packages](#install-dependent-packages)
2. [Install LIPSedge camera SDK](#install-lipsedge-camera-sdk)
3. [Get openni2 wrapper source](#get-openni2-wrapper-source)
4. [Build wrapper and launch openni2_camera](#build-wrapper-and-launch-openni2_camera)
5. [Launch rqt viewer](#launch-rqt-viewer)
6. [Troubleshooting](Troubleshooting.md)

### Install dependent packages

- ros: setup ROS environment according to your Ubuntu distro: http://wiki.ros.org/ROS/Installation

- openni2: make sure lib openni2 package is installed
```
$ sudo apt-get install libopenni2-0 libopenni2-dev
```

### Install LIPSedge camera SDK

Download LIPSedge™ DL/M3: [SDK (openni2 compliant)](https://filebox.lips-hci.com/index.php/s/hFZwjnwdM68g4lg)

NOTE:
* system requirement: Ubuntu 18.04/16.04 or later (currently only 64-bit version is supported)

Then install it to your system.

For example:
* Run install.sh and it will install libraries to system automatically.
```
$ tar -xzf LIPS-Linux-x64-OpenNI2.2.tar.gz
$ cd LIPS-Linux-x64-OpenNI2.2
$ ./install.sh
```
NOTE: LIPSedge™ SDK package may require OpenCV, please refer this Wiki [page](https://github.com/lips-hci/openni_linux/wiki#install-opencv).

* Install OpenCV 3.4.1 (sources [3.4.1.zip](https://github.com/opencv/opencv/archive/3.4.1.zip)).

*You can install OpenCV 3.4.1 via running provided script opencv3.4.1_installation_in_linux.sh


### Get openni2 wrapper source
This wrapper is modified to add support for video mode QQQVGA (80x60@30Hz).

You have to rebuild and install it on your ROS

```
$ mkdir -p ~/LIPSedge_ws/src
$ cd ~/LIPSedge_ws/src
$ catkin_init_workspace
$ git clone https://github.com/lips-hci/LIPSedge-ros
```

### Build wrapper and launch openni2_camera

* For LIPSedge™ DL camera

```
$ cd ~/LIPSedge_ws
$ ln -s src/openni2_camera/run_DL.sh .
$ ./run_DL.sh
```

* For LIPSedge™ M3 camera

```
$ cd ~/LIPSedge_ws
$ ln -s src/openni2_camera/run_M3.sh .
$ ./run_M3.sh
```

### Launch rqt viewer

Now you can check depth/ir/rgb images, make sure LIPSedge™ camera is already connected to your host PC.

```
$ cd ~/LIPSedge_ws
$ ln -s src/openni2_camera/view.sh .
$ ./view.sh
```

* Select topic /camera/depth/image in rqt
<img src="Screenshot_rqt_depth_image.png" width="300">

* Select topic /camera/rgb/image_raw in rqt
<img src="Screenshot_rqt_rgb_image_raw.png" width="300">

- NOTE: If you have problem with running rqt, try using image_view

* To view Depth image
```
$ rosrun image_view image_view image:=/camera/depth/image
```
* To view IR image
```
$ rosrun image_view image_view image:=/camera/ir/image
```
* To view RGB image
```
$ rosrun image_view image_view image:=/camera/rgb/image_raw
```
