# spec/classes/java_service_wrapper_spec.pp

require 'spec_helper'

describe 'java_service_wrapper' do

  context 'Linux - x86 - 32bits' do
    let(:facts) do
      {:jsw_kernel => 'linux', :jsw_arch => 'x86-32', :jsw_extension => '.so'}
    end

    it "should create class 'java_service_wrapper'" do
      should create_class('java_service_wrapper')
    end
    it 'should create /usr/local/lib/wrapper.jar' do
      should contain_file('/usr/local/lib/wrapper.jar').with({
        'ensure' => 'present',
        'owner'  => 'root',
        'group'	 => 'root',
        'mode'   => '0755',
        'source' => 'puppet:///modules/java_service_wrapper/lib/wrapper.jar',
      })
    end

    it 'should create /usr/local/lib/libwrapper.so' do
      should contain_file('/usr/local/lib/libwrapper.so').with({
        'ensure' => 'present',
        'owner'  => 'root',
        'group'	 => 'root',
        'mode'   => '0755',
        'source' => 'puppet:///modules/java_service_wrapper/lib/libwrapper-linux-x86-32.so',
      })
    end

    it 'should create /usr/local/bin/wrapper' do
      should contain_file('/usr/local/bin/wrapper').with({
        'ensure' => 'present',
        'owner'  => 'root',
        'group'	 => 'root',
        'mode'   => '0755',
        'source' => 'puppet:///modules/java_service_wrapper/bin/wrapper-linux-x86-32',
      })
    end
  end

  context 'Linux - x86 - 64bits' do
    let(:facts) do
      {:jsw_kernel => 'linux', :jsw_arch => 'x86-64', :jsw_extension => '.so'}
    end

    it "should create class 'java_service_wrapper'" do
      should create_class('java_service_wrapper')
    end
    it 'should create /usr/local/lib/wrapper.jar' do
      should contain_file('/usr/local/lib/wrapper.jar').with({
        'ensure' => 'present',
        'owner'  => 'root',
        'group'	 => 'root',
        'mode'   => '0755',
        'source' => 'puppet:///modules/java_service_wrapper/lib/wrapper.jar',
      })
    end

    it 'should create /usr/local/lib/libwrapper.so' do
      should contain_file('/usr/local/lib/libwrapper.so').with({
        'ensure' => 'present',
        'owner'  => 'root',
        'group'	 => 'root',
        'mode'   => '0755',
        'source' => 'puppet:///modules/java_service_wrapper/lib/libwrapper-linux-x86-64.so',
      })
    end

    it 'should create /usr/local/bin/wrapper' do
      should contain_file('/usr/local/bin/wrapper').with({
        'ensure' => 'present',
        'owner'  => 'root',
        'group'	 => 'root',
        'mode'   => '0755',
        'source' => 'puppet:///modules/java_service_wrapper/bin/wrapper-linux-x86-64',
      })
    end
  end

  context 'Darwin - universal - 32bits' do
    let(:facts) do
      {:jsw_kernel => 'macosx', :jsw_arch => 'universal-32', :jsw_extension => '.jnilib'}
    end

    it "should create class 'java_service_wrapper'" do
      should create_class('java_service_wrapper')
    end
    it 'should create /usr/local/lib/wrapper.jar' do
      should contain_file('/usr/local/lib/wrapper.jar').with({
        'ensure' => 'present',
        'owner'  => 'root',
        'group'	 => 'root',
        'mode'   => '0755',
        'source' => 'puppet:///modules/java_service_wrapper/lib/wrapper.jar',
      })
    end

    it 'should create /usr/local/lib/libwrapper.jnilib' do
      should contain_file('/usr/local/lib/libwrapper.jnilib').with({
        'ensure' => 'present',
        'owner'  => 'root',
        'group'	 => 'root',
        'mode'   => '0755',
        'source' => 'puppet:///modules/java_service_wrapper/lib/libwrapper-macosx-universal-32.jnilib',
      })
    end

    it 'should create /usr/local/bin/wrapper' do
      should contain_file('/usr/local/bin/wrapper').with({
        'ensure' => 'present',
        'owner'  => 'root',
        'group'	 => 'root',
        'mode'   => '0755',
        'source' => 'puppet:///modules/java_service_wrapper/bin/wrapper-macosx-universal-32',
      })
    end
  end

  context 'Darwin - universal - 64bits' do
    let(:facts) do
      {:jsw_kernel => 'macosx', :jsw_arch => 'universal-64', :jsw_extension => '.jnilib'}
    end

    it "should create class 'java_service_wrapper'" do
      should create_class('java_service_wrapper')
    end
    it 'should create /usr/local/lib/wrapper.jar' do
      should contain_file('/usr/local/lib/wrapper.jar').with({
        'ensure' => 'present',
        'owner'  => 'root',
        'group'	 => 'root',
        'mode'   => '0755',
        'source' => 'puppet:///modules/java_service_wrapper/lib/wrapper.jar',
      })
    end

    it 'should create /usr/local/lib/libwrapper.jnilib' do
      should contain_file('/usr/local/lib/libwrapper.jnilib').with({
        'ensure' => 'present',
        'owner'  => 'root',
        'group'	 => 'root',
        'mode'   => '0755',
        'source' => 'puppet:///modules/java_service_wrapper/lib/libwrapper-macosx-universal-64.jnilib',
      })
    end

    it 'should create /usr/local/bin/wrapper' do
      should contain_file('/usr/local/bin/wrapper').with({
        'ensure' => 'present',
        'owner'  => 'root',
        'group'	 => 'root',
        'mode'   => '0755',
        'source' => 'puppet:///modules/java_service_wrapper/bin/wrapper-macosx-universal-64',
      })
    end
  end
end
