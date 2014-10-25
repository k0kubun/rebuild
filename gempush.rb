#!/usr/bin/env ruby

require_relative './lib/rebuild/version'
`gem build rebuild.gemspec`
`gem push rebuild-#{Rebuild::VERSION}.gem`
