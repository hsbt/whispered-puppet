# http://serverfault.com/questions/127460/how-do-i-install-a-yum-package-group-with-puppet
define yumgroup($ensure = "present", $optional = false) {
   case $ensure {
      present,installed: {
         $pkg_types_arg = $optional ? {
            true => "--setopt=group_package_types=optional,default,mandatory",
            default => ""
         }
         exec { "Installing $name yum group":
            path => "/usr/bin",
            command => "yum -y groupinstall $pkg_types_arg $name",
            unless => "yum -y groupinstall $pkg_types_arg $name --downloadonly",
            timeout => 600,
         }
      }
   }
}

include epel
include nginx
include monit
include elasticsearch
include rbenv
