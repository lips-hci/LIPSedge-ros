#!/bin/bash
catkin_make
source ./devel/setup.bash
roslaunch openni2_launch lips_DL.launch
