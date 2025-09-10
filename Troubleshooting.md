* [Error message: "No matching devices have been found"](Toubleshooting.md#No-matching-devices-have-been-found)
-----
### No matching devices have been found

- If you launch and see such error message, please try below steps.

  - Download script from LIPS support site. [ros/ros2 helper scripts](https://fbox.lips-hci.com/s/boCcXcJrK8Zg9Kq)
  - Place install script inside your camera LIPSedge SDK and run it.

The script file name looks as *install_ros_{camera}_{os version}.sh*, select your camera model and OS version.

Below screenshot we use LIPSedge L210 camera as example, assume OS is Ubuntu 22.04.

![LIPSedge L210 SDK directory](no_matching_devices_sdk_dir.png)

```
$ sudo ./install_ros_L210_ubuntu22.sh
```
