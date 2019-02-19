#!/bin/bash
catkin_make
source ./devel/setup.bash
roslaunch openni2_launch lips_M3.launch
