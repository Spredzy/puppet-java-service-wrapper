# Facter: jsw_arch
#
# architecture name based on jsw standtards
#
Facter.add('jsw_arch') do
  setcode do
    cur_model = Facter.value(:hardwaremodel)
    cur_kernel = Facter.value(:kernel)
    return 'universal-32' if cur_kernel.eql? 'Darwin' and cur_model =~ /i[3456]86/
    return 'universal-64' if cur_kernel.eql? 'Darwin' and cur_model == 'x86_64'
    case cur_model
    when /(i[3456]86|pentium)/
      'x86-32'
    when 'x86_64'
      'x86-64'
    when 'ia32'
      'ia-32'
    when 'ia64'
      'ia-64'
    when /^(powerpc|ppc)$/
      'ppc-32'
    when /^(powerpc|ppc)64$/
      'ppc-64'
    else
      fail("Unsupported arch : #{cur_model} - Get in touch with the Module maintainer to see how it can be fixed that")
    end
  end
end
