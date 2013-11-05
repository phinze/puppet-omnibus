class Rubygems < FPM::Cookery::Recipe
  description 'package management framework for Ruby libraries/applications'

  name 'rubygems'
  version '1.8.15'
  revision 1
  homepage 'http://www.rubygems.org/'
  source "http://production.cf.rubygems.org/rubygems/rubygems-#{version}.tgz"
  sha256 'a14cd45dc57ea624593c88f6c30fb7b38d0c6ca98c815501e9236c76bb6a2e33'

  maintainer '<paulh@instructure.com>'
  vendor     'fpm'
  license    'The Ruby License'

  def build
  end

  def install
    cleanenv_safesystem "#{destdir}/bin/ruby setup.rb"
  end
end
