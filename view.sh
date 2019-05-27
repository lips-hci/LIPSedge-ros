#!/bin/bash
#
# To view RGB-D
#rosrun image_view image_view image:=/camera/rgb/raw_image &
#rosrun image_view image_view image:=/camera/depth/image &
#
# To view Depth-IR
#rosrun image_view image_view image:=/camera/depth/image &
#rosrun image_view image_view image:=/camera/ir/image &
rqt_image_view
