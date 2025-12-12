* [Error message: "No matching devices have been found"](#no-matching-devices-have-been-found)
* [RLException: [lipsedge_T235.launch] is neither a launch file in package [openni2_camera] nor is [openni2_camera] a launch file name](#rlexception)

-----
### No matching devices have been found

- If you launch and see such error message, please try below steps.

  - Use helper script in the directory [scripts](https://github.com/lips-hci/LIPSedge-ros/tree/ros1/scripts)
  - Put helper script inside your LIPSedge™ camera SDK and run it.

The script file name looks as *install_ros_{camera}_{os version}.sh*, select your camera model and OS version.

Below screenshot we use LIPSedge™ L210 camera as example, assume OS is Ubuntu 22.04.

![LIPSedge L210 SDK directory](no_matching_devices_sdk_dir.png)

```
$ cd LIPSedge-L210-SDK-Linux-amd64-2.4.4.2_v1.6.0
$ sudo ./install_ros_L210_ubuntu22.sh
```

### RLException

- message shows [lipsedge_T235.launch] is neither a launch file in package [openni2_camera] nor is [openni2_camera] a launch file name
```
workspace# roslaunch openni2_camera lipsedge_T235.launch
RLException: [lipsedge_T235.launch] is neither a launch file in package [openni2_camera] nor is [openni2_camera] a launch file name
The traceback for the exception was written to the log file
```
- Remember to source **setup.bash** before running launch
- It's possible you are using wrong package, the correct package name is **openni2_launch**
```
$ cd ~/workspace
$ source ./devel/setup.bash
$ roslaunch openni2_launch lipsedge_T235.launch
```
