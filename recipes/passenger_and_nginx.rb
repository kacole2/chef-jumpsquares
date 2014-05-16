# Author: Kendrick Coleman (kendrickcoleman@gmail.com)
# Cookbook Name:: jumpsquares
# Recipe:: passenger_and_nginx
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

#THIS RECIPE ISN'T WORKING. GETS 403 FORBIDDEN ERRORS WITH NGINX!!!
include_recipe "apt"
include_recipe "openssl"
include_recipe "rvm::system"

rvm_shell "bundle install" do
      
     ruby_string "#{node['rvm']['default_ruby']}"
     cwd node['jumpsquares']['jumpsquares_dir']
     
     code %{
       source #{node['jumpsquares']['rvm_source']}
       rvmsudo gem install passenger -v 4.0.42 --no-rdoc --no-ri
       rvmsudo gem install rake -v 10.3.1 --no-rdoc --no-ri
       }
   end
include_recipe "jumpsquares::default"
include_recipe "nginx::source"
ENV['PATH']="#{node['nginx']['rvm_path']}:#{ENV['PATH']}"