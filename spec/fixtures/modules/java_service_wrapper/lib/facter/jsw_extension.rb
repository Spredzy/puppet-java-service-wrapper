# Facter: jsw_extension
#
# extension suffix name based on kernel used
#
Facter.add('jsw_extension') do
  setcode do
    cur_kernel = Facter.value(:kernel)
    case cur_kernel
    when /FreeBSD|Linux|HP\-UX|sunos/
      '.so'
    when 'Darwin'
      '.jnilib'
    when 'AIX'
      '.a'
    else
      '.dll'
    end
  end
end
