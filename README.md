# A Puppet module for java-service-wrapper [![Build Status](https://travis-ci.org/Spredzy/puppet-java-service-wrapper.png)](https://travis-ci.org/Spredzy/puppet-java-service-wrapper)

The Java Service Wrapper enables a Java Application to be run as a Windows Service or UNIX Daemon.
This module allows one to daemonize her java services with the jsw libraries.

## Basic Usage

This example is based on logstash

    java_service_wrapper::service{'logstash':
      wrapper_mainclass  => 'WrapperJarApp',
      wrapper_additional => ['-Xms1G', '-Xmx1G'],
      wrapper_library    => ['/usr/local/lib'],
      wrapper_classpath  => ['/usr/local/lib/wrapper.jar', '/usr/local/bin/logstash.jar'],
      wrapper_parameter  => ['/usr/local/bin/logstash.jar', 'agent', '-f', '/etc/logstash/test.conf']
    }


If all you want is install the java-service-wrapper libraries, simply add the following to your manifests

    include java-service-wrapper

## Notes

It is considered that Java will already be installed or will be installed if you decide to install java-service-wrapper.
