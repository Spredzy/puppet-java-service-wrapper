# Facter: jsw_arch
#
# architecture name based on jsw standtards
#
Facter.add('jsw_arch') do
  setcode do
    cur_model = Facter.value(:hardwaremodel)
    case cur_model
    when /(i[3456]86|pentium|ia32)/
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
      cur_model
    end
  end
end
