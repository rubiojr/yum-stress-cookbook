#
# Cookbook Name:: yum-stress
# Recipe:: default
#
# Copyright 2009, Sergio Rubio
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

cookbook_file '/var/chef/site-cookbooks/yum.tar.gz' do
  source 'yum.tar.gz'
end

bash "cookbook upload" do
  user 'root'
  cwd '/var/chef/site-cookbooks'
  code <<-EOH
    tar xzf yum.tar.gz
    knife cookbook upload yum
  EOH
end

search :node, "hostname:*"

5.times do

  package "httpd" do
    action :install
  end

  service 'httpd' do 
    action :start
  end

  package "mysql-server" do
    action :install
  end

  service 'mysqld' do
	  action :start
  end

  package "httpd" do
    action :remove
  end
  package "mysql-server" do
    action :remove
  end
end

[:create, :delete].each do |a|
  directory "/tmp/crap" do
      action a
  end
end

Chef::Log.info "Stressing YumCache"
5.times do
  cache = Chef::Provider::Package::Yum::YumCache.instance
  cache.reload
end
