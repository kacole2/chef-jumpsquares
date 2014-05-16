# Author: Kendrick Coleman (kendrickcoleman@gmail.com)
# Cookbook Name:: jumpsquares
# Attributes:: default
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

#jumpsquares directories and attributes
default['jumpsquares']['www_dir']  = '/var/www'
default['jumpsquares']['jumpsquares_dir']  = '/var/www/jumpsquares'
default['jumpsquares']['rvm_source']  = '/usr/local/rvm/scripts/rvm'

#attributes to pass to rvm cookbook
default['rvm']['default_ruby']      = "ruby-2.1.2"
default['rvm']['user_default_ruby'] = "ruby-2.1.2"
default['rvm']['rubies']      = ["ruby-2.1.2"]

#attributes to pass to postgresql cookbook
default["postgresql"]["pg_hba_defaults"]                 = false
default["postgresql"]["pg_hba"] = [
    { "type"=> "local", "db"=> "all", "user"=> "postgres",   "addr"=> "",             "method"=> "peer" },
    { "type"=> "local", "db"=> "all", "user"=> "all",        "addr"=> "",             "method"=> "md5" },
    { "type"=> "host",  "db"=> "all", "user"=> "all",        "addr"=> "127.0.0.1/32", "method"=> "md5" },
    { "type"=> "host",  "db"=> "all", "user"=> "all",        "addr"=> "::1/128",      "method"=> "md5" }
  ]