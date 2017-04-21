#!/bin/bash
#
# Author: Chris Jones <chris.jones@lambdastack.io>
# Copyright 2017, LambdaStack
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Sets the base roles for the nodes so as to start over...

source /ceph-host/bootstrap/common/base.sh

echo "====> Creating Chef Tags..."

# IMPORTANT: DO NOT attempt to put the run_list all together!!! If that happens we then need to create checks, wait
# and quorum checks!

# NB: Tag names below come from `ceph-chef` cookbook

# For Ceph Kraken and above - Ceph Mgr runs along side of ceph-mon nodes.
for i in ${CEPH_MON_HOSTS[@]}; do
  knife tag create $i 'ceph-mon' $CHEF_KNIFE_DEBUG
done

for i in ${CEPH_OSD_HOSTS[@]}; do
  knife tag create $i 'ceph-osd' $CHEF_KNIFE_DEBUG
done

for i in ${CEPH_RGW_HOSTS[@]}; do
  knife tag create $i 'ceph-rgw' $CHEF_KNIFE_DEBUG
done

for i in ${CEPH_ADMIN_HOSTS[@]}; do
  knife tag create $i 'ceph-admin' $CHEF_KNIFE_DEBUG
  # NOTE: ceph-restapi can be split out later if desired
  knife tag create $i 'ceph-restapi' $CHEF_KNIFE_DEBUG
done

for i in ${CEPH_ADC_HOSTS[@]}; do
  knife tag create $i 'ceph-adc' $CHEF_KNIFE_DEBUG
done