# Author: Kendrick Coleman (kendrickcoleman@gmail.com)
# Cookbook Name:: jumpsquares
# Recipe:: default
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
include_recipe "postgresql::server"
include_recipe "postgresql::libpq"
include_recipe "postgresql::client"

#create our postgresql user that will have access to the server
pg_user "jumpgres" do
  privileges superuser: true, createdb: true, login: true
  password "jump123"
end
#create the jumpsquares appliance-production environment database
pg_database "jumpsquares_prod" do
  owner "jumpgres"
  encoding "UTF-8"
  template "template0"
  locale "en_US.UTF-8"
end

#create the directory where www files live. most likley this is /var/www/
directory node['jumpsquares']['www_dir'] do
  owner "www-data"
  group "www-data"
  mode 00755
  action :create
end
#create the subdirectory where our application will live
directory node['jumpsquares']['jumpsquares_dir'] do
  owner "www-data"
  group "www-data"
  mode 00755
  action :create
end
#copy from git our jumpsquares project
git node['jumpsquares']['jumpsquares_dir'] do
  user "www-data"
  group "www-data"
  repository "https://github.com/kacole2/JumpSquares.git"
  reference "master"
  action :sync
end
#imagemagick is needed for our apptype images. this is a beastly install. just hang tight
apt_package "imagemagick" do
  action :install
end
#Bundle install runs. This relies on the rvm shell script
#this will also setup the environment by creating the database tables and precomiling some stuff
#IMPORTANT NOTE: the recipe may die here because the rvm environment isn't set. you have two options.
#1. reboot the machine, then run chef-client again
#2. go to the console of the machine and key in "source /usr/local/rvm/scripts/rvm" then run chef-cleint
rvm_shell "bundle install" do
     ruby_string "#{node['rvm']['default_ruby']}"
     cwd node['jumpsquares']['jumpsquares_dir']
     code %{
       source #{node['jumpsquares']['rvm_source']}
       rvmsudo bundle install
       rvmsudo rake RAILS_ENV=appliance-production db:setup
       rvmsudo rake RAILS_ENV=appliance-production assets:precompile
       }
   end