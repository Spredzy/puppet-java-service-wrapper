# Class: java_service_wrapper
#
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
