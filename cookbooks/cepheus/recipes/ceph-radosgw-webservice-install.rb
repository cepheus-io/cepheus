#
# Author:: Chris Jones <chris.jones@lambdastack.io>
# Cookbook Name:: cepheus
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

include_recipe 'cepheus::ceph-conf'

# This recipe installs everything needed for the RGW Admin Web Service...

package 'uwsgi' do
    action :upgrade
end
package 'uwsgi-plugin-python' do
    action :upgrade
end
package 'python-flask' do
    action :upgrade
end
package 'nginx' do
    action :upgrade
end

directory '/usr/local/lib/rgw_webservice' do
    owner 'nginx'
    group 'nginx'
    mode 00755
end

directory '/usr/local/lib/rgw_webservice/templates' do
    owner 'nginx'
    group 'nginx'
    mode 00755
end

directory '/var/log/rgw_webservice' do
    owner 'nginx'
    group 'nginx'
    mode 00755
end

file '/usr/local/lib/rgw_webservice/__init__.py' do
    action :touch
    owner 'nginx'
    group 'nginx'
    mode 00644
end

cookbook_file '/usr/local/lib/rgw_webservice/rgw_webservice' do
    source 'rgw_webservice.py'
    owner 'nginx'
    group 'nginx'
    mode 00755
end

# NB: May want to add a config file to hold admin user and keys etc.

# Add nginx directory for app

# Link app to lib directory file
link '/usr/local/bin/rgw_webservice' do
    to '/usr/local/lib/rgw_webservice/rgw_webservice.wsgi'
    user 'nginx'
    group 'nginx'
end

# Setup the NGINX config file. Since this is the only service using nginx we can just modify the nginx.conf directly.
template '/etc/nginx/nginx.conf' do
    source 'nginx.conf.erb'
    owner 'root'
    group 'root'
    # notifies :reload, "service[nginx]", :immediately
end

# Setup the uwsgi ini
template '/etc/rgw_webservice.ini' do
    source 'rgw-webservice.ini.erb'
    owner 'root'
    group 'root'
end

# Add Unit file for service
template '/etc/systemd/system/rgw_webservice.service' do
    source 'rgw-webservice.service.erb'
    owner 'root'
    group 'root'
end

# Add help file
template '/usr/local/lib/rgw_webservice/templates/rgw_webservice_help.html' do
    source 'rgw-webservice-help.html.erb'
    owner 'nginx'
    group 'nginx'
end

# NB: So rgw_webservice process can read ceph.conf
if node['cepheus']['ceph']['repo']['version']['name'] != 'hammer'
    execute "add_user_to_ceph" do
      command "usermod -a -G ceph nginx"
      ignore_failure true
    end
end
