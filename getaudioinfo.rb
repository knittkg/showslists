#! /usr/bin/env ruby

begin
  require "audioinfo"
rescue LoadError
  require "rubygems"
  require "audioinfo"
end

ARGV.each do |filename|
  AudioInfo.open(filename) do |info|
    puts([filename])
    puts([info.artist])
    puts([info.title])
    puts([info.length])
  end
end
