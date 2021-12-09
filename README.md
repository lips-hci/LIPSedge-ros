# ROS openni 2.0 wrapper for LIPSedge DL/M3 ToF cameras #

### 1. Install the pre-required ROS packages ###

Install ROS according to the version of Ubuntu: http://wiki.ros.org/ROS/Installation

### 2. Install openni2 packages for Ubuntu ###
Make sure you have openni2 package installed
```
$ sudo apt-get install libopenni2-0 libopenni2-dev
```
### 3. Download and install LIPS SDK with ROS support ###
Download link: [LIPS SDK (openni2)](https://filebox.lips-hci.com/index.php/s/hFZwjnwdM68g4lg)

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
NOTE: LIPS SDK package requires OpenCV, please refer this Wiki [page](https://github.com/lips-hci/openni_linux/wiki#install-opencv).

* Install OpenCV 3.4.1 (sources [3.4.1.zip](https://github.com/opencv/opencv/archive/3.4.1.zip)).

*You can install OpenCV 3.4.1 via running provided script opencv3.4.1_installation_in_linux.sh


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

* Select topic /camera/depth/image in rqt
<img src="Screenshot_rqt_depth_image.png" width="300">

* Select topic /camera/rgb/image_raw in rqt
<img src="Screenshot_rqt_rgb_image_raw.png" width="300">

#### NOTE: If you have problem with running rqt, try using image_view ####

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
