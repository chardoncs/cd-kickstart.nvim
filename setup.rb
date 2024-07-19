#!/usr/bin/env ruby

require 'optparse'

def main opts
end

if __FILE__ == $PROGRAM_NAME
  opts = {}

  OptionParser.new do |parser|
  end.parse!

  main opts
end
