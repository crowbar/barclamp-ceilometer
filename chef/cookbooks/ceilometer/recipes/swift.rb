# Copyright 2011 Dell, Inc.
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

unless node[:ceilometer][:use_gitrepo]
  package "python-ceilometer"
  package "openstack-ceilometer" # needed for pipeline.yaml (at  least)
end
# TODO else git_repo?

include_recipe "#{@cookbook_name}::common"

# TODO are the keystone values known from included common recipe or do we have to do explicit search again?
keystone_register "give ceilometer user ResellerAdmin role" do
  protocol keystone_protocol
  host keystone_host
  port keystone_admin_port
  token keystone_token
  user_name keystone_service_user
  tenant_name keystone_service_tenant
  role_name "ResellerAdmin"
  action :add_access
end

# TODO prepare /var/log/ceilometer/swift-proxy-server.log - writable for swift-proxy
# TODO check swift rights to /etc/ceilometer/ceilometer.conf - readable by swift-proxy
# ----> make those part of openstack-ceilometer package + add openstack-swift to openstack-ceilometer group


# TODO update pipeline.yaml with some storage specific parts?
