# A Puppet module for java-service-wrapper

The Java Service Wrapper enables a Java Application to be run as a Windows Service or UNIX Daemon.
This module will install the core library for java-service-wrapper to work on your system.

## Basic Usage

For the latest version
```
include java-service-wrapper
```

For a specific version
```
class {'java-service-wrapper':
  version   => '3.5.17',
  base_path => '/usr/local'/,
}
```

## Notes

It is considered that Java will already be installed or will be installed if you decided to install java-service-wrapper.
