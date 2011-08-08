maintainer       "Sergio Rubio"
maintainer_email "rubiojr@frameos.org"
license          "Apache 2.0"
description      "Cookbook for thesting Opscode Chef RHEL installs"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.1"

%w{ redhat centos scientific }.each do |os|
  supports os, ">= 5.0"
end
