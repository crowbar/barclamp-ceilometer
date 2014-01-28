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
else
  ceilometer_path = "/opt/ceilometer"
  venv_path = node[:ceilometer][:use_virtualenv] ? "#{ceilometer_path}/.venv" : nil
  venv_prefix = node[:ceilometer][:use_virtualenv] ? ". #{venv_path}/bin/activate &&" : nil
  puts "venv_path=#{venv_path}"
  puts "use_virtualenv=#{node[:ceilometer][:use_virtualenv]}"
  pfs_and_install_deps "ceilometer" do
    cookbook "ceilometer"
    cnode node
    virtualenv venv_path
    path ceilometer_path
    wrap_bins [ "ceilometer" ]
  end
  create_user_and_dirs(@cookbook_name)
end


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

# swift user needs read access to ceilometer.conf
user node[:swift][:user] do
  gid node[:ceilometer][:group]
end

# log dir (/var/log/ceilometer) is currently not configurable
file "/var/log/ceilometer/swift-proxy-server.log"
  owner node[:swift][:user]
  group node[:swift][:group]
  mode  "0644"
  action :create_if_missing
end


# possibly update pipeline.yaml with some storage specific parts
