# Author: Kendrick Coleman (kendrickcoleman@gmail.com)
# Cookbook Name:: jumpsquares
# Recipe:: dothemall
#
# Copyright 2014, KendrickColeman.com & jumpsquares.net
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
include_recipe "apt"
include_recipe "openssl"
include_recipe "rvm::system"
include_recipe "postgresql::server"
include_recipe "postgresql::libpq"
include_recipe "postgresql::client"

  
pg_user "jumpgres" do
  privileges superuser: true, createdb: true, login: true
  password "jump123"
end

pg_database "jumpsquares_prod" do
  owner "jumpgres"
  encoding "UTF-8"
  template "template0"
  locale "en_US.UTF-8"
end


directory node['www_dir'] do
  owner "www-data"
  group "www-data"
  mode 00755
  action :create
end

directory node['jumpsquares_dir'] do
  owner "www-data"
  group "www-data"
  mode 00755
  action :create
end

git node['jumpsquares_dir'] do
  repository "https://github.com/kacole2/JumpSquares.git"
  reference "master"
  action :sync
end

rvm_shell "bundle install" do
      
     ruby_string "ruby-2.1.2"
     cwd node['jumpsquares_dir']
     
     code %{
       source /usr/local/rvm/scripts/rvm
       export rvmsudo_secure_path=1
       rvmsudo gem install passenger -v 4.0.42 --no-rdoc --no-ri
       rvmsudo gem install rake -v 10.3.1 --no-rdoc --no-ri
       rvmsudo bundle install
       rvmsudo rake RAILS_ENV=appliance-production db:setup
       rvmsudo rake RAILS_ENV=appliance-production assets:precompile
       }
   end
   
include_recipe "nginx::source"
ENV['PATH']="#{node['nginx']['rvm_path']}:#{ENV['PATH']}"