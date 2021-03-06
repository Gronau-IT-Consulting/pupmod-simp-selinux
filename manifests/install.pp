# Install selinux-related packages
#
class selinux::install {
  assert_private()

  if $facts['os']['name'] in ['RedHat','CentOS'] {
    $utils_packages = [
      'checkpolicy',
      'policycoreutils-python'
    ]
  }
  elsif $facts['os']['name'] in ['Debian','Ubuntu'] {
    $utils_packages = [
      'checkpolicy',
      'policycoreutils'
    ]
  }
  else {
    fail("OS '${facts['os']['name']}' not supported by '${module_name}'")
  }

  if $::selinux::manage_utils_package {
    ensure_resource('package', $utils_packages, { 'ensure' => $::selinux::package_ensure })
  }

  if $::selinux::manage_mcstrans_package {
    package { $::selinux::mcstrans_package_name: ensure => $::selinux::package_ensure }
  }

  if $::selinux::manage_restorecond_package {
    package { $::selinux::restorecond_package_name: ensure => $::selinux::package_ensure }
  }
}
