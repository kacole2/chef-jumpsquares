# Author: Kendrick Coleman (kendrickcoleman@gmail.com)
# Cookbook Name:: jumpsquares
# Attributes:: passenger_and_nginx
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

include_attribute 'jumpsquares::default'

#attributes to pass to nginx cookbook
default['nginx']['version']      = '1.6.0'
default['nginx']['default_root'] = '/var/www/jumpsquares/public'
default['nginx']['rvm_path'] = "/usr/local/rvm/gems/ruby-2.1.2/bin:/usr/local/rvm/gems/ruby-2.1.2@global/bin:/usr/local/rvm/rubies/ruby-2.1.2/bin"
default['nginx']['configure_flags']    = ["--add-module=/usr/local/rvm/gems/ruby-2.1.2/gems/passenger-4.0.42/ext/nginx"]
default['nginx']['source']['modules']  = %w(
  nginx::http_ssl_module
  nginx::http_gzip_static_module
  nginx::passenger
)
default['nginx']['passenger']['version'] = '4.0.42'
default['nginx']['passenger']['root'] = "/usr/local/rvm/gems/ruby-2.1.2/gems/passenger-4.0.42"
default['nginx']['passenger']['ruby'] = "/usr/local/rvm/wrappers/ruby-2.1.2/ruby"
default['nginx']['passenger']['gem_binary'] = "/usr/local/rvm/wrappers/ruby-2.1.2/gem"