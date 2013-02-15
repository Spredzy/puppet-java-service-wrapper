# Class: java_service_wrapper
#
#    Manage  the installation of the java_Service_wrapper
#    libraries based on your system specs
#
# Parameter: base_path
#
#  base_path where those files needs to be installed
#  base_path expect to have a bin/ and lib/ folder in it
#
# Actions:
#
#    Install the files to their respective path
#
# Requires:
#
#    A working java implementation
#
# Sample Usage:
#
#    include java_service_wrapper
#
#    class {'java_service_wrapper' :
#         base_path => '/usr/local',
#    }
#
# Note:
#
#    This class will normally be included from a
#    java_service_wrapper::service definition
#
class java_service_wrapper(
  $base_path = $java_service_wrapper::params::base_path,
) inherits java_service_wrapper::params
{

  file {"${base_path}/lib/wrapper.jar" :
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => "puppet:///modules/java_service_wrapper/lib/wrapper.jar",
  }

  file {"${base_path}/lib/libwrapper${::jsw_extension}":
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => "puppet:///modules/java_service_wrapper/lib/libwrapper-${::jsw_kernel}-${::jsw_arch}${::jsw_extension}",
  }

  file {"${base_path}/bin/wrapper" :
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => "puppet:///modules/java_service_wrapper/bin/wrapper-${::jsw_kernel}-${::jsw_arch}",
  }
}
