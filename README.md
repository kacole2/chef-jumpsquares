jumpsquares Cookbook
====================
This cookbook will install a <a href="http://jumpsquares.net">JumpSquares</a> application on an ubuntu or debian machine. Only use this if you feel like you want to play around.
Otherwise, it's probably a safer idea to download the <a href="http://kendrickcoleman.com/index.php/Ruby-on-Rails-Projects/jumpsquares-a-new-kind-of-bookmark.html">appliance version</a> that's pre-built. This was an attempt to make my first chef cookbook.


Requirements
------------
Tested with Ubuntu 12.06.03

#### Other cookbooks used:
- `apt` - used to update packages to the latest
- `openssl` - requirements for postgresql
- `rvm` - installs RVM and rubies. Suggested ruby to install is ruby-2.1.2
- `postgresql` - database for JumpSquares
- `nginx` - used for passenger_and_thin recipe. This recipe doesn't work (403 Forbidden) but leaving it there for future purposes
- `thin_nginx` - used for thin_and_nginx recipe. Creates a thin and nginx rack based solution

#### Installs packages outside of the cookbooks:
- `ImageMagick` - used for application type images

#### All gems required to run JumpSquares through RVM shell calling "bundle install" are installed


Attributes
----------
Attributes here are supposed to be overwritten.

#### jumpsquares::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['jumpsquares']['www_dir']</tt></td>
    <td>String</td>
    <td>www directory</td>
    <td><tt>'/var/www'</tt></td>
  </tr>
  <tr>
    <td><tt>['jumpsquares']['jumpsquares_dir']</tt></td>
    <td>String</td>
    <td>the JumpSquares directory</td>
    <td><tt>'/var/www/jumpsquares'</tt></td>
  </tr>
  <tr>
    <td><tt>['jumpsquares']['rvm_source']</tt></td>
    <td>String</td>
    <td>the local RVM source</td>
    <td><tt>'/usr/local/rvm/scripts/rvm'</tt></td>
  </tr>
  <tr>
    <td><tt>["postgresql"]["pg_hba_defaults"] </tt></td>
    <td>Boolean</td>
    <td>we want to set our own default</td>
    <td><tt>False</tt></td>
  </tr>
  <tr>
    <td><tt>["postgresql"]["pg_hba"]</tt></td>
    <td>String</td>
    <td>the that changes it all</td>
    <td><tt>[
    { "type"=> "local", "db"=> "all", "user"=> "postgres",   "addr"=> "",             "method"=> "peer" },
    { "type"=> "local", "db"=> "all", "user"=> "all",        "addr"=> "",             "method"=> "md5" },
    { "type"=> "host",  "db"=> "all", "user"=> "all",        "addr"=> "127.0.0.1/32", "method"=> "md5" },
    { "type"=> "host",  "db"=> "all", "user"=> "all",        "addr"=> "::1/128",      "method"=> "md5" }
  ]</tt></td>
  </tr>
</table>

#### jumpsquares::thin_and_nginx
I have no idea why, but these value are not overriding the cookbook. Go into the thin_nginx::default recipe and make sure the following values are correct

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['thin_nginx']['app_name']</tt></td>
    <td>String</td>
    <td>Of course it's JumpSquares!</td>
    <td><tt>"jumpsquares"</tt></td>
  </tr>
  <tr>
    <td><tt>['thin_nginx']['www_dir']</tt></td>
    <td>String</td>
    <td>the JumpSquares directory</td>
    <td><tt>'/var/www/'</tt></td>
  </tr>
  <tr>
    <td><tt>['thin_nginx']['rails_env']</tt></td>
    <td>String</td>
    <td>specify our rails envionment</td>
    <td><tt>"appliance-production"</tt></td>
  </tr>
  <tr>
    <td><tt>['thin_nginx']['ruby_version']</tt></td>
    <td>String</td>
    <td>ruby version needed for calling RVM</td>
    <td><tt>"ruby-2.1.2"</tt></td>
  </tr>
  <tr>
    <td><tt>['thin_nginx']['ruby_path']</tt></td>
    <td>String</td>
    <td>RVM ruby local path</td>
    <td><tt>"/usr/local/rvm"</tt></td>
  </tr>
  <tr>
    <td><tt>['thin_nginx']['rvm_source']</tt></td>
    <td>String</td>
    <td>RVM ruby source</td>
    <td><tt>"/usr/local/rvm/scripts/rvm"</tt></td>
  </tr>
  
</table>

Usage
-----
#### jumpsquares::default

When using jumpsquares in your node's `run_list`, it will only do a basic install. You need to specify other cookbooks and recipes to create a working solution.
Here is my current recipe run list that works:
0. `apt` <br>
1. `openssl` <br>
2. `rvm::system` <br>
3. `postgresql::server` <br>
4. `postgresql::libpq` <br>
5. `postgresql::client` <br>
6. `jumpsquares` <br>
7. `thin_nginx` <br>

#### jumpsquares::thin_nginx
Just include `jumpsquares::default` in your node's `run_list`. However go to 'thin_nginx' and make sure the attributes match what is shown above.

Contributing
------------
I'm not a developer. This is probably very ugly. Feel free to make this not look like garbage! :)

e.g.
1. Fork the repository on Github <br>
2. Create a named feature branch (like `add_component_x`) <br>
3. Write your change <br>
4. Write tests for your change (if applicable) <br>
5. Run the tests, ensuring they all pass <br>
6. Submit a Pull Request using Github <br>

License and Authors
-------------------
Authors: <a href="http://www.kendrickcoleman.com">Kendrick Coleman</a> | <a href="http://twitter.com/KendrickColeman">@KendrickColeman</a>


