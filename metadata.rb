name             'jumpsquares'
maintainer       'Kendrick Coleman'
maintainer_email 'kendrickcoleman@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures JumpSquares'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

recipe "jumpsquares", "this will only install the core pieces. Needs more recipes for a complete install"
recipe "jumpsquares::passenger_and_nginx", "NOT WORKING! Getting 403 Forbidden Errors with nginx"
recipe "jumpsquares::thin_and_nginx", "Use this. It will create a completely working JumpSquares install"

depends "apt"
depends "openssl"
depends "rvm"
depends "postgresql"
depends "nginx"
depends "thin_nginx"

supports "ubuntu"
supports "debian"