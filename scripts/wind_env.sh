#!/bin/bash

# set -x

LOCAL_DIR=$(dirname $(readlink -f $0))

WIND_HOME=${LOCAL_DIR}
WIND_PLATFORM=vxworks-7
WIND_PREFERRED_PACKAGES=vxworks-7
WIND_HOST_TYPE=x86-linux2
WIND_TOOLCHAINS=rust:llvm:gnu
WIND_VX7_HOST_TYPE=x86_64-linux
WIND_HOST_TYPE_WB=x86_64-linux2
WIND_LLVM_HOST_TYPE=LINUX64
WIND_VX7_LLVM_HOST_TYPE=LINUX64
WIND_VX7_GNU_HOST_TYPE=x86_64-linux2
WIND_GNU_HOST_TYPE=x86_64-linux2
WIND_RUST_HOST_TYPE=x86_64-unknown-linux-gnu
WIND_VX7_RUST_HOST_TYPE=x86_64-unknown-linux-gnu
WIND_PKGS_DIR_NAME=pkgs_v2
WIND_USR=
WIND_COMPONENTS_LIBNAMES=
WRSD_LICENSE_FILE=${WIND_HOME}/license
WIND_BASE=${WIND_HOME}/${WIND_PLATFORM}
WIND_COMPILER_PATHS=${WIND_HOME}/compilers
WIND_FOUNDATION_PATH=${WIND_BASE}/host
WIND_UTILITIES=${WIND_FOUNDATION_PATH}/${WIND_HOST_TYPE}/bin
COMP_DSM_TOOLS=${WIND_FOUNDATION_PATH}
WIND_BUILD=${WIND_BASE}/build
WIND_BUILD_TOOL=${WIND_BUILD}/tool
WIND_KRNL_MK=${WIND_BUILD}/mk/krnl
WIND_USR_MK=${WIND_BUILD}/mk/usr
OSCONFIG_PATH=${WIND_BUILD}/osconfig
TCLLIBPATH=${OSCONFIG_PATH}/tcl
WIND_VSB_PROFILE_PATHS=${WIND_BUILD}/misc/vsb_profiles
WIND_PREBUILT_PATHS=${WIND_BASE}/samples/prebuilt_projects
WIND_WRVX_MK=${WIND_BUILD}/mk/wrvx
WIND_PKGS=${WIND_BASE}/${WIND_PKGS_DIR_NAME}
WIND_BSP_PATHS=${WIND_PKGS}/unsupported:${WIND_PKGS}/os/board
WIND_LAYER_PATHS=${WIND_PKGS}
WIND_TOOLS=${WIND_HOME}/workbench-4
APROBE=${WIND_TOOLS}/${WIND_HOST_TYPE_WB}
WIND_RPM=${WIND_TOOLS}/eclipse
WIND_WRSV_PATH=${WIND_TOOLS}/wrsysviewer
WIND_WRWB_PATH=${WIND_TOOLS}/eclipse/${WIND_HOST_TYPE_WB}
WIND_SEARCH_URL=https://docs.windriver.com/search?facetreset=yes&source=all&q={expression}&labels=3&sort=score&rpp=10
WIND_WELCOME_URL=https://docs.windriver.com/category/os_vxworks_7_sr0640
WIND_RSS_CHANNELS=WIND_RSS_CHANNELS=https://www.windriver.com/feeds/vxworks_700.xml:https://www.windriver.com/feeds/workbench_400.xml
WIND_LLVM_PATH=${WIND_COMPILER_PATHS}/llvm-9.0.1.1
WIND_GNU_PATH=${WIND_COMPILER_PATHS}/gnu-8.3.0.1
WIND_RUST_PATH=${WIND_COMPILER_PATHS}/rust-1.39.0.0
WIND_DOCS=${WIND_BASE}/docs
WIND_SAMPLES=${WIND_BASE}/samples/system:${WIND_BASE}/samples/rtp:${WIND_BASE}/samples/dkm:${WIND_BASE}/samples/wrtool/wrlinux:${WIND_BASE}/samples/wrtool/vxworks7:${WIND_BASE}/samples/wrtool:${WIND_TOOLS}/samples/windiss:${WIND_TOOLS}/samples/samples/vxworks7
WIND_PSL_PATHS=${WIND_PKGS}/unsupported:${WIND_PKGS}/os/psl
PATH=${WIND_FOUNDATION_PATH}/${WIND_VX7_HOST_TYPE}/bin:${WIND_FOUNDATION_PATH}/${WIND_HOST_TYPE}/bin:${WIND_BUILD}/mk/scripts:${WIND_TOOLS}/wrasp/${WIND_HOST_TYPE}/bin:${WIND_TOOLS}/wrsysviewer/host/${WIND_HOST_TYPE_WB}/bin:${WIND_TOOLS}/${WIND_HOST_TYPE_WB}/bin:${WRSD_LICENSE_FILE}/lmapi-5/${WIND_HOST_TYPE}/bin:${WIND_TOOLS}:${WIND_LLVM_PATH}/${WIND_LLVM_HOST_TYPE}/bin:${WIND_RUST_PATH}/${WIND_RUST_HOST_TYPE}/bin:${WIND_GNU_PATH}/${WIND_GNU_HOST_TYPE}/bin:${PATH}
LD_LIBRARY_PATH=${WIND_FOUNDATION_PATH}/${WIND_VX7_HOST_TYPE}/lib:${WIND_FOUNDATION_PATH}/${WIND_HOST_TYPE}/lib:${WIND_TOOLS}/wrsysviewer/host/${WIND_HOST_TYPE_WB}/lib:${WIND_TOOLS}/${WIND_HOST_TYPE_WB}/lib::${WRSD_LICENSE_FILE}/lmapi-5/${WIND_HOST_TYPE}/lib

env \
WIND_HOME=${WIND_HOME} \
WIND_PLATFORM=${WIND_PLATFORM} \
WIND_PREFERRED_PACKAGES=${WIND_PREFERRED_PACKAGES} \
WIND_HOST_TYPE=${WIND_HOST_TYPE} \
WIND_TOOLCHAINS=${WIND_TOOLCHAINS} \
WIND_VX7_HOST_TYPE=${WIND_VX7_HOST_TYPE} \
WIND_HOST_TYPE_WB=${WIND_HOST_TYPE_WB} \
WIND_LLVM_HOST_TYPE=${WIND_LLVM_HOST_TYPE} \
WIND_VX7_LLVM_HOST_TYPE=${WIND_VX7_LLVM_HOST_TYPE} \
WIND_VX7_GNU_HOST_TYPE=${WIND_VX7_GNU_HOST_TYPE} \
WIND_GNU_HOST_TYPE=${WIND_GNU_HOST_TYPE} \
WIND_RUST_HOST_TYPE=${WIND_RUST_HOST_TYPE} \
WIND_VX7_RUST_HOST_TYPE=${WIND_VX7_RUST_HOST_TYPE} \
WIND_PKGS_DIR_NAME=${WIND_PKGS_DIR_NAME} \
WIND_USR=${WIND_USR} \
WIND_COMPONENTS_LIBNAMES=${WIND_COMPONENTS_LIBNAMES} \
WRSD_LICENSE_FILE=${WRSD_LICENSE_FILE} \
WIND_BASE=${WIND_BASE} \
WIND_COMPILER_PATHS=${WIND_COMPILER_PATHS} \
WIND_FOUNDATION_PATH=${WIND_FOUNDATION_PATH} \
WIND_UTILITIES=${WIND_UTILITIES} \
COMP_DSM_TOOLS=${COMP_DSM_TOOLS} \
WIND_BUILD=${WIND_BUILD} \
WIND_BUILD_TOOL=${WIND_BUILD_TOOL} \
WIND_KRNL_MK=${WIND_KRNL_MK} \
WIND_USR_MK=${WIND_USR_MK} \
OSCONFIG_PATH=${OSCONFIG_PATH} \
TCLLIBPATH=${TCLLIBPATH} \
WIND_VSB_PROFILE_PATHS=${WIND_VSB_PROFILE_PATHS} \
WIND_PREBUILT_PATHS=${WIND_PREBUILT_PATHS} \
WIND_WRVX_MK=${WIND_WRVX_MK} \
WIND_PKGS=${WIND_PKGS} \
WIND_BSP_PATHS=${WIND_BSP_PATHS} \
WIND_LAYER_PATHS=${WIND_LAYER_PATHS} \
WIND_TOOLS=${WIND_TOOLS} \
APROBE=${APROBE} \
WIND_RPM=${WIND_RPM} \
WIND_WRSV_PATH=${WIND_WRSV_PATH} \
WIND_WRWB_PATH=${WIND_WRWB_PATH} \
WIND_SEARCH_URL=${WIND_SEARCH_URL} \
WIND_WELCOME_URL=${WIND_WELCOME_URL} \
WIND_RSS_CHANNELS=${WIND_RSS_CHANNELS} \
WIND_LLVM_PATH=${WIND_LLVM_PATH} \
WIND_GNU_PATH=${WIND_GNU_PATH} \
WIND_RUST_PATH=${WIND_RUST_PATH} \
WIND_DOCS=${WIND_DOCS} \
WIND_SAMPLES=${WIND_SAMPLES} \
WIND_PSL_PATHS=${WIND_PSL_PATHS} \
PATH=${PATH} \
LD_LIBRARY_PATH=${LD_LIBRARY_PATH} \
bash

