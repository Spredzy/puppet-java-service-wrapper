# Define: java_service_wrapper::startupscript
#
#
define java_service_wrapper::startupscript(
  $run_as_user = 'root',
  $base_path = '/usr/local',
  $app_name = $name,
  $wrapper_cmd = './wrapper',
  $wrapper_conf = "/etc/${name}.conf",
  $piddir = "/var/run/${name}.pid",
  $use_upstart = false,
  $app_long_name) {

    class {'java_service_wrapper' :
      base_path => $base_path,
    }

    file {"${base_path}/bin/${app_name}_wrapper" :
      ensure  => 'present',
      owner   => $run_as_user,
      group   => $run_as_user,
      mode    => '0755',
      content => template("java_service_wrapper/sh.script.in"),
    }

  }
