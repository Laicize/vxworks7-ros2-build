# Makefile fragment for defs.vxworks.mk
#
# Copyright (c) 2021 Wind River Systems, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# modification history
# --------------------
# 17jan21,akh created
#
ifndef __vxworks_defs
__vxworks_defs = TRUE

ifeq ($(WIND_CC_SYSROOT),)
$(error WIND_CC_SYSROOT is not defined)
endif

# introduced in 21.03
WIND_RELEASE_ID ?= 21.11
WIND_RELEASE_ID_YEAR = $(word 1,$(subst ., ,$(WIND_RELEASE_ID))) 
WIND_RELEASE_ID_MONTH = $(word 2,$(subst ., ,$(WIND_RELEASE_ID))) 

## Add missing variablse from SDK
export TOOL=llvm

3PP_DIR?=$(WIND_CC_SYSROOT)/usr/3pp
3PP_HOST_DIR=$(3PP_DIR)/host
3PP_DEVELOP_DIR=$(3PP_DIR)/develop
3PP_DEVELOP_USR_DIR=$(3PP_DEVELOP_DIR)/usr
3PP_DEPLOY_DIR=$(3PP_DIR)/deploy

endif
