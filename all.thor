require 'thor'

thorfiles = Dir['lib/tasks/**/*.thor']
thorfiles.each {|file| Thor::Util::load_thorfile file }
