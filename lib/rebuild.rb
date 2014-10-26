# Require necessary files
lib_rebuild = File.expand_path('../rebuild', __FILE__)
Dir.glob(File.join(lib_rebuild, '*.rb')).each do |lib_path|
  lib = lib_path.split('/').last.gsub('.rb$', '')
  require "rebuild/#{lib}"
end

module Rebuild
end
