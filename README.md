VxWorks® 7 ROS2 Build Scripts
===
---

# Overview

The VxWorks 7 ROS2 Build Scripts provide build scripts to automate building
ROS2 with a VxWorks SDK.

The Robot Operating System 2 is a set of software libraries and tools that
aid in building robot applications. ROS2 is a re-architecture of the
framework to include support for new use cases.

These new use cases include:
* Teams of multiple robots
* Small embedded platforms
* Real-time systems
* Non-ideal networks
* Production environment
* Design patterns for building and structuring systems


The default configuration build configuration will build a minimal set of
ROS2 packages necessary for running the example applications.

This configuration is suited for prototyping and personal
use.  Please refer to the details of each individual ROS2 package for details
on what requirements and terms of use they may have.

*NOTE*: ROS2 is not part of any VxWorks® product. If you need help,
use the resources available or contact your Wind River sales representative
to arrange for consulting services.

# Project License

The source code for this project is provided under the Apache 2.0 license license.
Text for the ROS2 dependencies and other applicable license notices can be found in
the LICENSE file in the project top level directory. Different
files may be under different licenses. Each source file should include a
license notice that designates the licensing terms for the respective file.

*NOTE*: Your use of the VxWorks SDK is subject to the non-commercial use
license agreement that accompanies the software (the "License"). To review
the License, please read the file NCLA.txt which can be viewed from a
browser here: Non-Commercial License Agreement.

By downloading, installing or using the software, you acknowledge that you
have read, understand, and are agreeing to the terms of the License.
Subject to the License, you can proceed to download the VxWorks SDK.

# Prerequisite(s)

* Download a VxWorks Software Development Kit from Wind River Labs
   * https://labs.windriver.com/downloads/wrsdk.html

* The build system will need to download source code from github.com and bitbucket.org.  A
  working Internet connection with access to both sites is required.

For the standard build you must also have:

* Supported Linux host for both ROS2 and VxWorks 7
   * ROS 2.0 Target Platforms
      * http://www.ros.org/reps/rep-2000.html
   * VxWorks 7 SR0640
      * https://docs.windriver.com/bundle/vxworks_7_release_notes_sr0640/page/bym1551818657142.html
   * For ROS2 Dashing Diademata, Ubuntu Bionic (18.04) 64-bit LTS is the Tier 1 host
* Install the development tools and ROS tools from “Building ROS 2 on Linux”
   * https://index.ros.org/doc/ros2/Installation/Dashing/Linux-Development-Setup/
* Install the “Required Linux Host OS Packages”  for VxWorks 7
   * https://docs.windriver.com/bundle/2020_03_Workbench_Release_Notes_SR0640_1/page/age1436590316395.html
* Mercurial (hg) package for Eigen (optional)

## Directory Structure
Packages
```
├── Docker
├── Makefile
├── pkg
│   ├── asio
│   ├── colcon
│   ├── python
│   ├── ros2
│   ├── sdk
│   ├── tinyxml2
│   ├── turtlebot3
│   └── unixextra
```
It uses Makefile to invoke ros2 and turtlebot3 colcon build, and also build some dependencies.
A Docker (Ubuntu 18.04) based build is used to avoid a necessity for installing build dependencies.
Build Artifacs
```
├── build      - pkg build artifacts
├── downloads  - download arctifacts
├── export     
    ├── deploy - a ready-to-deploy filesystem with ROS2 libraries and binaries
    └── root   - a development artifacts with ROS2 libraries and headers
``` 

## ROS2 VxWorks patches
ROS2 patches for VxWorks are located in the separate repository
https://github.com/Wind-River/vxworks7-layer-for-ros2

It is cloned during the build to the *patches* dir
```
├── pkg
│   ├── ros2
│   │   ├── patches

```
## Build VxWorks 7 and ROS2

Clone this repository using the master branch
```
git clone https://github.com/Wind-River/vxworks7-ros2-build.git
cd vxworks7-ros2-build
```

Build Docker image
```
cd Docker/vxbuild
docker build -t vxbuild:1.0 .
cd Docker/vxros2build
docker build -t vxros2build:1.0 .
```

Download the VxWorks SDK for IA - UP Squared from https://labs.windriver.com/downloads/wrsdk.html
```
wget https://labs.windriver.com/downloads/wrsdk-vxworks7-up2-1.7.tar.bz2
```

Extract the VxWorks SDK tarball
```
tar –jxvf wrsdk-vxworks7-up2-1.7.tar.bz2
```

Run Docker image

```bash
cd vxworks7-ros2-build
docker run -ti -v <path-to-the-wrsdk>:/wrsdk -v $PWD:/work vxros2build:1.0
```

By default it runs as a user ```wruser``` with ```uid=1000(wruser) gid=1000(wruser)```, if you have different ids, run it as

```bash
$ docker run -ti -e UID=`id -u` -e GID=`id -g` -v <path-to-the-wrsdk>:/wrsdk -v $PWD:/work vxros2build:1.0
```

See [Dockerfile](Docker/vxbuild/Dockerfile) for the complete list of environment variables

Inside Docker container: Source the development environment
```
wruser@d19165730517:/work source /wrsdk/toolkit/wind_sdk_env.linux
```

Inside Docker container: Run make to build ROS2 using the SDK
```
wruser@d19165730517:/work make
```

Build artifacts are in the export directory
```
wruser@d19165730517:/work ls export/deploy/
bin  lib
```

Rebuild from scratch
```
wruser@d19165730517:/work make distclean
wruser@d19165730517:/work make
```

It could be that the build fails if it runs behind the firewall, see [#22](https://github.com/Wind-River/vxworks7-ros2-build/issues/22).
In this case rerun it without a certificate check as

```bash
WGET_OPT="--no-check-certificate -O" CURL="" make
```

## Run ROS2 C/C++ examples

Run QEMU
```
sudo apt-get install uml-utilities
sudo tunctl -u $USER -t tap0
sudo ifconfig tap0 192.168.200.254 up

cd vxworks7-ros2-build
```

### Method 1: USB mount

Run QEMU with a prebuilt VxWorks kernel and the *export* directory mounted as a USB device.
Check the directory size, it could be that you can get an error described in [#16](https://github.com/Wind-River/vxworks7-ros2-build/issues/16) then use [Method 2](#method-2-hdd-image)

Tested with

```bash
$ qemu-system-x86_64 --version
QEMU emulator version 6.2.0 (Debian 1:6.2+dfsg-2ubuntu6.2)
Copyright (c) 2003-2021 Fabrice Bellard and the QEMU Project developers
```

```bash
$ du -sh ./export/deploy
494M    export/deploy/

$ sudo qemu-system-x86_64 -m 512M  -kernel $WIND_SDK_HOME/bsps/itl_generic_2_0_2_1/boot/vxWorks -net nic  -net tap,ifname=tap0,script=no,downscript=no -display none -serial stdio -monitor none -append "bootline:fs(0,0)host:vxWorks h=192.168.200.254 e=192.168.200.1 u=target pw=boot o=gei0" -usb -device usb-ehci,id=ehci  -device usb-storage,drive=fat32 -drive file=fat:rw:./export/deploy,id=fat32,format=raw,if=none
```

Run ROS2 example
```
telnet 192.168.200.1
```

```
-> cmd
[vxWorks *]# set env LD_LIBRARY_PATH="/bd0a/lib"
[vxWorks *]# cd /bd0a/bin/
[vxWorks *]# rtp exec -u 0x20000 timer_lambda
Launching process 'timer_lambda' ...
Process 'timer_lambda' (process Id = 0xffff80000046f070) launched.
[INFO] [minimal_timer]: Hello, world!
[INFO] [minimal_timer]: Hello, world!
[INFO] [minimal_timer]: Hello, world!
[INFO] [minimal_timer]: Hello, world!
```

### Method 2: HDD image

Run QEMU with a prebuilt VxWorks kernel and HDD.

```bash
# create a disk 800MB
$ dd if=/dev/zero of=ros2.img count=800 bs=1M
# format it as a FAT32
$ mkfs.vfat -F 32 ./ros2.img

# mount, copy, unmount, you need to be sudo 
$ mkdir -p ~/tmp/mount
$ sudo mount -o loop -t vfat ./ros2.img $HOME/tmp/mount
$ sudo cp -r -L ./export/deploy/* $HOME/tmp/mount/.
$ sudo umount $HOME/tmp/mount
```

```bash
sudo qemu-system-x86_64 -m 512M -kernel ~/Downloads/wrsdk-vxworks7-up2-1.7/bsps/itl_generic_2_0_2_1/boot/vxWorks -net nic -net tap,ifname=tap0,script=no,downscript=no -display none -serial stdio -append "bootline:fs(0,0)host:vxWorks h=192.168.200.254 e=192.168.200.1 u=ftp pw=ftp123 o=gei0" -device ich9-ahci,id=ahci -drive file=./ros2.img,if=none,id=ros2disk,format=raw -device ide-hd,drive=ros2disk,bus=ahci.0
```

Run ROS2 example
```
telnet 192.168.200.1
```

```
-> cmd
[vxWorks *]# set env LD_LIBRARY_PATH="/ata4/lib"
[vxWorks *]# cd /ata4/bin/
[vxWorks *]# rtp exec -u 0x20000 timer_lambda
Launching process 'timer_lambda' ...
Process 'timer_lambda' (process Id = 0xffff80000046f070) launched.
[INFO] [minimal_timer]: Hello, world!
[INFO] [minimal_timer]: Hello, world!
[INFO] [minimal_timer]: Hello, world!
[INFO] [minimal_timer]: Hello, world!
```

## Run ROS2 Python examples

```
[vxWorks *]# set env AMENT_PREFIX_PATH="/ata4"
[vxWorks *]# cd /ata4/bin
[vxWorks *]# rtp exec -u 0x20000 python3 ros2 pkg list
Launching process 'python3' ...
Process 'python3' (process Id = 0xffff80000046f070) launched.
[vxWorks *]#
```


## Build a simple CMake based OSS project

```
$ cd vxworks7-ros2-build
$ docker run -ti -v <path-to-the-wrsdk>:/wrsdk -v $PWD:/work vxros2build:1.0
$ source /wrsdk/toolkit/wind_sdk_env.linux

$ git clone https://github.com/ttroy50/cmake-examples.git
$ cd cmake-examples/01-basic/A-hello-cmake; mkdir vxworks-build; cd vxworks-build
$ cmake .. -DCMAKE_TOOLCHAIN_FILE=/work/buildspecs/cmake/toolchain.cmake
-- The C compiler identification is Clang 9.0.1
-- The CXX compiler identification is Clang 9.0.1
-- Check for working C compiler: /wrsdk/toolkit/host_tools/x86_64-linux/bin/wr-cc
-- Check for working C compiler: /wrsdk/toolkit/host_tools/x86_64-linux/bin/wr-cc -- works
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Detecting C compile features
-- Detecting C compile features - done
-- Check for working CXX compiler: /wrsdk/toolkit/host_tools/x86_64-linux/bin/wr-c++
-- Check for working CXX compiler: /wrsdk/toolkit/host_tools/x86_64-linux/bin/wr-c++ -- works
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- Configuring done
-- Generating done
-- Build files have been written to: /work/cmake-examples/01-basic/A-hello-cmake/vxworks-build

$ make
Scanning dependencies of target hello_cmake
[ 50%] Building CXX object CMakeFiles/hello_cmake.dir/main.cpp.o
[100%] Linking CXX executable hello_cmake
[100%] Built target hello_cmake
```

## Native ROS2 compilation

It is possible to build ROS2 natively using the same docker image

```bash
$ cd vxworks7-ros2-build
$ docker run -ti -v <path-to-the-wrsdk>:/wrsdk -v $PWD:/work vxros2build:1.0
wruser@90c3e6ebcc76:/work$ mkdir -p build/ros2/ros2_native/src && cd build/ros2/ros2_native
wruser@90c3e6ebcc76:/work/build/ros2/ros2_native$ vcs import src < /work/build/ros2/ros2_ws/ros2.repos
wruser@90c3e6ebcc76:/work/build/ros2/ros2_native$ colcon build --merge-install --cmake-force-configure --packages-up-to-regex examples_rcl* ros2action ros2component ros2msg ros2node ros2pkg ros2service ros2topic ros2cli ros2lifecycle ros2multicast ros2param ros2run ros2srv pendulum_control --cmake-args -DCMAKE_BUILD_TYPE:STRING=Debug -DBUILD_TESTING:BOOL=OFF

wruser@90c3e6ebcc76:/work/build/ros2/ros2_native/install$ source setup.bash
wruser@90c3e6ebcc76:/work/build/ros2/ros2_native/install$ ros2 run demo_nodes_py talker
[INFO] [talker]: Publishing: "Hello World: 0"
[INFO] [talker]: Publishing: "Hello World: 1"
[INFO] [talker]: Publishing: "Hello World: 2"
```

# Legal Notices

All product names, logos, and brands are property of their respective owners. All company,
product and service names used in this software are for identification purposes only.
Wind River and VxWorks are registered trademarks of Wind River Systems, Inc. UNIX is a
registered trademark of The Open Group.

Disclaimer of Warranty / No Support: Wind River does not provide support
and maintenance services for this software, under Wind River’s standard
Software Support and Maintenance Agreement or otherwise. Unless required
by applicable law, Wind River provides the software (and each contributor
provides its contribution) on an “AS IS” BASIS, WITHOUT WARRANTIES OF ANY
KIND, either express or implied, including, without limitation, any warranties
of TITLE, NONINFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A PARTICULAR
PURPOSE. You are solely responsible for determining the appropriateness of
using or redistributing the software and assume any risks associated with
your exercise of permissions under the license.
