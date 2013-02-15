# Class: java_service_wrapper
#
#    Manage  the installation of the java_service_wrapper
#    libraries based on your system specs
#
# Parameter:
#
#    None
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
# Note:
#
#    This class will normally be included from a
#    java_service_wrapper::service definition
#
class java_service_wrapper() {

  file {"/usr/local/lib/wrapper.jar" :
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => "puppet:///modules/java_service_wrapper/lib/wrapper.jar",
  }

  file {"/usr/local/lib/libwrapper${::jsw_extension}":
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => "puppet:///modules/java_service_wrapper/lib/libwrapper-${::jsw_kernel}-${::jsw_arch}${::jsw_extension}",
  }

  file {"/usr/local/bin/wrapper" :
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => "puppet:///modules/java_service_wrapper/bin/wrapper-${::jsw_kernel}-${::jsw_arch}",
  }
}
