class PuppetOmnibus < FPM::Cookery::Recipe
  homepage 'https://github.com/phinze/puppet-omnibus/tree/puppet2.7'

  section 'Utilities'
  name 'puppet-omnibus'
  version '2.7.25'
  description 'Puppet Omnibus package'
  revision 1
  vendor 'fpm'
  maintainer 'Paul Hinze <paulh@instructure.com>'
  license 'Apache 2.0 License'

  OLD_PACKAGES = %w[
    puppet
    puppet-common
    facter
  ]

  conflicts(*OLD_PACKAGES)
  replaces(*OLD_PACKAGES)

  source '', :with => :noop

  omnibus_package true
  omnibus_dir     "/opt/#{name}"
  omnibus_recipes 'libyaml',
                  'ruby',
                  'rubygems',
                  'puppet',
                  'aws'

  # Set up paths to initscript and config files per platform
  platforms [:ubuntu, :debian] do
    config_files '/etc/puppet/puppet.conf',
                 '/etc/init.d/puppet',
                 '/etc/default/puppet'
  end
  platforms [:fedora, :redhat, :centos] do
    config_files '/etc/puppet/puppet.conf',
                 '/etc/init.d/puppet',
                 '/etc/sysconfig/puppet'
  end
  omnibus_additional_paths config_files

  def build
    # Nothing
  end

  def install
    # Set paths to package scripts
    self.class.post_install builddir('post-install')
    self.class.pre_uninstall builddir('pre-uninstall')
  end

end

