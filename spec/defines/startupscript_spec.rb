# spec/defines/startupscript_spec.rb

require 'spec_helper'

describe 'java_service_wrapper::startupscript' do

  let(:title) { 'logstash' }
  let(:params) { {:app_long_name => 'Logstash',:name => 'logstash'} }

  it 'should include class java_service_wrapper' do
    should include_class('java_service_wrapper')
  end

  context 'RUN_AS_USER = root' do
    let(:params) { {:app_long_name => 'Logstash', :run_as_user => 'root'} }
    it 'should contain file logstash_wrapper' do
      should contain_file('/usr/local/bin/logstash_wrapper').with({
        'ensure'  => 'present',
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0755',
      })
    end
    it 'should contain file with appropriate parameters' do
      should contain_file('/usr/local/bin/logstash_wrapper')\
        .with_content(/^APP_NAME="logstash"$/)\
        .with_content(/^APP_LONG_NAME="Logstash"$/)\
        .with_content(/^WRAPPER_CMD=".\/wrapper"$/)\
        .with_content(/^WRAPPER_CONF="\/etc\/logstash\.conf"$/)\
        .with_content(/^PIDDIR="\/var\/run\/logstash.pid"$/)\
        .with_content(/^RUN_AS_USER=$/)\
        .with_content(/^USE_UPSTART=$/)
    end
  end

  context 'RUN_AS_USER = logstash' do
    let(:params) { {:app_long_name => 'Logstash', :run_as_user => 'logstash', :use_upstart => true, :wrapper_cmd => '/bin/wrapper'} }
    it 'should contain file logstash_wrapper' do
      should contain_file('/usr/local/bin/logstash_wrapper').with({
        'ensure'  => 'present',
        'owner'   => 'logstash',
        'group'   => 'logstash',
        'mode'    => '0755',
      })
    end
    it 'should contain file with appropriate parameters' do
      should contain_file('/usr/local/bin/logstash_wrapper')\
        .with_content(/^APP_NAME="logstash"$/)\
        .with_content(/^APP_LONG_NAME="Logstash"$/)\
        .with_content(/^WRAPPER_CMD="\/bin\/wrapper"$/)\
        .with_content(/^WRAPPER_CONF="\/etc\/logstash\.conf"$/)\
        .with_content(/^PIDDIR="\/var\/run\/logstash.pid"$/)\
        .with_content(/^RUN_AS_USER="logstash"$/)\
        .with_content(/^USE_UPSTART=true$/)
    end
  end

end
