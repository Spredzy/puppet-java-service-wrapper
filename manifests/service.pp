# Define: java_service_wrapper::service
#
#   Set a java service as a daemon using java_service_wrapper
#
# Parameters:
#
#    [*run_as_user*]        : The user the service will be run as
#    [*base_path*]          : The location were files will be installed
#    [*app_name*]           : The application name
#    [*app_long_name*]      : The application long name - if any
#    [*wrapper_cmd*]        : The path to the wrapper binary
#    [*wrapper_conf*]       : The path to the wrapper configuration file
#    [*piddir*]             : The path to the pid file
#    [*user_upstart*]       : Boolean to specify is upstart will be used
#    [*wrapper_java_cmd*]   : The path to the java binary
#    [*wrapper_logfile*]    : The path to the wrapper logfile
#    [*wrapper_classpath*]  : Array of paths to classpaths
#    [*wrapper_mainclass*]  : Name of the wrapper main class : WrapperSimpleApp, WrapperJarApp, WrapperStartStopApp
#    [*wrapper_library*]    : Array of paths to libraroes
#    [*wrapper_additional*] : Array of JVM configuration flag
#    [*wrapper_parameter*]  : Array of parameters the application will take as input
#
# Actions:
#
#    It will install the java_service_wrapper component if not yet installed
#    It will configure the service_wrapper initd scriot and the service_wrapper.conf
#    on which java_service_wrapper will rely on for its configuration
#
# Requires :
#
#    A working java implementation
#
# Sample usage :
#
#    java_service_wrapper::service{'logstash' :
#         run_as_user => 'logstash',
#         app_name    => 'logstash',
#         wrapper_classpasth => ['/usr/local/lib/wrapper.jar', '/usr/local/bin/logstash.jar'],
#         wrapper_library => ['/usr/local/lib'],
#         wrapper_classpasth => ['/usr/local/bin/logstash.jar', 'agent', '-f', '/etc/logstash.d/test.conf']
#    }
#
#
define java_service_wrapper::service(
  $run_as_user        = 'root',
  $base_path          = '/usr/local',
  $app_name           = $name,
  $app_long_name      = $name,
  $wrapper_cmd        = './wrapper',
  $wrapper_conf       = "/etc/${name}.conf",
  $piddir             = '/var/run/',
  $use_upstart        = false,
  $wrapper_java_cmd   = '/usr/bin/java',
  $wrapper_logfile    = "/var/log/${name}_wrapper.log",
  $wrapper_classpath  = [''],
  $wrapper_mainclass  = 'WrapperSimpleApp',
  $wrapper_library    = [''],
  $wrapper_additional = [''],
  $wrapper_parameter  = [''],
) {

  include java_service_wrapper

  validate_string($run_as_user)
  validate_string($base_path)
  validate_string($app_name)
  validate_string($app_long_name)
  validate_string($wrapper_cmd)
  validate_string($wrapper_conf)
  validate_string($piddir)
  validate_string($wrapper_java_cmd)
  validate_string($wrapper_logfile)
  validate_string($wrapper_mainclass)

  validate_bool($use_upstart)

  if $wrapper_classpath {
    validate_array($wrapper_classpath)
  }

  if $wrapper_library {
    validate_array($wrapper_library)
  }

  if $wrapper_additional {
    validate_array($wrapper_additional)
  }

  if $wrapper_parameter {
    validate_array($wrapper_parameter)
  }

  File[$wrapper_logfile] -> File[$wrapper_conf] -> File["${base_path}/bin/${app_name}_wrapper"] -> File["/etc/init.d/${app_name}"] ~> Service[$app_name]

  File {
    owner => $run_as_user,
    group => $run_as_user
  }

  file {$wrapper_logfile:
    ensure => 'present',
    mode   => '0640',
  }

  file {$wrapper_conf:
    ensure  => 'present',
    mode    => '0640',
    content => template("${module_name}/etc/wrapper.conf.erb"),
  }

  file {"${base_path}/bin/${app_name}_wrapper" :
    ensure  => 'present',
    mode    => '0755',
    content => template("${module_name}/usr/local/bin/sh.script.in.erb"),
  }

  file {"/etc/init.d/${app_name}":
    ensure  => 'link',
    mode    => '0755',
    target  => "${base_path}/bin/${app_name}_wrapper",
  }

  service {$app_name:
    ensure     => 'running',
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }

}
