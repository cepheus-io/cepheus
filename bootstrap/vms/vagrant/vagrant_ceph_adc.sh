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

source vagrant_base.sh

# IMPORTANT: DO NOT attempt to put the run_list all together!!! If that happens we then need to create checks, wait
# and quorum checks!

# NOTE: This sets up the ADC (haproxy and keepalived)
for vm in ${CEPH_ADC_HOSTS[@]}; do
  do_on_node $CEPH_CHEF_BOOTSTRAP "$KNIFE node run_list add $vm.$BOOTSTRAP_DOMAIN 'role[ceph-adc]' $CHEF_KNIFE_DEBUG"
  do_on_node $vm "sudo chef-client $CHEF_CLIENT_DEBUG -o 'role[ceph-adc]'"
  sleep 5
done
