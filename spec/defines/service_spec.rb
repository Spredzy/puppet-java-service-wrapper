# spec/defines/service_spec.rb

require 'spec_helper'

describe 'java_service_wrapper::service' do

  let(:title) { 'logstash' }
  let(:params) do
    {:app_long_name => 'Logstash',
      :wrapper_java_cmd  => '/usr/bin/java',
      :wrapper_mainclass => 'WrapperJarApp',
      :wrapper_library   => ['/usr/local/lib'],
      :wrapper_additional => ['-Xms1G', '-Xmx1G'],
      :wrapper_classpath => ['/usr/local/lib/wrapper.jar', '/usr/local/bin/logstash.jar'],
      :wrapper_parameter => ['/usr/local/bin/logstash.jar', 'agent', '-f', '/etc/logstash.d/test.conf'],
      :name => 'logstash'}
  end

  it 'should include class java_service_wrapper' do
    should include_class('java_service_wrapper')
  end

  context 'RUN_AS_USER = root' do
    let(:params) do
      {:app_long_name     => 'Logstash',
        :run_as_user       => 'root',
        :wrapper_java_cmd  => '/usr/bin/java',
        :wrapper_mainclass => 'WrapperJarApp',
        :wrapper_library   => ['/usr/local/lib'],
        :wrapper_additional => ['-Xms1G', '-Xmx1G'],
        :wrapper_classpath => ['/usr/local/lib/wrapper.jar', '/usr/local/bin/logstash.jar'],
        :wrapper_parameter => ['/usr/local/bin/logstash.jar', 'agent', '-f', '/etc/logstash.d/test.conf'],
      }
    end
    it 'creates logstash_wrapper' do
      should contain_file('/usr/local/bin/logstash_wrapper').with({
        'ensure'  => 'present',
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0755',
      })
    end

    it ' logstah_wrapper contains appropriate fields' do
      should contain_file('/usr/local/bin/logstash_wrapper')\
        .with_content(/^APP_NAME="logstash"$/)\
        .with_content(/^APP_LONG_NAME="Logstash"$/)\
        .with_content(/^WRAPPER_CMD=".\/wrapper"$/)\
        .with_content(/^WRAPPER_CONF="\/etc\/logstash\.conf"$/)\
        .with_content(/^PIDDIR="\/var\/run\/"$/)\
        .with_content(/^RUN_AS_USER=$/)\
        .with_content(/^USE_UPSTART=$/)
    end

    it 'creates wrapper.conf' do
      should contain_file('/etc/logstash.conf').with({
        'ensure' => 'present',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0640',
      })
    end

    it 'wrapper.conf file with appropriate parameters' do
      should contain_file('/etc/logstash.conf')\
        .with_content(/^wrapper\.logfile=\/var\/log\/logstash_wrapper\.conf$/)\
        .with_content(/^wrapper\.java\.command=\/usr\/bin\/java$/)\
        .with_content(/^wrapper\.java\.mainclass=org\.tanukisoftware\.wrapper\.WrapperJarApp$/)\
        .with_content(/^wrapper\.java\.classpath\.1=\/usr\/local\/lib\/wrapper\.jar$/)\
        .with_content(/^wrapper\.java\.library\.path\.1=\/usr\/local\/lib$/)\
        .with_content(/^wrapper\.java\.classpath\.2=\/usr\/local\/bin\/logstash\.jar$/)\
        .with_content(/^wrapper\.java\.additional\.1=\-Xms1G$/)\
        .with_content(/^wrapper\.java\.additional\.2=\-Xmx1G$/)\
        .with_content(/^wrapper\.app\.parameter\.1=\/usr\/local\/bin\/logstash\.jar$/)\
        .with_content(/^wrapper\.app\.parameter\.2=agent$/)\
        .with_content(/^wrapper\.app\.parameter\.3=\-f$/)\
        .with_content(/^wrapper\.app\.parameter\.4=\/etc\/logstash\.d\/test\.conf$/)\
    end

    it '/etc/init.d/logstash' do
      should contain_file('/etc/init.d/logstash').with({
        'ensure' => 'link',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0755',
        'target' => '/usr/local/bin/logstash_wrapper',
      })
    end

    it 'service logstash start' do
      should contain_service('logstash').with({
        'ensure'     => 'running',
        'enable'     => 'true',
        'hasstatus'  => 'true',
        'hasrestart' => 'true',
      })
    end

  end

  context 'RUN_AS_USER = logstash' do
    let(:params) do
      {:app_long_name     => 'Logstash',
        :run_as_user       => 'logstash',
        :use_upstart       => true,
        :wrapper_cmd       => '/bin/wrapper',
        :wrapper_java_cmd  => '/usr/bin/java',
        :wrapper_mainclass => 'WrapperJarApp',
        :wrapper_library   => ['/usr/local/lib'],
        :wrapper_additional => ['-Xms1G', '-Xmx1G'],
        :wrapper_classpath => ['/usr/local/lib/wrapper.jar', '/usr/local/bin/logstash.jar'],
        :wrapper_parameter => ['/usr/local/bin/logstash.jar', 'agent', '-f', '/etc/logstash.d/test.conf'],
      }
    end

    it 'creates logstash_wrapper' do
      should contain_file('/usr/local/bin/logstash_wrapper').with({
        'ensure'  => 'present',
        'owner'   => 'logstash',
        'group'   => 'logstash',
        'mode'    => '0755',
      })
    end

    it 'logstash_wrapper contains appropriate fields' do
      should contain_file('/usr/local/bin/logstash_wrapper')\
        .with_content(/^APP_NAME="logstash"$/)\
        .with_content(/^APP_LONG_NAME="Logstash"$/)\
        .with_content(/^WRAPPER_CMD="\/bin\/wrapper"$/)\
        .with_content(/^WRAPPER_CONF="\/etc\/logstash\.conf"$/)\
        .with_content(/^PIDDIR="\/var\/run\/"$/)\
        .with_content(/^RUN_AS_USER="logstash"$/)\
        .with_content(/^USE_UPSTART=true$/)
    end

    it 'creates wrapper.conf' do
      should contain_file('/etc/logstash.conf').with({
        'ensure' => 'present',
        'owner'  => 'logstash',
        'group'  => 'logstash',
        'mode'   => '0640',
      })
    end

    it 'wrapper.conf file with appropriate parameters' do
      should contain_file('/etc/logstash.conf')\
        .with_content(/^wrapper\.logfile=\/var\/log\/logstash_wrapper\.conf$/)\
        .with_content(/^wrapper\.java\.command=\/usr\/bin\/java$/)\
        .with_content(/^wrapper\.java\.mainclass=org\.tanukisoftware\.wrapper\.WrapperJarApp$/)\
        .with_content(/^wrapper\.java\.classpath\.1=\/usr\/local\/lib\/wrapper\.jar$/)\
        .with_content(/^wrapper\.java\.library\.path\.1=\/usr\/local\/lib$/)\
        .with_content(/^wrapper\.java\.classpath\.2=\/usr\/local\/bin\/logstash\.jar$/)\
        .with_content(/^wrapper\.java\.additional\.1=\-Xms1G$/)\
        .with_content(/^wrapper\.java\.additional\.2=\-Xmx1G$/)\
        .with_content(/^wrapper\.app\.parameter\.1=\/usr\/local\/bin\/logstash\.jar$/)\
        .with_content(/^wrapper\.app\.parameter\.2=agent$/)\
        .with_content(/^wrapper\.app\.parameter\.3=\-f$/)\
        .with_content(/^wrapper\.app\.parameter\.4=\/etc\/logstash\.d\/test\.conf$/)\
    end

    it '/etc/init.d/logstash' do
      should contain_file('/etc/init.d/logstash').with({
        'ensure' => 'link',
        'owner'  => 'logstash',
        'group'  => 'logstash',
        'mode'   => '0755',
        'target' => '/usr/local/bin/logstash_wrapper',
      })
    end

    it 'service logstash start' do
      should contain_service('logstash').with({
        'ensure'     => 'running',
        'enable'     => 'true',
        'hasstatus'  => 'true',
        'hasrestart' => 'true',
      })
    end
  end

end
