#!/usr/bin/env bash

# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Variables
INSTANCE_IP=$(curl -s api.ipify.org)
INSTANCE_CIDR=$INSTANCE_IP/32
ARRAY=("https-api-onprem-k8s-local" "ssh-external-to-master-onprem-k8s-local" "ssh-external-to-node-onprem-k8s-local")

for item in ${ARRAY[@]}
do
  echo "Updating firewall-rule $item source-range to $INSTANCE_CIDR"
  gcloud compute firewall-rules update $item --source-ranges=$INSTANCE_CIDR
done
#gcloud compute firewall-rules create https-api-onprem-k8s-local --source-ranges=${INSTANCE_CIDR} --target-tags="onprem-k8s-local-k8s-io-role-master" --allow tcp