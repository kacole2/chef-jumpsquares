# Author: Kendrick Coleman (kendrickcoleman@gmail.com)
# Cookbook Name:: jumpsquares
# Attributes:: thin_and_nginxs
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

#attributes to pass to thin_nginx cookbook
override['thin_nginx']['app_name'] = "jumpsquares"
override['thin_nginx']['www_dir']  = "/var/www/"
override['thin_nginx']['rails_env'] = "appliance-production"

override['thin_nginx']['ruby_version'] = "ruby-2.1.2"
override['thin_nginx']['ruby_path'] = "/usr/local/rvm"
override['thin_nginx']['rvm_source'] = "/usr/local/rvm/scripts/rvm"