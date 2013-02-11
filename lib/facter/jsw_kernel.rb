# Facter: jsw_kernel
#
# kernel name based on jsw names
#
Facter.add('jsw_kernel') do
  setcode do
    cur_kernel = Facter.value(:kernel)
    case cur_kernel
    when 'sunos'
      'solaris'
    when 'Darwin'
      'macosx'
    when 'HP-UX'
      'hpux'
    when 'AIX'
      'aix'
    when 'FreeBSD'
      'freebsd'
    when 'Linux'
      'linux'
    else
      cur_kernel
    end
  end
end
