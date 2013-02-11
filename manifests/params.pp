# Class: java-service-wrapper::params
#
#    This class manages the java-service-wrapper installation parameters
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class java_service_wrapper::params() {

  $version   = '3.5.17'
  $base_path = '/usr/local/'
  $base_url  = "http://wrapper.tanukisoftware.com/download/${version}"
  $tar_ball  = "wrapper-${::jsw_kernel}-${::jsw_arch}-${version}"
  $full_url  = "${base_url}/${tar_ball}.tar.gz"
  $library   = 'libwrapper.so'

}
