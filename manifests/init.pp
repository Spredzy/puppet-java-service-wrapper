class java_service_wrapper(
  $version   = $java_service_wrapper::params::version,
  $base_path = $java_service_wrapper::params::base_path,
) inherits java_service_wrapper::params
{

  Exec['Download and unpack java_service_wrapper tarball'] -> Exec["cp /tmp/${java_service_wrapper::params::tar_ball}/lib/wrapper.jar ${base_path}/lib/wrapper.jar"] -> Exec["cp /tmp/${java_service_wrapper::params::tar_ball}/lib/${java_service_wrapper::params::library} ${base_path}/lib/${java_service_wrapper::params::library}"] -> Exec["cp /tmp/${java_service_wrapper::params::tar_ball}/bin/wrapper ${base_path}/bin/wrapper"] -> Exec['Remove temporary files']

  Exec { path => ['/bin', '/usr/bin'] }
  exec {'Download and unpack java_service_wrapper tarball' :
    command => "wget -O /tmp/${java_service_wrapper::params::tar_ball}.tar.gz ${java_service_wrapper::params::full_url} && tar -zxf /tmp/${java_service_wrapper::params::tar_ball}.tar.gz -C /tmp",
    unless  => "ls ${base_path}/bin/wrapper && ls ${base_path}/lib/${java_service_wrapper::params::library} && ls ${base_path}/lib/wrapper.jar",
  }
  exec {"cp /tmp/${java_service_wrapper::params::tar_ball}/lib/wrapper.jar ${base_path}/lib/wrapper.jar" :
    unless => "ls ${base_path}/lib/wrapper.jar",
  }
  exec {"cp /tmp/${java_service_wrapper::params::tar_ball}/lib/${java_service_wrapper::params::library} ${base_path}/lib/${java_service_wrapper::params::library}" :
    unless => "ls ${base_path}/lib/${java_service_wrapper::params::library}",
  }
  exec {"cp /tmp/${java_service_wrapper::params::tar_ball}/bin/wrapper ${base_path}/bin/wrapper" :
    unless => "ls ${base_path}/bin/wrapper",
  }
  exec{'Remove temporary files' :
    command => "rm -rf /tmp/${java_service_wrapper::params::tar_ball} && rm -rf /tmp/${java_service_wrapper::params::tar_ball}.tar.gz",
    onlyif  => "ls /tmp/${java_service_wrapper::params::tar_ball}",
  }


}
