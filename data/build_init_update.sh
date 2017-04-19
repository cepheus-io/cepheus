#!/bin/bash
#
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

# NOTE: AUTOGENERATED FILE. Only modify template version.

# Exit immediately if anything goes wrong!
set -eu

# Creates the REPO_ROOT env var for everything else to use...
export REPO_ROOT=$(git rev-parse --show-toplevel)

# Builds the bootstrapping environment based on the templates and data found in this directory.

# NB: Output directories for this process already exists
# NB: The `build.yaml` will get created by combining all of the required yamls.

## ALL data files *MUST* be processed before anything else can be processed!

# Build from template

echo "====> Generating bootstrap/common/cepheus_build_update.sh..."
$REPO_ROOT/data/templates/template_engine -d $REPO_ROOT/data/$BUILD_LOCATION/$BUILD_DATA_CENTER/build.yaml -i $REPO_ROOT/data/templates/bootstrap/common/cepheus_build_update.sh.j2 -o $REPO_ROOT/bootstrap/common/cepheus_build_update.sh
sudo chmod +x $REPO_ROOT/bootstrap/common/cepheus_build_update.sh

echo "====> Generating bootstrap/common/cepheus_bootstrap_init.sh..."
$REPO_ROOT/data/templates/template_engine -d $REPO_ROOT/data/$BUILD_LOCATION/$BUILD_DATA_CENTER/build.yaml -i $REPO_ROOT/data/templates/bootstrap/common/cepheus_bootstrap_init.sh.j2 -o $REPO_ROOT/bootstrap/common/cepheus_bootstrap_init.sh
sudo chmod +x $REPO_ROOT/bootstrap/common/cepheus_bootstrap_init.sh

echo "====> Generating bootstrap/common/cepheus_backup_rsync.sh..."
$REPO_ROOT/data/templates/template_engine -d $REPO_ROOT/data/$BUILD_LOCATION/$BUILD_DATA_CENTER/build.yaml -i $REPO_ROOT/data/templates/bootstrap/common/cepheus_backup_rsync.sh.j2 -o $REPO_ROOT/bootstrap/common/cepheus_backup_rsync.sh
sudo chmod +x $REPO_ROOT/bootstrap/common/cepheus_backup_rsync.sh

echo "====> Generating bootstrap/common/cepheus_backup_no_rsync.sh..."
$REPO_ROOT/data/templates/template_engine -d $REPO_ROOT/data/$BUILD_LOCATION/$BUILD_DATA_CENTER/build.yaml -i $REPO_ROOT/data/templates/bootstrap/common/cepheus_backup_no_rsync.sh.j2 -o $REPO_ROOT/bootstrap/common/cepheus_backup_no_rsync.sh
sudo chmod +x $REPO_ROOT/bootstrap/common/cepheus_backup_no_rsync.sh

echo "====> Generating bootstrap/common/bootstrap_chef_server.sh..."
$REPO_ROOT/data/templates/template_engine -d $REPO_ROOT/data/$BUILD_LOCATION/$BUILD_DATA_CENTER/build.yaml -i $REPO_ROOT/data/templates/bootstrap/common/bootstrap_chef_server.sh.j2 -o $REPO_ROOT/bootstrap/common/bootstrap_chef_server.sh
sudo chmod +x $REPO_ROOT/bootstrap/common/bootstrap_chef_server.sh